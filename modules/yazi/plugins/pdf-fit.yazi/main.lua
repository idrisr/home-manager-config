--- @since 26.1.22
--- @sync entry

local M = {}

local MAX_PX = 3000

local get_mode = ya.sync(function(state)
	if state.mode == nil then
		state.mode = "image"
	end
	return state.mode
end)

local function target_px()
	local max_w = rt.preview and rt.preview.max_width or MAX_PX
	local max_h = rt.preview and rt.preview.max_height or MAX_PX
	local size = math.min(MAX_PX, max_w, max_h)
	if size <= 0 then
		return MAX_PX
	end
	return math.floor(size)
end

local function jpeg_quality()
	local q = rt.preview and rt.preview.image_quality or 75
	if type(q) ~= "number" then
		return 75
	end
	return q
end

local function pdftc_lines(path)
	local output, err = Command("pdftc"):arg(path):output()
	if not output then
		return {
			ui.Line("pdftc failed"):bold(),
			ui.Line(tostring(err)):dim(),
		}
	end

	if not output.status.success then
		local msg = output.stderr
		if msg == nil or msg == "" then
			msg = output.stdout
		end
		if msg == nil or msg == "" then
			msg = "pdftc exited with code " .. tostring(output.status.code)
		end

		return {
			ui.Line("pdftc error"):bold(),
			ui.Line(msg):dim(),
		}
	end

	local out = output.stdout or ""
	out = out:gsub("\r\n", "\n")
	if rt and rt.preview and rt.preview.tab_size then
		out = out:gsub("\t", string.rep(" ", rt.preview.tab_size))
	else
		out = out:gsub("\t", "  ")
	end

	if out:match("%S") == nil then
		return { ui.Line("No table of contents"):dim() }
	end

	local raw = {}
	for line in (out .. "\n"):gmatch("([^\n]*)\n") do
		raw[#raw + 1] = line
	end
	while #raw > 0 and raw[#raw] == "" do
		raw[#raw] = nil
	end

	local lines = {}
	for i = 1, #raw do
		lines[#lines + 1] = ui.Line(raw[i])
	end

	return lines
end

local function preview_toc(job)
	local lines = pdftc_lines(tostring(job.file.path))
	local skip = job.skip or 0
	local max_skip = math.max(0, #lines - 1)
	if skip > max_skip then
		return ya.emit("peek", { max_skip, only_if = job.file.url, upper_bound = true })
	end

	local start = math.max(0, skip) + 1
	local view = {}
	for i = start, #lines do
		view[#view + 1] = lines[i]
	end
	if #view == 0 then
		view = { ui.Line("") }
	end

	local widgets = {
		ui.Clear(job.area),
		ui.Text(view):area(job.area):wrap(ui.Wrap.YES),
	}

	ya.preview_widget(job, widgets)
end

local function preview_image(self, job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err, bound = self:preload(job)
	if bound and bound > 0 then
		return ya.emit("peek", { bound - 1, only_if = job.file.url, upper_bound = true })
	elseif not ok or err then
		return ya.preview_widget(job, err)
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, image_err = ya.image_show(cache, job.area)
	ya.preview_widget(job, image_err)
end

function M:peek(job)
	local mode = get_mode()
	if mode == "toc" then
		return preview_toc(job)
	end
	return preview_image(self, job)
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local mode = get_mode()
		local units = job.units or 0
		local step = units
		if mode ~= "toc" then
			step = ya.clamp(-1, units, 1)
		end
		ya.emit("peek", { math.max(0, cx.active.preview.skip + step), only_if = job.file.url })
	end
end

function M.entry(state, job)
	if state.mode == "toc" then
		state.mode = "image"
	else
		state.mode = "toc"
	end

	local h = cx.active.current.hovered
	if h then
		ya.emit("peek", { cx.active.preview.skip or 0, only_if = h.url })
	end
end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local output, err = Command("pdftoppm")
		:arg({
			"-f", job.skip + 1,
			"-l", job.skip + 1,
			"-singlefile",
			"-scale-to", target_px(),
			"-jpeg", "-jpegopt", "quality=" .. tostring(jpeg_quality()),
			tostring(job.file.path), tostring(cache),
		})
		:output()

	if not output then
		return true, Err("Failed to start `pdftoppm`, error: %s", err)
	elseif not output.status.success then
		local pages = job.skip > 0 and tonumber(output.stderr:match("the last page %((%d+)%)"))
		return true, Err("Failed to convert PDF to image, stderr: %s", output.stderr), pages
	end

	return ya.image_precache(Url(cache .. ".jpg"), cache)
end

return M
