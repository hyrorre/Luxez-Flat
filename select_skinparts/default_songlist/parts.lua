local parts = {}

local function load()
	
	local TOV = main_state.timer_off_value
	
	local op_timer = {
		alloff	= get_customTimer_id(),
		assist	= get_customTimer_id(),
		dp		= get_customTimer_id(),
		dop		= get_customTimer_id(),
		ex		= get_customTimer_id()
	}

	parts.source = {
		{id = "src-default-songlist2-songbar",		path = "select_skinparts/default_songlist/songbar.png"},
		{id = "clearlamp",	path = "select_skinparts/default_songlist/clearlamp_resize.png"},
		{id = "level_count",	path = "select_skinparts/default_songlist/level_count_resize.png"},
		{id = "ln",	path = "select_skinparts/default_songlist/songlist_ln_resize.png"},
		{id = "select_cursor",	path = "select_skinparts/default_songlist/select_cursor_resize.png"},
		{id = "select_cursor_yazirushi",	path = "select_skinparts/default_songlist/select_cursor_yazirushi.png"},
		{id = "select_cursor_yazirushi_up",	path = "select_skinparts/default_songlist/select_cursor_yazirushi_big_up.png"},
		{id = "select_cursor_yazirushi_down",	path = "select_skinparts/default_songlist/select_cursor_yazirushi_big_down.png"},
		{id = "lamp_graph",	path = "select_skinparts/default_songlist/lamp_graph_resize.png"},
		{id = "trophy",	path = "select_skinparts/default_songlist/trophy_resize.png"},
		{id = "warning",	path = "select_skinparts/default_songlist/warning.png"},
	}

	parts.image = {
		{id = "default_songlist2_bar_song",		src = "src-default-songlist2-songbar", x = 0, y = 0, w = 750, h = 54},
		{id = "default_songlist2_bar_folder",	src = "src-default-songlist2-songbar", x = 0, y = 54, w = 750, h = 54},
		{id = "default_songlist2_bar_table",	src = "src-default-songlist2-songbar", x = 0, y = 108, w = 750, h = 54},
		{id = "default_songlist2_bar_grade",	src = "src-default-songlist2-songbar", x = 0, y = 162, w = 750, h = 54},
		{id = "default_songlist2_bar_nograde",	src = "src-default-songlist2-songbar", x = 0, y = 216, w = 750, h = 54},
		{id = "default_songlist2_bar_command",	src = "src-default-songlist2-songbar", x = 0, y = 270, w = 750, h = 54},
		{id = "default_songlist2_bar_search",	src = "src-default-songlist2-songbar", x = 0, y = 324, w = 750, h = 54},
		{id = "default_songlist2_bar_nosong",	src = "src-default-songlist2-songbar", x = 0, y = 378, w = 750, h = 54},

		{id = "default_songlist2_lamp_noplay",	src = "clearlamp", x = 0, y = 0, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_failed",	src = "clearlamp", x = 0, y = 72, w = 84, h = 72, divx = 2, cycle = 50},
		{id = "default_songlist2_lamp_assist",	src = "clearlamp", x = 0, y = 144, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_lassist",	src = "clearlamp", x = 0, y = 216, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_easy",	src = "clearlamp", x = 0, y = 288, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_normal",	src = "clearlamp", x = 0, y = 360, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_hard",	src = "clearlamp", x = 0, y = 432, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_exhard",	src = "clearlamp", x = 0, y = 504, w = 84, h = 72, divx = 2, cycle = 100},
		{id = "default_songlist2_lamp_fc",		src = "clearlamp", x = 0, y = 576, w = 126, h = 72, divx = 3, cycle = 150},
		{id = "default_songlist2_lamp_perfect",	src = "clearlamp", x = 0, y = 648, w = 126, h = 72, divx = 3, cycle = 150},
		{id = "default_songlist2_lamp_max",		src = "clearlamp", x = 0, y = 720, w = 84, h = 72, divx = 2, cycle = 100},
		
		{id = "default_songlist2_lamp_noplay_p",	src = "clearlamp", x = 126, y = 0, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_failed_p",	src = "clearlamp", x = 126, y = 72, w = 84, h = 72, divx = 2, cycle = 50},
		{id = "default_songlist2_lamp_assist_p",	src = "clearlamp", x = 126, y = 144, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_lassist_p",	src = "clearlamp", x = 126, y = 216, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_easy_p",		src = "clearlamp", x = 126, y = 288, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_normal_p",	src = "clearlamp", x = 126, y = 360, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_hard_p",		src = "clearlamp", x = 126, y = 432, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_exhard_p",	src = "clearlamp", x = 126, y = 504, w = 84, h = 72, divx = 2, cycle = 100},
		{id = "default_songlist2_lamp_fc_p",		src = "clearlamp", x = 126, y = 576, w = 126, h = 72, divx = 3, cycle = 150},
		{id = "default_songlist2_lamp_perfect_p",	src = "clearlamp", x = 126, y = 648, w = 126, h = 72, divx = 3, cycle = 150},
		{id = "default_songlist2_lamp_max_p",		src = "clearlamp", x = 126, y = 720, w = 84, h = 72, divx = 2, cycle = 100},
		
		{id = "default_songlist2_lamp_noplay_r",	src = "clearlamp", x = 252, y = 0, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_failed_r",	src = "clearlamp", x = 252, y = 72, w = 84, h = 72, divx = 2, cycle = 50},
		{id = "default_songlist2_lamp_assist_r",	src = "clearlamp", x = 252, y = 144, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_lassist_r",	src = "clearlamp", x = 252, y = 216, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_easy_r",		src = "clearlamp", x = 252, y = 288, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_normal_r",	src = "clearlamp", x = 252, y = 360, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_hard_r",		src = "clearlamp", x = 252, y = 432, w = 42, h = 72, divx = 1},
		{id = "default_songlist2_lamp_exhard_r",	src = "clearlamp", x = 252, y = 504, w = 84, h = 72, divx = 2, cycle = 100},
		{id = "default_songlist2_lamp_fc_r",		src = "clearlamp", x = 252, y = 576, w = 126, h = 72, divx = 3, cycle = 150},
		{id = "default_songlist2_lamp_perfect_r",	src = "clearlamp", x = 252, y = 648, w = 84, h = 72, divx = 2, cycle = 100},
		{id = "default_songlist2_lamp_max_r",		src = "clearlamp", x = 252, y = 720, w = 84, h = 72, divx = 2, cycle = 100},
		
		{id = "default_songlist2_trophy_bronze",	src = "trophy", x = 120, y = 0, w = 60, h = 44},
		{id = "default_songlist2_trophy_silver",	src = "trophy", x = 60, y = 0, w = 60, h = 44},
		{id = "default_songlist2_trophy_gold",		src = "trophy", x = 0, y = 0, w = 60, h = 44},
		
		{id = "default_songlist2_label_ln",			src = "ln", x = 0, y = 0, w = 40, h = 30},
		{id = "default_songlist2_label_cn",			src = "ln", x = 40, y = 0, w = 40, h = 30},
		{id = "default_songlist2_label_hcn",		src = "ln", x = 80, y = 0, w = 40, h = 30},
		{id = "default_songlist2_label_random",		src = "ln", x = 120, y = 0, w = 70, h = 20},
		{id = "default_songlist2_label_mine",		src = "ln", x = 120, y = 20, w = 70, h = 20},
		
		{id = "default_songlist2_bar_select",		src = "select_cursor", x = 0, y = 0, w = 770, h = 94},
		{id = "default_songlist2_bar_select_left",		src = "select_cursor", x = 0, y = 0, w = 25, h = 94},
		{id = "default_songlist2_bar_select_right",		src = "select_cursor", x = 25, y = 0, w = 770-25, h = 94},
		{id = "default_songlist2_bar_select_yazirushi",		src = "select_cursor_yazirushi", x = 0, y = 0, w = 770, h = 94},
		{id = "default_songlist2_bar_select_yazirushi_up",		src = "select_cursor_yazirushi_up", x = 0, y = 0, w = 52, h = 37},
		{id = "default_songlist2_bar_select_yazirushi_down",		src = "select_cursor_yazirushi_down", x = 0, y = 0, w = 52, h = 37},

		{id = "warning_dp",		src = "warning", x = 0, y = 0, w = 669, h = 42},
		{id = "warning_ex",		src = "warning", x = 0, y = 42, w = 669, h = 42},  
		{id = "warning_assist",		src = "warning", x = 0, y = 84, w = 669, h = 42},
	}

	parts.imageset = {
		{id = "default_songlist2_bar", images = {
			"default_songlist2_bar_song","default_songlist2_bar_folder",
			"default_songlist2_bar_table","default_songlist2_bar_grade",
			"default_songlist2_bar_nograde","default_songlist2_bar_command",
			"default_songlist2_bar_search","default_songlist2_bar_nosong"
		}},
	}

	parts.value = {
		{id = "default_songlist2_playlevel_bar", src = "level_count", x = 0, y = 0, w = 360, h = 31, divx = 10, digit = 2},
	}

	parts.text = {
		{id = "default_songlist2_bartext", font = "font_songlist", size = 30, overflow = 1},
	}
	
	parts.graph = {
		{id = "lamp_graph", src = "lamp_graph", x = 0, y = 0, w = 11, h = 180, divx = 11, divy = 6, cycle = 100, type = -1},
	}
	
	local t_listoff = {}
	local t_liston = {}
	local t_lamp = {}
	local t_playerlamp = {}
	local t_rivallamp = {}
	
	do		
		local bar_num		= 20
		
		local list_x_off	= 1200
		local list_x_on		= list_x_off - 30
		local list_w		= 750
		local list_h		= 54 --1080 / bar_num
		
		local lamp_w		= 42
		local lamp_h		= list_h + 18
		local lamp_x		= -9
		local lamp_y		= -9
		
		local bar_roop		 = 30
		
		do
			local list_y = 1161
			for i = 1, bar_num + 4, 1 do
				table.insert(t_listoff, {id = "default_songlist2_bar", loop = (bar_roop * i), dst = {{time = 0, x = 1920, y = list_y, w = list_w, h = list_h, acc = 2},{time = (bar_roop * i), x = list_x_off}}})
				table.insert(t_liston,  {id = "default_songlist2_bar", dst = {{x = list_x_on, y = list_y, w = list_w, h = list_h}}})
				list_y = list_y - list_h
			end
			
			local lamp_category = {
				"default_songlist2_lamp_noplay","default_songlist2_lamp_failed",
				"default_songlist2_lamp_assist","default_songlist2_lamp_lassist",
				"default_songlist2_lamp_easy","default_songlist2_lamp_normal",
				"default_songlist2_lamp_hard","default_songlist2_lamp_exhard",
				"default_songlist2_lamp_fc","default_songlist2_lamp_perfect",
				"default_songlist2_lamp_max"
			}
			for i, v in ipairs(lamp_category) do
				table.insert(t_lamp,		{id = v, blend = 2, dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
				table.insert(t_playerlamp,	{id = v .. "_p", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
				table.insert(t_rivallamp,	{id = v .. "_r", dst = {{x = lamp_x, y = lamp_y, w = lamp_w, h = lamp_h}}})
			end
		end
	end

	parts.songlist = {
		id = "default_songlist2",
		center = 12,
		clickable = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23},
		listoff = t_listoff,
		liston  = t_liston,
		text = {
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30}}},						-- 通常
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, b = 153}}},				-- 新規
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30}}},						-- SongBar通常
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, b = 153}}},				-- SongBar新規
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, b = 245}}},				-- FolderBar通常
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, b = 153}}},				-- FolderBar新規
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, r = 245, g = 245}}},	-- TableBar or HashBar
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, r = 245, b = 245}}},	-- GradeBar
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, g = 153, b = 153}}},	-- SongBar or GradeBar（曲未所持）
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, g = 245}}},				-- CommandBar or ContainerBar
			{id = "default_songlist2_bartext",  filter = 1, dst = {{x = 138, y = 8, w = 540, h = 30, r = 245}}},				-- SearchWordBar
		},

