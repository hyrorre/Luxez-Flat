-- BMZ: show the selected G-BATTLE opponent without changing player options.
local function load()
	if not bmz then return nil end
	local prefix = "luxe_battle_"
	local active, known, pattern, loading = 20200, 20201, 20202, 20203
	local parts = {
		bmzBattleInfo = true,
		source = {
			{id = prefix .. "rival", path = "select_skinparts/default_scoredata/rival_data_resize.png"},
			{id = prefix .. "detail", path = "select_skinparts/default_modebotton/score_detail_panel.png"},
			{id = prefix .. "keys", path = "result/png/random_pattern.png"},
			{id = prefix .. "options", path = "select_skinparts/default_stateplayoption/stateoption_resize.png"},
			{id = prefix .. "options_bmz", path = "select_skinparts/default_stateplayoption/random_bmz.png"},
		},
		-- The bundled Noto Sans CJK Medium is closest to the key tiles' bold digits.
		font = {{id = prefix .. "digits", path = "select_skinparts/default_detailoptions/font/NotoSansCJKjp-Medium.otf"}},
		image = {}, imageset = {}, text = {}, destination = {},
	}
	local function is_double()
		local mode = main_state.number(20208)
		return mode == 10 or mode == 14
	end
	local function count()
		local mode = main_state.number(20208)
		if mode == 10 then return 5 elseif mode == 14 then return 7 else return mode end
	end
	local function sprite(id, source, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. source, x = x, y = y, w = w, h = h})
	end
	local function destination(id, x, top, w, h, double, op, draw, muted, color)
		local frame = {x = x, y = 1080 - top - h, w = w, h = h}
		-- The native NO PLAY face is RGB(127, 128, 128).
		if muted then color = {127, 128, 128} end
		if color then frame.r, frame.g, frame.b = color[1], color[2], color[3] end
		table.insert(parts.destination, {id = prefix .. id, op = op or {active}, draw = function()
			return is_double() == double and (not draw or draw())
		end, dst = {frame}})
	end
	local function text(id, value, x, top, w, double, options)
		options = options or {}
		local size = options.size or 18
		local definition = {id = prefix .. id, font = options.font or "font_sub_small",
			size = size, overflow = 1, align = options.align or 0}
		if options.outline then
			definition.outlineColor, definition.outlineWidth = "000000FF", options.outline
		end
		if type(value) == "number" then definition.ref = value
		elseif type(value) == "function" then definition.value = value
		else definition.constantText = value end
		table.insert(parts.text, definition)
		destination(id, x, top, w, size, double, options.op, options.draw, options.muted, options.color)
	end
	local arrangements = {"NORMAL", "MIRROR", "RANDOM", "R-RANDOM", "S-RANDOM", "SPIRAL",
		"H-RANDOM", "ALL-SCR", "RANDOM-EX", "S-RANDOM-EX", "F-RANDOM", "MF-RANDOM"}
	local insets = {47, 25, 21, 8, 7, 28, 7, 19, 13, 0, 8, 0}
	local widths = {44, 88, 97, 123, 124, 82, 124, 100, 112, 138, 123, 138}
	for index = 1, #arrangements do
		local inset = insets[index]
		sprite("arrange_" .. index, index <= 10 and "options" or "options_bmz", inset,
			index <= 10 and (index - 1) * 25 or (index - 11) * 21, widths[index], 21)
	end
	for number = 1, 7 do sprite("key_" .. number, "keys", (number - 1) * 25, 0, 25, 35) end
	-- 8, 9 and S: the frame and plain face of tile 1 (odd, light) or tile 2 (even, dark),
	-- picked by the original lane as the numbered tiles are.
	local blanks = {{"key_left", 0, 5}, {"key_fill", 5, 1}, {"key_right", 19, 6}}
	local blank_images = {}
	for _, blank in ipairs(blanks) do
		for shade = 1, 2 do
			sprite(blank[1] .. "_" .. shade, "keys", (shade - 1) * 25 + blank[2], 0, blank[3], 35)
		end
		blank_images[blank[1]] = {}
		for value = 0, 9 do
			table.insert(blank_images[blank[1]], prefix .. blank[1] .. "_" .. (value % 2 == 1 and 1 or 2))
		end
	end
	for _, double in ipairs({false, true}) do
		local layout = double and "dp_" or "sp_"
		local source, x, top, w, h = double and "detail" or "rival",
			double and 302 or 709, double and 663 or 664, double and 412 or 413, double and 284 or 150
		-- Reassemble clean native strips: retain the glow, corners, header dot and alpha,
		-- and omit the original SCORE/BREAK/LAMP or judgment labels and divider.
		-- An 11 px rim and a 25 px inner glow run down both sides into the bottom corners.
		-- The labels tint the left glow, so the clean right glow is mirrored there
		-- (negative width). Only the flat centre column is stretched.
		local edge, body = 36, h - 57
		local strips = {
			-- The dot's glow reaches the title, so keep all of it left of the title.
			{"head_left", 0, 0, 36, 38, 0, 0, 36, 38},
			{"head_middle", 250, 0, 1, 38, 36, 0, w - 68, 38},
			{"head_right", 381, 0, 32, 38, w - 32, 0, 32, 38},
			{"left", 0, 38, 11, body, 0, 38, 11, body},
			{"left_glow", 377, 38, 25, body, edge, 38, -25, body},
			{"middle", 175, 38, 1, body, edge, 38, w - edge * 2, body},
			{"right", 377, 38, edge, body, w - edge, 38, edge, body},
			{"bottom_left", 0, h - 19, edge, 19, 0, h - 19, edge, 19},
			{"bottom", 175, h - 19, 1, 19, edge, h - 19, w - edge * 2, 19},
			{"bottom_right", 377, h - 19, edge, 19, w - edge, h - 19, edge, 19},
		}
		for index, strip in ipairs(strips) do
			if double or index > 3 then
				local id = layout .. strip[1]
				sprite(id, source, strip[2], strip[3], strip[4], strip[5])
				destination(id, x + strip[6], top + strip[7], strip[8], strip[9], double)
			end
		end
		if double then
			text("dp_title", "G-BATTLE INFO", x + 35, top + 10, w - 60, true,
				{font = "font_VL-Gothic-Regular", size = 24})
		else
			-- Keep the original baked RIVAL DATA heading exactly as it is.
			sprite("sp_header", source, 0, 0, 413, 38)
			destination("sp_header", x, top, w, 38, false)
		end
		text(layout .. "loading", "LOADING", x + 24, top + 46, w - 48, double,
			{op = {active, loading}, muted = true})
		text(layout .. "unknown", "NO DATA", x + 24, top + 46, w - 48, double,
			{op = {active, -known, -loading}, muted = true})
		for side = 1, double and 2 or 1 do
			local ref = 20204 + side
			local row = double and (side - 1) * 80 or 0
			local option_x = x + (double and 64 or 24)
			if double then
				text(layout .. "side_" .. side, side .. "P", x + 24, top + 45 + row, 32, double,
					{op = {active, known, -loading}})
			end
			for index, arrange in ipairs(arrangements) do
				destination("arrange_" .. index, option_x, top + 43 + row, widths[index], 21,
					double, {active, known, -loading}, function() return main_state.text(ref) == arrange end)
			end
			if double then
				text(layout .. "unknown_side_" .. side, "NO DATA", option_x, top + 45 + row, 250, double,
					{op = {active, known, -loading}, muted = true, draw = function() return main_state.text(ref) == "" end})
			end
			-- Fixed lane orders use the result skin's actual numbered key tiles.
			for n = 4, 9 do
				if not double or n == 5 or n == 7 then
					-- Match Result: native 25x35 artwork with its original two-pixel gap.
					local pitch = 27
					for key = 1, n do
						local number_ref = 20210 + (side - 1) * 10 + key - 1
						local id = layout .. n .. "_" .. side .. "_" .. key
						local left, key_top = x + 24 + (key - 1) * pitch, top + 73 + row
						local function token()
							local value = main_state.number(number_ref)
							local mode = main_state.number(20208)
							if (mode == 5 or mode == 7 or double) and value == n + 1 then return "S" end
							return tostring(value)
						end
						local function visible() return count() == n and main_state.number(number_ref) > 0 end
						local images = {}
						for value = 0, 9 do
							images[#images + 1] = prefix .. "key_" .. math.max(1, math.min(value, 7))
						end
						-- IntegerProperty values and image-index refs are separate namespaces.
						table.insert(parts.imageset, {id = prefix .. id, value = number_ref, images = images})
						destination(id, left, key_top, 25, 35, double, {active, pattern, -loading}, function()
							return visible() and main_state.number(number_ref) <= 7 and token() ~= "S"
						end)
						local function fallback() return visible() and (main_state.number(number_ref) > 7 or token() == "S") end
						local fill_left, fill_right = blanks[2][2], blanks[3][2]
						for _, blank in ipairs({{blanks[1][1], 0, blanks[1][3]},
							{blanks[2][1], fill_left, fill_right - fill_left}, {blanks[3][1], fill_right, blanks[3][3]}}) do
							table.insert(parts.imageset, {id = prefix .. id .. "_" .. blank[1], value = number_ref,
								images = blank_images[blank[1]]})
							destination(id .. "_" .. blank[1], left + blank[2], key_top, blank[3], 35, double,
								{active, pattern, -loading}, fallback)
						end
						-- The tiles' digits: RGB(255, 168, 0) with a black edge.
						text(id .. "_fallback", token, left + 12, key_top + 1, 24, double,
							{font = prefix .. "digits", size = 27, align = 1, outline = 1, color = {255, 168, 0},
								op = {active, pattern, -loading}, draw = fallback})
					end
				end
			end
			text(layout .. "pattern_status_" .. side, function()
				local arrange = main_state.text(ref)
				if arrange == "S-RANDOM" or arrange == "SPIRAL" or arrange == "H-RANDOM"
					or arrange == "ALL-SCR" or arrange == "S-RANDOM-EX" then return "NOT FIXED" end
				return "NO DATA"
			end, x + 24, top + 84 + row, w - 48, double,
				{op = {active, known, -pattern, -loading}, muted = true})
		end
		if double then
			text("dp_label", "DP", x + 24, top + 210, 32, true, {op = {active, known, -loading}})
			text("dp_option", 20207, x + 64, top + 210, w - 90, true, {op = {active, known, -loading}})
			text("dp_unknown", "NO DATA", x + 64, top + 210, w - 90, true,
				{op = {active, known, -loading}, muted = true, draw = function() return main_state.text(20207) == "" end})
		end
		text(layout .. "copy", 86, x + 24, top + (double and 243 or 119), w - 48, double)
	end
	return parts
end
return {load = load}
