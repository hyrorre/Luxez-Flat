local parts = {}

local function load()

	parts.source = {
		{id = "src-default-optionpanel-panel1", path = "select_skinparts/default_optionpanel/option1_panel_ver1.3.0.png"},
		{id = "option1_text", path = "select_skinparts/default_optionpanel/option1_text_ver1.3.0.png"},
		{id = "src-default-optionpanel-panel2", path = "select_skinparts/default_optionpanel/option2_panel_ver1.3.0.png"},
		{id = "option2_text", path = "select_skinparts/default_optionpanel/option2_text_ver1.3.0.png"},
		{id = "src-default-optionpanel-panel3", path = "select_skinparts/default_optionpanel/option3_panel_ver1.3.0.png"},
		{id = "option3_text", path = "select_skinparts/default_optionpanel/option3_text_ver1.3.0.png"},
		{id = "src-default-optionpanel-cursor", path = "select_skinparts/default_optionpanel/option_cursor_resize.png"},
		{id = "cursor", path = "select_skinparts/default_optionpanel/cursor_ver1.3.0.png"},
		{id = "other_option", path = "select_skinparts/default_optionpanel/lane_option_ver1.3.0.png"},
		{id = "gas_limit", path = "select_skinparts/default_optionpanel/gas_low_limit_ver1.3.0.png"},
		{id = "extra_mode", path = "select_skinparts/default_optionpanel/extra_mode_ver1.3.0.png"},
	}

	parts.image = {
		{id = "default_optionpanel_option_panel1",				src = "src-default-optionpanel-panel1", x = 0, y = 0, w = 1920, h = 1080, act = (function() return xxxx() end)},
		{id = "option1_text",				src = "option1_text", x = 0, y = 0, w = 1920, h = 1080},

		{id = "default_optionpanel_option_selector11_2",		src = "cursor", x = 0, y = 41*9, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_3",		src = "cursor", x = 0, y = 41*8, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_4",		src = "cursor", x = 0, y = 41*7, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_5",		src = "cursor", x = 0, y = 41*6, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_6",		src = "cursor", x = 0, y = 41*5, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_7",		src = "cursor", x = 0, y = 41*4, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_8",		src = "cursor", x = 0, y = 41*3, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_9",		src = "cursor", x = 0, y = 41*2, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_10",		src = "cursor", x = 0, y = 41*1, w = 213, h = 576},
		{id = "default_optionpanel_option_selector11_11",		src = "cursor", x = 0, y = 41*0, w = 213, h = 576},
		
				
		{id = "default_optionpanel_option_panel2",				src = "src-default-optionpanel-panel2", x = 0, y = 0, w = 1920, h = 1080, act = (function() return xxxx() end)},
		{id = "option2_text",				src = "option2_text", x = 0, y = 0, w = 1920, h = 1080},

		{id = "default_optionpanel_option_selector21_off",		src = "cursor", x = 0, y = 0, w = 213, h = 76},
		{id = "default_optionpanel_option_selector21_on",		src = "cursor", x = 0, y = 500, w = 213, h = 76},			

		{id = "default_optionpanel_option_panel3",				src = "src-default-optionpanel-panel3", x = 0, y = 0, w = 1920, h = 1080, act = (function() return xxxx() end)},
		{id = "option3_text",				src = "option3_text", x = 0, y = 0, w = 1920, h = 1080},
		
		{id = "default_optionpanel_option_selector31_1",		src = "cursor", x = 213, y = 41*4, w = 263, h = 576},
		{id = "default_optionpanel_option_selector31_2",		src = "cursor", x = 213, y = 41*3, w = 263, h = 576},
		{id = "default_optionpanel_option_selector31_3",		src = "cursor", x = 213, y = 41*2, w = 263, h = 576},
		{id = "default_optionpanel_option_selector31_4",		src = "cursor", x = 213, y = 41*1, w = 263, h = 576},
		{id = "default_optionpanel_option_selector31_5",		src = "cursor", x = 213, y = 41*0, w = 263, h = 576},

		{id = "default_lanecover_button",	src = "other_option", x = 0, y = 0, w = 225, h = 90, divy = 2, len = 2, ref = 330, act = 330},
		{id = "default_liftcover_button",	src = "other_option", x = 0, y = 0, w = 225, h = 90, divy = 2, len = 2, ref = 331, act = 331},
		{id = "default_hidden_button",		src = "other_option", x = 0, y = 0, w = 225, h = 90, divy = 2, len = 2, ref = 332, act = 332},
		{id = "default_hsadjust_button",	src = "other_option", x = 0, y = 0, w = 225, h = 90, divy = 2, len = 2, ref = 342, act = 342},
		{id = "default_constant_button",	src = "other_option", x = 0, y = 0, w = 225, h = 90, divy = 2, len = 2, ref = 400, act = 400},
		{id = "default_coveroption_button_rect",	src = "other_option", x = 0, y = 90, w = 225, h = 45},

		{id = "gas_low_limit", src = "gas_limit", x = 0, y = 0, w = 175, h = 135, divy = 3, len = 3, ref = 341, act = 341},
		{id = "gas_low_limit_rect", src = "gas_limit", x = 0, y = 135, w = 175, h = 45},

		{id = "ex_note",	src = "extra_mode", x = 0, y = 0, w = 175, h = 180, divy = 4, len = 4, ref = 350, act = 350},
		{id = "ex_longnote",	src = "extra_mode", x = 175, y = 0, w = 175, h = 270, divy = 6, len = 6, ref = 353, act = 353},
	}

	parts.imageset = {
--[[ 0.8.4以前
		{id = "default_optionpanel_option_target", ref = 77, images = {
			"default_optionpanel_option_selector11_1","default_optionpanel_option_selector11_2",
			"default_optionpanel_option_selector11_3","default_optionpanel_option_selector11_4",
			"default_optionpanel_option_selector11_5","default_optionpanel_option_selector11_6",
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
--]]
		{id = "default_optionpanel_option_random", ref = 42, images = {
			"default_optionpanel_option_selector11_2",
			"default_optionpanel_option_selector11_3","default_optionpanel_option_selector11_4",
			"default_optionpanel_option_selector11_5","default_optionpanel_option_selector11_6",
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		{id = "default_optionpanel_option_gauge", ref = 40, images = {
			"default_optionpanel_option_selector11_6",
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		{id = "default_optionpanel_option_hsfix", ref = 55, images = {
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		{id = "default_optionpanel_option_random2", ref = 43, images = {
			"default_optionpanel_option_selector11_2",
			"default_optionpanel_option_selector11_3","default_optionpanel_option_selector11_4",
			"default_optionpanel_option_selector11_5","default_optionpanel_option_selector11_6",
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		{id = "default_optionpanel_option_dp", ref = 54, images = {
			"default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		
		{id = "default_optionpanel_option_exjudge", ref = 301, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_regulspeed", ref = 302, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_judgearea", ref = 303, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_legacy", ref = 304, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_marknote", ref = 305, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_bpmguide", ref = 306, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		{id = "default_optionpanel_option_nomine", ref = 307, images = {
			"default_optionpanel_option_selector21_off","default_optionpanel_option_selector21_on"
		}},
		
		{id = "default_optionpanel_option_gas", ref = 78, images = {
			"default_optionpanel_option_selector31_1","default_optionpanel_option_selector31_2",
			"default_optionpanel_option_selector31_3","default_optionpanel_option_selector31_4",
			"default_optionpanel_option_selector31_5"
		}},
		{id = "default_optionpanel_option_bga", ref = 72, images = {
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		{id = "default_optionpanel_option_adjust", ref = 75, images = {
			"default_optionpanel_option_selector11_10","default_optionpanel_option_selector11_11"
		}},
	}

	parts.value = {
		{id = "default_optionpanel_duration",		src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 4, ref = 312},
		{id = "default_optionpanel_duration_green",	src = "number_alte", x = 0, y = 25, w = 140, h = 25, divx = 10, digit = 4, ref = 313},
		{id = "default_optionpanel_judgetiming",	src = "number_alte", x = 140, y = 0, w = 168, h = 50, divx = 12, divy = 2, digit = 4, ref = 12, align = 2},	
	}

	parts.text = {
		{id = "default_optionpanel_target_1",	font = "font_sub_small", size = 18, overflow = 1, ref = 201},
		{id = "default_optionpanel_target_2",	font = "font_sub_small", size = 18, overflow = 1, ref = 202},
		{id = "default_optionpanel_target_3",	font = "font_sub_small", size = 18, overflow = 1, ref = 203},
		{id = "default_optionpanel_target_4",	font = "font_sub_small", size = 18, overflow = 1, ref = 204},
		{id = "default_optionpanel_target_5",	font = "font_sub_small", size = 18, overflow = 1, ref = 205},
		{id = "default_optionpanel_target_6",	font = "font_sub_small", size = 18, overflow = 1, ref = 206},
		{id = "default_optionpanel_target_7",	font = "font_sub_small", size = 18, overflow = 1, ref = 207},
		{id = "default_optionpanel_target_8",	font = "font_sub_small", size = 18, overflow = 1, ref = 208},
		{id = "default_optionpanel_target_9",	font = "font_sub_small", size = 18, overflow = 1, ref = 209},
		{id = "default_optionpanel_target_10",	font = "font_sub_small", size = 18, overflow = 1, ref = 3},
		{id = "default_optionpanel_target_11",	font = "font_sub_small", size = 18, overflow = 1, ref = 210},
		{id = "default_optionpanel_target_12",	font = "font_sub_small", size = 18, overflow = 1, ref = 211},
		{id = "default_optionpanel_target_13",	font = "font_sub_small", size = 18, overflow = 1, ref = 212},
		{id = "default_optionpanel_target_14",	font = "font_sub_small", size = 18, overflow = 1, ref = 213},
		{id = "default_optionpanel_target_15",	font = "font_sub_small", size = 18, overflow = 1, ref = 214},
		{id = "default_optionpanel_target_16",	font = "font_sub_small", size = 18, overflow = 1, ref = 215},
		{id = "default_optionpanel_target_17",	font = "font_sub_small", size = 18, overflow = 1, ref = 216},
		{id = "default_optionpanel_target_18",	font = "font_sub_small", size = 18, overflow = 1, ref = 217},
		{id = "default_optionpanel_target_19",	font = "font_sub_small", size = 18, overflow = 1, ref = 218},
	}
	
	parts.destination = {
		{id = -110, loop = 300, op = {21}, timer = 21,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 180}}},
		{id = -110, loop = 300, op = {-21}, timer = 31,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 180},{time = 300, a = 0}}},
		
		{id = "default_optionpanel_option_panel1",	loop = 300, op = {21}, timer = 21,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel1",	loop = 300, op = {-21}, timer = 31,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},

		{id = "default_optionpanel_option_random",	loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 536, y = 235, w = 213, h = 576}}},
		{id = "default_optionpanel_option_gauge",	loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 746, y = 399, w = 213, h = 576}}},
		{id = "default_optionpanel_option_hsfix",	loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 956, y = 440, w = 213, h = 576}}},
		{id = "default_optionpanel_option_random2",	loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 1166, y = 235, w = 213, h = 576}}},
		{id = "default_optionpanel_option_dp",		loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 851, y = 110, w = 213, h = 576}}},

		{id = "option1_text",	loop = 300, op = {21}, timer = 21,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "option1_text",	loop = 300, op = {-21}, timer = 31,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},



		{id = -110, loop = 300, op = {22}, timer = 22,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 180},}},
		{id = -110, loop = 300, op = {-22}, timer = 32,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 180},{time = 300, a = 0}}},		

		{id = "default_optionpanel_option_panel2",		loop = 300,	op = {22}, timer = 22, dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel2",		loop = 300,	op = {-22}, timer = 32, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},

		{id = "default_optionpanel_option_exjudge",		loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 479 + 250*0, y = 193, w = 213, h = 76}}},
		{id = "default_optionpanel_option_regulspeed",	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 604 + 250*0, y = 746, w = 213, h = 76}}},
		{id = "default_optionpanel_option_judgearea",	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 479 + 250*1, y = 193, w = 213, h = 76}}},
		{id = "default_optionpanel_option_legacy",		loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 604 + 250*1, y = 746, w = 213, h = 76}}},
		{id = "default_optionpanel_option_marknote",	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 479 + 250*2, y = 193, w = 213, h = 76}}},
		{id = "default_optionpanel_option_bpmguide",	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 604 + 250*2, y = 746, w = 213, h = 76}}},
		{id = "default_optionpanel_option_nomine",		loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 479 + 250*3, y = 193, w = 213, h = 76}}},

		{id = "option2_text",		loop = 300,	op = {22}, timer = 22, dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "option2_text",		loop = 300,	op = {-22}, timer = 32, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},

		{id = "ex_note", loop = 300,	op = {22}, timer = 22,	dst = {{time = 300, x = 1435, y = 622, w = 175, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "gas_low_limit_rect",	op = {22}, dst = {{x = 1435, y = 622, w = 175, h = 45}}, mouseRect = {x = 0, y = 0, w = 175, h = 45}},
		{id = "ex_longnote", loop = 300,	op = {22}, timer = 22,	dst = {{time = 300, x = 1435, y = 502, w = 175, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "gas_low_limit_rect",	op = {22}, dst = {{x = 1435, y = 502, w = 175, h = 45}}, mouseRect = {x = 0, y = 0, w = 175, h = 45}},



		{id = -110, loop = 300, op = {23}, timer = 23,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 180}}},
		{id = -110, loop = 300, op = {-23}, timer = 33,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 180},{time = 300, a = 0}}},

		{id = "default_optionpanel_option_panel3",	loop = 300, op = {23}, timer = 23,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel3",	loop = 300, op = {-23}, timer = 33,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},
		{id = "default_lanecover_button",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1375, y = 801 - 50 * 0, w = 225, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "default_liftcover_button",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1375, y = 801 - 50 * 1, w = 225, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "default_hidden_button",		loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1375, y = 801 - 50 * 2, w = 225, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "default_hsadjust_button",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1375, y = 801 - 50 * 3, w = 225, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "default_constant_button",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1375, y = 801 - 50 * 4, w = 225, h = 45, a = 0},{time = 300, a = 255}}},

		{id = "default_optionpanel_option_gas",		loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 411, y = 641, w = 263, h = 576, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_option_bga",		loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 480, y = 144, w = 213, h = 576, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_option_adjust",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 710, y = 184, w = 213, h = 576, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_duration",		loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 939-24, y = 770-27, w = 14, h = 25, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_duration_green",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1014-24, y = 770-27, w = 14, h = 25, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_judgetiming",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1027+14, y = 225+15, w = 14, h = 25, a = 0},{time = 300, a = 255}}},

		{id = "option3_text",	loop = 300, op = {23}, timer = 23,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = 0}}},
		{id = "option3_text",	loop = 300, op = {-23}, timer = 33,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2},{time = 300, x = -1920}}},
		
		{id = "default_coveroption_button_rect",	op = {23}, dst = {{x = 1375, y = 801 - 50 * 0, w = 225, h = 45}}, mouseRect = {x = 0, y = 0, w = 225, h = 45}},
		{id = "default_coveroption_button_rect",	op = {23}, dst = {{x = 1375, y = 801 - 50 * 1, w = 225, h = 45}}, mouseRect = {x = 0, y = 0, w = 225, h = 45}},
		{id = "default_coveroption_button_rect",	op = {23}, dst = {{x = 1375, y = 801 - 50 * 2, w = 225, h = 45}}, mouseRect = {x = 0, y = 0, w = 225, h = 45}},
		{id = "default_coveroption_button_rect",	op = {23}, dst = {{x = 1375, y = 801 - 50 * 3, w = 225, h = 45}}, mouseRect = {x = 0, y = 0, w = 225, h = 45}},
		{id = "default_coveroption_button_rect",	op = {23}, dst = {{x = 1375, y = 801 - 50 * 4, w = 225, h = 45}}, mouseRect = {x = 0, y = 0, w = 225, h = 45}},

		{id = "gas_low_limit", loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 1400, y = 501, w = 175, h = 45, a = 0},{time = 300, a = 255}}},
		{id = "gas_low_limit_rect",	op = {23}, dst = {{x = 1400, y = 501, w = 175, h = 45}}, mouseRect = {x = 0, y = 0, w = 175, h = 45}},


	}

	for i, v in pairs(parts.text) do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, loop = 300, op = {21}, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 230}}})
	end

	-- ir
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,3) == "IR ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 0, g = 255, b = 255}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,3) == "IR ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 0, g = 255, b = 255}}})
	end

	for i = 11, 20 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,3) == "IR ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 0, g = 255, b = 255}}})
	end

	-- rival
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,6) == "RIVAL ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 192, b = 0}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,6) == "RIVAL ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 192, b = 0}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,6) == "RIVAL ") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 192, b = 0}}})
	end

	-- max
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,3) == "MAX") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 0, b = 142}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,3) == "MAX") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 0, b = 142}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,3) == "MAX") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 0, b = 142}}})
	end

	-- a
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,6) == "RANK A") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 128, b = 0}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,6) == "RANK A") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 128, b = 0}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,6) == "RANK A") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 128, b = 0}}})
	end

	-- aa
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,7) == "RANK AA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 210, g = 210, b = 210}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,7) == "RANK AA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 210, g = 210, b = 210}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,7) == "RANK AA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 210, g = 210, b = 210}}})
	end

	-- aaa
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,8) == "RANK AAA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 246, b = 0}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,8) == "RANK AAA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 246, b = 0}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,8) == "RANK AAA") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 246, b = 0}}})
	end

	-- NEXT RANK
	for i = 1, 9 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i):sub(1,9) == "NEXT RANK") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 153, b = 173}}})
	end

	for i = 10, 10 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(3):sub(1,9) == "NEXT RANK") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 153, b = 173}}})
	end

	for i = 11, 19 do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, draw = function() return (main_state.option(21) and main_state.text(200+i-1):sub(1,9) == "NEXT RANK") end, loop = 300, timer = 21, dst = {{time = 300, x = 276 + 10, y = 801 - 31 - ((37 - 2) * (i - 1)), w = 190, h = 18, a = 255, r = 255, g = 153, b = 173}}})
	end
	
	return parts	
end

return {
	parts = parts,
	load = load
}