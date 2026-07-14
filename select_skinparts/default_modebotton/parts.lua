local parts = {}

local OP_IR_DATA = get_property_op()
local OP_JUDGE_DETAIL =	get_property_op()

parts.property = {
	{name = "表示情報", item = {
		{name = "IR DATA（NETWORK OFF時のみJUDGE DETAIL）",		op = OP_IR_DATA},
		{name = "JUDGE DETAIL",		op = OP_JUDGE_DETAIL},
	},def = "IR DATA（NETWORK OFF時のみJUDGE DETAIL）"},
}

local function load()
	local flg = false
	local flg2 = false
	local flg3 = false

	rank_plus = true

	help_number = 1

	local timer = {
		on	= get_customTimer_id(),
		off	= get_customTimer_id()
	}

	local timer2 = {
		on	= get_customTimer_id(),
		off	= get_customTimer_id()
	}

	local timer3 = {
		on	= get_customTimer_id(),
		off	= get_customTimer_id()
	}

	local function help_open()
		flg = not flg
		if flg then
			main_state.set_timer(timer.on, main_state.time())
			main_state.set_timer(timer.off, main_state.timer_off_value)
			main_state.audio_play(skin_config.get_path("customize/sound/help_window_open.wav"))
			if flg3 then
				flg3 = false
				main_state.set_timer(timer3.off, main_state.time())
				main_state.set_timer(timer3.on, main_state.timer_off_value)
			elseif flg2 then
				flg2 = false
				main_state.set_timer(timer2.off, main_state.time())
				main_state.set_timer(timer2.on, main_state.timer_off_value)
			end
		else
			main_state.set_timer(timer.off, main_state.time())
			main_state.set_timer(timer.on, main_state.timer_off_value)
			main_state.audio_play(skin_config.get_path("customize/sound/help_window_close.wav"))
		end
	end

	local function settings_open()
		flg2 = not flg2
		if flg2 then
			main_state.audio_play(skin_config.get_path("customize/sound/window_open.wav"))
			main_state.set_timer(timer2.on, main_state.time())
			main_state.set_timer(timer2.off, main_state.timer_off_value)
			if flg then
				flg = false
				main_state.set_timer(timer.off, main_state.time())
				main_state.set_timer(timer.on, main_state.timer_off_value)
			elseif flg3 then
				flg3 = false
				main_state.set_timer(timer3.off, main_state.time())
				main_state.set_timer(timer3.on, main_state.timer_off_value)
			end
		else
			main_state.set_timer(timer2.off, main_state.time())
			main_state.set_timer(timer2.on, main_state.timer_off_value)
			main_state.audio_play(skin_config.get_path("customize/sound/window_close.wav"))
		end
	end

	local function score_detail_open()
		flg3 = not flg3
		if flg3 then
			main_state.audio_play(skin_config.get_path("customize/sound/window_open.wav"))
			main_state.set_timer(timer3.on, main_state.time())
			main_state.set_timer(timer3.off, main_state.timer_off_value)
			if flg then
				flg = false
				main_state.set_timer(timer.off, main_state.time())
				main_state.set_timer(timer.on, main_state.timer_off_value)
			elseif flg2 then
				flg2 = false
				main_state.set_timer(timer2.off, main_state.time())
				main_state.set_timer(timer2.on, main_state.timer_off_value)
			end
		else
			main_state.set_timer(timer3.off, main_state.time())
			main_state.set_timer(timer3.on, main_state.timer_off_value)
			main_state.audio_play(skin_config.get_path("customize/sound/window_close.wav"))
		end
	end

	local function help_1()
		if not(help_number == 1) then
			help_number = 1
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_2()
		if not(help_number == 2) then
			help_number = 2
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_3()
		if not(help_number == 3) then
			help_number = 3
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_4()
		if not(help_number == 4) then
			help_number = 4
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_5()
		if not(help_number == 5) then
			help_number = 5
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_6()
		if not(help_number == 6) then
			help_number = 6
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_7()
		if not(help_number == 7) then
			help_number = 7
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_8()
		if not(help_number == 8) then
			help_number = 8
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_9()
		if not(help_number == 9) then
			help_number = 9
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_10()
		if not(help_number == 10) then
			help_number = 10
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_11()
		if not(help_number == 11) then
			help_number = 11
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	local function help_12()
		if not(help_number == 12) then
			help_number = 12
			main_state.audio_play(skin_config.get_path("customize/sound/help_page_change.wav"))
		end
	end

	-- 自身の順位枠か
	function isMyFrame(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		local myRank = main_state.number(179)
		local isyou = main_state.text(119 + indexNum) == "YOU"
		return (indexRank == myRank) and isyou
	end

	-- 1位か
	function isrank1(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 1)
	end

	-- 2位か
	function isrank2(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 2)
	end

	-- 3位か
	function isrank3(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 3)
	end

	-- 3位以内か
	function is1to3(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 1) or (indexRank == 2) or (indexRank == 3)
	end

	-- 10位以内か
	function is1to10(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 1) or (indexRank == 2) or (indexRank == 3) or (indexRank == 4) or (indexRank == 5) or (indexRank == 6) or (indexRank == 7) or (indexRank == 8) or (indexRank == 9) or (indexRank == 10)
	end


	parts.source = {
		{id = "modebotton", path = "select_skinparts/default_modebotton/modebotton_resize.png"},
		{id = "off", path = "select_skinparts/default_modebotton/off.png"},
		{id = "help_window", path = "select_skinparts/default_modebotton/help_window_resize.png"},
		{id = "help_article", path = "select_skinparts/default_modebotton/help_article.png"},
		{id = "help1", path = "select_skinparts/default_modebotton/help_1.png"},
		{id = "help2", path = "select_skinparts/default_modebotton/help_2.png"},
		{id = "help3", path = "select_skinparts/default_modebotton/help_3.png"},
		{id = "help4", path = "select_skinparts/default_modebotton/help_4.png"},
		{id = "help5", path = "select_skinparts/default_modebotton/help_5.png"},
		{id = "help6", path = "select_skinparts/default_modebotton/help_6.png"},
		{id = "help7", path = "select_skinparts/default_modebotton/help_7.png"},
		{id = "help8", path = "select_skinparts/default_modebotton/help_8.png"},
		{id = "help9", path = "select_skinparts/default_modebotton/help_9.png"},
		{id = "help10", path = "select_skinparts/default_modebotton/help_10.png"},
		{id = "help11", path = "select_skinparts/default_modebotton/help_11.png"},
		{id = "help12", path = "select_skinparts/default_modebotton/help_12.png"},

		{id = "settings_window", path = "select_skinparts/default_modebotton/replay_set_window_resize.png"},
		{id = "score_detail", path = "select_skinparts/default_modebotton/score_detail_window_resize.png"},
		{id = "replay_item", path = "select_skinparts/default_modebotton/replay_item_resize.png"},
		{id = "judge_item", path = "select_skinparts/default_modebotton/judge_item_resize.png"},
		{id = "volume_parts", path = "select_skinparts/default_modebotton/other_option_resize.png"},

		{id = "score_data_parts_80", path = "select_skinparts/default_modebotton/clear_rank_resize_80.png"},
		{id = "figure", path = "select_skinparts/default_modebotton/figure.png"},
		{id = "ir_rank_figure", path = "select_skinparts/default_modebotton/ir_rank_figure_ver.1.3.0.png"},
		{id = "ir_scroll_cursor", path = "select_skinparts/default_modebotton/songscroll_cursor_resize.png"},
		{id = "ir_you", path = "select_skinparts/default_modebotton/ir_you.png"},
		{id = "ir_you_2", path = "select_skinparts/default_modebotton/ir_you_2.png"},
		{id = "rank123", path = "select_skinparts/default_modebotton/rank123.png"},

		{id = "src-default_irdata_irdata_bg", path = "select_skinparts/default_modebotton/ir_data_resize.png"},
		{id = "irdata_loading", path = "select_skinparts/default_modebotton/ir_data_loading.png"},
		{id = "score_detail_panel", path = "select_skinparts/default_modebotton/score_detail_panel.png"},
		{id = "ir_rank_figure_small", path = "select_skinparts/default_modebotton/ir_rank_figure_ver.1.3.0_small.png"},
		{id = "1st_to_10th", path = "select_skinparts/default_modebotton/1st_to_10th.png"},
	}
	
	parts.image = {
		{id = "skinselect_botton",	src = "modebotton", x = 0, y = 69*0, w = 69, h = 69, act = 14},
		{id = "keyconfig_botton",	src = "modebotton", x = 0, y = 69*1, w = 69, h = 69, act = 13},
		{id = "settings_botton",	src = "modebotton", x = 0, y = 69*2, w = 69, h = 69, act = (function() return settings_open() end)},
		{id = "help_botton",	src = "modebotton", x = 0, y = 69*3, w = 69, h = 69, act = (function() return help_open() end)},
		{id = "ranking_botton",	src = "modebotton", x = 0, y = 69*4, w = 69, h = 69, act = 210},
		{id = "score_botton",	src = "modebotton", x = 0, y = 69*5, w = 69, h = 69, act = (function() return score_detail_open() end)},
		{id = "readme_botton",	src = "modebotton", x = 0, y = 69*6, w = 69, h = 69, act = 17},
		{id = "button_rect",	src = "modebotton", x = 0, y = 69*7, w = 69, h = 69},
		{id = "black",	src = "off", x = 0, y = 0, w = 1, h = 1, act = (function() return xxxx() end)},
		{id = "help_window", src = "help_window", x = 0, y = 0, w = 1920, h = 1080},
		{id = "help1_botton", src = "help_article", x = 0, y = 50*0, w = 240, h = 50, act = (function() return help_1() end)},
		{id = "help2_botton", src = "help_article", x = 0, y = 50*1, w = 240, h = 50, act = (function() return help_2() end)},
		{id = "help3_botton", src = "help_article", x = 0, y = 50*2, w = 240, h = 50, act = (function() return help_3() end)},
		{id = "help4_botton", src = "help_article", x = 0, y = 50*3, w = 240, h = 50, act = (function() return help_4() end)},
		{id = "help5_botton", src = "help_article", x = 0, y = 50*4, w = 240, h = 50, act = (function() return help_5() end)},
		{id = "help6_botton", src = "help_article", x = 0, y = 50*5, w = 240, h = 50, act = (function() return help_6() end)},
		{id = "help7_botton", src = "help_article", x = 0, y = 50*6, w = 240, h = 50, act = (function() return help_7() end)},
		{id = "help8_botton", src = "help_article", x = 0, y = 50*10, w = 240, h = 50, act = (function() return help_8() end)},
		{id = "help9_botton", src = "help_article", x = 0, y = 50*11, w = 240, h = 50, act = (function() return help_9() end)},
		{id = "help10_botton", src = "help_article", x = 0, y = 50*12, w = 240, h = 50, act = (function() return help_10() end)},
		{id = "help11_botton", src = "help_article", x = 0, y = 50*13, w = 240, h = 50, act = (function() return help_11() end)},
		{id = "help12_botton", src = "help_article", x = 0, y = 50*14, w = 240, h = 50, act = (function() return help_12() end)},
		{id = "close_botton", src = "help_article", x = 0, y = 50*7, w = 240, h = 50, act = (function() return help_open() end)},
		{id = "close_botton_2", src = "help_article", x = 0, y = 50*7, w = 240, h = 50, act = (function() return settings_open() end)},
		{id = "close_botton_3", src = "help_article", x = 0, y = 50*7, w = 240, h = 50, act = (function() return score_detail_open() end)},
		{id = "article_rect", src = "help_article", x = 0, y = 50*8, w = 240, h = 50},
		{id = "cursor", src = "help_article", x = 0, y = 50*9, w = 240, h = 50},
		{id = "help1_text", src = "help1", x = 0, y = 0, w = 1234, h = 970},
		{id = "help2_text", src = "help2", x = 0, y = 0, w = 1234, h = 970},
		{id = "help3_text", src = "help3", x = 0, y = 0, w = 1234, h = 970},
		{id = "help4_text", src = "help4", x = 0, y = 0, w = 1234, h = 970},
		{id = "help5_text", src = "help5", x = 0, y = 0, w = 1234, h = 970},
		{id = "help6_text", src = "help6", x = 0, y = 0, w = 1234, h = 970},
		{id = "help7_text", src = "help7", x = 0, y = 0, w = 1234, h = 970},
		{id = "help8_text", src = "help8", x = 0, y = 0, w = 1234, h = 970},
		{id = "help9_text", src = "help9", x = 0, y = 0, w = 1234, h = 970},
		{id = "help10_text", src = "help10", x = 0, y = 0, w = 1234, h = 970},
		{id = "help11_text", src = "help11", x = 0, y = 0, w = 1234, h = 970},
		{id = "help12_text", src = "help12", x = 0, y = 0, w = 1234, h = 970},

		{id = "mybest_dot",		src = "figure",	x = 121, y = 50, w = 5, h = 5},
		{id = "mybest_per",		src = "figure",	x = 126, y = 50, w = 16, h = 14},

		-- {id = "ir_you", src = "ir_you", x = 0, y = 0, w = 414, h = 54},
		{id = "ir_you_2", src = "ir_you_2", x = 0, y = 0, w = 414 + 3 + 28, h = 54 + 28},

		{id = "rank1", src = "rank123", x = 0, y = 0, w = 414, h = 52},
		{id = "rank2", src = "rank123", x = 0, y = 52, w = 414, h = 52},
		{id = "rank3", src = "rank123", x = 0, y = 104, w = 414, h = 52},

		{id = "settings_window", src = "settings_window", x = 0, y = 0, w = 1130, h = 825, act = (function() return xxxx() end)},

		{id = "replay_item_1", src = "replay_item", x = 0, y = 0, w = 240, h = 550, divy = 11, len = 11, ref = 321, act = 321},
		{id = "replay_item_2", src = "replay_item", x = 0, y = 0, w = 240, h = 550, divy = 11, len = 11, ref = 322, act = 322},
		{id = "replay_item_3", src = "replay_item", x = 0, y = 0, w = 240, h = 550, divy = 11, len = 11, ref = 323, act = 323},
		{id = "replay_item_4", src = "replay_item", x = 0, y = 0, w = 240, h = 550, divy = 11, len = 11, ref = 324, act = 324},

		{id = "judge_algorithm_item", src = "judge_item", x = 0, y = 0, w = 240, h = 150, divy = 3, len = 3, ref = 340, act = 340},

		{id = "score_detail_window", src = "score_detail", x = 0, y = 0, w = 1130, h = 825, act = (function() return xxxx() end)},
		{id = "score_detail_text", src = "score_detail", x = 0, y = 825, w = 1130, h = 825},
		{id = "irdata_window",	src = "src-default_irdata_irdata_bg",	x = 0, y = 0, w = 400+12, h = 275+9},
		{id = "slash_sen",		src = "number_alte", x = 180, y = 75, w = 12, h = 20},
		{id = "dot_sen", 	src = "number_alte", x = 175, y = 75, w = 5, h = 5},
		{id = "per_sen_big", 	src = "number_alte", x = 200, y = 75, w = 16, h = 19},
		{id = "irdata_loading", src = "irdata_loading", x = 0,y = 0, w = 113, h = 60, divy = 4, cycle = 1600},
		{id = "score_detail_panel",	src = "score_detail_panel",	x = 0, y = 0, w = 400+12, h = 275+9},
		{id = "per_sen", 	src = "number_alte", x = 160, y = 75, w = 14, h = 16},
		{id = "dot_sen", 	src = "number_alte", x = 175, y = 75, w = 5, h = 5},
	}

	parts.value = {
		{id = "master_count",	src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 3, ref = 57},
		{id = "key_count",		src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 3, ref = 58},
		{id = "bgm_count",		src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 3, ref = 59},
		{id = "detail_score", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 71},
		{id = "detail_maxscore", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 72},
		{id = "detail_miss", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 76},
		{id = "detail_cb", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 425},
		{id = "detail_combo", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 75},
		{id = "detail_totalnotes", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 74},
		{id = "detail_play", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 77},
		{id = "detail_clear", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 78},
		{id = "detail_fail", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 79},
		{id = "detail_pgreat", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 80},
		{id = "detail_great", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 81},
		{id = "detail_good", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 82},
		{id = "detail_bad", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 83},
		{id = "detail_poor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 84},
		{id = "detail_epoor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 420},
		{id = "detail_fast", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 423},
		{id = "detail_slow", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 424},
		{id = "detail_fast_smallwindow", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 423},
		{id = "detail_slow_smallwindow", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 424},
		{id = "default_playerdata_mode_diff_count",		src = "number_1_small", x = 0, y = 0, w = 110, h = 17, divx = 11, digit = 4, align = 1, value = function()

			score = main_state.number(71)
			maxscore = (main_state.number(74) * 2)
			if maxscore < 1 then
				scorerate = 0
			else	
				scorerate = score / maxscore
			end
			rivalscore = main_state.number(271)
			if maxscore < 1 then
				rival_scorerate = 0
			else	
				rival_scorerate = rivalscore / maxscore
			end
			--score off
			if maxscore < 1 then
				return 0
			elseif rank_plus then
				--max+
				if scorerate == 18/18 then
					return 0
				--max-
				elseif scorerate < 18/18 and scorerate >= 17/18 then
					return math.ceil(maxscore * 9/9) - score
				--aaa+
				elseif scorerate < 17/18 and scorerate >= 16/18 then
					return score - math.ceil(maxscore * 8/9)
				--aaa-
				elseif scorerate < 16/18 and scorerate >= 15/18 then
					return math.ceil(maxscore * 8/9) - score
				--aa+
				elseif scorerate < 15/18 and scorerate >= 14/18 then
					return score - math.ceil(maxscore * 7/9)
				--aa-
				elseif scorerate < 14/18 and scorerate >= 13/18 then
					return math.ceil(maxscore * 7/9) - score
				--a+
				elseif scorerate < 13/18 and scorerate >= 12/18 then
					return score - math.ceil(maxscore * 6/9)
				--a-
				elseif scorerate < 12/18 and scorerate >= 11/18 then
					return math.ceil(maxscore * 6/9) - score
				--b+
				elseif scorerate < 11/18 and scorerate >= 10/18 then
					return score - math.ceil(maxscore * 5/9)
				--b-
				elseif scorerate < 10/18 and scorerate >= 9/18 then
					return math.ceil(maxscore * 5/9) - score
				--c+
				elseif scorerate < 9/18 and scorerate >= 8/18 then
					return score - math.ceil(maxscore * 4/9)
				--c-
				elseif scorerate < 8/18 and scorerate >= 7/18 then
					return math.ceil(maxscore * 4/9) - score
				--d+
				elseif scorerate < 7/18 and scorerate >= 6/18 then
					return score - math.ceil(maxscore * 3/9)
				--d-
				elseif scorerate < 6/18 and scorerate >= 5/18 then
					return math.ceil(maxscore * 3/9) - score
				--e+
				elseif scorerate < 5/18 and scorerate >= 4/18 then
					return score - math.ceil(maxscore * 2/9)
				--e-
				elseif scorerate < 4/18 and scorerate >= 2/18 then
					return math.ceil(maxscore * 2/9) - score
				--f+
				elseif scorerate < 2/18 and scorerate >= 0/18 then
					return score - math.ceil(maxscore * 0/9)
				end
			else
				--max-
				if scorerate < 18/18 and scorerate >= 16/18 then
					return math.ceil(maxscore * 9/9) - score
				--aaa-
				elseif scorerate < 16/18 and scorerate >= 14/18 then
					return math.ceil(maxscore * 8/9) - score
				--aa-
				elseif scorerate < 14/18 and scorerate >= 12/18 then
					return math.ceil(maxscore * 7/9) - score
				--a-
				elseif scorerate < 12/18 and scorerate >= 10/18 then
					return math.ceil(maxscore * 6/9) - score
				--b-
				elseif scorerate < 10/18 and scorerate >= 8/18 then
					return math.ceil(maxscore * 5/9) - score
				--c-
				elseif scorerate < 8/18 and scorerate >= 6/18 then
					return math.ceil(maxscore * 4/9) - score
				--d-
				elseif scorerate < 6/18 and scorerate >= 4/18 then
					return math.ceil(maxscore * 3/9) - score
				--e-
				elseif scorerate < 4/18 and scorerate >= 0/18 then
					return math.ceil(maxscore * 2/9) - score
				end
			end
		end},
		{id = "current_irrank",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 179, align = 2},
		{id = "totalplayer_irrank",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 6, ref = 180, align = 2,space = -1},
			
		{id = "default_irdata_clearrate_count",		src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 3, ref = 227},
		{id = "default_irdata_ir_rank_count",		src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 179},
		{id = "default_irdata_ir_rank_total_count",	src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 180},
		{id = "detail_pgreat", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 80},
		{id = "detail_great", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 81},
		{id = "detail_good", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 82},
		{id = "detail_bad", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 83},
		{id = "detail_poor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 84},
		{id = "detail_epoor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 420},
		{id = "detail_cb", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 425},
		{id = "detail_fast", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 423},
		{id = "detail_slow", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 424},
		{id = "default_ranking_score_count_1", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 380},
		{id = "default_ranking_score_count_2", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 381},
		{id = "default_ranking_score_count_3", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 382},
		{id = "default_ranking_score_count_4", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 383},
		{id = "default_ranking_score_count_5", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 384},

		{id = "default_ranking_scorerate_count_1",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(380)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_1",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(380)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_2",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(381)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_2",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(381)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_3",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(382)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_3",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(382)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_4",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(383)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_4",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(383)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_5",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(384)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_5",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(384)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},

		{id = "default_irdata_clearrate_count",		src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 3, ref = 227},
		{id = "default_irdata_ir_rank_count",		src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 179},
		{id = "default_irdata_ir_rank_total_count",	src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 180},
		{id = "detail_pgreat", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 80},
		{id = "detail_great", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 81},
		{id = "detail_good", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 82},
		{id = "detail_bad", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 83},
		{id = "detail_poor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 84},
		{id = "detail_epoor", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 420},
		{id = "detail_cb", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 425},
		{id = "detail_fast", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 423},
		{id = "detail_slow", src = "number_1",	 x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 2, ref = 424},
		{id = "default_ranking_score_count_1", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 380},
		{id = "default_ranking_score_count_2", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 381},
		{id = "default_ranking_score_count_3", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 382},
		{id = "default_ranking_score_count_4", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 383},
		{id = "default_ranking_score_count_5", src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, align = 0, ref = 384},

		{id = "default_ranking_scorerate_count_1",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(380)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_1",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(380)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_2",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(381)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_2",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(381)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_3",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(382)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_3",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(382)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_4",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(383)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_4",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(383)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
		{id = "default_ranking_scorerate_count_5",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			local score = main_state.number(384)
			local maxscore = main_state.number(74) * 2
			local scorerate = 0
			if score > 0 and maxscore > 0 then scorerate = math.floor(score / maxscore * 100)  end
			return scorerate
		end},
		{id = "default_ranking_scorerate_dot_count_5",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			local score = main_state.number(384)
			local maxscore = main_state.number(74) * 2
			local scorerate_dot = 0
			if score > 0 and maxscore > 0 then scorerate_dot = ((score / maxscore) * 10000) % 100  end
			return scorerate_dot
		end},
	
	}

	parts.slider = {
		{id = "default_volumeslider_master",	src = "volume_parts", x = 15, y = 170, w = 15, h = 15, angle = 1, range = 200, type = 17},
		{id = "default_volumeslider_key",		src = "volume_parts", x = 15, y = 170, w = 15, h = 15, angle = 1, range = 200, type = 18},
		{id = "default_volumeslider_bgm",		src = "volume_parts", x = 15, y = 170, w = 15, h = 15, angle = 1, range = 200, type = 19},
	
		{id = "default_ranking_name_1",		font = "font_sub_small", size = 18, align = 2, ref = 120, overflow = 1},
		{id = "default_ranking_name_2",		font = "font_sub_small", size = 18, align = 2, ref = 121, overflow = 1},
		{id = "default_ranking_name_3",		font = "font_sub_small", size = 18, align = 2, ref = 122, overflow = 1},
		{id = "default_ranking_name_4",		font = "font_sub_small", size = 18, align = 2, ref = 123, overflow = 1},
		{id = "default_ranking_name_5",		font = "font_sub_small", size = 18, align = 2, ref = 124, overflow = 1},
	}

	parts.text = {
		{id = "default_ranking_name_1",		font = "font_sub_small", size = 18, align = 2, ref = 120, overflow = 1},
		{id = "default_ranking_name_2",		font = "font_sub_small", size = 18, align = 2, ref = 121, overflow = 1},
		{id = "default_ranking_name_3",		font = "font_sub_small", size = 18, align = 2, ref = 122, overflow = 1},
		{id = "default_ranking_name_4",		font = "font_sub_small", size = 18, align = 2, ref = 123, overflow = 1},
		{id = "default_ranking_name_5",		font = "font_sub_small", size = 18, align = 2, ref = 124, overflow = 1},
	}

	parts.graph = {
		{id = "master_graph", src = "volume_parts", x = 0, y = 150, w = 200, h = 3, angle = 2, type = 17},    
		{id = "key_graph", src = "volume_parts", x = 0, y = 150, w = 200, h = 3, angle = 2, type = 18},  
		{id = "bg_graph", src = "volume_parts", x = 0, y = 150, w = 200, h = 3, angle = 2, type = 19},  
	}
	
	local skinselect_x = 316
	local skinselect_y = 996
	local ranking_x = 655
	local botton_space = 78

	local help1_botton_x = 225
	local help1_botton_y = 883
	local help_space = 58
	
	local settings_window_x = 21
	local settings_window_y = 73

	local detail_score_x = 900
	local detail_score_y = 522

	local rank_diff_x = 640
	local rank_diff_y = 550

	local rank_x = rank_diff_x + settings_window_x + 242
	local rank_y = rank_diff_y + settings_window_y + 97
	local lamp_x = rank_diff_x + settings_window_x + 243
	local lamp_y = rank_diff_y + settings_window_y + 20
	local next_x = rank_diff_x + settings_window_x + 249
	local next_y = rank_diff_y + settings_window_y + 69
	local rate_x = rank_diff_x + settings_window_x + 286
	local rate_y = rank_diff_y + settings_window_y + 49

	local irdata_position = {
		x = 308,
		y = 133
		}
	
	local pgreat_diff = {
		x = 100,
		y = 204
		}

	local pos = {x = irdata_position.x + 202, y = irdata_position.y + 208}
	local pos2 = {x = irdata_position.x + 222 - 15}
	local y_space = 29
	local scorerate_x_diff = 136 - 15
	local op_ir_data = (skin_config.option["表示情報"] == OP_IR_DATA)

	local window_open_time = 200

	local window_size_scale = 0.12

	parts.destination = {

		{id = "irdata_window",				draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x-6, y = irdata_position.y, w = 400+12, h = 275+9}}},

		{id = "score_detail_panel",				draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end,	dst = {{x = irdata_position.x-6, y = irdata_position.y, w = 400+12, h = 275+9}}},


		--{id = "irdata_window",				op = {51, 1030},	dst = {{x = irdata_position.x-6, y = irdata_position.y, w = 400+12, h = 275+9}}},

		{id = "default_irdata_ir_rank_count",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x + 150, y = irdata_position.y + 26 + 32, w = 12, h = 20}}},
		
		{id = "default_irdata_ir_rank_total_count",		draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x + 220, y = irdata_position.y + 26 + 32, w = 12, h = 20}}},
		
		{id = "default_irdata_clearrate_count",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x + 162, y = irdata_position.y + 26, w = 12, h = 20}}},
		
		{id = "per_sen_big", 	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x + 202, y = irdata_position.y + 27, w = 16, h = 19}}},

		{id = "slash_sen",		draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = irdata_position.x + 205, y = irdata_position.y + 58, w = 12, h = 20}}},
		
		{id = "irdata_loading" ,draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and main_state.option(606)) end, dst = {{x = irdata_position.x + 265, y = irdata_position.y + 252, w = 113, h = 15}}},
		
		{id = "detail_pgreat", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*0, w = 12, h = 20}}},
		{id = "detail_great", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*1, w = 12, h = 20}}},
		{id = "detail_good", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*2, w = 12, h = 20}}},
		{id = "detail_bad", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*3, w = 12, h = 20}}},
		{id = "detail_poor", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*4, w = 12, h = 20}}},
		{id = "detail_epoor", draw = function() return main_state.number(71) >= 0 and ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*5, w = 12, h = 20}}},
		{id = "detail_cb", draw = function() return main_state.number(71) >= 0 and ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*5 -38, w = 12, h = 20}}},
		{id = "detail_fast_smallwindow", draw = function() return main_state.number(71) >= 0 and ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x + 110, y = irdata_position.y + pgreat_diff.y - 23, w = 12, h = 20, r = 0 ,g = 174, b = 255}}},
		{id = "detail_slow_smallwindow", draw = function() return main_state.number(71) >= 0 and ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x + 197, y = irdata_position.y + pgreat_diff.y - 23, w = 12, h = 20, r = 255 ,g = 0, b = 84}}},

		{id = "default_irdata_clearrate_count",			draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, 	dst = {{x = irdata_position.x + 162 + 95, y = irdata_position.y + 26 + 10, w = 12, h = 20}}},
		
		{id = "per_sen_big", 	draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, 	dst = {{x = irdata_position.x + 202 + 95, y = irdata_position.y + 27 + 10, w = 16, h = 19}}},

		{id = "default_irdata_ir_rank_count",			draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, 	dst = {{x = irdata_position.x + 150 + 76, y = irdata_position.y + 26 + 32 + 50, w = 12, h = 20}}},
		{id = "default_irdata_ir_rank_total_count",		draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, 	dst = {{x = irdata_position.x + 220 + 76, y = irdata_position.y + 26 + 32 + 50, w = 12, h = 20}}},

		{id = "slash_sen",		draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, 	dst = {{x = irdata_position.x + 205 + 76, y = irdata_position.y + 58 + 50, w = 12, h = 20}}},

		{id = "default_ranking_name_1",					draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos.x - 5, y = pos.y + 1, w = 130 - 5, h = 18}}},
		{id = "default_ranking_name_2",					draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos.x - 5, y = pos.y + 1 - 29, w = 130 - 5, h = 18}}},
		{id = "default_ranking_name_3",					draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos.x - 5, y = pos.y + 1 - 58, w = 130 - 5, h = 18}}},
		{id = "default_ranking_name_4",					draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos.x - 5, y = pos.y + 1 - 87, w = 130 - 5, h = 18}}},
		{id = "default_ranking_name_5",					draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos.x - 5, y = pos.y + 1 - 116, w = 130 - 5, h = 18}}},
		{id = "default_ranking_score_count_1",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos2.x, y = pos.y - 0, w = 12, h = 20}}},
		{id = "default_ranking_score_count_2",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos2.x, y = pos.y - 29, w = 12, h = 20}}},
		{id = "default_ranking_score_count_3",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos2.x, y = pos.y - 58, w = 12, h = 20}}},
		{id = "default_ranking_score_count_4",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos2.x, y = pos.y - 87, w = 12, h = 20}}},
		{id = "default_ranking_score_count_5",			draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data) end,	dst = {{x = pos2.x, y = pos.y - 116, w = 12, h = 20}}},
		
		{id = "default_ranking_scorerate_count_1", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 1) >= 0 end,	dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*0, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_1", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 1) >= 0 end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*0, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 1) >= 0 end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*0, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 1) >= 0 end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*0, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_2", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 2) >= 0 end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*1, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_2", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 2) >= 0 end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*1, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 2) >= 0 end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*1, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 2) >= 0 end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*1, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_3", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 3) >= 0 end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*2, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_3", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 3) >= 0 end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*2, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 3) >= 0 end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*2, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 3) >= 0 end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*2, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_4", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 4) >= 0 end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*3, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_4", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 4) >= 0 end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*3, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 4) >= 0 end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*3, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 4) >= 0 end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*3, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_5", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 5) >= 0 end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*4, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_5", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 5) >= 0 end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*4, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 5) >= 0 end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*4, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) and main_state.number(379 + 5) >= 0 end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*4, w = 5, h = 5}}},
	

		{id = "skinselect_botton",	dst = {{x = skinselect_x + botton_space * 0, y = skinselect_y, w = 69, h = 69}}},
		{id = "keyconfig_botton",	dst = {{x = skinselect_x + botton_space * 1, y = skinselect_y, w = 69, h = 69}}},
		{id = "settings_botton",	dst = {{x = skinselect_x + botton_space * 2, y = skinselect_y, w = 69, h = 69}}},
		{id = "help_botton",	dst = {{x = skinselect_x + botton_space * 3, y = skinselect_y, w = 69, h = 69}}},
		{id = "ranking_botton",	dst = {{x = ranking_x + botton_space * 0, y = skinselect_y, w = 69, h = 69}}},
		{id = "score_botton",	dst = {{x = ranking_x + botton_space * 1, y = skinselect_y, w = 69, h = 69}}},
		{id = "readme_botton",	dst = {{x = ranking_x + botton_space * 2, y = skinselect_y, w = 69, h = 69}}},

		{id = "button_rect",	dst = {{x = skinselect_x + botton_space * 0, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},
		{id = "button_rect",	dst = {{x = skinselect_x + botton_space * 1, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},		
		{id = "button_rect",	dst = {{x = skinselect_x + botton_space * 2, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},		
		{id = "button_rect",	dst = {{x = skinselect_x + botton_space * 3, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},		
		{id = "button_rect",	dst = {{x = ranking_x + botton_space * 0, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},		
		{id = "button_rect",	dst = {{x = ranking_x + botton_space * 1, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},	
		{id = "button_rect",	dst = {{x = ranking_x + botton_space * 2, y = skinselect_y, w = 69, h = 69}}, mouseRect = {x = 0, y = 0, w = 69, h = 69}},	

		-- {id = "settings_window", loop = 300, timer = timer2.on,	dst = {{time = 0, x = -1130, y = settings_window_y, w = 1130, h = 825}, {time = 300, x = settings_window_x}}},
		-- {id = "settings_window", loop = 300, timer = timer2.off,	dst = {{time = 0, x = settings_window_x, y = settings_window_y, w = 1130, h = 825}, {time = 300, x = -1130}}},

		-- {id = "settings_window", loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x, y = settings_window_y - 20, w = 1130, h = 825, a = 0}, {time = window_open_time / 2, y = settings_window_y - 6, a = 127}, {time = window_open_time, y = settings_window_y, a = 255}}},
		-- {id = "settings_window", loop = window_open_time, timer = timer2.off,	dst = {{time = 0, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 255}, {time = window_open_time, y = settings_window_y - 20, a = 0}, {time = window_open_time, y = settings_window_y - 5000}}},

		{id = "settings_window", loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x+1130*(window_size_scale*0.5), y = settings_window_y+825*(window_size_scale*0.5), w = 1130*(1-window_size_scale), h = 825*(1-window_size_scale), a = 0}, {time = window_open_time / 2, x = settings_window_x+1130*(window_size_scale*0.5/3), y = settings_window_y+825*(window_size_scale*0.5/3), w = 1130*(1-window_size_scale/3), h = 825*(1-window_size_scale/3), a = 127}, {time = window_open_time, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 255}}},
		{id = "settings_window", loop = window_open_time, timer = timer2.off,	dst = {{time = 0, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 255}, {time = window_open_time, x = settings_window_x+1130*(window_size_scale*0.5), y = settings_window_y+825*(window_size_scale*0.5), w = 1130*(1-window_size_scale), h = 825*(1-window_size_scale), a = 0}, {time = window_open_time, x = settings_window_x, y = settings_window_y - 5000}}},


		{id = "replay_item_1", draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 225, y = settings_window_y + 563, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 225, y = settings_window_y + 563, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "replay_item_2", draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 225, y = settings_window_y + 563-70*1, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 225, y = settings_window_y + 563-70*1, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "replay_item_3", draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 225, y = settings_window_y + 563-70*2, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 225, y = settings_window_y + 563-70*2, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "replay_item_4", draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 225, y = settings_window_y + 563-70*3, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 225, y = settings_window_y + 563-70*3, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "judge_algorithm_item", draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 92, y = settings_window_y + 92, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 92, y = settings_window_y + 92, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "master_graph",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 587, y = settings_window_y + 556, w = 200, h = 3, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "key_graph",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 587, y = settings_window_y + 458, w = 200, h = 3, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "bg_graph",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 587, y = settings_window_y + 361, w = 200, h = 3, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},


		{id = "default_volumeslider_master",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 580, y = settings_window_y + 556 -6, w = 15, h = 15, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_volumeslider_key",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 580, y = settings_window_y + 458 -6, w = 15, h = 15, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_volumeslider_bgm",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 580, y = settings_window_y + 361 -6, w = 15, h = 15, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		
		{id = "master_count",	draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 750, y = settings_window_y + 556 +20, w = 14, h = 25, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "key_count",		draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 750, y = settings_window_y + 458 +20, w = 14, h = 25, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "bgm_count",		draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 750, y = settings_window_y + 361 +20, w = 14, h = 25, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},


		{id = "close_botton_2",draw = function() return flg2 end, loop = window_open_time, timer = timer2.on,	dst = {{time = 0, x = settings_window_x + 850, y = settings_window_y + 24, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg2 end, dst = {{x = settings_window_x + 850, y = settings_window_y + 24, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "score_detail_window", loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x+1130*(window_size_scale*0.5), y = settings_window_y+825*(window_size_scale*0.5), w = 1130*(1-window_size_scale), h = 825*(1-window_size_scale), a = 0}, {time = window_open_time / 2, x = settings_window_x+1130*(window_size_scale*0.5/3), y = settings_window_y+825*(window_size_scale*0.5/3), w = 1130*(1-window_size_scale/3), h = 825*(1-window_size_scale/3), a = 127}, {time = window_open_time, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 255}}},
		{id = "score_detail_window", loop = window_open_time, timer = timer3.off,	dst = {{time = 0, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 255}, {time = window_open_time, x = settings_window_x+1130*(window_size_scale*0.5), y = settings_window_y+825*(window_size_scale*0.5), w = 1130*(1-window_size_scale), h = 825*(1-window_size_scale), a = 0}, {time = window_open_time, x = settings_window_x, y = settings_window_y - 5000}}},
		
		{id = "score_detail_text", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x, y = settings_window_y, w = 1130, h = 825, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "default_playerdata_state_clear", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = lamp_x, y = lamp_y, w = 97, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "default_playerdata_rank_aaa",  op = {200}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_aa",  op = {201}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_a",  op = {202}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_b",  op = {203}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_c",  op = {204}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_d",  op = {205}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_e",  op = {206}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_rank_f",  op = {207}, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rank_x, y = rank_y, w = 101, h = 40, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},



		{id = "diff_rank_max",  draw = function() return not(rank_plus) and flag_score and scorerate < 18/18 and scorerate >= 16/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aaa",  draw = function() return not(rank_plus) and flag_score and scorerate < 16/18 and scorerate >= 14/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aa",  draw = function() return not(rank_plus) and flag_score and scorerate < 14/18 and scorerate >= 12/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-5, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_a",  draw = function() return not(rank_plus) and flag_score and scorerate < 12/18 and scorerate >= 10/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_b",  draw = function() return not(rank_plus) and flag_score and scorerate < 10/18 and scorerate >= 8/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_c",  draw = function() return not(rank_plus) and flag_score and scorerate < 8/18 and scorerate >= 6/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_d",  draw = function() return not(rank_plus) and flag_score and scorerate < 6/18 and scorerate >= 4/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_e",  draw = function() return not(rank_plus) and flag_score and scorerate < 4/18 and scorerate >= 0/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "diff_rank_max",  draw = function() return rank_plus and flag_score and scorerate < 18/18 and scorerate >= 17/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aaa",  draw = function() return rank_plus and flag_score and scorerate < 16/18 and scorerate >= 15/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aa",  draw = function() return rank_plus and flag_score and scorerate < 14/18 and scorerate >= 13/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-5, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_a",  draw = function() return rank_plus and flag_score and scorerate < 12/18 and scorerate >= 11/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_b",  draw = function() return rank_plus and flag_score and scorerate < 10/18 and scorerate >= 9/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_c",  draw = function() return rank_plus and flag_score and scorerate < 8/18 and scorerate >= 7/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_d",  draw = function() return rank_plus and flag_score and scorerate < 6/18 and scorerate >= 5/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_e",  draw = function() return rank_plus and flag_score and scorerate < 4/18 and scorerate >= 2/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "diff_rank_max_plus",  draw = function() return rank_plus and flag_score and scorerate == 18/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aaa_plus",  draw = function() return rank_plus and flag_score and scorerate < 17/18 and scorerate >= 16/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_aa_plus",  draw = function() return rank_plus and flag_score and scorerate < 15/18 and scorerate >= 14/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-5, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_a_plus",  draw = function() return rank_plus and flag_score and scorerate < 13/18 and scorerate >= 12/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_b_plus",  draw = function() return rank_plus and flag_score and scorerate < 11/18 and scorerate >= 10/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_c_plus",  draw = function() return rank_plus and flag_score and scorerate < 9/18 and scorerate >= 8/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_d_plus",  draw = function() return rank_plus and flag_score and scorerate < 7/18 and scorerate >= 6/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_e_plus",  draw = function() return rank_plus and flag_score and scorerate < 5/18 and scorerate >= 4/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "diff_rank_f_plus",  draw = function() return rank_plus and flag_score and scorerate < 2/18 and scorerate >= 0/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x-10, y = next_y, w = 43, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "default_playerdata_mode_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate >= 14/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_mode_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate < 14/18 and scorerate >= 12/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45-5, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_mode_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate < 12/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45-10, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "default_playerdata_mode_diff_count", draw = function() return rank_plus and flag_score and scorerate >= 15/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_mode_diff_count", draw = function() return rank_plus and flag_score and scorerate < 15/18 and scorerate >= 13/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45-5, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_mode_diff_count", draw = function() return rank_plus and flag_score and scorerate < 13/18 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = next_x+45-10, y = next_y+3, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		--scorerate 100%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate == 10/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-35+5, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate == 10/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x+5, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "per_sen", draw = function() return flag_score and scorerate == 10/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x+22+5, y = rate_y+1, w = 14, h = 16, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "dot_sen", draw = function() return flag_score and scorerate == 10/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-5+5, y = rate_y+1, w = 5, h = 5, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

        --scorerate 10~99%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-35, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "per_sen", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x+22, y = rate_y+1, w = 14, h = 16, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "dot_sen", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-5, y = rate_y+1, w = 5, h = 5, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		--scorerate ~10%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate < 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-35-5, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate < 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-5, y = rate_y, w = 10, h = 17, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "per_sen", draw = function() return flag_score and scorerate < 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x+22-5, y = rate_y+1, w = 14, h = 16, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "dot_sen", draw = function() return flag_score and scorerate < 1/10 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = rate_x-5-5, y = rate_y+1, w = 5, h = 5, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},


		--{id = "detail_score", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 0 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "default_playerdata_score_count", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 0 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "slash_sen",	draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 80, y = settings_window_y + detail_score_y, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_maxscore", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 92, y = settings_window_y + detail_score_y, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_miss", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 1 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_cb", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 2 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_combo", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 3 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "slash_sen",	draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 80, y = settings_window_y + detail_score_y - 27 * 3 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_totalnotes", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 92, y = settings_window_y + detail_score_y - 27 * 3 - 50 * 0, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		
		{id = "detail_play", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 3 - 50 * 1, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_clear", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 4 - 50 * 1, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_fail", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 5 - 50 * 1, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "detail_pgreat", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 5 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_great", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 6 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_good", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 7 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_bad", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 8 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_poor", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 9 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_epoor", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x, y = settings_window_y + detail_score_y - 27 * 10 - 50 * 2, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		
		{id = "detail_fast", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 20, y = settings_window_y + detail_score_y - 27 * 10 - 50 * 3, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "slash_sen",	draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 80 + 20, y = settings_window_y + detail_score_y - 27 * 10 - 50 * 3, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "detail_slow", draw = function() return (flg3 and main_state.number(71) >= 0) end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + detail_score_x + 92 + 20, y = settings_window_y + detail_score_y - 27 * 10 - 50 * 3, w = 12, h = 20, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},

		{id = "close_botton_3",draw = function() return flg3 end, loop = window_open_time, timer = timer3.on,	dst = {{time = 0, x = settings_window_x + 850, y = settings_window_y + 24, w = 240, h = 50, a = 0}, {time = window_open_time}, {time = window_open_time, a = 255}}},
		{id = "article_rect",draw = function() return flg3 end, dst = {{x = settings_window_x + 850, y = settings_window_y + 24, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},

		{id = "black", draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0}, {time = window_open_time/2, a = 200*2/3}, {time = window_open_time, a = 200}}},
		{id = "black", loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 200}, {time = window_open_time, a = 0}, {time = window_open_time, y = -5000}}},
		-- {id = "help_window", loop = 300, timer = timer.on,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080}, {time = 300, x = 0}}},
		-- {id = "help_window", loop = 300, timer = timer.off,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080}, {time = 300, x = -1920}}},

		-- {id = "help_window", loop = 300, timer = timer.on,	dst = {{time = 0, x = -1920, y = 0, w = 1920, h = 1080}, {time = 300, x = 0}}},
		-- {id = "help_window", loop = 300, timer = timer.off,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080}, {time = 300, x = -1920}}},

		{id = "help_window", loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 0, y = -30, w = 1920, h = 1080, a = 0}, {time = window_open_time / 2, y = -9, a = 127}, {time = window_open_time, y = 0, a = 255}}},
		{id = "help_window", loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255}, {time = window_open_time, y = -30, a = 0}, {time = window_open_time, y = -5000}}},
		
		
		{id = "help1_text",draw = function() return (flg and (help_number == 1)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help2_text",draw = function() return (flg and (help_number == 2)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help3_text",draw = function() return (flg and (help_number == 3)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help4_text",draw = function() return (flg and (help_number == 4)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help5_text",draw = function() return (flg and (help_number == 5)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help6_text",draw = function() return (flg and (help_number == 6)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help7_text",draw = function() return (flg and (help_number == 7)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help8_text",draw = function() return (flg and (help_number == 8)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help9_text",draw = function() return (flg and (help_number == 9)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help10_text",draw = function() return (flg and (help_number == 10)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help11_text",draw = function() return (flg and (help_number == 11)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},
		{id = "help12_text",draw = function() return (flg and (help_number == 12)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = 476, y = 25 - 30, w = 1234, h = 970, a = 0}, {time = window_open_time / 2,  y = 25 - 9, a = 127}, {time = window_open_time, y = 25, a = 255}}},

		{id = "help1_text",draw = function() return ((help_number == 1)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help2_text",draw = function() return ((help_number == 2)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help3_text",draw = function() return ((help_number == 3)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help4_text",draw = function() return ((help_number == 4)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help5_text",draw = function() return ((help_number == 5)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help6_text",draw = function() return ((help_number == 6)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help7_text",draw = function() return ((help_number == 7)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help8_text",draw = function() return ((help_number == 8)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help9_text",draw = function() return ((help_number == 9)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help10_text",draw = function() return ((help_number == 10)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help11_text",draw = function() return ((help_number == 11)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},
		{id = "help12_text",draw = function() return ((help_number == 12)) end, loop = window_open_time, timer = timer.off,	dst = {{time = 0, x = 476, y = 25, w = 1234, h = 970, a = 255}, {time = window_open_time, y = 25 - 30, a = 0}, {time = window_open_time, y = -5000}}},


		{id = "help1_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 0 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 0 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 0, a = 255}}},
		{id = "help2_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 1 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 1 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 1, a = 255}}},
		{id = "help3_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 2 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 2 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 2, a = 255}}},
		{id = "help4_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 3 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 3 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 3, a = 255}}},
		{id = "help5_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 4 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 4 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 4, a = 255}}},
		{id = "help6_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 5 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 5 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 5, a = 255}}},
		{id = "help8_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 6 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 6 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 6, a = 255}}},
		{id = "help9_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 7 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 7 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 7, a = 255}}},
		{id = "help10_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 8 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 8 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 8, a = 255}}},
		{id = "help11_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 9 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 9 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 9, a = 255}}},
		{id = "help12_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 10 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 10 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 10, a = 255}}},
		
		{id = "help7_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 11.5 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 11.5 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 11.5, a = 255}}},
		
		{id = "close_botton",draw = function() return flg end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 13 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 13 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 13, a = 255}}},
		
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 0, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 1, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 2, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 3, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 4, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 5, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 6, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 7, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 8, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 9, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 10, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 11.5, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		{id = "article_rect",draw = function() return flg end, dst = {{x = help1_botton_x, y = help1_botton_y - help_space * 13, w = 240, h = 50}}, mouseRect = {x = 0, y = 0, w = 240, h = 50}},
		
		{id = "cursor",draw = function() return (flg and (help_number == 1)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 0 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 0 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 0, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 2)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 1 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 1 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 1, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 3)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 2 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 2 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 2, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 4)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 3 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 3 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 3, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 5)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 4 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 4 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 4, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 6)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 5 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 5 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 5, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 8)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 6 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 6 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 6, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 9)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 7 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 7 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 7, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 10)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 8 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 8 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 8, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 11)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 9 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 9 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 9, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 12)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 10 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 10 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 10, a = 255}}},
		{id = "cursor",draw = function() return (flg and (help_number == 7)) end, loop = window_open_time, timer = timer.on,	dst = {{time = 0, x = help1_botton_x, y = help1_botton_y - help_space * 11.5 - 30, w = 240, h = 50, a = 0}, {time = window_open_time / 2,  y = help1_botton_y - help_space * 11.5 - 9, a = 127}, {time = window_open_time, y = help1_botton_y - help_space * 11.5, a = 255}}},
	}

	do
		
		local ir = {}

		local frame_position = {
			x = 10,
			y = 32
			}
		
		ir.image		= {}
		ir.text			= {}
		ir.value		= {}
		ir.slider		= {}
		ir.destination	= {}
		ir.pos			= {}
		
		-- 全体の座標
		ir.pos.x = 1400-1249
		ir.pos.y = 215+50-183
		
		-- 各要素のx座標
		ir.pos.rank_x	= ir.pos.x + 23
		ir.pos.clear_x	= ir.pos.x + 110
		ir.pos.score_x	= ir.pos.x + 268 - 18
		ir.pos.scorerate_x	= ir.pos.x + 200 - 20
		ir.pos.score_diff_x	= ir.pos.x + 361 + 5 - 12
		ir.pos.name_x	= ir.pos.x + 110
		ir.pos.scroll_x	= ir.pos.x + 429 - 5
		
		-- 各要素のy座標調整用
		ir.pos.rank_offset_y	= 23
		ir.pos.clear_offset_y	= 12
		ir.pos.score_offset_y	= 20
		ir.pos.scorerate_offset_y	= 14
		ir.pos.score_diff_offset_y	= 25
		ir.pos.name_offset_y	= 28
		ir.pos.scroll_offset_y = 560-35-6
		
		-- 行の高さ
		ir.pos.line_h = 57.5 - 5 - 0.5

		local irdata_position = {
			x = 308,
			y = 133
			}
	
		local pos = {x = irdata_position.x + 202 - 180 - 12, y = irdata_position.y + 211}
		local y_space = 29

		if main_state.option(51) then

			for i = 1, 10 do

				table.insert(parts.image,	{id = "rank_th_" .. i,  src = "1st_to_10th", x = 0, y = 16  * (i - 1), w = 30, h = 16})
	
				for j = 1, 5 do
	
					table.insert(parts.destination, {id = "rank_th_" .. i, draw = function() return op_ir_data and main_state.number(389 + j) == i and (main_state.option(2) or main_state.option(3)) and main_state.option(51) and not(main_state.option(606)) and not(flg or flg2 or flg3)  end, dst = {{x = pos.x + 7, y = pos.y - y_space*(j-1),	w = 30, h = 16}}})
	
				end
	
			end
	
			for i = 1, 5 do
	
				table.insert(parts.value,	{id = "ir_rank_small" .. i,  src = "ir_rank_figure_small", x = 0, y = 0, w = 110, h = 16, divx = 10, digit = 4, ref = 389 + i, align = 2})
	
				table.insert(parts.destination, {id = "ir_rank_small" .. i, draw = function() return op_ir_data and main_state.number(389 + i) > 10 and (main_state.option(2) or main_state.option(3)) and main_state.option(51) and not(main_state.option(606)) and not(flg or flg2 or flg3)  end, dst = {{x = pos.x,	y = pos.y - y_space*(i-1),	w = 11, h = 16}}})
	
				
			end


			local v = ir.pos.y + (ir.pos.line_h * 10)
			-- SCORE WINDOWのほうのカーソル
			table.insert(ir.slider, {id = "ir_scroll_cursor",	src = "ir_scroll_cursor", x = 0, y = 0, w = 64, h = 64, angle = 2, range = 464, type = 8, changeable = false})
			table.insert(ir.slider, {id = "ir_scroll_collision",	src = "ir_scroll_cursor", x = 0, y = 64, w = 64, h = 64, angle = 2, range = 464, type = 8, changeable = true})
			table.insert(ir.destination,  {id = "ir_scroll_cursor", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, blend = 2, dst = {{time = 0, x = ir.pos.scroll_x, y = ir.pos.y + ir.pos.scroll_offset_y, w = 64, h = 64, a = 0},{time = window_open_time},{time = window_open_time, a = 255},{time = window_open_time + 350, a = 180},{time = window_open_time + 400, a = 255}}})
			table.insert(ir.destination,  {id = "ir_scroll_collision",	draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.scroll_x, y = ir.pos.y + ir.pos.scroll_offset_y, w = 64, h = 64, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})

			-- IR DATAのほうのカーソル
			table.insert(ir.slider, {id = "ir_scroll_cursor_2",	src = "ir_scroll_cursor", x = 0, y = 0, w = 64, h = 64, angle = 2, range = 464-360, type = 8, changeable = false})
			table.insert(ir.slider, {id = "ir_scroll_collision_2",	src = "ir_scroll_cursor", x = 0, y = 64, w = 64, h = 64, angle = 2, range = 464-360, type = 8, changeable = true})
			table.insert(ir.destination,  {id = "ir_scroll_cursor_2", draw = function() return not(flg or flg2 or flg3) and main_state.option(51) and (main_state.option(2) or main_state.option(3)) and not(main_state.option(606)) and op_ir_data end, loop = 0, blend = 2, dst = {{time = 0, x = 675 - 20, y = 316, w = 64, h = 64, a = 255},{time = 750, a = 200},{time = 800, a = 255}}})
			table.insert(ir.destination,  {id = "ir_scroll_collision_2",	draw = function() return not(flg or flg2 or flg3) and main_state.option(51) and (main_state.option(2) or main_state.option(3)) and not(main_state.option(606)) and op_ir_data end, dst = {{x = 675 - 20, y = 316, w = 64, h = 64, a = 255}}})

			table.insert(ir.destination,  {id = "current_irrank", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = frame_position.x+1855+23-21-194-1249-70, y = frame_position.y+1200-162-157+10-183-13, w = 17, h = 25, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination,  {id = "totalplayer_irrank", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = frame_position.x+1855+23-21-194+95-1249-70, y = frame_position.y+1200-162-155+10-183-13, w = 11, h = 15, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})

			table.insert(ir.text, {id = "ir_name_scorewindow",	font = "font_sub_small", size = 18, align = 2, ref = 1020, overflow = 1})

			table.insert(ir.destination,  {id = "ir_name_scorewindow", draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+480, y = ir.pos.y+670, w = 200, h = 24, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})

			for i = 1, 10 do
				
				table.insert(ir.destination,  {id = "rank1",	draw = function() return flg3 and (isrank1(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+15, y = ir.pos.y+523+5-ir.pos.line_h*(i-1), w = 414+1, h = 52, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
				table.insert(ir.destination,  {id = "rank2",	draw = function() return flg3 and (isrank2(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+15, y = ir.pos.y+523+5-ir.pos.line_h*(i-1), w = 414+1, h = 52, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
				table.insert(ir.destination,  {id = "rank3",	draw = function() return flg3 and (isrank3(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+15, y = ir.pos.y+523+5-ir.pos.line_h*(i-1), w = 414+1, h = 52, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})

			end

			for i = 1, 10 do

			-- table.insert(ir.destination,	{id = "ir_you", draw = function() return (flg3 and isMyFrame(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+2+11, y = ir.pos.y+523+7-52.5*(i-1), w = 417, h = 54, a = 0},{time = window_open_time},{time = window_open_time, a = 255}, {time = window_open_time + 750, a = 255}, {time = window_open_time + 1500, a = 255}}})

			table.insert(ir.destination,	{id = "ir_you_2", draw = function() return (flg3 and isMyFrame(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.x+2+12-14, y = ir.pos.y+523+7-4-14-ir.pos.line_h*(i-1), w = 417+28, h = 54+28, a = 0},{time = window_open_time},{time = window_open_time, a = 255}, {time = window_open_time + 750, a = 255}, {time = window_open_time + 1500, a = 255}}})

			table.insert(ir.image,	{id = "ir_state_clear" .. i, src = "score_data_parts_80", x = 110*4/5, y = 220*4/5, w = 100*4/5, h = 220*4/5, divy = 11, len = 11, ref = 389 + i})
			table.insert(ir.value,	{id = "ir_rank" .. i,  src = "ir_rank_figure", x = 0, y = 0, w = 140, h = 20, divx = 10, digit = 4, ref = 389 + i, align = 2})
			table.insert(ir.value,	{id = "ir_score" .. i,	src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 379 + i, align = 0})
			table.insert(ir.value,	{id = "ir_score_diff" .. i,	src = "figure", x = 0, y = 150, w = 132, h = 30, divx = 12, divy = 2, digit = 7, align = 2, space = -1, value = function()
				local ir_score_diff = 0
				local mybest_score = 0
				local ir_score = main_state.number(379 + i)
				if main_state.number(170) < main_state.number(171) then mybest_score = main_state.number(171)
				else mybest_score = main_state.number(170) end
				if ir_score >= 0 then ir_score_diff = mybest_score - ir_score end
				return ir_score_diff
			end})
			table.insert(ir.value,	{id = "ir_scorerate" .. i,	src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 3, align = 0, space = -1, value = function()
				local ir_score = main_state.number(379 + i)
				local ir_maxscore = main_state.number(74) * 2
				local ir_scorerate = 0
				if ir_score > 0 and ir_maxscore > 0 then ir_scorerate = math.floor(ir_score / ir_maxscore * 100)  end
				return ir_scorerate
			end})
			table.insert(ir.value,	{id = "ir_scorerate_dot" .. i,	src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 2, align = 0, padding = 1, space = -1, value = function()
				local ir_score = main_state.number(379 + i)
				local ir_maxscore = main_state.number(74) * 2
				local ir_scorerate_dot = 0
				if ir_score > 0 and ir_maxscore > 0 then ir_scorerate_dot = ((ir_score / ir_maxscore) * 10000) % 100  end
				return ir_scorerate_dot
			end})
			table.insert(ir.text,		 {id = "ir_name" .. i,	font = "font_sub_small", size = 18, overflow = 1, ref = 119 + i, align = 0})			
			table.insert(ir.destination, {id = "ir_state_clear" .. i, draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.clear_x,	y = v + ir.pos.clear_offset_y,	w = 80, h = 16, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_rank" .. i, draw = function() return flg3 and not(is1to3(i)) end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.rank_x,	y = v + ir.pos.rank_offset_y,	w = 14, h = 20, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_score" .. i, draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.score_x,	y = v + ir.pos.score_offset_y,	w = 17, h = 25, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_score_diff" .. i, draw = function() return flg3 and main_state.number(71) >= 0 and main_state.number(379 + i) >= 0 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.score_diff_x,	y = v + ir.pos.score_diff_offset_y,	w = 11, h = 15, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_name" .. i, draw = function() return flg3 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.name_x,	y = v + ir.pos.name_offset_y,	w = 170, h = 24, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_scorerate" .. i, draw = function() return flg3 and main_state.number(379 + i) >= 0 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.scorerate_x+23-18, y = v + ir.pos.scorerate_offset_y-1, w = 11, h = 15, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "ir_scorerate_dot" .. i, draw = function() return flg3 and main_state.number(379 + i) >= 0 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.scorerate_x+21+18, y = v + ir.pos.scorerate_offset_y-1, w = 11, h = 15, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "mybest_dot", draw = function() return flg3 and main_state.number(379 + i) >= 0 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.scorerate_x+35, y = v + ir.pos.scorerate_offset_y, w = 5, h = 5, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})
			table.insert(ir.destination, {id = "mybest_per", draw = function() return flg3 and main_state.number(379 + i) >= 0 end, loop = window_open_time, timer = timer3.on, dst = {{time = 0, x = ir.pos.scorerate_x+31+30, y = v + ir.pos.scorerate_offset_y, w = 16, h = 14, a = 0},{time = window_open_time},{time = window_open_time, a = 255}}})

			v = v - ir.pos.line_h
			end

		end
		
		append_all(parts.image, ir.image)
		append_all(parts.value, ir.value)
		append_all(parts.text, ir.text)
		append_all(parts.slider, ir.slider)
		append_all(parts.destination, ir.destination)
		
	end

	
	return parts	
end

return {
	parts = parts,
	load = load
}