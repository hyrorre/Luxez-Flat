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

	-- 10位以内か
	function is1to10(indexNum)
		local indexRank = main_state.number(389 + indexNum)
		return (indexRank == 1) or (indexRank == 2) or (indexRank == 3) or (indexRank == 4) or (indexRank == 5) or (indexRank == 6) or (indexRank == 7) or (indexRank == 8) or (indexRank == 9) or (indexRank == 10)
	end

	parts.source = {
		{id = "src-default_irdata_irdata_bg", path = "select_skinparts/default_irdata/ir_data_resize.png"},
		{id = "irdata_loading", path = "select_skinparts/default_irdata/ir_data_loading.png"},
		{id = "score_detail_panel", path = "select_skinparts/default_irdata/score_detail_panel.png"},
		{id = "ir_rank_figure_small", path = "select_skinparts/default_irdata/ir_rank_figure_ver.1.3.0_small.png"},
		{id = "1st_to_10th", path = "select_skinparts/default_irdata/1st_to_10th.png"},
	}
	
	parts.image = {
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

	parts.text = {
		{id = "default_ranking_name_1",		font = "font_sub_small", size = 18, align = 2, ref = 120, overflow = 1},
		{id = "default_ranking_name_2",		font = "font_sub_small", size = 18, align = 2, ref = 121, overflow = 1},
		{id = "default_ranking_name_3",		font = "font_sub_small", size = 18, align = 2, ref = 122, overflow = 1},
		{id = "default_ranking_name_4",		font = "font_sub_small", size = 18, align = 2, ref = 123, overflow = 1},
		{id = "default_ranking_name_5",		font = "font_sub_small", size = 18, align = 2, ref = 124, overflow = 1},
	}
	
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
		{id = "detail_epoor", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*5, w = 12, h = 20}}},
		{id = "detail_cb", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x, y = irdata_position.y + pgreat_diff.y - 26*5 -38, w = 12, h = 20}}},
		{id = "detail_fast", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x + 110, y = irdata_position.y + pgreat_diff.y - 23, w = 12, h = 20, r = 0 ,g = 174, b = 255}}},
		{id = "detail_slow", draw = function() return ((main_state.option(2) or main_state.option(3)) and ((main_state.option(51) and not(op_ir_data)) or not(main_state.option(51)))) end, dst = {{x = irdata_position.x + pgreat_diff.x + 197, y = irdata_position.y + pgreat_diff.y - 23, w = 12, h = 20, r = 255 ,g = 0, b = 84}}},

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
		
		{id = "default_ranking_scorerate_count_1", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end,	dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*0, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_1", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*0, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*0, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*0, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_2", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*1, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_2", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*1, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*1, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*1, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_3", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*2, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_3", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*2, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*2, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*2, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_4", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*3, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_4", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*3, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*3, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*3, w = 5, h = 5}}},
		{id = "default_ranking_scorerate_count_5", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-35+scorerate_x_diff, y = pos.y-29*4, w = 10, h = 17}}},
		{id = "default_ranking_scorerate_dot_count_5", draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+scorerate_x_diff, y = pos.y-29*4, w = 10, h = 17}}},
		{id = "per_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x+22+scorerate_x_diff, y = pos.y+1-29*4, w = 14, h = 16}}},
		{id = "dot_sen",	draw = function() return ((main_state.option(2) or main_state.option(3)) and main_state.option(51) and op_ir_data and not(main_state.option(606))) end, dst = {{x = pos.x-5+scorerate_x_diff, y = pos.y-29*4, w = 5, h = 5}}},
	}

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

				table.insert(parts.destination, {id = "rank_th_" .. i, draw = function() return main_state.number(389 + j) == i and (main_state.option(2) or main_state.option(3)) and main_state.option(51) and not(main_state.option(606)) end, dst = {{x = pos.x + 7, y = pos.y - y_space*(j-1),	w = 30, h = 16}}})

			end

		end

		for i = 1, 5 do

			table.insert(parts.value,	{id = "ir_rank_small" .. i,  src = "ir_rank_figure_small", x = 0, y = 0, w = 110, h = 16, divx = 10, digit = 4, ref = 389 + i, align = 2})

			table.insert(parts.destination, {id = "ir_rank_small" .. i, draw = function() return main_state.number(389 + i) > 10 and (main_state.option(2) or main_state.option(3)) and main_state.option(51) and not(main_state.option(606)) end, dst = {{x = pos.x,	y = pos.y - y_space*(i-1),	w = 11, h = 16}}})


			
		end

	end
	
	return parts
end

return {
	parts = parts,
	load = load
}