--[[
		level = {
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31}}},								-- 難易度未定義
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 50+15+10, b = 50+15+10}}},				-- BEGINNER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 75+20+10, g = 223+20+5}}},				-- NORMAL
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 255, g = 155+5, b = 85+10}}},				-- HYPER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 255, g = 50+10+10, b = 50+10+10}}},		-- ANOTHER
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 194+20+5, g = 50+20+10, b = 255}}},		-- INSANE
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31, r = 152+10+5, g = 152+10+5, b = 152+10+5}}},	-- IR RANKING
		},
]]

		level = {
			{id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31}}},								-- 難易度未定義
			-- {id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 50+15+20, b = 50+15+20}}},				-- BEGINNER
						{id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 64, b = 64}}},				-- BEGINNER
			-- {id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 75+20+20, g = 223+20+10}}},				-- NORMAL
						{id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 64}}},				-- NORMAL
			-- {id = "default_songlist2_playlevel_bar", blend = 0,  dst = {{x = 32, y = 11, w = 36, h = 31, r = 255, g = 155+10, b = 85+20}}},				-- HYPER
			{id = "default_songlist2_playlevel_bar", blend = 0,  dst = {{x = 32, y = 11, w = 36, h = 31, g = 166, b = 64}}},
			-- {id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 255, g = 50+10+20, b = 50+10+20}}},		-- ANOTHER
			-- {id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 194+20+10, g = 50+20+20, b = 255}}},		-- INSANE			-- HYPER
			{id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, g = 64, b = 64}}},		-- ANOTHER
			{id = "default_songlist2_playlevel_bar", blend = 0, dst = {{x = 32, y = 11, w = 36, h = 31, r = 207, g = 64, b = 255}}},		-- INSANE
			{id = "default_songlist2_playlevel_bar", dst = {{x = 32, y = 11, w = 36, h = 31}}},	-- IR RANKING
		},

		lamp = t_lamp,
		playerlamp = t_playerlamp,
		rivallamp = t_rivallamp,
		trophy = {
			{id = "default_songlist2_trophy_bronze", dst = {{x = 38, y = 5, w = 60, h = 44}}},
			{id = "default_songlist2_trophy_silver", dst = {{x = 38, y = 5, w = 60, h = 44}}},
			{id = "default_songlist2_trophy_gold", dst = {{x = 38, y = 5, w = 60, h = 44}}},
		},
