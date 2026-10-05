-- BMZ DETAIL OPTIONS v1. The player owns settings, input and translations.
local function load()
	if not bmz or bmz.get_option("bmz_detail_options", "0") ~= "1" then return nil end
	local prefix = "luxe_detail_"
	local pitch, left, width = 274, 9, 258
	local parts = {
		bmzDetailOptions = 1,
		bmzDetailOptionsNumbers = true,
		bmzDetailOptionsClose = true,
		source = {
			{id = prefix .. "panel", path = "select_skinparts/default_optionpanel/option2_panel_ver1.3.0.png"},
			{id = prefix .. "cursor", path = "select_skinparts/default_optionpanel/cursor_ver1.3.0.png"},
		},
		font = {
			{id = prefix .. "font", path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub/sub.fnt"},
			{id = prefix .. "small", path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub_small/sub_small.fnt"},
			{id = prefix .. "choices", path = "select_skinparts/default_detailoptions/font/NotoSansCJKjp-Medium.otf"},
		},
		panel = {}, image = {}, text = {}, destination = {},
	}
	local function panel(id, color)
		table.insert(parts.panel, {id = prefix .. id, color = color})
	end
	local function sprite(id, src, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. src, x = x, y = y, w = w, h = h})
	end
	local function text(id, ref, size, align, font)
		local font_id = prefix .. (font or "font")
		table.insert(parts.text, {id = prefix .. id, ref = ref, font = font_id,
			size = size, align = align or 0, overflow = 1})
	end
	local function hit(id, event)
		table.insert(parts.image, {id = prefix .. id, src = -1, w = 1, h = 1, act = event, clickable = true})
	end
	-- Coordinates below use a top-left origin. Match the original 300 ms opening
	-- and closing easing; moving hit areas exist only while E2 is active.
	local function draw(id, x, y, w, h, options, slot, color, alpha)
		local op = {19300, 22}
		for _, value in ipairs(options or {}) do table.insert(op, value) end
		local frame = {time = 0, x = x - 1920, y = 1080 - y - h, w = w, h = h, acc = 2, a = alpha or 255}
		if color then frame.r, frame.g, frame.b = color[1], color[2], color[3] end
		local frames = {frame, {time = 300, x = x}}
		if slot and slot >= 7 then
			frame.time, frame.x = 300, x
			frames = {frame}
		end
		table.insert(parts.destination, {id = prefix .. id, op = op, timer = 22, loop = 300, dst = frames,
			bmzDetailScroll = slot and {pitch, 0} or nil})
		-- Freeze only the seven visible columns on exit. Neither overscan nor hits
		-- should slide back into view, including transitions to the other panels.
		if not id:match("_hit$") and (not slot or slot < 7) then
			local close_op = {19300, -22}
			for _, value in ipairs(options or {}) do table.insert(close_op, value) end
			local close = {time = 0, x = x, y = 1080 - y - h, w = w, h = h, acc = 2, a = alpha or 255}
			if color then close.r, close.g, close.b = color[1], color[2], color[3] end
			table.insert(parts.destination, {id = prefix .. id, op = close_op, timer = 32, loop = -1,
				dst = {close, {time = 300, x = x - 1920}}, bmzDetailScroll = slot and {pitch, 0} or nil})
		end
	end
	panel("shade", "000000B4")
	panel("column", "10091B70")
	panel("selected", "34065780")
	panel("header", "35085CA0")
	panel("footer", "10091B90")
	panel("black", "000000FF")
	-- Crop only the rounded rim, not the opaque fill baked into the 24 px corners.
	-- Each span is {height, outer inset, inner inset}; coordinates match the old
	-- purple card. Keep its antialiased pixels and bevel, without editing the PNG.
	local rim = {
		{1, 22, 24}, {1, 17, 24}, {1, 14, 24}, {1, 12, 24},
		{1, 10, 24}, {1, 9, 24}, {1, 8, 24}, {1, 7, 16},
		{1, 6, 15}, {1, 5, 13}, {1, 5, 12}, {1, 4, 11},
		{1, 3, 10}, {1, 3, 10}, {1, 2, 9}, {1, 2, 9},
		{1, 2, 8}, {4, 1, 8}, {3, 1, 7},
	}
	local corners, fill_bands, dy = {}, {}, 0
	for index, span in ipairs(rim) do
		local h, outer, inner = span[1], span[2], span[3]
		for corner = 0, 3 do
			local right, bottom = corner % 2 == 1, corner >= 2
			local sx = right and 814 - inner or 607 + outer
			local sy = bottom and 354 - dy - h or 173 + dy
			local id = "corner_" .. corner .. "_" .. index
			sprite(id, "panel", sx, sy, inner - outer, h)
			table.insert(corners, {id, right and width - inner or outer,
				bottom and 550 - dy - h or dy, inner - outer, h})
		end
		if dy >= 7 then table.insert(fill_bands, {dy, h, inner}) end
		dy = dy + h
	end
	sprite("top", "panel", 631, 173, 159, 7)
	sprite("bottom", "panel", 631, 347, 159, 7)
	sprite("left", "panel", 607, 197, 7, 133)
	sprite("right", "panel", 807, 197, 7, 133)
	-- The old 176x39 crop includes purple outside the rounded 175x38 button.
	-- These disjoint bands retain only the neutral button pixels, not its matte.
	local button_bands, button_y = {}, 0
	for index, band in ipairs({
		{1, 10}, {1, 6}, {1, 4}, {1, 3}, {2, 2}, {4, 1}, {18, 0},
		{4, 1}, {2, 2}, {1, 3}, {1, 4}, {1, 6}, {1, 10},
	}) do
		local h, inset = band[1], band[2]
		local id = "button_" .. index
		sprite(id, "panel", 623 + inset, 277 + button_y, 175 - inset * 2, h)
		table.insert(button_bands, {id, inset, button_y, 175 - inset * 2, h})
		button_y = button_y + h
	end
	sprite("value_selected", "cursor", 0, 500, 213, 76)
	hit("blocker", 0)
	table.insert(parts.destination, {id = prefix .. "blocker", op = {19300, 22}, dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, 22}, timer = 22, loop = 300,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0}, {time = 300, a = 255}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, -22}, timer = 32, loop = -1,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255}, {time = 300, a = 0}}})
	local function border(x, options, slot, alpha)
		for _, piece in ipairs(corners) do
			draw(piece[1], x + piece[2], 180 + piece[3], piece[4], piece[5], options, slot, nil, alpha)
		end
		for _, piece in ipairs({
			{"top", x + 24, 180, width - 48, 7}, {"bottom", x + 24, 723, width - 48, 7},
			{"left", x, 204, 7, 502}, {"right", x + width - 7, 204, 7, 502},
		}) do
			draw(piece[1], piece[2], piece[3], piece[4], piece[5], options, slot, nil, alpha)
		end
	end
	local function fill(id, x, row, slot, header)
		draw(id, x + 7, 204, width - 14, header and 46 or 502, {row}, slot)
		for _, band in ipairs(fill_bands) do
			local y, h, inset = band[1], band[2], band[3]
			draw(id, x + inset, 180 + y, width - inset * 2, h, {row}, slot)
			if not header then draw(id, x + inset, 730 - y - h, width - inset * 2, h, {row}, slot) end
		end
	end
	local function button(x, y, scale, cell, slot)
		for _, band in ipairs(button_bands) do
			-- Share rounded edges between bands: rounding height independently would
			-- leave horizontal gaps when the 39 px source is enlarged to 50 px.
			local x1 = math.floor(x + band[2] * scale + 0.5)
			local x2 = math.floor(x + (band[2] + band[4]) * scale + 0.5)
			local y1 = math.floor(y + band[3] * scale + 0.5)
			local y2 = math.floor(y + (band[3] + band[5]) * scale + 0.5)
			draw(band[1], x1, y1, x2 - x1, y2 - y1, {cell}, slot)
		end
	end
	for slot = 0, 8 do
		local column = slot == 7 and -1 or slot == 8 and 7 or slot
		local x, row, id = left + column * pitch, 19400 + slot * 10, "row_" .. slot
		hit(id .. "_hit", 19310 + slot)
		text(id .. "_label", row, 26, 1)
		text(id .. "_status", row + 2, 18, 1, "small")
		text(id .. "_external", row + 1, 26, 1, "choices")
		draw(id .. "_hit", x, 180, width, 550, {row}, slot)
		fill("column", x, row, slot)
		fill("selected", x, row + 1, slot)
		fill("header", x, row, slot, true)
		border(x, {row, -(row + 1)}, slot, 100)
		border(x, {row + 1}, slot, 255)
		draw(id .. "_label", x + width / 2, 208, width - 24, 36, {row}, slot)
		draw(id .. "_status", x + width / 2, 698, width - 24, 22, {row}, slot, {255, 214, 158})
		draw(id .. "_external", x + width / 2, 652, width - 24, 34, {row, row + 4}, slot, {255, 214, 158})
		for choice = 0, 7 do
			local cell = 19500 + slot * 64 + choice * 4
			local name, y = id .. "_choice_" .. choice, 274 + choice * 52
			hit(name .. "_hit", cell)
			text(name, cell, 26, 1, "choices")
			-- Apply the same uniform scale to both source images. The cursor has
			-- a 19 px glow margin outside the button in the original option panel.
			local scale = 226 / 176
			button(x + 16, y, scale, cell, slot)
			draw("value_selected", x + 16 - 19 * scale, y - 19 * scale, 213 * scale, 76 * scale, {cell + 1}, slot)
			-- Keep the visible cap height and center with Noto Sans CJK's metrics.
			draw(name, x + width / 2, y + 4, 210, 38, {cell, row + 3}, slot)
			draw(name, x + width / 2, y + 4, 210, 38, {cell, -(row + 3)}, slot, {172, 172, 172})
			draw(name .. "_hit", x + 10, y, 238, 50, {cell + 2}, slot)
		end
		text(id .. "_number", row + 1, 26, 1, "choices")
		button(x + 16, 274, 226 / 176, row + 5, slot)
		draw("value_selected", x + 16 - 19 * 226 / 176, 274 - 19 * 226 / 176,
			213 * 226 / 176, 76 * 226 / 176, {row + 5}, slot)
		draw(id .. "_number", x + width / 2, 278, 210, 38, {row + 5}, slot)
		for direction = 0, 1 do
			local name, bx = id .. "_number_" .. direction, x + 16 + direction * 122
			hit(name .. "_hit", 19320 + slot * 2 + direction)
			table.insert(parts.text, {id = prefix .. name, font = prefix .. "choices",
				constantText = direction == 0 and "−" or "+", size = 26, align = 1})
			button(bx, 342, 104 / 176, row + 5, slot)
			draw(name, bx + 52, 336, 90, 38, {row + 5}, slot)
			draw(name .. "_hit", bx, 336, 104, 38, {row + 6 + direction}, slot)
		end
	end
	draw("footer", 9, 746, 1902, 178)
	text("category", 19302, 26)
	text("value", 19301, 26, 2, "choices")
	text("description", 19303, 26)
	text("auxiliary", 19305, 26)
	text("reason", 19304, 18, 0, "small")
	draw("category", 28, 756, 1260, 36, nil, nil, {218, 177, 255})
	draw("value", 1892, 756, 520, 36)
	draw("description", 28, 796, 1864, 36)
	draw("auxiliary", 28, 836, 1864, 36, nil, nil, {204, 193, 220})
	draw("reason", 28, 884, 1864, 24, nil, nil, {255, 214, 158})
	-- Masks only cover the pillarbox outside the 1920 px canvas.
	for _, x in ipairs({-1920, 1920}) do
		table.insert(parts.destination, {id = prefix .. "black", op = {19300}, dst = {{x = x, y = 0, w = 1920, h = 1080}}})
	end
	return parts
end

return {parts = {}, load = load}
