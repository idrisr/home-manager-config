--- @since 26.1.22

local M = {}

local function get_video()
	local ok, mod = pcall(require, "video")
	if ok then
		return mod
	end
	return nil
end

local function split_areas(area, image_h)
	local min_text = 6
	if image_h and image_h > 0 then
		if area.h <= min_text + 1 then
			min_text = math.max(3, area.h - 1)
		end
		image_h = math.max(1, math.min(image_h, area.h - min_text))
		local text_h = math.max(1, area.h - image_h)

		local chunks = ui.Layout()
			:direction(ui.Layout.VERTICAL)
			:constraints({
				ui.Constraint.Length(image_h),
				ui.Constraint.Length(text_h),
			})
			:split(area)

		return chunks[1], chunks[2]
	end

	local text_h = math.floor(area.h * 0.3)
	text_h = math.max(min_text, math.min(12, text_h))
	if area.h <= text_h + 1 then
		text_h = math.max(3, area.h - 1)
	end

	local chunks = ui.Layout()
		:direction(ui.Layout.VERTICAL)
		:constraints({
			ui.Constraint.Fill(1),
			ui.Constraint.Length(text_h),
		})
		:split(area)

	return chunks[1], chunks[2]
end

local function estimate_image_height(video, path, area)
	if not video or not video.list_meta then
		return nil
	end

	local meta = video.list_meta(path, "stream=codec_type,width,height")
	if not meta or not meta.streams then
		return nil
	end

	for _, stream in ipairs(meta.streams) do
		if stream.codec_type == "video" and stream.width and stream.height then
			if stream.width > 0 and stream.height > 0 then
				local img_w = stream.width
				local img_h = stream.height
				local max_w = rt.preview and rt.preview.max_width or nil
				local max_h = rt.preview and rt.preview.max_height or nil
				if max_w and max_h and max_w > 0 and max_h > 0 then
					local scale = math.min(max_w / img_w, max_h / img_h, 1)
					img_w = math.floor(img_w * scale)
					img_h = math.floor(img_h * scale)
					local rows = math.floor(img_h * area.h / max_h)
					rows = math.max(1, rows - 1)
					if rows > 0 then
						return rows
					end
				end

				return math.floor(area.w * stream.height / stream.width * 0.55)
			end
		end
	end

	return nil
end

local function chapter_lines(path)
	local output, err = Command("videoChapter"):arg(path):output()
	if not output then
		return {
			ui.Line("videoChapter failed"):bold(),
			ui.Line(tostring(err)):dim(),
		}
	end

	if not output.status.success then
		local msg = output.stderr
		if msg == nil or msg == "" then
			msg = output.stdout
		end
		if msg == nil or msg == "" then
			msg = "videoChapter exited with code " .. tostring(output.status.code)
		end

		return {
			ui.Line("videoChapter error"):bold(),
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
		return { ui.Line("No chapters found"):dim() }
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

function M:peek(job)
	local widgets = {}

	local image_shown = false
	local video = get_video()
	local image_h = estimate_image_height(video, job.file.path, job.area)
	local image_area, text_area = split_areas(job.area, image_h)
	if video then
		local start, cache = os.clock(), ya.file_cache(job)
		if cache then
			local ok, err = video:preload(job)
			if ok and not err then
				ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))
				local _, image_err = ya.image_show(cache, image_area)
				if image_err then
					widgets[#widgets + 1] = ui.Text(tostring(image_err))
						:area(image_area)
						:wrap(ui.Wrap.YES)
				else
					image_shown = true
				end
			elseif err then
				widgets[#widgets + 1] = ui.Text(tostring(err))
					:area(image_area)
					:wrap(ui.Wrap.YES)
			end
		end
	end

	if not image_shown then
		widgets[#widgets + 1] = ui.Clear(image_area)
	end

	local lines = { ui.Line("Chapters"):bold() }
	local output = chapter_lines(tostring(job.file.path))
	for i = 1, #output do
		lines[#lines + 1] = output[i]
	end

	widgets[#widgets + 1] = ui.Clear(text_area)
	widgets[#widgets + 1] = ui.Text(lines)
		:area(text_area)
		:wrap(ui.Wrap.YES)

	ya.preview_widget(job, widgets)
end

function M:seek(job)
	local video = get_video()
	if video and video.seek then
		return video:seek(job)
	end
end

return M
