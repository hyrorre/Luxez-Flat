local parts = {}

-- local OP_RANK_PLUS_OFF = get_property_op()
-- local OP_RANK_PLUS_ON =	get_property_op()


parts.property = {
	-- {name = "RANK+表記", item = {
	-- 	{name = "OFF",		op = OP_RANK_PLUS_OFF},
	-- 	{name = "ON",		op = OP_RANK_PLUS_ON},
	-- },def = "ON"},
}


local function load()

	local font1_id = "font-default-commonparts-m_select1"
	flag_score = false
	local flag_rival_score = false

	local score = main_state.number(71)
	local maxscore = (main_state.number(74) * 2)
	local scorerate = score / maxscore
	local rivalscore = main_state.number(271)
	local rival_scorerate = rivalscore / maxscore
	local rank_plus = false

	parts.source = {
		{id = "src-default_rivaldata_parts", path = "select_skinparts/default_scoredata/rival_data_resize.png"},
		{id = "src-default_playerdata_parts", path = "select_skinparts/default_scoredata/score_data_resize.png"},
		{id = "score_data_parts", path = "select_skinparts/default_scoredata/clear_rank_resize.png"},
		{id = "rival_rank", path = "select_skinparts/default_scoredata/rank_ver1.3.0_rival.png"},
		{id = "play_data_window", path = "select_skinparts/default_scoredata/play_data_window.png"},
	}
	
	parts.image = {
		
		{id = "default_rivaldata_parts",			src = "src-default_rivaldata_parts", x = 0, y = 0, w = 413, h = 135+15},
		{id = "default_playerdata_parts",			src = "src-default_playerdata_parts", x = 0, y = 0, w = 395+17, h = 180+18},
		{id = "default_playerdata_state_clear",		src = "score_data_parts", x = 110, y = 0, w = 97, h = 220, divy = 11, len = 11, ref = 370},

		{id = "play_data_window",					src = "play_data_window", x = 0, y = 0, w = 412, h = 218},

		{id = "rival_state_clear", src = "score_data_parts", x = 110, y = 0, w = 97, h = 220, divy = 11, len = 11, ref = 371},

		{id = "default_playerdata_rank_aaa",		src = "score_data_parts", x = 0, y = 280, w = 101, h = 40},
		{id = "default_playerdata_rank_aa",			src = "score_data_parts", x = 0, y = 240, w = 101, h = 40},
		{id = "default_playerdata_rank_a",			src = "score_data_parts", x = 0, y = 200, w = 101, h = 40},
		{id = "default_playerdata_rank_b",			src = "score_data_parts", x = 0, y = 160, w = 101, h = 40},
		{id = "default_playerdata_rank_c",			src = "score_data_parts", x = 0, y = 120, w = 101, h = 40},
		{id = "default_playerdata_rank_d",			src = "score_data_parts", x = 0, y = 80, w = 101, h = 40},
		{id = "default_playerdata_rank_e",			src = "score_data_parts", x = 0, y = 40, w = 101, h = 40},
		{id = "default_playerdata_rank_f",			src = "score_data_parts", x = 0, y = 0, w = 101, h = 40},

		{id = "rival_rank_aaa",		src = "rival_rank", x = 0, y = 32*7, w = 96, h = 32},
		{id = "rival_rank_aa",		src = "rival_rank", x = 0, y = 32*6, w = 96, h = 32},
		{id = "rival_rank_a",		src = "rival_rank", x = 0, y = 32*5, w = 96, h = 32},
		{id = "rival_rank_b",		src = "rival_rank", x = 0, y = 32*4, w = 96, h = 32},
		{id = "rival_rank_c",		src = "rival_rank", x = 0, y = 32*3, w = 96, h = 32},
		{id = "rival_rank_d",		src = "rival_rank", x = 0, y = 32*2, w = 96, h = 32},
		{id = "rival_rank_e",		src = "rival_rank", x = 0, y = 32*1, w = 96, h = 32},
		{id = "rival_rank_f",		src = "rival_rank", x = 0, y = 0, w = 96, h = 32},

		{id = "diff_rank_max_plus", src = "score_data_parts", x = 210, y = 320, w = 43, h = 20},
		{id = "diff_rank_aaa_plus", src = "score_data_parts", x = 210, y = 300, w = 43, h = 20},
		{id = "diff_rank_aa_plus", src = "score_data_parts", x = 210, y = 280, w = 43, h = 20},
		{id = "diff_rank_a_plus", src = "score_data_parts", x = 210, y = 260, w = 43, h = 20},
		{id = "diff_rank_b_plus", src = "score_data_parts", x = 210, y = 240, w = 43, h = 20},
		{id = "diff_rank_c_plus", src = "score_data_parts", x = 210, y = 220, w = 43, h = 20},
		{id = "diff_rank_d_plus", src = "score_data_parts", x = 210, y = 200, w = 43, h = 20},
		{id = "diff_rank_e_plus", src = "score_data_parts", x = 210, y = 180, w = 43, h = 20},
		{id = "diff_rank_f_plus", src = "score_data_parts", x = 210, y = 160, w = 43, h = 20},

		{id = "diff_rank_max", src = "score_data_parts", x = 210, y = 140, w = 43, h = 20},
		{id = "diff_rank_aaa", src = "score_data_parts", x = 210, y = 120, w = 43, h = 20},
		{id = "diff_rank_aa", src = "score_data_parts", x = 210, y = 100, w = 43, h = 20},
		{id = "diff_rank_a", src = "score_data_parts", x = 210, y = 80, w = 43, h = 20},
		{id = "diff_rank_b", src = "score_data_parts", x = 210, y = 60, w = 43, h = 20},
		{id = "diff_rank_c", src = "score_data_parts", x = 210, y = 40, w = 43, h = 20},
		{id = "diff_rank_d", src = "score_data_parts", x = 210, y = 20, w = 43, h = 20},
		{id = "diff_rank_e", src = "score_data_parts", x = 210, y = 0, w = 43, h = 20},

		{id = "per_sen", 	src = "number_alte", x = 160, y = 75, w = 14, h = 16},
		{id = "dot_sen", 	src = "number_alte", x = 175, y = 75, w = 5, h = 5},
		{id = "slash_sen",		src = "number_alte", x = 180, y = 75, w = 12, h = 20},
		{id = ":_sen",		src = "number_alte", x = 195, y = 75, w = 5, h = 14},
	}

	parts.value = {
		
		{id = "default_playerdata_score_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, value = function()
			score = main_state.number(71)
			rival_bad = main_state.number(283)
			rival_poor = main_state.number(284)
			if (score < 0 or rival_bad < 0 or rival_poor < 0)then flag_rival_score = false
			else flag_rival_score = true
			end
			if score < 0 then flag_score = false
			else flag_score = true
			end
			return score
		end},
		{id = "default_playerdata_miss_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, ref = 76},
		{id = "default_playerdata_combo_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, ref = 75},
		{id = "default_playerdata_diff_count",				src = "number_1_small", x = 0, y = 0, w = 110, h = 17, divx = 11, digit = 4, align = 1, value = function()
			-- rank_plus = (skin_config.option["RANK+表記"] == OP_RANK_PLUS_ON)
			rank_plus = true
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
		{id = "rival_rank_diff_count",				src = "number_1_small", x = 0, y = 0, w = 110, h = 17, divx = 11, digit = 4, align = 1, value = function()
			--rivalscore off
			if maxscore < 1 then
				return 0
			elseif rank_plus then
				--max+
				if rival_scorerate == 18/18 then
					return 0
				--max-
				elseif rival_scorerate < 18/18 and rival_scorerate >= 17/18 then
					return math.ceil(maxscore * 9/9) - rivalscore
				--aaa+
				elseif rival_scorerate < 17/18 and rival_scorerate >= 16/18 then
					return rivalscore - math.ceil(maxscore * 8/9)
				--aaa-
				elseif rival_scorerate < 16/18 and rival_scorerate >= 15/18 then
					return math.ceil(maxscore * 8/9) - rivalscore
				--aa+
				elseif rival_scorerate < 15/18 and rival_scorerate >= 14/18 then
					return rivalscore - math.ceil(maxscore * 7/9)
				--aa-
				elseif rival_scorerate < 14/18 and rival_scorerate >= 13/18 then
					return math.ceil(maxscore * 7/9) - rivalscore
				--a+
				elseif rival_scorerate < 13/18 and rival_scorerate >= 12/18 then
					return rivalscore - math.ceil(maxscore * 6/9)
				--a-
				elseif rival_scorerate < 12/18 and rival_scorerate >= 11/18 then
					return math.ceil(maxscore * 6/9) - rivalscore
				--b+
				elseif rival_scorerate < 11/18 and rival_scorerate >= 10/18 then
					return rivalscore - math.ceil(maxscore * 5/9)
				--b-
				elseif rival_scorerate < 10/18 and rival_scorerate >= 9/18 then
					return math.ceil(maxscore * 5/9) - rivalscore
				--c+
				elseif rival_scorerate < 9/18 and rival_scorerate >= 8/18 then
					return rivalscore - math.ceil(maxscore * 4/9)
				--c-
				elseif rival_scorerate < 8/18 and rival_scorerate >= 7/18 then
					return math.ceil(maxscore * 4/9) - rivalscore
				--d+
				elseif rival_scorerate < 7/18 and rival_scorerate >= 6/18 then
					return rivalscore - math.ceil(maxscore * 3/9)
				--d-
				elseif rival_scorerate < 6/18 and rival_scorerate >= 5/18 then
					return math.ceil(maxscore * 3/9) - rivalscore
				--e+
				elseif rival_scorerate < 5/18 and rival_scorerate >= 4/18 then
					return rivalscore - math.ceil(maxscore * 2/9)
				--e-
				elseif rival_scorerate < 4/18 and rival_scorerate >= 2/18 then
					return math.ceil(maxscore * 2/9) - rivalscore
				--f+
				elseif rival_scorerate < 2/18 and rival_scorerate >= 0/18 then
					return rivalscore - math.ceil(maxscore * 0/9)
				end
			else
				--max-
				if rival_scorerate < 18/18 and rival_scorerate >= 16/18 then
					return math.ceil(maxscore * 9/9) - rivalscore
				--aaa-
				elseif rival_scorerate < 16/18 and rival_scorerate >= 14/18 then
					return math.ceil(maxscore * 8/9) - rivalscore
				--aa-
				elseif rival_scorerate < 14/18 and rival_scorerate >= 12/18 then
					return math.ceil(maxscore * 7/9) - rivalscore
				--a-
				elseif rival_scorerate < 12/18 and rival_scorerate >= 10/18 then
					return math.ceil(maxscore * 6/9) - rivalscore
				--b-
				elseif rival_scorerate < 10/18 and rival_scorerate >= 8/18 then
					return math.ceil(maxscore * 5/9) - rivalscore
				--c-
				elseif rival_scorerate < 8/18 and rival_scorerate >= 6/18 then
					return math.ceil(maxscore * 4/9) - rivalscore
				--d-
				elseif rival_scorerate < 6/18 and rival_scorerate >= 4/18 then
					return math.ceil(maxscore * 3/9) - rivalscore
				--e-
				elseif rival_scorerate < 4/18 and rival_scorerate >= 0/18 then
					return math.ceil(maxscore * 2/9) - rivalscore
				end
			end
		end},

		{id = "default_playerdata_scorerate_count",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, ref = 102},
		{id = "default_playerdata_scorerate_dot_count",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, ref = 103, padding = 1},
		
		{id = "default_playerdata_clear_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 78},
		{id = "default_playerdata_play_count",				src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 4, ref = 77},

		{id = "rivaldata_score_count",	src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, ref = 271},
		{id = "rivaldata_miss_count",	src = "number_1", x = 0, y = 0, w = 120, h = 20, divx = 10, digit = 6, value = function()
			local v1 = main_state.number(283)
			local v2 = main_state.number(284)
			if v1 >= 0 and v2 >= 0 then
				return v1 + v2
			else
				return 0
			end
		end},
		{id = "rivaldata_diff_score_count",	src = "number_1_small", x = 0, y = 0, w = 120, h = 34, divx = 12, divy = 2, digit = 7, align = 1, value = function()
			local v1 = main_state.number(71)
			local v2 = main_state.number(271)
			if v1 < 0 then v1 = 0 end
			if v2 < 0 then v2 = 0 end
			return v1 - v2
		end},
		{id = "rivaldata_diff_miss_count",	src = "number_1_small", x = 120, y = 0, w = 120, h = 34, divx = 12, divy = 2, digit = 7, align = 1, value = function()
			local v1 = main_state.number(76)
			local v2 = main_state.number(283)
			local v3 = main_state.number(284)
			local v4 = main_state.number(271)
			if v1 < 0 then 
				if v4 <= 0 then
					v1 = 0
				else
					v1 = main_state.number(74)
				end
			end
			if v2 < 0 then v2 = 0 end
			if v3 < 0 then v3 = 0 end
			return v1 - (v2 + v3)
		end},
		{id = "rival_scorerate_count",			src = "number_1_small", x = 0, y = 0, w = 100, h = 17, divx = 10, digit = 3, value = function()
			return math.floor(rival_scorerate * 100)
		end},
		{id = "rival_scorerate_dot_count",		src = "number_1_small", x = 0, y = 34, w = 110, h = 17, divx = 11, digit = 2, value = function()
			return (rival_scorerate * 10000) % 100
		end},

		{id = "uptime_h_count",		src = "number_1", x = 0, y = 0, w = 132, h = 20, divx = 11, digit = 4, ref = 27},
		{id = "uptime_m_count",		src = "number_1", x = 0, y = 40, w = 132, h = 20, divx = 11, digit = 2, ref = 28},
		{id = "uptime_s_count",		src = "number_1", x = 0, y = 40, w = 132, h = 20, divx = 11, digit = 2, ref = 29},

		{id = "total_playtime_h_count",		src = "number_1", x = 0, y = 0, w = 132, h = 20, divx = 11, digit = 4, ref = 17},
		{id = "total_playtime_m_count",		src = "number_1", x = 0, y = 40, w = 132, h = 20, divx = 11, digit = 2, ref = 18},
		{id = "total_playtime_s_count",		src = "number_1", x = 0, y = 40, w = 132, h = 20, divx = 11, digit = 2, ref = 19},

		{id = "total_playnotes_count",		src = "number_1", x = 0, y = 0, w = 132, h = 20, divx = 11, digit = 10, ref = 333},
		{id = "total_clear_count",		src = "number_1", x = 0, y = 0, w = 132, h = 20, divx = 11, digit = 10, ref = 31},
		{id = "total_songs_count",		src = "number_1", x = 0, y = 0, w = 132, h = 20, divx = 11, digit = 10, ref = 30},
	}

	
	local window_x = 715
	local window_y = 81

	local score_x = window_x + 95
	local score_y = window_y + 121
	local play_x = window_x + 102
	local play_y = window_y + 14
	local rank_x = window_x + 242
	local rank_y = window_y + 97
	local lamp_x = window_x + 243
	local lamp_y = window_y + 20
	local next_x = window_x + 249
	local next_y = window_y + 69
	local rate_x = window_x + 286
	local rate_y = window_y + 49

	local rival_diff_x = score_x + 85
	local rival_score_y = window_y + 266
	local rival_rank_x = window_x + 287
	local rival_rank_y = window_y + 257
	local rival_rate_x = window_x + 320
	local rival_rate_y = window_y + 210
	local rival_next_x = window_x + 284
	local rival_next_y = window_y + 230
	local uptime_x = window_x + 226-30
	local uptime_y = window_y + 156

	parts.destination = {
		--{id = "text_test", dst = {{x = 100, y = 420, w = 20, h = 21}}},
		--{id = "text_test2", dst = {{x = 100, y = 390, w = 20, h = 21}}},
		--{id = "text_test3", dst = {{x = 100, y = 360, w = 20, h = 21}}},

		--{id = "default_playerdata_parts", op = {1}, dst = {{x = window_x, y = window_y, w = 395, h = 180}}},

		
		{id = "default_playerdata_parts", op = {2}, dst = {{x = window_x - 8, y = window_y-9, w = 395+17, h = 180+18}}},
		{id = "default_playerdata_parts", op = {3}, dst = {{x = window_x - 8, y = window_y-9, w = 395+17, h = 180+18}}},
		--{id = "default_playerdata_parts", op = {1030}, dst = {{x = window_x - 8, y = window_y-9, w = 395+17, h = 180+18}}},

		{id = "default_rivaldata_parts", op = {2}, dst = {{x = window_x-6, y = window_y+191-6, w = 413, h = 135+15}}},
		{id = "default_rivaldata_parts", op = {3}, dst = {{x = window_x-6, y = window_y+191-6, w = 413, h = 135+15}}},
		--{id = "default_rivaldata_parts", op = {1030}, dst = {{x = window_x-6, y = window_y+191-6, w = 413, h = 135+15}}},

		{id = "play_data_window", op = {1}, dst = {{x = window_x-8-30, y = window_y+9, w = 412, h = 218}}},
		
		{id = "uptime_h_count",	op = {1}, dst = {{x = uptime_x, y = uptime_y, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = uptime_x+52, y = uptime_y+3, w = 5, h = 14}}},
		{id = "uptime_m_count",	op = {1}, dst = {{x = uptime_x+60, y = uptime_y, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = uptime_x+88, y = uptime_y+3, w = 5, h = 14}}},
		{id = "uptime_s_count",	op = {1}, dst = {{x = uptime_x+96, y = uptime_y, w = 12, h = 20}}},

		{id = "total_playtime_h_count",	op = {1}, dst = {{x = uptime_x, y = uptime_y-30*1, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = uptime_x+52, y = uptime_y+3-30*1, w = 5, h = 14}}},
		{id = "total_playtime_m_count",	op = {1}, dst = {{x = uptime_x+60, y = uptime_y-30*1, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = uptime_x+88, y = uptime_y+3-30*1, w = 5, h = 14}}},
		{id = "total_playtime_s_count",	op = {1}, dst = {{x = uptime_x+96, y = uptime_y-30*1, w = 12, h = 20}}},

		{id = "total_playnotes_count",	op = {1}, dst = {{x = uptime_x, y = uptime_y-30*2, w = 12, h = 20}}},
		{id = "total_clear_count",	op = {1}, dst = {{x = uptime_x, y = uptime_y-30*3, w = 12, h = 20}}},
		{id = "total_songs_count",	op = {1}, dst = {{x = uptime_x, y = uptime_y-30*4, w = 12, h = 20}}},
--[[
		{id = "play_data_window", op = {1030}, dst = {{x = window_x-8-30, y = window_y+9, w = 412, h = 218}}},

		{id = "uptime_h_count",	op = {1030}, dst = {{x = uptime_x, y = uptime_y, w = 12, h = 20}}},
		{id = ":_sen", op = {1030},	dst = {{x = uptime_x+52, y = uptime_y+3, w = 5, h = 14}}},
		{id = "uptime_m_count",	op = {1030}, dst = {{x = uptime_x+60, y = uptime_y, w = 12, h = 20}}},
		{id = ":_sen", op = {1030},	dst = {{x = uptime_x+88, y = uptime_y+3, w = 5, h = 14}}},
		{id = "uptime_s_count",	op = {1030}, dst = {{x = uptime_x+96, y = uptime_y, w = 12, h = 20}}},

		{id = "total_playtime_h_count",	op = {1030}, dst = {{x = uptime_x, y = uptime_y-30*1, w = 12, h = 20}}},
		{id = ":_sen", op = {1030},	dst = {{x = uptime_x+52, y = uptime_y+3-30*1, w = 5, h = 14}}},
		{id = "total_playtime_m_count",	op = {1030}, dst = {{x = uptime_x+60, y = uptime_y-30*1, w = 12, h = 20}}},
		{id = ":_sen", op = {1030},	dst = {{x = uptime_x+88, y = uptime_y+3-30*1, w = 5, h = 14}}},
		{id = "total_playtime_s_count",	op = {1030}, dst = {{x = uptime_x+96, y = uptime_y-30*1, w = 12, h = 20}}},

		{id = "total_playnotes_count",	op = {1030}, dst = {{x = uptime_x, y = uptime_y-30*2, w = 12, h = 20}}},
		{id = "total_clear_count",	op = {1030}, dst = {{x = uptime_x, y = uptime_y-30*3, w = 12, h = 20}}},
		{id = "total_songs_count",	op = {1030}, dst = {{x = uptime_x, y = uptime_y-30*4, w = 12, h = 20}}},
]]
		--[[
		{id = "uptime_h_count",	op = {1}, dst = {{x = 440, y = 581, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = 492, y = 584, w = 5, h = 14}}},
		{id = "uptime_m_count",	op = {1}, dst = {{x = 501, y = 581, w = 12, h = 20}}},
		{id = ":_sen", op = {1},	dst = {{x = 529, y = 584, w = 5, h = 14}}},
		{id = "uptime_s_count",	op = {1}, dst = {{x = 538, y = 581, w = 12, h = 20}}},
		]]

			
		-- 曲、コース選択時
		{id = "default_playerdata_state_clear", draw = function() return flag_score end,			timer = 11, loop = 200,	dst = {
			{time = 0 , x = lamp_x, y = lamp_y+10, w = 97, h = 20, a = 0, acc = 2},
			{time = 200 , y = lamp_y, a = 255, acc = 2},}},
		{id = "rival_state_clear",               op = {625, 2},			dst = {{x = score_x, y = rival_score_y - 55, w = 97, h = 20}}},
		{id = "default_playerdata_score_count", draw = function() return flag_score end,			dst = {{x = score_x, y = score_y, w = 12, h = 20}}},
		{id = "default_playerdata_miss_count", draw = function() return flag_score end,				dst = {{x = score_x, y = score_y-27, w = 12, h = 20}}},
		{id = "default_playerdata_combo_count", draw = function() return flag_score end,			dst = {{x = score_x, y = score_y-54, w = 12, h = 20}}},
		{id = "default_playerdata_clear_count", draw = function() return flag_score end,			dst = {{x = play_x-65, y = play_y, w = 12, h = 20}}},
		{id = "default_playerdata_play_count", draw = function() return flag_score end,				dst = {{x = play_x, y = play_y, w = 12, h = 20}}},
		{id = "slash_sen",						 draw = function() return flag_score end,			dst = {{x = play_x-10, y = play_y, w = 12, h = 20}}},		

		{id = "default_playerdata_rank_aaa", op = {200}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_aa", op = {201}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_a", op = {202}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_b", op = {203}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_c", op = {204}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_d", op = {205}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_e", op = {206}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},
		{id = "default_playerdata_rank_f", op = {207}, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rank_x, y = rank_y+10, w = 101, h = 40, a = 0, acc = 2},
			{time = 200 , y = rank_y, a = 255, acc = 2},}},

		{id = "rival_rank_aaa", draw = function() return rivalscore > 0 and rival_scorerate >= 16/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_aa", draw = function() return rivalscore > 0 and rival_scorerate < 16/18 and rival_scorerate >= 14/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_a", draw = function() return rivalscore > 0 and rival_scorerate < 14/18 and rival_scorerate >= 12/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_b", draw = function() return rivalscore > 0 and rival_scorerate < 12/18 and rival_scorerate >= 10/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_c", draw = function() return rivalscore > 0 and rival_scorerate < 10/18 and rival_scorerate >= 8/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_d", draw = function() return rivalscore > 0 and rival_scorerate < 8/18 and rival_scorerate >= 6/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_e", draw = function() return rivalscore > 0 and rival_scorerate < 6/18 and rival_scorerate >= 4/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},
		{id = "rival_rank_f", draw = function() return rivalscore > 0 and rival_scorerate < 4/18 and rival_scorerate >= 0/18 end, timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rank_x, y = rival_rank_y+10, w = 96, h = 32, a = 0, acc = 2},
			{time = 200 , y = rival_rank_y, a = 255, acc = 2},}},

			{id = "diff_rank_max", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 18/18 and rival_scorerate >= 16/18 end, 	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aaa", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 16/18 and rival_scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aa", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 14/18 and rival_scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-5, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_a", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 12/18 and rival_scorerate >= 10/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_b", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 10/18 and rival_scorerate >= 8/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_c", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 8/18 and rival_scorerate >= 6/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_d", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 6/18 and rival_scorerate >= 4/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_e", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 4/18 and rival_scorerate >= 0/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			
			{id = "diff_rank_max", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 18/18 and rival_scorerate >= 17/18 end, 	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aaa", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 16/18 and rival_scorerate >= 15/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aa", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 14/18 and rival_scorerate >= 13/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-5, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_a", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 12/18 and rival_scorerate >= 11/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_b", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 10/18 and rival_scorerate >= 9/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_c", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 8/18 and rival_scorerate >= 7/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_d", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 6/18 and rival_scorerate >= 5/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_e", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 4/18 and rival_scorerate >= 2/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			
			{id = "diff_rank_max_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate == 18/18 end, 	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aaa_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 17/18 and rival_scorerate >= 16/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aa_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 15/18 and rival_scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-5, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_a_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 13/18 and rival_scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_b_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 11/18 and rival_scorerate >= 10/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_c_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 9/18 and rival_scorerate >= 8/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_d_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 7/18 and rival_scorerate >= 6/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_e_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 5/18 and rival_scorerate >= 4/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			{id = "diff_rank_f_plus", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 2/18 and rival_scorerate >= 0/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x-10, y = rival_next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = rival_next_y, a = 255, acc = 2},}},
			
			{id = "rival_rank_diff_count", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			{id = "rival_rank_diff_count", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 14/18 and rival_scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45-5, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			{id = "rival_rank_diff_count", draw = function() return not(rank_plus) and rivalscore > 0 and rival_scorerate < 12/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45-10, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			
			{id = "rival_rank_diff_count", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate >= 15/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			{id = "rival_rank_diff_count", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 15/18 and rival_scorerate >= 13/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45-5, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			{id = "rival_rank_diff_count", draw = function() return rank_plus and rivalscore > 0 and rival_scorerate < 13/18 end,	timer = 11, loop = 200,	dst = {
				{time = 0 , x = rival_next_x+45-10, y = rival_next_y+13, w = 10, h = 17, a = 0, acc = 2},
				{time = 200 , y = rival_next_y+3, a = 255, acc = 2},}},
			
		--rival_scorerate 100%
		{id = "rival_scorerate_count", draw = function() return rivalscore > 0 and rival_scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-35+5, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "rival_scorerate_dot_count", draw = function() return rivalscore > 0 and rival_scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x+5, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return rivalscore > 0 and rival_scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x+22+5, y = rival_rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return rivalscore > 0 and rival_scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-5+5, y = rival_rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},

		--rival_scorerate 10~99%
		{id = "rival_scorerate_count", draw = function() return rivalscore > 0 and rival_scorerate < 10/10 and rival_scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-35, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "rival_scorerate_dot_count", draw = function() return rivalscore > 0 and rival_scorerate < 10/10 and rival_scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return rivalscore > 0 and rival_scorerate < 10/10 and rival_scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x+22, y = rival_rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return rivalscore > 0 and rival_scorerate < 10/10 and rival_scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-5, y = rival_rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},

		--rival_scorerate ~10%
		{id = "rival_scorerate_count", draw = function() return rivalscore > 0 and rival_scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-35-5, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "rival_scorerate_dot_count", draw = function() return rivalscore > 0 and rival_scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-5, y = rival_rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return rivalscore > 0 and rival_scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x+22-5, y = rival_rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return rivalscore > 0 and rival_scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rival_rate_x-5-5, y = rival_rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rival_rate_y+1, a = 255, acc = 2},}},
			
		--[[
			{id = "diff_rank_max", op = {200}, 	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aaa", op = {201},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_aa", op = {202},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_a", op = {203},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_b", op = {204},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_c", op = {205},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_d", op = {206},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
			{id = "diff_rank_e", op = {207},	timer = 11, loop = 200,	dst = {
				{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
				{time = 200 , y = next_y, a = 255, acc = 2},}},
				--not(main_state.option(OP_RANK_PLUS_ON)) and 
		]]

		{id = "diff_rank_max", draw = function() return not(rank_plus) and flag_score and scorerate < 18/18 and scorerate >= 16/18 end, 	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aaa", draw = function() return not(rank_plus) and flag_score and scorerate < 16/18 and scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aa", draw = function() return not(rank_plus) and flag_score and scorerate < 14/18 and scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-5, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_a", draw = function() return not(rank_plus) and flag_score and scorerate < 12/18 and scorerate >= 10/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_b", draw = function() return not(rank_plus) and flag_score and scorerate < 10/18 and scorerate >= 8/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_c", draw = function() return not(rank_plus) and flag_score and scorerate < 8/18 and scorerate >= 6/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_d", draw = function() return not(rank_plus) and flag_score and scorerate < 6/18 and scorerate >= 4/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_e", draw = function() return not(rank_plus) and flag_score and scorerate < 4/18 and scorerate >= 0/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},

		{id = "diff_rank_max", draw = function() return rank_plus and flag_score and scorerate < 18/18 and scorerate >= 17/18 end, 	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aaa", draw = function() return rank_plus and flag_score and scorerate < 16/18 and scorerate >= 15/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aa", draw = function() return rank_plus and flag_score and scorerate < 14/18 and scorerate >= 13/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-5, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_a", draw = function() return rank_plus and flag_score and scorerate < 12/18 and scorerate >= 11/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_b", draw = function() return rank_plus and flag_score and scorerate < 10/18 and scorerate >= 9/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_c", draw = function() return rank_plus and flag_score and scorerate < 8/18 and scorerate >= 7/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_d", draw = function() return rank_plus and flag_score and scorerate < 6/18 and scorerate >= 5/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_e", draw = function() return rank_plus and flag_score and scorerate < 4/18 and scorerate >= 2/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},

		{id = "diff_rank_max_plus", draw = function() return rank_plus and flag_score and scorerate == 18/18 end, 	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aaa_plus", draw = function() return rank_plus and flag_score and scorerate < 17/18 and scorerate >= 16/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_aa_plus", draw = function() return rank_plus and flag_score and scorerate < 15/18 and scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-5, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_a_plus", draw = function() return rank_plus and flag_score and scorerate < 13/18 and scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_b_plus", draw = function() return rank_plus and flag_score and scorerate < 11/18 and scorerate >= 10/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_c_plus", draw = function() return rank_plus and flag_score and scorerate < 9/18 and scorerate >= 8/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_d_plus", draw = function() return rank_plus and flag_score and scorerate < 7/18 and scorerate >= 6/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_e_plus", draw = function() return rank_plus and flag_score and scorerate < 5/18 and scorerate >= 4/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},
		{id = "diff_rank_f_plus", draw = function() return rank_plus and flag_score and scorerate < 2/18 and scorerate >= 0/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x-10, y = next_y+10, w = 43, h = 20, a = 0, acc = 2},
			{time = 200 , y = next_y, a = 255, acc = 2},}},

		{id = "default_playerdata_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate >= 14/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},
		{id = "default_playerdata_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate < 14/18 and scorerate >= 12/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45-5, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},
		{id = "default_playerdata_diff_count", draw = function() return not(rank_plus) and flag_score and scorerate < 12/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45-10, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},

		{id = "default_playerdata_diff_count", draw = function() return rank_plus and flag_score and scorerate >= 15/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},
		{id = "default_playerdata_diff_count", draw = function() return rank_plus and flag_score and scorerate < 15/18 and scorerate >= 13/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45-5, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},
		{id = "default_playerdata_diff_count", draw = function() return rank_plus and flag_score and scorerate < 13/18 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = next_x+45-10, y = next_y+13, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = next_y+3, a = 255, acc = 2},}},

		--scorerate 100%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-35+5, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x+5, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return flag_score and scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x+22+5, y = rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return flag_score and scorerate == 10/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-5+5, y = rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},

		--scorerate 10~99%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-35, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x+22, y = rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return flag_score and scorerate < 10/10 and scorerate >= 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-5, y = rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},

		--scorerate ~10%
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score and scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-35-5, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score and scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-5, y = rate_y+10, w = 10, h = 17, a = 0, acc = 2},
			{time = 200 , y = rate_y, a = 255, acc = 2},}},
		{id = "per_sen",		draw = function() return flag_score and scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x+22-5, y = rate_y+11, w = 14, h = 16, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},
		{id = "dot_sen",		draw = function() return flag_score and scorerate < 1/10 end,	timer = 11, loop = 200,	dst = {
			{time = 0 , x = rate_x-5-5, y = rate_y+11, w = 5, h = 5, a = 0, acc = 2},
			{time = 200 , y = rate_y+1, a = 255, acc = 2},}},

--[[
		{id = "default_playerdata_rank_aaa", op = {200},	dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_aa", op = {201},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_a", op = {202},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_b", op = {203},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_c", op = {204},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_d", op = {205},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_e", op = {206},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},
		{id = "default_playerdata_rank_f", op = {207},		dst = {{x = rank_x, y = rank_y, w = 101, h = 40}}},

		{id = "diff_rank_max", op = {200},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_aaa", op = {201},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_aa", op = {202},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_a", op = {203},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_b", op = {204},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_c", op = {205},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_d", op = {206},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		{id = "diff_rank_e", op = {207},	dst = {{x = next_x, y = next_y, w = 43, h = 20}}},
		

		{id = "default_playerdata_diff_count", draw = function() return flag_score end,	dst = {{x = next_x+39, y = next_y+3, w = 10, h = 17}}},
		{id = "default_playerdata_scorerate_count", draw = function() return flag_score end,		dst = {{x = rate_x-35, y = rate_y, w = 10, h = 17}}},
		{id = "default_playerdata_scorerate_dot_count", draw = function() return flag_score end,	dst = {{x = rate_x, y = rate_y, w = 10, h = 17}}},
		{id = "per_sen",		draw = function() return flag_score end,	dst = {{x = rate_x+22, y = rate_y+1, w = 14, h = 16}}},
		{id = "dot_sen",		draw = function() return flag_score end,	dst = {{x = rate_x-5, y = rate_y+1, w = 5, h = 5}}},
]]

		{id = "rivaldata_score_count",		op = {625, 2},	dst = {{x = score_x, y = rival_score_y, w = 12, h = 20}}},
		{id = "rivaldata_miss_count",		op = {625, 2},	dst = {{x = score_x, y = rival_score_y - 27, w = 12, h = 20}}},
		{id = "rivaldata_diff_score_count",	draw = function() return flag_rival_score end, op = {625, 2},	dst = {{x = rival_diff_x, y = rival_score_y + 2, w = 10, h = 17}}},
		-- {id = "rivaldata_diff_miss_count",	draw = function() return flag_rival_score end, op = {625, 2},	dst = {{x = rival_diff_x, y = rival_score_y - 27 + 2, w = 10, h = 17}}},
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}