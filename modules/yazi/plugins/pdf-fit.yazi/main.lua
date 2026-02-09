--- @since 26.1.22

local M = {}

local MAX_PX = 3000

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

function M:peek(job)
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

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err)
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local step = ya.clamp(-1, job.units, 1)
		ya.emit("peek", { math.max(0, cx.active.preview.skip + step), only_if = job.file.url })
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
