local parts = {}

local function load()
	parts.source = {
		{id = "chartinfo_panel", path = "select_skinparts/default_chart/chartinfo_ver1.2.0.png"},
		{id = "style_judge", path = "select_skinparts/default_chart/judge_keystyle_resize.png"},
		{id = "bpm_font", path = "select_skinparts/default_chart/bpm_font.png"},
		{id = "no_chart", path = "select_skinparts/default_chart/no_chart.png"},
		{id = "chart_count_panel", path = "select_skinparts/default_chart/chart_count_3.png"},
	}

	local flg = false;

	parts.image = {
		--{id = "chart_panel",	src = "chartinfo_panel", x = 0, y = 0, w = 800, h = 229},
		{id = "chart_panel",	src = "chartinfo_panel", x = 0, y = 0, w = 800+38, h = 229+38},
		{id = "no_chart",	src = "no_chart", x = 0, y = 0, w = 800, h = 229},
		{id = "default_info_judge_veryeasy",	src = "style_judge", x = 0, y = 0, w = 120, h = 20},
		{id = "default_info_judge_easy",		src = "style_judge", x = 0, y = 20, w = 120, h = 20},
		{id = "default_info_judge_normal",		src = "style_judge", x = 0, y = 40, w = 120, h = 20},
		{id = "default_info_judge_hard",		src = "style_judge", x = 0, y = 60, w = 120, h = 20},
		{id = "default_info_judge_veryhard",	src = "style_judge", x = 0, y = 80, w = 120, h = 20},
		{id = "default_info_s_5keys",			src = "style_judge", x = 120, y = 0, w = 80, h = 20},
		{id = "default_info_s_7keys",			src = "style_judge", x = 120, y = 20, w = 80, h = 20},
		{id = "default_info_s_9keys",			src = "style_judge", x = 120, y = 40, w = 80, h = 20},
		{id = "default_info_s_10keys",			src = "style_judge", x = 120, y = 60, w = 80, h = 20},
		{id = "default_info_s_14keys",			src = "style_judge", x = 120, y = 80, w = 80, h = 20},
		{id = "default_info_s_24keys",			src = "style_judge", x = 120, y = 100, w = 80, h = 20},
		{id = "default_info_s_24keysDP",		src = "style_judge", x = 120, y = 120, w = 80, h = 20},
		{id = ":_sen",		src = "number_alte", x = 195, y = 75, w = 5, h = 14},
		{id = "dot_sen",		src = "number_alte", x = 175, y = 75, w = 5, h = 5},
		{id = "bpm_sen",		src = "bpm_font", x = 180, y = 0, w = 17, h = 7},
		{id = "chart_count_panel",	src = "chart_count_panel", x = 0, y = 0, w = 254, h = 82},
	}
	
	parts.value = {
		{id = "chart_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, ref = 300, align = 0},
		{id = "totalnote_count",		src = "number_alte", x = 0, y = 50, w = 110, h = 25, divx = 10, digit = 6, ref = 74, align = 0},
		{id = "mainbpm_count",			src = "number_alte", x = 0, y = 50, w = 110, h = 25, divx = 10, digit = 4, ref = 92, align = 0},
		{id = "note_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 350, align = 2},
		{id = "ln_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 351, align = 2},
		{id = "scr_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 352, align = 2},
		{id = "bss_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 353, align = 2},
		{id = "peak_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 360, align = 2},
		{id = "end_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 362, align = 2},
		{id = "ave_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 5, ref = 364, align = 2},
		{id = "total_count",			src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 368, align = 1},
		{id = "songtime_m_count",		src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 2, ref = 1163},
		{id = "songtime_s_count",		src = "number_1", x = 0, y = 40, w = 132, h = 20, divx = 11, digit = 2, ref = 1164},
		{id = "tn_count",	src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 1, value = function()
			if (main_state.option(2))and not(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) then
				if not(flg) then
					main_state.set_timer(timer_nochart.on, main_state.time())
					main_state.set_timer(timer_nochart.off, main_state.timer_off_value)
					flg = true
				end
			else
				if (flg) then
					main_state.set_timer(timer_nochart.off, main_state.time())
					main_state.set_timer(timer_nochart.on, main_state.timer_off_value)
					flg = false
				end
			end
			local total = main_state.number(368)
			local notes = main_state.number(74)
			local tn_value = 0
			if notes > 0 then tn_value = math.floor(total / notes)  end
			return tn_value
		end},
		{id = "tn_dot_count",	src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 3, value = function()
			local total = main_state.number(368)
			local notes = main_state.number(74)
			local tn_dot_value = 0
			if notes > 0 then tn_dot_value = ((total / notes) * 1000) % 1000  end
			return tn_dot_value
		end},
		{id = "bpm_min_count",	src = "bpm_font", x = 0, y = 0, w = 180, h = 30, divx = 10, digit = 4, ref = 91, align = 0, space = -1},
		{id = "bpm_max_count",		src = "bpm_font", x = 0, y = 0, w = 180, h = 30, divx = 10, digit = 4, ref = 90, align = 0, space = -1},
		
	}

	parts.judgegraph = {{
		id = "default_info_notes_graph",
		type = 0,
		backTexOff = 0,
		delay = 500,
		orderReverse = 0,
		noGap = 0,
	}}
	parts.bpmgraph = {{id = "default_info_bpmgraph"}}

	local note_y = 426
	local style_x = 514
	local style_y = 611
	local judge_x = 700
	local judge_y = 581

	local chart_count_x = 770
	local chart_count_y = 550


	parts.destination = {

		{id = "chart_count_panel",	op = {1}, dst = {{x = chart_count_x - 19 + 96, y = chart_count_y - 19, w = 254, h = 82}}},
		{id = "chart_count",	op = {1}, dst = {{x = chart_count_x + 220, y = chart_count_y + 11, w = 12, h = 20}}},

		{id = "chart_panel",	op = {2}, dst = {{x = 308-19, y = 415-19, w = 800+38, h = 229+38}}},
		{id = "totalnote_count", draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end,	dst = {{x = 347, y = 479, w = 11, h = 25}}},
		{id = "mainbpm_count",	dst = {{x = 369, y = 521, w = 11, h = 25, r = 0, g = 229, b = 32}}},
		{id = "note_count",	dst = {{x = 434, y = note_y, w = 12, h = 20}}},
		{id = "ln_count",	dst = {{x = 512, y = note_y, w = 12, h = 20}}},
		{id = "scr_count",	dst = {{x = 581, y = note_y, w = 12, h = 20}}},
		{id = "bss_count",	dst = {{x = 652, y = note_y, w = 12, h = 20}}},
		{id = "peak_count",	dst = {{x = 824, y = note_y, w = 12, h = 20}}},
		{id = "end_count",	dst = {{x = 903, y = note_y, w = 12, h = 20}}},
		{id = "ave_count",	dst = {{x = 976, y = note_y, w = 12, h = 20}}},
		{id = "total_count",	dst = {{x = 700, y = 611, w = 12, h = 20}}},
		{id = "songtime_m_count",	draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = 501, y = 581, w = 12, h = 20, r = 81, g = 212, b = 255}}},
		{id = "songtime_s_count",	draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = 538, y = 581, w = 12, h = 20, r = 81, g = 212, b = 255}}},
		{id = ":_sen", draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end,		op = {2},dst = {{x = 529, y = 584, w = 5, h = 14, r = 81, g = 212, b = 255}}},
		{id = "tn_count",	draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = 762, y = 611, w = 10, h = 17}}},
		{id = "tn_dot_count",	draw = function() return (main_state.option(2))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = 778, y = 611, w = 10, h = 17}}},
		{id = "dot_sen",		op = {2},dst = {{x = 773, y = 612, w = 5, h = 5}}},
		{id = "bpm_min_count",	draw = function() return (main_state.number(91) ~= main_state.number(90)) end, dst = {{x = 859-2, y = 590, w = 18, h = 30}}},
		{id = "bpm_max_count",	draw = function() return (main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = 953-2, y = 590, w = 18, h = 30}}},
		{id = "bpm_sen",		draw = function() return (main_state.number(91) ~= main_state.number(90)) end, op = {2}, dst = {{x = 934-2, y = 603, w = 17, h = 7}}},

		{id = "default_info_s_7keys",		op = {160},		dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_14keys",		op = {162},		dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_9keys",		op = {164},		dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_5keys",		op = {161},		dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_10keys",		op = {163},		dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_24keys",		op = {1160},	dst = {{x = style_x, y = style_y, w = 80, h = 20}}},
		{id = "default_info_s_24keysDP",	op = {1161},	dst = {{x = style_x, y = style_y, w = 80, h = 20}}},

		{id = "default_info_judge_veryeasy",	op = {184},	dst = {{x = judge_x, y = judge_y, w = 120, h = 20}}},
		{id = "default_info_judge_easy",		op = {183},	dst = {{x = judge_x, y = judge_y, w = 120, h = 20}}},
		{id = "default_info_judge_normal",		op = {182},	dst = {{x = judge_x, y = judge_y, w = 120, h = 20}}},
		{id = "default_info_judge_hard",		op = {181},	dst = {{x = judge_x, y = judge_y, w = 120, h = 20}}},
		{id = "default_info_judge_veryhard",	draw = function() return (main_state.option(180))and(main_state.number(74)>0 or main_state.number(92)>0 or main_state.number(368)>0) end, dst = {{x = judge_x, y = judge_y, w = 120, h = 20}}},

		{id = "default_info_notes_graph",	op = {2},	dst = {{x = 420, y = 480, w = 664, h = 90}}},
		{id = "default_info_bpmgraph",		op = {2},	dst = {{x = 420, y = 480, w = 664, h = 90}}},
		
		{id = "no_chart",	loop = 150, op = {2}, timer = timer_nochart.on, dst = {{x = 308, y = 415, w = 800, h = 229, a = 0},{time = 150, a = 255}}},
		{id = "no_chart",	loop = 150, op = {2}, timer = timer_nochart.off, dst = {{x = 308, y = 415, w = 800, h = 229, a = 255},{time = 150, a = 0}}},
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}