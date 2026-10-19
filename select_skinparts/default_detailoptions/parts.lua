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
			{id = prefix .. "panel1", path = "select_skinparts/default_optionpanel/option1_panel_bmz.png"},
			{id = prefix .. "panel3", path = "select_skinparts/default_optionpanel/option3_panel_ver1.3.0.png"},
			{id = prefix .. "cursor", path = "select_skinparts/default_optionpanel/cursor_ver1.3.0.png"},
		},
		font = {
			{id = prefix .. "font", path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub/sub.fnt"},
			{id = prefix .. "small", path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub_small/sub_small.fnt"},
			{id = prefix .. "choices", path = "select_skinparts/default_detailoptions/font/NotoSansCJKjp-Medium.otf"},
		},
		panel = {}, image = {}, imageset = {}, text = {}, destination = {},
	}
	local function panel(id, color)
		table.insert(parts.panel, {id = prefix .. id, color = color})
	end
	local function sprite(id, src, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. src, x = x, y = y, w = w, h = h})
	end
	local function text(id, ref, size, align, font, outline)
		local font_id = prefix .. (font or "font")
		table.insert(parts.text, {id = prefix .. id, ref = ref, font = font_id,
			size = size, align = align or 0, overflow = 1,
			outlineColor = outline and "000000FF" or nil, outlineWidth = outline})
	end
	local function hit(id, event)
		table.insert(parts.image, {id = prefix .. id, src = -1, w = 1, h = 1, act = event, clickable = true})
	end
	-- Coordinates below use a top-left origin. Match the original 300 ms opening
	-- and closing easing; moving hit areas exist only while E2 is active.
	-- The selected item always lands in the centre slot 3. bmzDetailRaise lifts
	-- whichever column is passing the centre, following the scroll interpolation,
	-- for drawing, hit areas and the frozen exit alike.
	local selected_raise = 24
	local function draw(id, x, y, w, h, options, slot, color, alpha, when)
		-- Drawing column: overscan slot 7 sits left of 0 and slot 8 right of 6.
		local raise = slot and {slot == 7 and -1 or slot == 8 and 7 or slot, selected_raise} or nil
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
			draw = when, bmzDetailScroll = slot and {pitch, 0} or nil, bmzDetailRaise = raise})
		-- Freeze only the seven visible columns on exit. Neither overscan nor hits
		-- should slide back into view, including transitions to the other panels.
		if not id:match("_hit$") and (not slot or slot < 7) then
			local close_op = {19300, -22}
			for _, value in ipairs(options or {}) do table.insert(close_op, value) end
			local close = {time = 0, x = x, y = 1080 - y - h, w = w, h = h, acc = 2, a = alpha or 255}
			if color then close.r, close.g, close.b = color[1], color[2], color[3] end
			table.insert(parts.destination, {id = prefix .. id, op = close_op, timer = 32, loop = -1,
				dst = {close, {time = 300, x = x - 1920}}, draw = when, bmzDetailScroll = slot and {pitch, 0} or nil, bmzDetailRaise = raise})
		end
	end
	panel("shade", "000000B4")
	panel("footer", "10091B90")
	panel("black", "000000FF")
	-- Column colours follow each row's category. These option cards share the
	-- purple card's rounded corners pixel for pixel; each entry is
	-- {source, left, top, right, bottom} of the opaque card (right / bottom exclusive)
	-- the light rim colour the normal cards use for their bottom caption, and the
	-- top of the card's first button (always 16 px inside both sides).
	local cards = {
		blue = {"panel3", 483, 712, 690, 957, {76, 242, 254}, 85}, -- BGA
		green = {"panel1", 749, 334, 956, 702, {76, 254, 97}, 85}, -- groove gauge
		-- GAS supplies the card and buttons. Its wide title reaches both glow
		-- strips, so only the header fill comes from the clean LANE STYLE card.
		orange = {"panel3", 414, 133, 671, 460, {254, 177, 76}, 85, {"panel1", 539, 334, 746}},
		red = {"panel3", 713, 713, 920, 917, {254, 75, 75}, 85}, -- auto adjust
		purple = {"panel", 607, 172, 814, 355, {176, 75, 254}, 105}, -- assist
	}
	-- Index = category_id: 1 LANE / HI-SPEED, 2 GAUGE, 4 LONG NOTE,
	-- 5 ASSIST / MODIFIER, 6 BGA, 7 JUDGE (0 and the retired 3 stay blue).
	local category_colors = {"blue", "blue", "green", "blue", "orange", "purple", "red", "blue"}
	local category_parts = {}
	-- Slice the same part from every card and register an imageset per column
	-- that picks the colour from that row's category_id, so the columns need no
	-- extra destinations or draw conditions.
	local function card_sprite(id, slice, header)
		for name, card in pairs(cards) do
			local source = header and card[8] or card
			local x, y, w, h = slice(source[2], source[3], source[4], source[5], card)
			sprite(id .. "_" .. name, source[1], x, y, w, h)
		end
		table.insert(category_parts, id)
	end
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
		local h, outer, inner, offset = span[1], span[2], span[3], dy
		for corner = 0, 3 do
			local right, bottom = corner % 2 == 1, corner >= 2
			local id = "corner_" .. corner .. "_" .. index
			card_sprite(id, function(l, t, r, b)
				return right and r - inner or l + outer,
					bottom and b - 1 - offset - h or t + 1 + offset, inner - outer, h
			end)
			table.insert(corners, {id, right and width - inner or outer,
				bottom and 550 - dy - h or dy, inner - outer, h})
		end
		if dy >= 7 then
			-- The opaque fill copies the card itself: each rounded top row takes the
			-- header gradient at the same height, from a column clear of the title,
			-- plus the glow inside both rims; bottom rows retain their curved shading.
			local band = "row_" .. index
			card_sprite("grad_" .. band, function(l, t) return l + 24, t + 1 + offset, 1, h end)
			card_sprite("grad_" .. band .. "_l", function(l, t)
				return l + inner, t + 1 + offset, 24 - inner, h
			end)
			card_sprite("grad_" .. band .. "_r", function(_, t, r)
				return r - 24, t + 1 + offset, 24 - inner, h
			end)
			card_sprite("body_" .. band, function(l, _, _, b) return l + 24, b - 1 - offset - h, 1, h end)
			card_sprite("body_" .. band .. "_l", function(l, _, _, b)
				return l + inner, b - 1 - offset - h, 24 - inner, h
			end)
			card_sprite("body_" .. band .. "_r", function(_, _, r, b)
				return r - 24, b - 1 - offset - h, 24 - inner, h
			end)
			table.insert(fill_bands, {dy, h, inner, band})
		end
		dy = dy + h
	end
	card_sprite("top", function(l, t) return l + 24, t + 1, 159, 7 end)
	card_sprite("bottom", function(l, _, _, b) return l + 24, b - 8, 159, 7 end)
	-- Keep the header's bevel at its original height. Stretching it with the body
	-- would change its slope at the join with the unscaled corners.
	card_sprite("left_header", function(l, t) return l, t + 25, 7, 22 end)
	card_sprite("right_header", function(_, t, r) return r - 7, t + 25, 7, 22 end)
	card_sprite("left", function(l, t) return l, t + 70, 7, 1 end)
	card_sprite("right", function(_, t, r) return r - 7, t + 70, 7, 1 end)
	-- Below the corners the header gradient continues to 47 px, then the body is
	-- flat. A 15 px glow runs inside both side rims from top to bottom; cutting it
	-- at the gradient's end would leave a visible step.
	card_sprite("grad", function(l, t) return l + 22, t + 25, 1, 22 end, true)
	card_sprite("grad_l", function(l, t) return l + 7, t + 25, 15, 22 end, true)
	card_sprite("grad_r", function(_, t, r) return r - 22, t + 25, 15, 22 end, true)
	card_sprite("body", function(l, t) return l + 22, t + 70, 1, 1 end)
	card_sprite("glow_l", function(l, t) return l + 7, t + 70, 15, 1 end)
	card_sprite("glow_r", function(_, t, r) return r - 22, t + 70, 15, 1 end)
	-- The button keeps the normal panel's 1:1 height and is three-sliced to fill
	-- the column. Its 15 px rounded caps come from a button on the same-colour
	-- card, so the matte around the rounding is that card's own fill and glow,
	-- which the column draws at the same offsets. The middle column is neutral.
	card_sprite("button_l", function(l, t, _, _, card) return l + 16, t + card[7], 15, 38 end)
	card_sprite("button_r", function(_, t, r, _, card) return r - 31, t + card[7], 15, 38 end)
	sprite("button_m", "panel", 690, 277, 20, 38)
	-- Register every category part above as one imageset per column.
	for slot = 0, 8 do
		for _, part in ipairs(category_parts) do
			local images = {}
			for _, name in ipairs(category_colors) do
				table.insert(images, prefix .. part .. "_" .. name)
			end
			table.insert(parts.imageset, {id = prefix .. part .. "_" .. slot,
				value = 19401 + slot * 10, images = images})
		end
	end
	-- The cursor glows 19 px beyond the button; its caps cover that and the button cap.
	sprite("value_selected_l", "cursor", 0, 500, 37, 76)
	sprite("value_selected_m", "cursor", 96, 500, 20, 76)
	sprite("value_selected_r", "cursor", 176, 500, 37, 76)
	hit("blocker", 0)
	table.insert(parts.destination, {id = prefix .. "blocker", op = {19300, 22}, dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, 22}, timer = 22, loop = 300,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0}, {time = 300, a = 255}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, -22}, timer = 32, loop = -1,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255}, {time = 300, a = 0}}})
	local function border(x, options, slot, alpha)
		for _, piece in ipairs(corners) do
			draw(piece[1] .. "_" .. slot, x + piece[2], 180 + piece[3], piece[4], piece[5],
				options, slot, nil, alpha)
		end
		for _, piece in ipairs({
			{"top", x + 24, 180, width - 48, 7}, {"bottom", x + 24, 723, width - 48, 7},
			{"left_header", x, 204, 7, 22}, {"right_header", x + width - 7, 204, 7, 22},
			{"left", x, 226, 7, 480}, {"right", x + width - 7, 226, 7, 480},
		}) do
			draw(piece[1] .. "_" .. slot, piece[2], piece[3], piece[4], piece[5],
				options, slot, nil, alpha)
		end
	end
	-- Opaque card fill like the normal panel: header gradient, flat body, side glow.
	local function fill(x, row, slot)
		-- Each row is a stretched centre with the unstretched glow edges on top.
		local function three(id, center, y, h, inset, edge)
			edge = edge or 22
			draw(center .. "_" .. slot, x + inset, y, width - inset * 2, h, {row}, slot)
			draw(id .. "_l_" .. slot, x + inset, y, edge - inset, h, {row}, slot)
			draw(id .. "_r_" .. slot, x + width - edge, y, edge - inset, h, {row}, slot)
		end
		for _, band in ipairs(fill_bands) do
			local y, h, inset, id = band[1], band[2], band[3], band[4]
			three("grad_" .. id, "grad_" .. id, 180 + y, h, inset, 24)
			three("body_" .. id, "body_" .. id, 730 - y - h, h, inset, 24)
		end
		three("grad", "grad", 204, 22, 7)
		three("glow", "body", 226, 480, 7)
	end
	local button_width = width - 32
	local function button(x, y, cell, slot)
		draw("button_l_" .. slot, x, y, 15, 38, {cell}, slot)
		draw("button_m", x + 15, y, button_width - 30, 38, {cell}, slot)
		draw("button_r_" .. slot, x + button_width - 15, y, 15, 38, {cell}, slot)
	end
	local function cursor(x, y, options, slot)
		draw("value_selected_l", x - 19, y - 19, 37, 76, options, slot)
		draw("value_selected_m", x + 18, y - 19, button_width - 36, 76, options, slot)
		draw("value_selected_r", x + button_width - 18, y - 19, 37, 76, options, slot)
	end
	-- Header gradient, title, then 1:1 buttons every 41 px as on the normal cards.
	local first = 244
	for slot = 0, 8 do
		local column = slot == 7 and -1 or slot == 8 and 7 or slot
		local x, row, id = left + column * pitch, 19400 + slot * 10, "row_" .. slot
		hit(id .. "_hit", 19310 + slot)
		-- Black-edged like the titles printed on the normal cards.
		text(id .. "_label", row, 24, 1, "choices", 2)
		text(id .. "_caption", row + 3, 14, 1, "choices")
		text(id .. "_status", row + 2, 18, 1, "small")
		text(id .. "_external", row + 1, 26, 1, "choices")
		draw(id .. "_hit", x, 180, width, 550, {row}, slot)
		fill(x, row, slot)
		-- Only the centre slot is ever selected, so each slot draws one rim set.
		if slot == 3 then
			border(x, {row + 1}, slot, 255)
		else
			border(x, {row}, slot, 100)
		end
		draw(id .. "_label", x + width / 2, 198, width - 24, 32, {row}, slot)
		-- Like the normal cards, the English category caption sits at the bottom in
		-- the card's light rim colour.
		for _, name in ipairs({"blue", "green", "orange", "red", "purple"}) do
			local categories, terms = {}, {}
			for category, color in ipairs(category_colors) do
				if color == name and category > 1 then table.insert(categories, category - 1) end
			end
			for _, category in ipairs(categories) do
				table.insert(terms, "number(" .. (row + 1) .. ")==" .. category)
			end
			draw(id .. "_caption", x + width / 2, 702, width - 24, 18, {row}, slot, cards[name][6],
				nil, table.concat(terms, " || "))
		end
		draw(id .. "_status", x + width / 2, 662, width - 24, 22, {row}, slot, {255, 214, 158})
		draw(id .. "_external", x + width / 2, 616, width - 24, 34, {row, row + 4}, slot, {255, 214, 158})
		for choice = 0, 7 do
			local cell = 19500 + slot * 64 + choice * 4
			local name, y = id .. "_choice_" .. choice, first + choice * 41
			hit(name .. "_hit", cell)
			text(name, cell, 20, 1, "choices")
			button(x + 16, y, cell, slot)
		end
		text(id .. "_number", row + 1, 20, 1, "choices")
		-- A number has no choice to highlight: draw it in an unselected button.
		button(x + 16, first, row + 5, slot)
		-- As on the normal panel, finish every button before drawing any cursor.
		-- Otherwise the next button's opaque cap cuts a rectangle out of the glow.
		for choice = 0, 7 do
			local cell, y = 19500 + slot * 64 + choice * 4, first + choice * 41
			cursor(x + 16, y, {cell + 1}, slot)
		end
		-- Labels sit above all glows, including the neighbouring choices' halos.
		for choice = 0, 7 do
			local cell = 19500 + slot * 64 + choice * 4
			local name, y = id .. "_choice_" .. choice, first + choice * 41
			-- Keep the visible cap height and center with Noto Sans CJK's metrics.
			draw(name, x + width / 2, y + 1, 210, 32, {cell, row + 3}, slot)
			draw(name, x + width / 2, y + 1, 210, 32, {cell, -(row + 3)}, slot, {172, 172, 172})
			draw(name .. "_hit", x + 16, y, button_width, 38, {cell + 2}, slot)
		end
		draw(id .. "_number", x + width / 2, first + 1, 210, 32, {row + 5}, slot)
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