--[[	label = {
			{id = "default_songlist2_label_ln",		dst = {{x = -50, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_random",	dst = {{x = 620, y = 5, w = 60, h = 20}}},
			{id = "default_songlist2_label_mine",	dst = {{x = 620, y = 29, w = 60, h = 20}}},
			{id = "default_songlist2_label_cn",		dst = {{x = -50, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_hcn",	dst = {{x = -50, y = 12, w = 40, h = 30}}},
		},]]
		label = {
			{id = "default_songlist2_label_ln",		dst = {{x = -50, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_random",	loop = 0, dst = {{time = 0, x = 610, y = 5, w = 70, h = 20, a = 255},{time = 1500, a = 80},{time = 3000, a = 255}}},
			{id = "default_songlist2_label_mine",	loop = 0, dst = {{time = 0, x = 610, y = 29, w = 70, h = 20, a = 255},{time = 1500, a = 80},{time = 3000, a = 255}}},
			{id = "default_songlist2_label_cn",		dst = {{x = -50, y = 12, w = 40, h = 30}}},
			{id = "default_songlist2_label_hcn",	dst = {{x = -50, y = 12, w = 40, h = 30}}},
		},
		graph = {id = "lamp_graph", dst = {{x = 50, y = 5, w = 500, h = 5}}}
	}
	
	parts.destination = {
		{id = "default_songlist2"},
		--{id = "default_songlist2_bar_select", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 255, b = 255},{time = 800, r = 100, g = 255, b = 255},{time = 2000, r = 70, g = 255, b = 255},{time = 2050, r = 230, g = 255, b = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 20, g = 255, b = 255}}},
		{id = "default_songlist2_bar_select_left", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 25, h = 94, r = 255, g = 255, b = 255, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_right", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150+25, y = 493, w = 1, h = 94, r = 255, g = 255, b = 255, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2000, w = 770-25},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_yazirushi", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 20, g = 255, b = 255}}},
		{id = "default_songlist2_bar_select_yazirushi_up", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493+73, w = 52, h = 37, r = 20, g = 255, b = 255, a = 0},{time = 200, y = 493+73+2, a = 255},{time = 1000, y = 493+73+10},{time = 1200, y = 493+73+12, a = 0},{time = 1500}}},
		{id = "default_songlist2_bar_select_yazirushi_down", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493-17, w = 52, h = 37, r = 20, g = 255, b = 255},{time = 200, y = 493-17-2, a = 255},{time = 1000, y = 493-17-10},{time = 1200, y = 493-17-12, a = 0},{time = 1500}}},

		--{id = "default_songlist2_bar_select", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 161, b = 161},{time = 800, r = 255, g = 64, b = 64},{time = 850,  r = 255, g = 161, b = 161}}},
		{id = "default_songlist2_bar_select", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 64, b = 64}}},
		{id = "default_songlist2_bar_select_left", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 25, h = 94, r = 255, g = 161, b = 161, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_right", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150+25, y = 493, w = 1, h = 94, r = 255, g = 161, b = 161, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2000, w = 770-25},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_yazirushi", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 64, b = 64}}},
		{id = "default_songlist2_bar_select_yazirushi_up", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493+73, w = 52, h = 37, r = 255, g = 64, b = 64, a = 0},{time = 200, y = 493+73+2, a = 255},{time = 1000, y = 493+73+10},{time = 1200, y = 493+73+12, a = 0},{time = 1500}}},
		{id = "default_songlist2_bar_select_yazirushi_down", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493-17, w = 52, h = 37, r = 255, g = 64, b = 64},{time = 200, y = 493-17-2, a = 255},{time = 1000, y = 493-17-10},{time = 1200, y = 493-17-12, a = 0},{time = 1500}}},

		--{id = "default_songlist2_bar_select", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 161, b = 255},{time = 800, r = 255, g = 65, b = 255},{time = 850, r = 255, g = 161, b = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 65, b = 255}}},
		{id = "default_songlist2_bar_select_left", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 25, h = 94, r = 255, g = 161, b = 255, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_right", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150+25, y = 493, w = 1, h = 94, r = 255, g = 161, b = 255, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2000, w = 770-25},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_yazirushi", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 65, b = 255}}},
		{id = "default_songlist2_bar_select_yazirushi_up", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493+73, w = 52, h = 37, r = 255, g = 65, b = 255, a = 0},{time = 200, y = 493+73+2, a = 255},{time = 1000, y = 493+73+10},{time = 1200, y = 493+73+12, a = 0},{time = 1500}}},
		{id = "default_songlist2_bar_select_yazirushi_down", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493-17, w = 52, h = 37, r = 255, g = 65, b = 255},{time = 200, y = 493-17-2, a = 255},{time = 1000, y = 493-17-10},{time = 1200, y = 493-17-12, a = 0},{time = 1500}}},


		--{id = "default_songlist2_bar_select", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 205, g = 205, b = 205},{time = 800, r = 150, g = 150, b = 0},{time = 850, r = 205, g = 205, b = 205}}},
		{id = "default_songlist2_bar_select", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 150, g = 150, b = 0}}},
		{id = "default_songlist2_bar_select_left", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 25, h = 94, r = 205, g = 205, b = 205, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_right", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150+25, y = 493, w = 1, h = 94, r = 205, g = 205, b = 205, a = 0},{time = 1000},{time = 1020, a = 170},{time = 2000, w = 770-25},{time = 2500},{time = 3000, a = 0},{time = 4000}}},
		{id = "default_songlist2_bar_select_yazirushi", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 150, g = 150, b = 0}}},
		{id = "default_songlist2_bar_select_yazirushi_up", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493+73, w = 52, h = 37, r = 150, g = 150, b = 0, a = 0},{time = 200, y = 493+73+2, a = 255},{time = 1000, y = 493+73+10},{time = 1200, y = 493+73+12, a = 0},{time = 1500}}},
		{id = "default_songlist2_bar_select_yazirushi_down", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150+598, y = 493-17, w = 52, h = 37, r = 150, g = 150, b = 0},{time = 200, y = 493-17-2, a = 255},{time = 1000, y = 493-17-10},{time = 1200, y = 493-17-12, a = 0},{time = 1500}}},

		
		--[[{id = "default_songlist2_bar_select", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 230, g = 255, b = 255, a = 255},{time = 2000, r = 150, g = 255, b = 255, a = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 255, b = 210, a = 210},{time = 800, r = 255, g = 100, b = 100,a = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 255, b = 210, a = 255},{time = 800, r = 255, g = 100, b = 255,a = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 230, g = 230, b = 255, a = 255},{time = 800, r = 180, g = 180, b = 0,a = 255}}},
		]]
		--[[
		{id = "default_songlist2_bar_select", timer = op_timer.alloff, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 230, g = 255, b = 255, a = 255},{time = 2000, r = 150, g = 255, b = 255, a = 200}}},
		{id = "default_songlist2_bar_select", timer = op_timer.dp, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 230, b = 230, a = 255},{time = 800, r = 255, g = 130, b = 130,a = 255}}},
		{id = "default_songlist2_bar_select", timer = op_timer.assist, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 230, b = 255, a = 255},{time = 800, r = 255, g = 130, b = 255,a = 200}}},
		{id = "default_songlist2_bar_select", timer = op_timer.ex, loop = 0, blend = 2, dst = {{time = 0, x = 1150, y = 493, w = 770, h = 94, r = 255, g = 255, b = 255, a = 255},{time = 800, r = 255, g = 255, b = 50,a = 200}}},
		]]

		{id = "warning_dp",		timer = op_timer.dp, loop = 120, dst = {{time = 0,x = 1920-669, y = 481, w = 669, h = 42, a = 0},{time = 120, a = 255}}},
		{id = "warning_ex",		timer = op_timer.ex, loop = 120, dst = {{time = 0,x = 1920-669, y = 481, w = 669, h = 42, a = 0},{time = 120, a = 255}}},
		{id = "warning_assist",		timer = op_timer.assist, loop = 120, dst = {{time = 0,x = 1920-669, y = 481, w = 669, h = 42, a = 0},{time = 120, a = 255}}},

	}

	parts.customTimers = {
		{id = op_timer.alloff},
		{id = op_timer.assist},
		{id = op_timer.dp},
		{id = op_timer.dop},
		{id = op_timer.ex},
		{id = get_customTimer_id(), timer = function()
			-- DPオプションの監視
			if	not(main_state.event_index(54) == 0
			or	main_state.event_index(54) == 1) then
				if main_state.timer(op_timer.dp) == TOV then
					main_state.set_timer(op_timer.dp, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.ex, TOV)
				end
				
			-- EXオプションの監視
			elseif	not(main_state.event_index(350) == 0
			and	(main_state.event_index(351) == 0 or main_state.event_index(351) == 1)
			and	(main_state.event_index(352) == 0 or main_state.event_index(352) == 1)
			and	(main_state.event_index(353) == 0 or main_state.event_index(353) == 1)) then
				if main_state.timer(op_timer.ex) == TOV then
					main_state.set_timer(op_timer.ex, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.dp, TOV)
				end

			-- アシストオプションの監視
			elseif	not((main_state.event_index(301) == 0
			and	main_state.event_index(302) == 0
			and	main_state.event_index(303) == 0
			and	main_state.event_index(304) == 0
			and	main_state.event_index(305) == 0
			and	main_state.event_index(306) == 0
			and	main_state.event_index(307) == 0) and 
			( 
				main_state.event_index(42) >= 0  and
				main_state.event_index(42) <= 4
			) and
			( 
				main_state.event_index(43) >= 0  and
				main_state.event_index(43) <= 4
			)
			) then
				if main_state.timer(op_timer.assist) == TOV then
					main_state.set_timer(op_timer.assist, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.dp, TOV)
					main_state.set_timer(op_timer.ex, TOV)
				end
				
			

			-- 全部OFFの監視
			else
				if main_state.timer(op_timer.alloff) == TOV then
					main_state.set_timer(op_timer.alloff, main_state.time())
					main_state.set_timer(op_timer.dp, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.ex, TOV)
				end
			end

			-- 全部OFFの監視
			--[[if	(main_state.event_index(54) == 0
			or	main_state.event_index(54) == 1) and 
			(main_state.event_index(301) == 0
			and	main_state.event_index(302) == 0
			and	main_state.event_index(303) == 0
			and	main_state.event_index(304) == 0
			and	main_state.event_index(305) == 0
			and	main_state.event_index(306) == 0
			and	main_state.event_index(307) == 0) and
			(main_state.event_index(350) == 0
			and	(main_state.event_index(351) == 0 or main_state.event_index(351) == 1)
			and	(main_state.event_index(352) == 0 or main_state.event_index(352) == 1)
			and	(main_state.event_index(353) == 0 or main_state.event_index(353) == 1))
			then
				if main_state.timer(op_timer.alloff) == TOV then
					main_state.set_timer(op_timer.alloff, main_state.time())
					main_state.set_timer(op_timer.dp, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.ex, TOV)
					return 
				end
			else
				main_state.set_timer(op_timer.alloff, TOV)
			end
			-- DPオプションの監視
			if	main_state.event_index(54) == 0
			or	main_state.event_index(54) == 1 then
				main_state.set_timer(op_timer.dp, TOV)
			else
				if main_state.timer(op_timer.dp) == TOV then
					main_state.set_timer(op_timer.dp, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.ex, TOV)
					return
				end
			end
			-- アシストオプションの監視
			if	main_state.event_index(301) == 0
			and	main_state.event_index(302) == 0
			and	main_state.event_index(303) == 0
			and	main_state.event_index(304) == 0
			and	main_state.event_index(305) == 0
			and	main_state.event_index(306) == 0
			and	main_state.event_index(307) == 0
			then
				main_state.set_timer(op_timer.assist, TOV)
			else
				if main_state.timer(op_timer.assist) == TOV then
					main_state.set_timer(op_timer.assist, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.dp, TOV)
					main_state.set_timer(op_timer.ex, TOV)
					return
				end
			end
			-- EXオプションの監視
			if	main_state.event_index(350) == 0
			and	(main_state.event_index(351) == 0 or main_state.event_index(351) == 1)
			and	(main_state.event_index(352) == 0 or main_state.event_index(352) == 1)
			and	(main_state.event_index(353) == 0 or main_state.event_index(353) == 1)
			then
				main_state.set_timer(op_timer.ex, TOV)
			else
				if main_state.timer(op_timer.ex) == TOV then
					main_state.set_timer(op_timer.ex, main_state.time())
					main_state.set_timer(op_timer.alloff, TOV)
					main_state.set_timer(op_timer.assist, TOV)
					main_state.set_timer(op_timer.dp, TOV)
					return
				end
			end
			--]]
		end}
	}

	return parts
end

return {
	parts = parts,
	load = load
}