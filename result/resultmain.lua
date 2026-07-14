main_state = require("main_state")

local luajava = require("luajava")
local Gdx = luajava.bindClass("com.badlogic.gdx.Gdx")

local input = luajava.bindClass("com.badlogic.gdx.Input")
local result_mode = 0
local pattern_mode = 0
local stagefile_gazou_on = 0

function append_all(list, t)
	if t then
		for i, v in pairs(t) do
			table.insert(list, v)
		end
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

local result_r = 0
local PROPERTY_OP = 899
local function get_property_op()
	PROPERTY_OP = PROPERTY_OP + 1
	return PROPERTY_OP
end

local op = {
	RESULT_L		= get_property_op(),
	RESULT_R		= get_property_op(),
	RANK_PLUS_OFF		= get_property_op(),
	RANK_PLUS_ON		= get_property_op(),
	GRAPH_OFF		= get_property_op(),
	GRAPH_ON		= get_property_op(),
	STAGEFILE_OFF	= get_property_op(),
	STAGEFILE_ON	= get_property_op(),
	STAGEFILE_GAZOU_OFF		= get_property_op(),
	STAGEFILE_GAZOU_FAILED		= get_property_op(),
	STAGEFILE_GAZOU_ON		= get_property_op(),
	PATTERN_OFF	= get_property_op(),
	PATTERN_ON	= get_property_op(),
	SHUTTER_OFF	= get_property_op(),
	SHUTTER_ON	= get_property_op(),
}

local property = {
	{name = "リザルトの配置", item = {
		{name = "左", op = op.RESULT_L},				
		{name = "右", op = op.RESULT_R}
	},def = "左"},
	-- {name = "RANK+表記", item = {
	-- 	{name = "OFF",		op = op.RANK_PLUS_OFF},
	-- 	{name = "ON",		op = op.RANK_PLUS_ON},
	-- },def = "ON"},

	{name = "背景にステージファイルを使用する（CLEAR時のみ）", item = {
		{name = "OFF",	op = op.STAGEFILE_OFF},
		{name = "ON",	op = op.STAGEFILE_ON}				
	},def = "OFF"},
	{name = "ステージファイルを表示する", item = {
		{name = "OFF",	op = op.STAGEFILE_GAZOU_OFF},
		{name = "FAILED時のみ",	op = op.STAGEFILE_GAZOU_FAILED},
		{name = "ON",	op = op.STAGEFILE_GAZOU_ON}				
	},def = "ON"},
	{name = "配置パターンの表示", item = {
		{name = "OFF",	op = op.PATTERN_OFF},
		{name = "ON",	op = op.PATTERN_ON}				
	},def = "ON"},
	{name = "シャッター演出", item = {
		{name = "OFF",		op = op.SHUTTER_OFF},
		{name = "ON",		op = op.SHUTTER_ON},
	},def = "ON"},
}

local filepath = {
	{name = "フレーム", path = "png/frame/*.png",def = "frame_default"},
	{name = "シャッター画像", path = "../customize/shutter/*.png"},
	{name = "シャッターフレーム", path = "png/shutter/*.png",def = "shutter_default"},
	{name = "リザルト背景(CLEAR AAA) resultbg clear AAA",	path = "../customize/resultbg/aaa/*.png"},
	{name = "リザルト背景(CLEAR AA) resultbg clear AA",		path = "../customize/resultbg/aa/*.png"},
	{name = "リザルト背景(CLEAR A) resultbg clear A",		path = "../customize/resultbg/a/*.png"},
	{name = "リザルト背景(CLEAR) resultbg clear",			path = "../customize/resultbg/clear/*.png"},
	{name = "リザルト背景(FAILED) resultbg failed",			path = "../customize/resultbg/failed/*.png"},
}

local header = {
	type = SKINTYPE,
	name = "Luxe_Flat",
	w = 1920,
	h = 1080,
	scene = 3600000,
	input = 500,
	fadeout = 2500,
	property = property,
	filepath = filepath
}

local function main()

	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end
	if skin_config.option["リザルトの配置"] == op.RESULT_R then 
		result_r = 1920-557-20+2
	end
	if skin_config.option["ステージファイルを表示する"] == op.STAGEFILE_GAZOU_ON then 
		stagefile_gazou_on = 1
	end
	if ((skin_config.option["ステージファイルを表示する"] == op.STAGEFILE_GAZOU_FAILED) and main_state.option(91)) then 
		stagefile_gazou_on = 1
	end
	if skin_config.option["配置パターンの表示"] == op.PATTERN_ON then 
		if (((main_state.option(161) or main_state.option(160)) and (main_state.event_index(42) == 2 or main_state.event_index(42) == 3)) or 
				((main_state.option(163) or main_state.option(162)) and (main_state.event_index(42) == 2 or main_state.event_index(42) == 3 or main_state.event_index(43) == 2 or main_state.event_index(43) == 3))) then
					pattern_mode = 1
		end
	end

	local score = main_state.number(71)
	local mybest_score = main_state.number(170)
	local maxscore = (main_state.number(74) * 2)
	local mybest_scorerate = mybest_score / maxscore
	local scorerate = score / maxscore
	local rank_plus = false
	local current_rank = 0
	local mybest_rank = 0
	
	skin.source = {
		{id = "flame",	path = "png/frame/*.png"},
		{id = "judge_detail_lamp",	path = "png/judge_detail_lamp.png"},
		{id = "result_infomation",	path = "png/result_infomation.png"},
		{id = "DJ_LEVEL",	path = "png/DJ_LEVEL.png"},
		{id = "DJ_LEVEL_akarui",	path = "png/DJ_LEVEL_akarui.png"},
		{id = "NEW_RECORD_FRAME",	path = "png/NEW_RECORD_FRAME.png"},
		{id = "new_record!!",	path = "png/new_record!!.png"},
		{id = "CLEARTYPE_TITLEFREAM",	path = "png/CLEARTYPE_TITLEFREAM.png"},
		{id = "SCORE_TITLEFREAM",	path = "png/SCORE_TITLEFREAM.png"},
		{id = "TAGRET_TITLEFREAM",	path = "png/TAGRET_TITLEFREAM.png"},
		{id = "rank_diff",	path = "png/rank_diff.png"},
		{id = "great",	path = "png/great.png"},
		{id = "replay_save", path = "png/replay_save.png"},
		{id = "RANK_DROPSHADOW_small",	path = "png/RANK_DROPSHADOW_2.png"},
		{id = "RANK_DROPSHADOW",	path = "png/RANK_DROPSHADOW.png"},
		{id = "score_data_parts", path = "png/clear_rank_resize.png"},
		{id = "score_data_parts_80", path = "png/clear_rank_resize_80.png"},
		{id = "score_data_parts_small", path = "png/clear_rank_resize_resize.png"},
		{id = "figure", path = "png/figure.png"},
		{id = "ir_rank_figure", path = "png/ir_rank_figure_ver.1.3.0.png"},
		{id = "chart_info_text", path = "png/chart_info_text.png"},
		{id = "clear_failed_2", path = "png/clear_failed_2.png"},
		{id = "clear_failed_dropshadow", path = "png/clear_failed_dropshadow.png"},
		{id = "clear_failed_light", path = "png/clear_failed_light.png"},
		{id = "result_modeselect", path = "png/result_modeselect.png"},
		{id = "ir_scroll_cursor", path = "png/songscroll_cursor_resize.png"},
		{id = "left_yazirusi", path = "png/left_yazirusi.png"},
		{id = "right_yazirusi", path = "png/right_yazirusi.png"},
		{id = "pggrgdbdpr", path = "png/pggrgdbdpr.png"},
		{id = "random_pattern", path = "png/random_pattern.png"},
		{id = "ir_you", path = "png/ir_you.png"},
		{id = "ir_you_2", path = "png/ir_you_2.png"},
		{id = "rank123", path = "png/rank123.png"},

		{id = "bg_aaa",	path = "../customize/resultbg/aaa/*.png"},
		{id = "bg_aa",	path = "../customize/resultbg/aa/*.png"},
		{id = "bg_a",	path = "../customize/resultbg/a/*.png"},
		{id = "bg_c",	path = "../customize/resultbg/clear/*.png"},
		{id = "bg_f",	path = "../customize/resultbg/failed/*.png"},
		{id = "shutter",	path = "png/black.png"},
		{id = "shutter_frame", path = "png/shutter/*.png"},
		{id = "shutter_background",	path = "../customize/shutter/*.png"},
	}
	
	skin.font = {
		{id = "font_songlist", path = "font/font_songlist/songlist.fnt", type = 0},
		{id = "font_sub", path = "font/font_sub/sub.fnt", type = 0},
		{id = "font_sub_small", path = "font/font_sub_small/sub_small.fnt", type = 0},
	}

	skin.image = {
		{id = "flame_left",		src = "flame",	x = 557*0, y = 0, w = 557, h = 1017},
		{id = "judge_detail_lamp",		src = "judge_detail_lamp",	x = 0, y = 0, w = 33, h = 254},
		{id = "flame_right",		src = "flame",	x = 557*1, y = 0, w = 557, h = 1010},
		{id = "flame_right_ir",		src = "flame",	x = 557*2, y = 0, w = 557, h = 1010},
		{id = "result_infomation",		src = "result_infomation",	x = 0, y = 0, w = 430, h = 170},
		{id = "frame_center_clear",		src = "flame",	x = 557*4, y = 0, w = 794, h = 1080},
		{id = "frame_center_failed",		src = "flame",	x = 557*4 + 794, y = 0, w = 794, h = 1080},

		{id = "CLEARTYPE_TITLEFREAM",		src = "CLEARTYPE_TITLEFREAM",	x = 0, y = 0, w = 146, h = 40},
		{id = "SCORE_TITLEFREAM",		src = "SCORE_TITLEFREAM",	x = 0, y = 0, w = 149, h = 59},
		{id = "TAGRET_TITLEFREAM",		src = "TAGRET_TITLEFREAM",	x = 0, y = 0, w = 206, h = 40},

		{id = "great_mozi",		src = "great",	x = 0, y = 0, w = 89, h = 48},

		{id = "result_modeselect_graph_data_on",		src = "result_modeselect",	x = 0, y = 0, w = 204, h = 35},
		{id = "result_modeselect_graph_data_off",		src = "result_modeselect",	x = 0, y = 35, w = 204, h = 35, act = (function() result_mode = 0 end)},
		{id = "result_modeselect_ir_ranking_on",		src = "result_modeselect",	x = 219, y = 35, w = 204, h = 35},
		{id = "result_modeselect_ir_ranking_off",		src = "result_modeselect",	x = 219, y = 0, w = 204, h = 35, act = (function() result_mode = 1 end)},
		{id = "result_modeselect_rect",		src = "result_modeselect",	x = 0, y = 70, w = 204, h = 35},

		{id = "replay_1",	src = "replay_save", x = 23*0, y = 0, w = 23, h = 28, act = 19},
		{id = "replay_2",	src = "replay_save", x = 23*1, y = 0, w = 23, h = 28, act = 316},
		{id = "replay_3",	src = "replay_save", x = 23*2, y = 0, w = 23, h = 28, act = 317},
		{id = "replay_4",	src = "replay_save", x = 23*3, y = 0, w = 23, h = 28, act = 318},

		{id = "replay_1_rect",	src = "replay_save", x = 23*0, y = 0, w = 23, h = 28},
		{id = "replay_2_rect",	src = "replay_save", x = 23*1, y = 0, w = 23, h = 28},
		{id = "replay_3_rect",	src = "replay_save", x = 23*2, y = 0, w = 23, h = 28},
		{id = "replay_4_rect",	src = "replay_save", x = 23*3, y = 0, w = 23, h = 28},

		{id = "state_clear",		src = "score_data_parts", x = 110, y = 0, w = 100, h = 220, divy = 11, len = 11, ref = 370},
		{id = "state_mybest_clear",		src = "score_data_parts", x = 110, y = 0, w = 100, h = 220, divy = 11, len = 11, ref = 371},

		{id = "mybest_dot",		src = "figure",	x = 121, y = 50, w = 5, h = 5},
		{id = "current_dot",		src = "figure",	x = 121, y = 65, w = 5, h = 5},

		{id = "mybest_per",		src = "figure",	x = 126, y = 50, w = 16, h = 14},
		{id = "current_per",		src = "figure",	x = 126, y = 65, w = 16, h = 14},
		
		{id = "bg_c",		src = "bg_c",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_aaa",		src = "bg_aaa",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_aa",		src = "bg_aa",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_a",		src = "bg_a",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_f",		src = "bg_f",	x = 0, y = 0, w = -1, h = -1},

		{id = "RANK_DROPSHADOW_small",	src = "RANK_DROPSHADOW_small", x = 0, y = 0, w = 98, h = 98},
		{id = "RANK_DROPSHADOW",	src = "RANK_DROPSHADOW", x = 0, y = 0, w = 539, h = 539},
		
		{id = "aaa_top",		src = "DJ_LEVEL", x = 0, y = 125*0, w = 250, h = 125},
		{id = "aa_top",			src = "DJ_LEVEL", x = 0, y = 125*1, w = 250, h = 125},
		{id = "a_top",			src = "DJ_LEVEL", x = 0, y = 125*2, w = 250, h = 125},
		{id = "b_top",			src = "DJ_LEVEL", x = 0, y = 125*3, w = 250, h = 125},
		{id = "c_top",			src = "DJ_LEVEL", x = 0, y = 125*4, w = 250, h = 125},
		{id = "d_top",			src = "DJ_LEVEL", x = 0, y = 125*5, w = 250, h = 125},
		{id = "e_top",			src = "DJ_LEVEL", x = 0, y = 125*6, w = 250, h = 125},
		{id = "f_top",			src = "DJ_LEVEL", x = 0, y = 125*7, w = 250, h = 125},

		{id = "aaa_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*0, w = 250, h = 125},
		{id = "aa_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*1, w = 250, h = 125},
		{id = "a_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*2, w = 250, h = 125},
		{id = "b_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*3, w = 250, h = 125},
		{id = "c_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*4, w = 250, h = 125},
		{id = "d_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*5, w = 250, h = 125},
		{id = "e_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*6, w = 250, h = 125},
		{id = "f_top_2",		src = "DJ_LEVEL_akarui", x = 0, y = 125*7, w = 250, h = 125},

		{id = "NEW_RECORD_FRAME", src = "NEW_RECORD_FRAME", x = 0, y = 0, w = 54, h = 54},
		{id = "new_record!!", src = "new_record!!", x = 0, y = 0, w = 74, h = 32},

		{id = "default_playerdata_rank_aaa",		src = "score_data_parts_small", x = 0, y = 24*7, w = 62, h = 24},
		{id = "default_playerdata_rank_aa",			src = "score_data_parts_small", x = 0, y = 24*6, w = 62, h = 24},
		{id = "default_playerdata_rank_a",			src = "score_data_parts_small", x = 0, y = 24*5, w = 62, h = 24},
		{id = "default_playerdata_rank_b",			src = "score_data_parts_small", x = 0, y = 24*4, w = 62, h = 24},
		{id = "default_playerdata_rank_c",			src = "score_data_parts_small", x = 0, y = 24*3, w = 62, h = 24},
		{id = "default_playerdata_rank_d",			src = "score_data_parts_small", x = 0, y = 24*2, w = 62, h = 24},
		{id = "default_playerdata_rank_e",			src = "score_data_parts_small", x = 0, y = 24*1, w = 62, h = 24},
		{id = "default_playerdata_rank_f",			src = "score_data_parts_small", x = 0, y = 24*0, w = 62, h = 24},

		{id = "rank_diff_e_minus", src = "rank_diff", x = 0, y = 15*0, w = 50, h = 15},
		{id = "rank_diff_d_minus", src = "rank_diff", x = 0, y = 15*1, w = 50, h = 15},
		{id = "rank_diff_c_minus", src = "rank_diff", x = 0, y = 15*2, w = 50, h = 15},
		{id = "rank_diff_b_minus", src = "rank_diff", x = 0, y = 15*3, w = 50, h = 15},
		{id = "rank_diff_a_minus", src = "rank_diff", x = 0, y = 15*4, w = 50, h = 15},
		{id = "rank_diff_aa_minus", src = "rank_diff", x = 0, y = 15*5, w = 50, h = 15},
		{id = "rank_diff_aaa_minus", src = "rank_diff", x = 0, y = 15*6, w = 50, h = 15},
		{id = "rank_diff_max_minus", src = "rank_diff", x = 0, y = 15*7, w = 50, h = 15},

		{id = "rank_diff_f_plus", src = "rank_diff", x = 0, y = 15*8, w = 50, h = 15},
		{id = "rank_diff_e_plus", src = "rank_diff", x = 0, y = 15*9, w = 50, h = 15},
		{id = "rank_diff_d_plus", src = "rank_diff", x = 0, y = 15*10, w = 50, h = 15},
		{id = "rank_diff_c_plus", src = "rank_diff", x = 0, y = 15*11, w = 50, h = 15},
		{id = "rank_diff_b_plus", src = "rank_diff", x = 0, y = 15*12, w = 50, h = 15},
		{id = "rank_diff_a_plus", src = "rank_diff", x = 0, y = 15*13, w = 50, h = 15},
		{id = "rank_diff_aa_plus", src = "rank_diff", x = 0, y = 15*14, w = 50, h = 15},
		{id = "rank_diff_aaa_plus", src = "rank_diff", x = 0, y = 15*15, w = 50, h = 15},
		{id = "rank_diff_max_plus", src = "rank_diff", x = 0, y = 15*16, w = 50, h = 15},

		{id = "left_yazirusi", src = "left_yazirusi", x = 0, y = 0, w = 34, h = 34},
		{id = "right_yazirusi", src = "right_yazirusi", x = 0, y = 0, w = 34, h = 34},

		{id = "pggrgdbdpr_7keys", src = "pggrgdbdpr", x = 0, y = 0, w = 205, h = 131},
		{id = "pggrgdbdpr_9keys", src = "pggrgdbdpr", x = 0, y = 131, w = 205, h = 131},

		{id = "1key", src = "random_pattern", x = 25*0, y = 0, w = 25, h = 35},
		{id = "2key", src = "random_pattern", x = 25*1, y = 0, w = 25, h = 35},
		{id = "3key", src = "random_pattern", x = 25*2, y = 0, w = 25, h = 35},
		{id = "4key", src = "random_pattern", x = 25*3, y = 0, w = 25, h = 35},
		{id = "5key", src = "random_pattern", x = 25*4, y = 0, w = 25, h = 35},
		{id = "6key", src = "random_pattern", x = 25*5, y = 0, w = 25, h = 35},
		{id = "7key", src = "random_pattern", x = 25*6, y = 0, w = 25, h = 35},

		-- {id = "random_pattern_warning", src = "random_pattern", x = 0, y = 50, w = 300, h = 30},

		{id = "5k", src = "chart_info_text", x = 0, y = 20*0, w = 40, h = 20},
		{id = "7k", src = "chart_info_text", x = 0, y = 20*1, w = 40, h = 20},
		{id = "9k", src = "chart_info_text", x = 0, y = 20*2, w = 40, h = 20},
		{id = "10k", src = "chart_info_text", x = 0, y = 20*3, w = 40, h = 20},
		{id = "14k", src = "chart_info_text", x = 0, y = 20*4, w = 40, h = 20},
		{id = "24k", src = "chart_info_text", x = 0, y = 20*5, w = 40, h = 20},
		{id = "48k", src = "chart_info_text", x = 0, y = 20*6, w = 40, h = 20},

		{id = "ve", src = "chart_info_text", x = 50, y = 20*0, w = 83, h = 20},
		{id = "e", src = "chart_info_text", x = 50, y = 20*1, w = 83, h = 20},
		{id = "n", src = "chart_info_text", x = 50, y = 20*2, w = 83, h = 20},
		{id = "h", src = "chart_info_text", x = 50, y = 20*3, w = 83, h = 20},
		{id = "vh", src = "chart_info_text", x = 50, y = 20*4, w = 83, h = 20},

		{id = "unknown", src = "chart_info_text", x = 150, y = 20*0, w = 100, h = 20},
		{id = "beginner", src = "chart_info_text", x = 150, y = 20*1, w = 100, h = 20},
		{id = "normal", src = "chart_info_text", x = 150, y = 20*2, w = 100, h = 20},
		{id = "hyper", src = "chart_info_text", x = 150, y = 20*3, w = 100, h = 20},
		{id = "another", src = "chart_info_text", x = 150, y = 20*4, w = 100, h = 20},
		{id = "insane", src = "chart_info_text", x = 150, y = 20*5, w = 100, h = 20},

		{id = "ave_fast", src = "figure", x = 25, y = 225, w = 39, h = 17},
		{id = "ave_slow", src = "figure", x = 65, y = 225, w = 39, h = 17},
		{id = "end_position", src = "figure", x = 0, y = 210, w = 89, h = 12},
		{id = "ms", src = "figure", x = 0, y = 225, w = 23, h = 12},

		{id = "big_clear_light", src = "clear_failed_light", x = 0, y = 0, w = 700, h = 250},
		{id = "big_failed_light", src = "clear_failed_light", x = 0, y = 250, w = 700, h = 250},
		{id = "big_fullcombo_light", src = "clear_failed_light", x = 0, y = 500, w = 700, h = 125},
		{id = "big_fullcombo_light", src = "clear_failed_light", x = 0, y = 625, w = 700, h = 125},

		{id = "big_clear_2", src = "clear_failed_2", x = 0, y = 0, w = 700, h = 250},
		{id = "big_failed_2", src = "clear_failed_2", x = 0, y = 250, w = 700, h = 250},
		{id = "big_fullcombo_2_full", src = "clear_failed_2", x = 0, y = 500, w = 700, h = 125},
		{id = "big_fullcombo_2_combo", src = "clear_failed_2", x = 0, y = 625, w = 700, h = 125},
		{id = "big_clear_shadow", src = "clear_failed_dropshadow", x = 0, y = 0, w = 1450, h = 1150},
		{id = "big_failed_shadow", src = "clear_failed_dropshadow", x = 0, y = 1150, w = 1450, h = 1150},
		{id = "big_fullcombo_shadow", src = "clear_failed_dropshadow", x = 0, y = 2300, w = 1450, h = 1150},
		
		-- {id = "ir_you", src = "ir_you", x = 0, y = 0, w = 414, h = 54},
		{id = "ir_you_2", src = "ir_you_2", x = 0, y = 0, w = 414 + 3 + 28, h = 54 + 28},

		{id = "rank1", src = "rank123", x = 0, y = 0, w = 414, h = 52},
		{id = "rank2", src = "rank123", x = 0, y = 52, w = 414, h = 52},
		{id = "rank3", src = "rank123", x = 0, y = 104, w = 414, h = 52},

		{id = "shutter", src = "shutter", x = 0, y = 0, w = 1, h = 1},

		{id = "shutter_left",	src = "shutter_frame", x = 0, y = 0, w = 1920, h = 1080},
		{id = "shutter_right",	src = "shutter_frame", x = 0, y = 1080, w = 1920, h = 1080},
		{id = "shutter_bar_left_1",	src = "shutter_frame", x = 0, y = 1080 * 2, w = 695, h = 695},
		{id = "shutter_bar_right_1",	src = "shutter_frame", x = 0, y = 1080 * 2 + 695, w = 1289, h = 1080},
		{id = "shutter_circle_1",	src = "shutter_frame", x = 0, y = 3935, w = 1522, h = 1522},
		{id = "shutter_circle_2",	src = "shutter_frame", x = 0, y = 5456, w = 788, h = 788},
		{id = "shutter_luster",	src = "shutter_frame", x = 0, y = 6250, w = 1920, h = 1080},
		{id = "shutter_background",	src = "shutter_background", x = 0, y = 0, w = 1920, h = 1080},

	}
	
	-- クリア更新表記
	local clear = {
		current	= main_state.number(370),
		best	= main_state.number(371),
		pos		= 0
	}

	skin.value = {
		{id = "rank_diff_count", src = "figure", x = 0, y = 150, w = 121, h = 15, divx = 11, digit = 4, align = 0, space = -1, value = function()
			if Gdx.input:isKeyPressed(input.Keys.RIGHT) then
				result_mode = 1
			end
			if Gdx.input:isKeyPressed(input.Keys.LEFT) then
				result_mode = 0
			end
			-- if Gdx.input:isKeyPressed(input.Keys.UP) then
			-- 	if (((main_state.option(161) or main_state.option(160)) and (main_state.event_index(42) == 2 or main_state.event_index(42) == 3)) or 
			-- 	((main_state.option(163) or main_state.option(162)) and (main_state.event_index(42) == 2 or main_state.event_index(42) == 3 or main_state.event_index(43) == 2 or main_state.event_index(43) == 3))) then
			-- 		pattern_mode = 1
			-- 	end
			-- end
			-- if Gdx.input:isKeyPressed(input.Keys.DOWN) then
			-- 	pattern_mode = 0
			-- end

			-- rank_plus = (skin_config.option["RANK+表記"] == op.RANK_PLUS_ON)
			rank_plus = true
			
			score = main_state.number(71)
			maxscore = (main_state.number(74) * 2)
			mybest_score = main_state.number(170)
			if maxscore < 1 then
				scorerate = 0
			else	
				scorerate = score / maxscore
			end
			if maxscore < 1 then
				mybest_scorerate = 0
			else	
				mybest_scorerate = mybest_score / maxscore
			end
			rivalscore = main_state.number(271)
			if maxscore < 1 then
				rival_scorerate = 0
			else	
				rival_scorerate = rivalscore / maxscore
			end

			if scorerate < 4/18 and scorerate >= 0/18 then
				current_rank = 0
			elseif scorerate < 6/18 and scorerate >= 4/18 then
				current_rank = 1
			elseif scorerate < 8/18 and scorerate >= 6/18 then
				current_rank = 2
			elseif scorerate < 10/18 and scorerate >= 8/18 then
				current_rank = 3
			elseif scorerate < 12/18 and scorerate >= 10/18 then
				current_rank = 4
			elseif scorerate < 14/18 and scorerate >= 12/18 then
				current_rank = 5
			elseif scorerate < 16/18 and scorerate >= 14/18 then
				current_rank = 6
			elseif scorerate < 18/18 and scorerate >= 16/18 then
				current_rank = 7
			end

			if mybest_scorerate < 4/18 and mybest_scorerate >= 0/18 then
				mybest_rank = 0
			elseif mybest_scorerate < 6/18 and mybest_scorerate >= 4/18 then
				mybest_rank = 1
			elseif mybest_scorerate < 8/18 and mybest_scorerate >= 6/18 then
				mybest_rank = 2
			elseif mybest_scorerate < 10/18 and mybest_scorerate >= 8/18 then
				mybest_rank = 3
			elseif mybest_scorerate < 12/18 and mybest_scorerate >= 10/18 then
				mybest_rank = 4
			elseif mybest_scorerate < 14/18 and mybest_scorerate >= 12/18 then
				mybest_rank = 5
			elseif mybest_scorerate < 16/18 and mybest_scorerate >= 14/18 then
				mybest_rank = 6
			elseif mybest_scorerate < 18/18 and mybest_scorerate >= 16/18 then
				mybest_rank = 7
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

		{id = "mybest_score",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 170, align = 2},
		{id = "current_score",		src = "figure", x = 0, y = 25, w = 170, h = 25, divx = 10, digit = 6, ref = 171, align = 2},

		{id = "mybest_scorerate",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 3, ref = 183, align = 0, space = -1},
		{id = "mybest_scorerate_dot",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 2, ref = 184, align = 0, padding = 1, space = -1},

		{id = "current_scorerate",		src = "figure", x = 0, y = 65, w = 110, h = 15, divx = 10, digit = 3, ref = 102, align = 0, space = -1},
		{id = "current_scorerate_dot",		src = "figure", x = 0, y = 65, w = 110, h = 15, divx = 10, digit = 2, ref = 103, align = 0, padding = 1, space = -1},

		{id = "score_diff",		src = "figure", x = 0, y = 150, w = 132, h = 30, divx = 12, divy = 2, digit = 7, ref = 172, align = 2, space = -1},

		{id = "mybest_bp",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 176, align = 2},
		{id = "current_bp",		src = "figure", x = 0, y = 25, w = 170, h = 25, divx = 10, digit = 6, ref = 76, align = 2},

		{id = "bp_diff",		src = "figure", x = 0, y = 180, w = 132, h = 30, divx = 12, divy = 2, digit = 7, ref = 178, align = 2, space = -1},

		{id = "target_score",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 151, align = 0},

		{id = "target_score_diff",		src = "figure", x = 0, y = 150, w = 132, h = 30, divx = 12, divy = 2, digit = 7, ref = 153, align = 2, space = -1},

		{id = "target_scorerate",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 3, ref = 157, align = 0, space = -1},
		{id = "target_scorerate_dot",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 2, ref = 158, align = 0, padding = 1, space = -1},

		{id = "mybest_irrank",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 182, align = 2},
		{id = "current_irrank",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 179, align = 2},
		{id = "totalplayer_irrank",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 6, ref = 180, align = 2,space = -1},

		-- {id = "mybest_irrank",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 182, align = 2},
		-- {id = "current_irrank",		src = "figure", x = 0, y = 0, w = 170, h = 25, divx = 10, digit = 6, ref = 179, align = 2},
		-- {id = "totalplayer_irrank",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 6, ref = 180, align = 2,space = -1},

		{id = "pgreat",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 110, align = 0, space = -1},
		{id = "great",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 111, align = 0, space = -1},
		{id = "good",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 112, align = 0, space = -1},
		{id = "bad",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 113, align = 0, space = -1},
		{id = "poor",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 114, align = 0, space = -1},
		{id = "fail",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 420, align = 0, space = -1},

		{id = "pgreat_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 410, align = 0, space = -1},
		{id = "great_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 412, align = 0, space = -1},
		{id = "good_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 414, align = 0, space = -1},
		{id = "bad_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 416, align = 0, space = -1},
		{id = "poor_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 418, align = 0, space = -1},
		{id = "fail_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 421, align = 0, space = -1},

		{id = "pgreat_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 411, align = 0, space = -1},
		{id = "great_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 413, align = 0, space = -1},
		{id = "good_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 415, align = 0, space = -1},
		{id = "bad_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 417, align = 0, space = -1},
		{id = "poor_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 419, align = 0, space = -1},
		{id = "fail_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 422, align = 0, space = -1},

		{id = "cb",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 425, align = 0, space = -1},
		{id = "maxcombo",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 75, align = 0, space = -1},
		
		--test
		{id = "scr",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 459, align = 0, space = -1},
		{id = "1key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 450, align = 0, space = -1},
		{id = "2key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 451, align = 0, space = -1},
		{id = "3key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 452, align = 0, space = -1},
		{id = "4key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 453, align = 0, space = -1},
		{id = "5key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 454, align = 0, space = -1},
		{id = "6key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 455, align = 0, space = -1},
		{id = "7key",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 456, align = 0, space = -1},

		{id = "total_fast",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 423, align = 2, space = -1},
		{id = "total_slow",		src = "figure", x = 0, y = 80, w = 140, h = 20, divx = 10, digit = 6, ref = 424, align = 2, space = -1},

		{id = "totalnotes", src = "figure", x = 0, y = 100, w = 120, h = 20, divx = 10, digit = 6, ref = 74, align = 2},
		{id = "difficulty_count", src = "figure", x = 0, y = 100, w = 120, h = 20, divx = 10, digit = 2, ref = 96, align = 2},

		{id = "gauge_count",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 3, ref = 107, align = 0, space = -1},
		{id = "gauge_count_dot",	src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 1, ref = 407, align = 0, padding = 1, space = -1},

		{id = "duration",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 4, ref = 372, align = 0, space = -1},
		{id = "duration_dot",	src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 2, ref = 373, align = 0, padding = 1, space = -1},

		{id = "average",		src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 4, ref = 374, align = 0, space = -1},
		{id = "average_dot",	src = "figure", x = 0, y = 50, w = 110, h = 15, divx = 10, digit = 2, ref = 375, align = 0, padding = 1, space = -1},

	}
	
	skin.text = {
		{id = "default_info_title",		font = "font_songlist", size = 30, align = 1, ref = 12, overflow = 1},
		{id = "default_info_artist",		font = "font_sub", size = 26, align = 1, ref = 16, overflow = 1},
		{id = "default_info_directory",	font = "font_sub", size = 26, align = 1, ref = 1003, overflow = 1},
		{id = "target_name",	font = "font_sub_small", size = 18, align = 0, ref = 3, overflow = 1},
		{id = "ir_name",	font = "font_sub_small", size = 18, align = 2, ref = 1020, overflow = 1},
	}

	do

		local lane_option = nil
		
		if main_state.event_index(42) == 1 then
			lane_option = "MIRROR"
		elseif main_state.event_index(42) == 2 then
			lane_option = "RANDOM"
		elseif main_state.event_index(42) == 3 then
			lane_option = "R-RANDOM"
		elseif main_state.event_index(42) == 4 then
			lane_option = "S-RANDOM"
		elseif main_state.event_index(42) == 5 then
			lane_option = "SPIRAL"
		elseif main_state.event_index(42) == 6 then
			lane_option = "H-RANDOM"
		elseif main_state.event_index(42) == 7 then
			lane_option = "ALL-SCR"
		elseif main_state.event_index(42) == 8 then
			lane_option = "RANDOM+"
		elseif main_state.event_index(42) == 9 then
			lane_option = "S_RANDOM+"
		else
			lane_option = "OFF"
		end

		if main_state.option(163) or main_state.option(162) or main_state.option(1161) then
			if main_state.event_index(43) == 1 then
				lane_option = lane_option .. " / MIRROR"
			elseif main_state.event_index(43) == 2 then
				lane_option = lane_option .. " / RANDOM"
			elseif main_state.event_index(43) == 3 then
				lane_option = lane_option .. " / R-RANDOM"
			elseif main_state.event_index(43) == 4 then
				lane_option = lane_option .. " / S-RANDOM"
			elseif main_state.event_index(43) == 5 then
				lane_option = lane_option .. " / SPIRAL"
			elseif main_state.event_index(43) == 6 then
				lane_option = lane_option .. " / H-RANDOM"
			elseif main_state.event_index(43) == 7 then
				lane_option = lane_option .. " / ALL-SCR"
			elseif main_state.event_index(43) == 8 then
				lane_option = lane_option .. " / RANDOM+"
			elseif main_state.event_index(43) == 9 then
				lane_option = lane_option .. " / S_RANDOM+"
			else
				lane_option = lane_option .. " / OFF"
			end

			if main_state.event_index(54) == 1 then
				lane_option = lane_option .. " , FLIP"
			elseif main_state.event_index(54) == 2 then
				lane_option = lane_option .. " , BATTLE"
			elseif main_state.event_index(54) == 3 then
				lane_option = lane_option .. " , BATTLE+AS"
			end
		end

		-- lane_option = lane_option .. "  "

		-- if main_state.event_index(450) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(450) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(450) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(450) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(450) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(450) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(450) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(450) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(451) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(451) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(451) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(451) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(451) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(451) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(451) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(451) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(452) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(452) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(452) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(452) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(452) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(452) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(452) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(452) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(453) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(453) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(453) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(453) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(453) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(453) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(453) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(453) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(454) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(454) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(454) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(454) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(454) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(454) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(454) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(454) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(455) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(455) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(455) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(455) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(455) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(455) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(455) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(455) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		-- lane_option = lane_option .. ","

		-- if main_state.event_index(456) == 1 then
		-- 	lane_option = lane_option .. "1"
		-- elseif main_state.event_index(456) == 2 then
		-- 	lane_option = lane_option .. "2"
		-- elseif main_state.event_index(456) == 3 then
		-- 	lane_option = lane_option .. "3"
		-- elseif main_state.event_index(456) == 4 then
		-- 	lane_option = lane_option .. "4"
		-- elseif main_state.event_index(456) == 5 then
		-- 	lane_option = lane_option .. "5"
		-- elseif main_state.event_index(456) == 6 then
		-- 	lane_option = lane_option .. "6"
		-- elseif main_state.event_index(456) == 7 then
		-- 	lane_option = lane_option ..  "7"
		-- elseif main_state.event_index(456) == 0 then
		-- 	lane_option = lane_option .. "0"
		-- end

		table.insert(skin.text, {id = "lane_option", font = "font_sub_small", size = 18, align = 0, constantText = lane_option, overflow = 1})
	end

	skin.slider = {}

	skin.gaugegraph = {
		{id = "gauge",  assistClearBGColor = "440044aa",
						 assistAndEasyFailBGColor = "004444aa",
						 grooveFailBGColor = "004400aa",
						 grooveClearAndHardBGColor = "440000aa",
						 exHardBGColor = "444400aa",
						 hazardBGColor = "444444aa",
						 borderColor = "440000aa"
		},
		{id = "gauge_line",  assistClearBGColor = "44004400",
						 assistAndEasyFailBGColor = "00444400",
						 grooveFailBGColor = "00440000",
						 grooveClearAndHardBGColor = "44000000",
						 exHardBGColor = "44440000",
						 hazardBGColor = "44444400",
						 borderColor = "44000000"
		}
   }
	
	skin.judgegraph = {
		{id = "notes_graph", noGap = 0, orderReverse = 0, type = 0, backTexOff = 1},
		{id = "judge_graph", noGap = 0, orderReverse = 1, type = 1, backTexOff = 1},
		{id = "fast_slow_graph", noGap = 0, orderReverse = 1, type = 2, backTexOff = 1},
	}

	skin.timingdistributiongraph = {
		{id = "timing_graph", backTexOff = 1, graphColor = "f5f5f5"},
	}
	
	local result_origin = {24, 76 - 18}
	if skin_config.option["リザルトの配置"] == op.RESULT_R then result_origin[1] = 1490 end
	
	local pos = {
		info		= {30,									855},
		logo		= {20,									1000},
		time		= {290,									1006},
		tgt			= {result_origin[1],					result_origin[2] + 366},
		replay_2	= {result_origin[1] + 53 + 187,			result_origin[2] + 266},
		replay_3	= {result_origin[1] + 93 + 187,			result_origin[2] + 266},
		replay_4	= {result_origin[1] + 133 + 187,		result_origin[2] + 266},
		ir			= {result_origin[1] + 105 - 92,			result_origin[2] + 316},
		ir_rank		= {result_origin[1] + 105 - 36,			result_origin[2] + 316},
		ir_total	= {result_origin[1] + 189,				result_origin[2] + 316},
		rate		= {result_origin[1] + 13 + 45,			result_origin[2] + 244},
		rate_ad		= {result_origin[1] + 13 + 45 + 52,		result_origin[2] + 244},
		clear		= {result_origin[1] + 13,				result_origin[2] + 220},
		clear_state	= {result_origin[1] - 12 + clear.pos,	result_origin[2] + 220},
		rank		= {result_origin[1] + 241 - 184,		result_origin[2] + 266},
		diff		= {result_origin[1] + 333,				result_origin[2] + 281},
		level		= {result_origin[1] + 353,				result_origin[2] + 281},
		score		= {result_origin[1] + 309,				result_origin[2] + 220},
		diffscore	= {result_origin[1] + 309,				result_origin[2] + 220 + 21},
		combo		= {result_origin[1] + 309,				result_origin[2] + 175},
		diffcombo	= {result_origin[1] + 309,				result_origin[2] + 175 + 21},
		miss		= {result_origin[1] + 105,				result_origin[2] + 175},
		diffmiss	= {result_origin[1] + 105,				result_origin[2] + 175 + 21},
		fast		= {result_origin[1] + 315,				result_origin[2] + 36},
		slow		= {result_origin[1] + 195,				result_origin[2] + 36},
		timing		= {result_origin[1] + 270,				result_origin[2] + 135}
	}
		
	local jg_pos = {x = result_origin[1] + 69, y = {}}
	jg_pos.y[1] = result_origin[2] + 133
	for i = 2, 6, 1 do
		jg_pos.y[i] = jg_pos.y[i - 1] - 24
	end
	
	
	local graph_l = {}
	local graph_max = 0
	local notes_t = main_state.number(74)
	local num = {422, 419, 417, 415, 413, 411, 410, 412, 414, 416, 418, 421}
	for i, v in ipairs(num) do
		graph_l[i] = main_state.number(v) / notes_t * 100
		if graph_max < graph_l[i] then graph_max = graph_l[i] end
	end
	for i, v in ipairs(graph_l) do
		graph_l[i] = v / graph_max * 100
	end
	local graph_pos = {x = {}, y = result_origin[2] + 31}
	graph_pos.x[1] = result_origin[1] + 185
	for i = 2, 12, 1 do
		graph_pos.x[i] = graph_pos.x[i - 1] + 17
	end
	
	local dt = {0, 500, 1000, 1300}
	--1.frameの移動が止まる時間 2.テキストの移動が止まる時間 3.ランクトップの移動が止まる時間
	local timer_tag = {500,700,900}


	local frame_position = {
		x = 10,
		y = 32
		}

	local replay_diff = {
		x = 1688, 
		y = 226
		}


	local playmode = {
		keys_7	= main_state.option(160),
		keys_5	= main_state.option(161),
		keys_14	= main_state.option(162),
		keys_10	= main_state.option(163),
		keys_9	= main_state.option(164),
		keys_24	= main_state.option(1160),
		keys_48	= main_state.option(1161)
	}

	skin.destination = {

		{id = "bg_c",	filter = 1, stretch = 3, op = {90},							dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_aaa",	filter = 1, stretch = 3, op = {90,300},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_aa",	filter = 1, stretch = 3, op = {90,301},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_a",	filter = 1, stretch = 3, op = {90,302},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = -110,								 op = {90, op.STAGEFILE_ON, 191},	dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- CLEAR
		{id = -100,		filter = 1, stretch = 3, op = {90, op.STAGEFILE_ON},		dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- CLEAR
		{id = "bg_f",	filter = 1, stretch = 3, op = {91},							dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
	
		{id = "flame_left", loop = timer_tag[1], op = {op.RESULT_L}, dst = {{time = 0, x = frame_position.x-3.6^5, y = frame_position.y, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = frame_position.x-3.6^4},{time = timer_tag[1]*2/5, x = frame_position.x-3.6^3},{time = timer_tag[1]*3/5, x = frame_position.x-3.6^2},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^1},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^0}}},
		{id = "flame_right", draw = function() return (skin_config.option["リザルトの配置"] == op.RESULT_L and result_mode == 0) end, loop = timer_tag[1], op = {op.RESULT_L}, dst = {{time = 0, x = 1920-557-(frame_position.x-3.6^5), y = frame_position.y-10, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = 1920-557-(frame_position.x-3.6^4)},{time = timer_tag[1]*2/5, x = 1920-557-(frame_position.x-3.6^3)},{time = timer_tag[1]*3/5, x = 1920-557-(frame_position.x-3.6^2)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^1)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^0)}}},
		{id = "flame_right_ir", draw = function() return (skin_config.option["リザルトの配置"] == op.RESULT_L and result_mode == 1) end, loop = timer_tag[1], op = {op.RESULT_L}, dst = {{time = 0, x = 1920-557-(frame_position.x-3.6^5), y = frame_position.y-10, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = 1920-557-(frame_position.x-3.6^4)},{time = timer_tag[1]*2/5, x = 1920-557-(frame_position.x-3.6^3)},{time = timer_tag[1]*3/5, x = 1920-557-(frame_position.x-3.6^2)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^1)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^0)}}},


		{id = "flame_left", loop = timer_tag[1], op = {op.RESULT_R}, dst = {{time = 0, x = 1920-557-(frame_position.x-3.6^5), y = frame_position.y, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = 1920-557-(frame_position.x-3.6^4)},{time = timer_tag[1]*2/5, x = 1920-557-(frame_position.x-3.6^3)},{time = timer_tag[1]*3/5, x = 1920-557-(frame_position.x-3.6^2)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^1)},{time = timer_tag[1]*5/5, x = 1920-557-(frame_position.x-3.6^0)}}},
		{id = "flame_right", draw = function() return (skin_config.option["リザルトの配置"] == op.RESULT_R and result_mode == 0) end, loop = timer_tag[1], op = {op.RESULT_R}, dst = {{time = 0, x = frame_position.x-3.6^5, y = frame_position.y-10, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = frame_position.x-3.6^4},{time = timer_tag[1]*2/5, x = frame_position.x-3.6^3},{time = timer_tag[1]*3/5, x = frame_position.x-3.6^2},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^1},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^0}}},
		{id = "flame_right_ir", draw = function() return (skin_config.option["リザルトの配置"] == op.RESULT_R and result_mode == 1) end, loop = timer_tag[1], op = {op.RESULT_R}, dst = {{time = 0, x = frame_position.x-3.6^5, y = frame_position.y-10, w = 557, h = 1017},{time = timer_tag[1]*1/5, x = frame_position.x-3.6^4},{time = timer_tag[1]*2/5, x = frame_position.x-3.6^3},{time = timer_tag[1]*3/5, x = frame_position.x-3.6^2},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^1},{time = timer_tag[1]*5/5, x = frame_position.x-3.6^0}}},

		{id = "judge_detail_lamp", loop = timer_tag[2], dst = {{time = timer_tag[2], x = frame_position.x + 97 + result_r, y = frame_position.y + 72, w = 33, h = 254, a = 0},{time = timer_tag[2]+80, a = 180},{time = timer_tag[2]+400, a = 0}}},

		{id = "result_infomation", loop = timer_tag[2], dst = {{time = timer_tag[1], x = 1920-557-frame_position.x+35 - result_r, y = frame_position.y+18, w = 430, h = 170, a = 0},{time = timer_tag[2], y = frame_position.y+18-10, a = 255}}},

		{id = "frame_center_clear", op = {90}, dst = {{x = 563, y = 0, w = 794, h = 1080}}},
		{id = "frame_center_failed", op = {91}, dst = {{x = 563, y = 0, w = 794, h = 1080}}},

		{id = "CLEARTYPE_TITLEFREAM",	loop = 2000, dst = {{time = 2000, x = frame_position.x+71 + result_r, y = frame_position.y+767, w = 146, h = 40, a = 0},{time = 2150, a = 255},{time = 2500, a = 0},{time = 6000}}},
		{id = "CLEARTYPE_TITLEFREAM",	loop = 2000+300*1, dst = {{time = 2000+300*1, x = frame_position.x+71 + result_r, y = frame_position.y+767-53, w = 146, h = 40, a = 0},{time = 2150+300*1, a = 255},{time = 2500+300*1, a = 0},{time = 6000+300*1}}},

		{id = "SCORE_TITLEFREAM",	loop = 2000+300*2, dst = {{time = 2000+300*2, x = frame_position.x+71 + result_r, y = frame_position.y+767-53-90, w = 149, h = 59, a = 0},{time = 2150+300*2, a = 255},{time = 2500+300*2, a = 0},{time = 6000+300*2}}},

		{id = "great_mozi", loop = timer_tag[2], dst = {{time = timer_tag[2], x = frame_position.x + 109 + result_r, y = frame_position.y + 281, w = 89, h = 48, r = 255*3/3, g = 255*1/3, b = 255*1/3, a = 75},{time = timer_tag[2]+30*1, r = 255*2/3, g = 255*0/3, b = 255*2/3},{time = timer_tag[2]+30*2, r = 255*1/3, g = 255*1/3, b = 255*3/3},{time = timer_tag[2]+30*3, r = 255*0/3, g = 255*2/3, b = 255*2/3},{time = timer_tag[2]+30*4, r = 255*1/3, g = 255*3/3, b = 255*1/3},{time = timer_tag[2]+30*5, r = 255*2/3, g = 255*2/3, b = 255*0/3},{time = timer_tag[2]+30*6, r = 255*3/3, g = 255*1/3, b = 255*1/3}}},


		{id = "SCORE_TITLEFREAM",		src = "SCORE_TITLEFREAM",	x = 0, y = 0, w = 149, h = 59},
		{id = "TAGRET_TITLEFREAM",		src = "TAGRET_TITLEFREAM",	x = 0, y = 0, w = 206, h = 40},

		{id = "CLEARTYPE_TITLEFREAM",	loop = 2000+300*3, dst = {{time = 2000+300*3, x = frame_position.x+71 + result_r, y = frame_position.y+767-53-161, w = 146, h = 40, a = 0},{time = 2150+300*3, a = 255},{time = 2500+300*3, a = 0},{time = 6000+300*3}}},

		{id = "TAGRET_TITLEFREAM",	loop = 2000+300*4, dst = {{time = 2000+300*4, x = frame_position.x+71 + result_r, y = frame_position.y+767-53-161-71, w = 206, h = 40, a = 0},{time = 2150+300*4, a = 255},{time = 2500+300*4, a = 0},{time = 6000+300*4}}},

		--aaa
		{id = "RANK_DROPSHADOW_small", loop = timer_tag[2]+350, op = {300}, dst = {{time = timer_tag[2], x = frame_position.x-10+385-1 + result_r, y = frame_position.y-32+940-1, w = 2, h = 2, r = 255, g = 251, b = 139, a = 255},{time = timer_tag[2]+350, x = frame_position.x-10+385-100 + result_r, y = frame_position.y-32+940-100, w = 200, h = 200, a = 0}}},
		{id = "RANK_DROPSHADOW", loop = timer_tag[2]+200, op = {300}, dst = {{time = timer_tag[2]+200, x = frame_position.x-10+385-50 + result_r, y = frame_position.y-32+940-50, w = 100, h = 100, r = 255, g = 251, b = 139, a = 255},{time = timer_tag[2]+600, x = frame_position.x-10+385-250 + result_r, y = frame_position.y-32+940-250, w = 500, h = 500, a = 0},{time = timer_tag[2]+3200}}},
				
		--aa
		{id = "RANK_DROPSHADOW_small", loop = timer_tag[2]+350, op = {301}, dst = {{time = timer_tag[2], x = frame_position.x-10+385-1 + result_r, y = frame_position.y-32+940-1, w = 2, h = 2, r = 180, g = 180, b = 180, a = 255},{time = timer_tag[2]+350, x = frame_position.x-10+385-100 + result_r, y = frame_position.y-32+940-100, w = 200, h = 200, a = 0}}},
		{id = "RANK_DROPSHADOW", loop = timer_tag[2]+600, op = {301}, dst = {{time = timer_tag[2]+200, x = frame_position.x-10+385-50 + result_r, y = frame_position.y-32+940-50, w = 100, h = 100, r = 180, g = 180, b = 180, a = 255},{time = timer_tag[2]+600, x = frame_position.x-10+385-250 + result_r, y = frame_position.y-32+940-250, w = 500, h = 500, a = 0}}},

		--a
		{id = "RANK_DROPSHADOW_small", loop = timer_tag[2]+350, op = {302}, dst = {{time = timer_tag[2], x = frame_position.x-10+385-1 + result_r, y = frame_position.y-32+940-1, w = 2, h = 2, r = 255, g = 192, b = 130, a = 255},{time = timer_tag[2]+350, x = frame_position.x-10+385-100 + result_r, y = frame_position.y-32+940-100, w = 200, h = 200, a = 0}}},
		{id = "RANK_DROPSHADOW", loop = timer_tag[2]+600, op = {302}, dst = {{time = timer_tag[2]+200, x = frame_position.x-10+385-50 + result_r, y = frame_position.y-32+940-50, w = 100, h = 100, r = 255, g = 192, b = 130, a = 255},{time = timer_tag[2]+600, x = frame_position.x-10+385-250 + result_r, y = frame_position.y-32+940-250, w = 500, h = 500, a = 0}}},

		{id = "aaa_top", loop = timer_tag[3], op = {300}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1900},{time = timer_tag[3]+2400, r = 204, g = 204, b = 204},{time = timer_tag[3]+2900, r = 255, g = 255, b = 255},{time = timer_tag[3]+3900},{time = timer_tag[3]+4400, r = 204, g = 204, b = 204},{time = timer_tag[3]+4900, r = 255, g = 255, b = 255}}},
		{id = "aaa_top_2", loop = timer_tag[3], op = {300}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+225, a = 255},{time = timer_tag[3]+450, a = 0},{time = timer_tag[3]+675, a = 255},{time = timer_tag[3]+900, a = 0},{time = timer_tag[3]+1400,a = 128},{time = timer_tag[3]+1900,a = 0},{time = timer_tag[3]+2900},{time = timer_tag[3]+2900+500,a = 128},{time = timer_tag[3]+2900+1000,a = 0},{time = timer_tag[3]+2900+2000},}},
		{id = "aa_top", loop = timer_tag[3]+900, op = {301}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1900},{time = timer_tag[3]+2400, r = 204, g = 204, b = 204},{time = timer_tag[3]+2900, r = 255, g = 255, b = 255},{time = timer_tag[3]+3900},{time = timer_tag[3]+4400, r = 204, g = 204, b = 204},{time = timer_tag[3]+4900, r = 255, g = 255, b = 255}}},
		{id = "aa_top_2", loop = timer_tag[3]+900, op = {301}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+225, a = 255},{time = timer_tag[3]+450, a = 0},{time = timer_tag[3]+675, a = 255},{time = timer_tag[3]+900, a = 0},{time = timer_tag[3]+1400,a = 128},{time = timer_tag[3]+1900,a = 0},{time = timer_tag[3]+2900},{time = timer_tag[3]+2900+500,a = 128},{time = timer_tag[3]+2900+1000,a = 0},{time = timer_tag[3]+2900+2000},}},
		{id = "a_top", loop = timer_tag[3]+900, op = {302}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1900},{time = timer_tag[3]+2400, r = 204, g = 204, b = 204},{time = timer_tag[3]+2900, r = 255, g = 255, b = 255},{time = timer_tag[3]+3900},{time = timer_tag[3]+4400, r = 204, g = 204, b = 204},{time = timer_tag[3]+4900, r = 255, g = 255, b = 255}}},
		{id = "a_top_2", loop = timer_tag[3]+900, op = {302}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+225, a = 255},{time = timer_tag[3]+450, a = 0},{time = timer_tag[3]+675, a = 255},{time = timer_tag[3]+900, a = 0},{time = timer_tag[3]+1400,a = 128},{time = timer_tag[3]+1900,a = 0},{time = timer_tag[3]+2900},{time = timer_tag[3]+2900+500,a = 128},{time = timer_tag[3]+2900+1000,a = 0},{time = timer_tag[3]+2900+2000},}},

		{id = "b_top", loop = timer_tag[3], op = {303}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1000},{time = timer_tag[3]+1500, r = 204, g = 204, b = 204},{time = timer_tag[3]+2000, r = 255, g = 255, b = 255},{time = timer_tag[3]+3000},{time = timer_tag[3]+3500, r = 204, g = 204, b = 204},{time = timer_tag[3]+4000, r = 255, g = 255, b = 255}}},
		{id = "b_top_2", loop = timer_tag[3], op = {303}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+500,a = 128},{time = timer_tag[3]+1000,a = 0},{time = timer_tag[3]+2000},{time = timer_tag[3]+2500,a = 128},{time = timer_tag[3]+3000,a = 0},{time = timer_tag[3]+4000},}},
		{id = "c_top", loop = timer_tag[3], op = {304}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1000},{time = timer_tag[3]+1500, r = 204, g = 204, b = 204},{time = timer_tag[3]+2000, r = 255, g = 255, b = 255},{time = timer_tag[3]+3000},{time = timer_tag[3]+3500, r = 204, g = 204, b = 204},{time = timer_tag[3]+4000, r = 255, g = 255, b = 255}}},
		{id = "c_top_2", loop = timer_tag[3], op = {304}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+500,a = 128},{time = timer_tag[3]+1000,a = 0},{time = timer_tag[3]+2000},{time = timer_tag[3]+2500,a = 128},{time = timer_tag[3]+3000,a = 0},{time = timer_tag[3]+4000},}},
		{id = "d_top", loop = timer_tag[3], op = {305}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1000},{time = timer_tag[3]+1500, r = 204, g = 204, b = 204},{time = timer_tag[3]+2000, r = 255, g = 255, b = 255},{time = timer_tag[3]+3000},{time = timer_tag[3]+3500, r = 204, g = 204, b = 204},{time = timer_tag[3]+4000, r = 255, g = 255, b = 255}}},
		{id = "d_top_2", loop = timer_tag[3], op = {305}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+500,a = 128},{time = timer_tag[3]+1000,a = 0},{time = timer_tag[3]+2000},{time = timer_tag[3]+2500,a = 128},{time = timer_tag[3]+3000,a = 0},{time = timer_tag[3]+4000},}},
		{id = "e_top", loop = timer_tag[3], op = {306}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1000},{time = timer_tag[3]+1500, r = 204, g = 204, b = 204},{time = timer_tag[3]+2000, r = 255, g = 255, b = 255},{time = timer_tag[3]+3000},{time = timer_tag[3]+3500, r = 204, g = 204, b = 204},{time = timer_tag[3]+4000, r = 255, g = 255, b = 255}}},
		{id = "e_top_2", loop = timer_tag[3], op = {306}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+500,a = 128},{time = timer_tag[3]+1000,a = 0},{time = timer_tag[3]+2000},{time = timer_tag[3]+2500,a = 128},{time = timer_tag[3]+3000,a = 0},{time = timer_tag[3]+4000},}},
		{id = "f_top", loop = timer_tag[3], op = {307}, dst = {{time = timer_tag[2], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 600},{time = (timer_tag[2]+timer_tag[3])/2, h = 250},{time = timer_tag[3], h = 125},{time = timer_tag[3]+1000},{time = timer_tag[3]+1500, r = 204, g = 204, b = 204},{time = timer_tag[3]+2000, r = 255, g = 255, b = 255},{time = timer_tag[3]+3000},{time = timer_tag[3]+3500, r = 204, g = 204, b = 204},{time = timer_tag[3]+4000, r = 255, g = 255, b = 255}}},
		{id = "f_top_2", loop = timer_tag[3], op = {307}, dst = {{time = timer_tag[3], x = frame_position.x+255 + result_r, y = 875, w = 250, h = 125, a = 0},{time = timer_tag[3]+500,a = 128},{time = timer_tag[3]+1000,a = 0},{time = timer_tag[3]+2000},{time = timer_tag[3]+2500,a = 128},{time = timer_tag[3]+3000,a = 0},{time = timer_tag[3]+4000},}},

		{id = "NEW_RECORD_FRAME", draw = function() return clear.current > clear.best end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+490 + result_r, y = frame_position.y+761, w = 54, h = 54, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+600, y = frame_position.y+761},{time = timer_tag[2]+800, y = frame_position.y+758},{time = timer_tag[2]+866, y = frame_position.y+759},{time = timer_tag[2]+966, y = frame_position.y+760},{time = timer_tag[2]+1100, y = frame_position.y+761},}},
		{id = "new_record!!", draw = function() return clear.current > clear.best end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+480 + result_r, y = frame_position.y+770, w = 74, h = 32, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+1000, a = 255},{time = timer_tag[2]+1400, a = 210},{time = timer_tag[2]+1800, a = 255}}},

		{id = "NEW_RECORD_FRAME", draw = function() return current_rank > mybest_rank end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+490 + result_r, y = frame_position.y+761-53, w = 54, h = 54, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+600, y = frame_position.y+761-53},{time = timer_tag[2]+800, y = frame_position.y+758-53},{time = timer_tag[2]+866, y = frame_position.y+759-53},{time = timer_tag[2]+966, y = frame_position.y+760-53},{time = timer_tag[2]+1100, y = frame_position.y+761-53},}},
		{id = "new_record!!", draw = function() return current_rank > mybest_rank end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+480 + result_r, y = frame_position.y+770-53, w = 74, h = 32, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+1000, a = 255},{time = timer_tag[2]+1400, a = 210},{time = timer_tag[2]+1800, a = 255}}},

		{id = "NEW_RECORD_FRAME", draw = function() return main_state.number(172) > 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+490 + result_r, y = frame_position.y+761-133, w = 54, h = 54, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+600, y = frame_position.y+761-133},{time = timer_tag[2]+800, y = frame_position.y+758-133},{time = timer_tag[2]+866, y = frame_position.y+759-133},{time = timer_tag[2]+966, y = frame_position.y+760-133},{time = timer_tag[2]+1100, y = frame_position.y+761-133},}},
		{id = "new_record!!", draw = function() return main_state.number(172) > 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+480 + result_r, y = frame_position.y+770-133, w = 74, h = 32, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+1000, a = 255},{time = timer_tag[2]+1400, a = 210},{time = timer_tag[2]+1800, a = 255}}},

		{id = "NEW_RECORD_FRAME", draw = function() return main_state.number(178) < 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+490 + result_r, y = frame_position.y+761-214, w = 54, h = 54, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+600, y = frame_position.y+761-214},{time = timer_tag[2]+800, y = frame_position.y+758-214},{time = timer_tag[2]+866, y = frame_position.y+759-214},{time = timer_tag[2]+966, y = frame_position.y+760-214},{time = timer_tag[2]+1100, y = frame_position.y+761-214},}},
		{id = "new_record!!", draw = function() return main_state.number(178) < 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+480 + result_r, y = frame_position.y+770-214, w = 74, h = 32, a = 0},{time = timer_tag[2], a = 255},{time = timer_tag[2]+1000, a = 255},{time = timer_tag[2]+1400, a = 210},{time = timer_tag[2]+1800, a = 255}}},

		{id = "state_clear", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+367 + result_r, y = frame_position.y+777+10, w = 100, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+777, a = 255}}},
		{id = "state_mybest_clear", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+232 + result_r, y = frame_position.y+777+10, w = 100, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+777, a = 255}}},
		
		--今回のランク
		{id = "default_playerdata_rank_aaa", op = {300}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_aa", op = {301}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_a", op = {302}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_b", op = {303}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_c", op = {304}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_d", op = {305}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_e", op = {306}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_f", op = {307}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		--自己ベストのランク
		{id = "default_playerdata_rank_aaa", op = {320}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_aa", op = {321}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_a", op = {322}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_b", op = {323}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_c", op = {324}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_d", op = {325}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_e", op = {326}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},
		{id = "default_playerdata_rank_f", op = {327}, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-135 + result_r, y = frame_position.y+723+10, w = 62, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+723, a = 255}}},

		{id = "current_score", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21 + result_r, y = frame_position.y+722-72+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-72, a = 255}}},
		{id = "mybest_score", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-135 + result_r, y = frame_position.y+722-72+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-72, a = 255}}},

		--mybest_scorerate 100%
		{id = "mybest_scorerate", draw = function() return main_state.number(183) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_scorerate_dot", draw = function() return main_state.number(183) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_dot", draw = function() return main_state.number(183) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "mybest_per", draw = function() return main_state.number(183) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},

		--mybest_scorerate 10%~99%
		{id = "mybest_scorerate", draw = function() return main_state.number(183) >= 10 and main_state.number(183) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18-5 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_scorerate_dot", draw = function() return main_state.number(183) >= 10 and main_state.number(183) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18-5 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_dot", draw = function() return main_state.number(183) >= 10 and main_state.number(183) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123-5 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "mybest_per", draw = function() return main_state.number(183) >= 10 and main_state.number(183) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30-5 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},

		--mybest_scorerate ~10%
		{id = "mybest_scorerate", draw = function() return main_state.number(183) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18-9 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_scorerate_dot", draw = function() return main_state.number(183) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18-9 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "mybest_dot", draw = function() return main_state.number(183) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123-9 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "mybest_per", draw = function() return  main_state.number(183) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30-9 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},

		--current_scorerate 100%
		{id = "current_scorerate", draw = function() return main_state.number(102) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18+135 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_scorerate_dot", draw = function() return main_state.number(102) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18+135 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_dot", draw = function() return main_state.number(102) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123+135 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "current_per", draw = function() return main_state.number(102) == 100 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},

		--current_scorerate 10%~99%
		{id = "current_scorerate", draw = function() return main_state.number(102) >= 10 and main_state.number(102) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18+135-5 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_scorerate_dot", draw = function() return main_state.number(102) >= 10 and main_state.number(102) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18+135-5 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_dot", draw = function() return main_state.number(102) >= 10 and main_state.number(102) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123+135-5 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "current_per", draw = function() return main_state.number(102) >= 10 and main_state.number(102) <= 99 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-5 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},

		--current_scorerate ~10%
		{id = "current_scorerate", draw = function() return main_state.number(102) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-123-18+135-9 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_scorerate_dot", draw = function() return main_state.number(102) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21-123+18+135-9 + result_r, y = frame_position.y+722-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-91, a = 255}}},
		{id = "current_dot", draw = function() return main_state.number(102) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35-123+135-9 + result_r, y = frame_position.y+722-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		{id = "current_per", draw = function() return  main_state.number(102) <= 9 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-9 + result_r, y = frame_position.y+722-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+722-90, a = 255}}},
		
		--rank_plus_on
		{id = "rank_diff_f_plus", draw = function() return rank_plus and scorerate < 2/18 and scorerate >= 0/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 2/18 and scorerate >= 0/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_e_minus", draw = function() return rank_plus and scorerate < 4/18 and scorerate >= 2/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 4/18 and scorerate >= 2/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_e_plus", draw = function() return rank_plus and scorerate < 5/18 and scorerate >= 4/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 5/18 and scorerate >= 4/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_d_minus", draw = function() return rank_plus and scorerate < 6/18 and scorerate >= 5/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 6/18 and scorerate >= 5/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_d_plus", draw = function() return rank_plus and scorerate < 7/18 and scorerate >= 6/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 7/18 and scorerate >= 6/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_c_minus", draw = function() return rank_plus and scorerate < 8/18 and scorerate >= 7/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 8/18 and scorerate >= 7/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_c_plus", draw = function() return rank_plus and scorerate < 9/18 and scorerate >= 8/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 9/18 and scorerate >= 8/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_b_minus", draw = function() return rank_plus and scorerate < 10/18 and scorerate >= 9/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 10/18 and scorerate >= 9/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_b_plus", draw = function() return rank_plus and scorerate < 11/18 and scorerate >= 10/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 11/18 and scorerate >= 10/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_a_minus", draw = function() return rank_plus and scorerate < 12/18 and scorerate >= 11/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 12/18 and scorerate >= 11/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_a_plus", draw = function() return rank_plus and scorerate < 13/18 and scorerate >= 12/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 13/18 and scorerate >= 12/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aa_minus", draw = function() return rank_plus and scorerate < 14/18 and scorerate >= 13/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 14/18 and scorerate >= 13/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-19 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aa_plus", draw = function() return rank_plus and scorerate < 15/18 and scorerate >= 14/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 15/18 and scorerate >= 14/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-19 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aaa_minus", draw = function() return rank_plus and scorerate < 16/18 and scorerate >= 15/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 16/18 and scorerate >= 15/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aaa_plus", draw = function() return rank_plus and scorerate < 17/18 and scorerate >= 16/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 17/18 and scorerate >= 16/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_max_minus", draw = function() return rank_plus and scorerate < 18/18 and scorerate >= 17/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate < 18/18 and scorerate >= 17/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_max_plus", draw = function() return rank_plus and scorerate == 18/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return rank_plus and scorerate == 18/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},

		--rank_plus_off
		{id = "rank_diff_e_minus", draw = function() return not(rank_plus) and scorerate < 4/18 and scorerate >= 0/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 4/18 and scorerate >= 0/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_d_minus", draw = function() return not(rank_plus) and scorerate < 6/18 and scorerate >= 4/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 6/18 and scorerate >= 4/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_c_minus", draw = function() return not(rank_plus) and scorerate < 8/18 and scorerate >= 6/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 8/18 and scorerate >= 6/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_b_minus", draw = function() return not(rank_plus) and scorerate < 10/18 and scorerate >= 8/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 10/18 and scorerate >= 8/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_a_minus", draw = function() return not(rank_plus) and scorerate < 12/18 and scorerate >= 10/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 12/18 and scorerate >= 10/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-25 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aa_minus", draw = function() return not(rank_plus) and scorerate < 14/18 and scorerate >= 12/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 14/18 and scorerate >= 12/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-19 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_aaa_minus", draw = function() return not(rank_plus) and scorerate < 16/18 and scorerate >= 14/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 16/18 and scorerate >= 14/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_max_minus", draw = function() return not(rank_plus) and scorerate < 18/18 and scorerate >= 16/18 end,	loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-62 + result_r, y = frame_position.y+722-118+71+19+10, w = 50, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},
		{id = "rank_diff_count", draw = function() return not(rank_plus) and scorerate < 18/18 and scorerate >= 16/18 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-13 + result_r, y = frame_position.y+722-118+71+19+10, w = 11, h = 15, g = 83, b = 83, a = 0},{time = timer_tag[2], y = frame_position.y+722-118+71+19, a = 255}}},

		{id = "score_diff", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-56 + result_r, y = frame_position.y+722-118+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118, a = 255}}},
		{id = "bp_diff", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-56 + result_r, y = frame_position.y+722-118-71+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118-71, a = 255}}},
		
		{id = "current_bp", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21 + result_r, y = frame_position.y+722-162+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-162, a = 255}}},
		{id = "mybest_bp", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-135 + result_r, y = frame_position.y+722-162+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-162, a = 255}}},

		{id = "target_name", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+125 + result_r, y = frame_position.y+722-238+1+10, w = 135, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+722-238+1, a = 255}}},

		{id = "target_score", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-85 + result_r, y = frame_position.y+722-233+10, w = 17, h = 25, r = 255, g = 169, b = 67, a = 0},{time = timer_tag[2], y = frame_position.y+722-233, a = 255}}},
		
		{id = "target_scorerate", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23+26-18 + result_r, y = frame_position.y+722-231+10, w = 11, h = 15, r = 255, g = 169, b = 67, a = 0},{time = timer_tag[2], y = frame_position.y+722-231, a = 255}}},
		{id = "target_scorerate_dot", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+21+26+18 + result_r, y = frame_position.y+722-231+10, w = 11, h = 15, r = 255, g = 169, b = 67, a = 0},{time = timer_tag[2], y = frame_position.y+722-231, a = 255}}},
		{id = "mybest_dot", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+35+26 + result_r, y = frame_position.y+722-230+10, w = 5, h = 5, r = 255, g = 169, b = 67, a = 0},{time = timer_tag[2], y = frame_position.y+722-230, a = 255}}},
		
		{id = "target_score_diff", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+31-123+30+135-56 + result_r, y = frame_position.y+722-118-71*2+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-118-71*2, a = 255}}},

		{id = "ir_name", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+330 + result_r, y = frame_position.y+722-238-54+10, w = 200, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+722-238-54, a = 255}}},

		{id = "current_irrank", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-194 + result_r, y = frame_position.y+722-162-157+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-157, a = 255}}},
		{id = "mybest_irrank", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-135-155 + result_r, y = frame_position.y+722-162-157+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-157, a = 255}}},
		{id = "totalplayer_irrank", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-21-194+95 + result_r, y = frame_position.y+722-162-155+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-155, a = 255}}},

		{id = "pgreat", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*0+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*0, a = 255}}},
		{id = "great", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*1+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*1, a = 255}}},
		{id = "good", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*2+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*2, a = 255}}},
		{id = "bad", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*3+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*3, a = 255}}},
		{id = "poor", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*4+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*4, a = 255}}},
		{id = "fail", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*5+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*5, a = 255}}},


		{id = "pgreat_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*0+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*0, a = 255}}},
		{id = "great_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*1+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*1, a = 255}}},
		{id = "good_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*2+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*2, a = 255}}},
		{id = "bad_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*3+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*3, a = 255}}},
		{id = "poor_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*4+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*4, a = 255}}},
		{id = "fail_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82 + result_r, y = frame_position.y+722-162-265-28*5+10, w = 14, h = 20, a = 0, r = 0, g = 174, b = 255},{time = timer_tag[2], y = frame_position.y+722-162-265-28*5, a = 255}}},


		{id = "pgreat_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*0+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*0, a = 255}}},
		{id = "great_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*1+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*1, a = 255}}},
		{id = "good_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*2+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*2, a = 255}}},
		{id = "bad_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*3+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*3, a = 255}}},
		{id = "poor_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*4+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*4, a = 255}}},
		{id = "fail_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36 + result_r, y = frame_position.y+722-162-265-28*5+10, w = 14, h = 20, a = 0, r = 255, g = 0, b = 84},{time = timer_tag[2], y = frame_position.y+722-162-265-28*5, a = 255}}},

		{id = "cb", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*5-42+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*5-42, a = 255}}},
		{id = "maxcombo", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-36-82*2 + result_r, y = frame_position.y+722-162-265-28*6-42+10, w = 14, h = 20, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*6-42, a = 255}}},

		{id = "total_fast", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-16+6-2-82 + result_r, y = frame_position.y+722-162-265-28*6-42+10, w = 14, h = 20, r = 0, g = 174, b = 255, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*6-42, a = 255}}},
		{id = "total_slow", loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+362+23-16+11-2 + result_r, y = frame_position.y+722-162-265-28*6-42+10, w = 14, h = 20, r = 255, g = 0, b = 84, a = 0},{time = timer_tag[2], y = frame_position.y+722-162-265-28*6-42, a = 255}}},

		{id = "result_modeselect_graph_data_on", draw = function() return result_mode == 0 end, dst = {{x = frame_position.x + 1411 - result_r, y = frame_position.y + 982, w = 204, h = 35}}},
		{id = "result_modeselect_graph_data_off", draw = function() return result_mode == 1 end, dst = {{x = frame_position.x + 1411 - result_r, y = frame_position.y + 982, w = 204, h = 35}}},
		{id = "result_modeselect_ir_ranking_on", draw = function() return result_mode == 1 end, dst = {{x = frame_position.x + 1411 + 219 - result_r, y = frame_position.y + 982, w = 204, h = 35}}},
		{id = "result_modeselect_ir_ranking_off", draw = function() return result_mode == 0 end, dst = {{x = frame_position.x + 1411 + 219 - result_r, y = frame_position.y + 982, w = 204, h = 35}}},
		{id = "result_modeselect_rect",	dst = {{x = frame_position.x + 1411 - result_r, y = frame_position.y + 982, w = 204, h = 35}}, mouseRect = {x = 0, y = 0, w = 204, h = 35}},
		{id = "result_modeselect_rect",	dst = {{x = frame_position.x + 1411 + 219 - result_r, y = frame_position.y + 982, w = 204, h = 35}}, mouseRect = {x = 0, y = 0, w = 204, h = 35}},

		{id = "left_yazirusi", loop = timer_tag[2], dst = {{time = timer_tag[2], x = frame_position.x + 1411 - 50 + 5 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 0},{time = timer_tag[2] + 500, x = frame_position.x + 1411 - 50 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 255},{time = timer_tag[2]+1500, x = frame_position.x + 1411 - 50 - 10 - result_r},{time = timer_tag[2]+2000, x = frame_position.x + 1411 - 50 - 15 - result_r, a = 0},{time = timer_tag[2]+4000}}},
		{id = "left_yazirusi", loop = timer_tag[2]+2000, dst = {{time = timer_tag[2]+2000, x = frame_position.x + 1411 - 50 + 5 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 0},{time = timer_tag[2] + 500+2000, x = frame_position.x + 1411 - 50 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 255},{time = timer_tag[2]+1500+2000, x = frame_position.x + 1411 - 50 - 10 - result_r},{time = timer_tag[2]+2000+2000, x = frame_position.x + 1411 - 50 - 15 - result_r, a = 0},{time = timer_tag[2]+4000+2000}}},
		
		{id = "right_yazirusi", loop = timer_tag[2], dst = {{time = timer_tag[2], x = frame_position.x + 1411 + 425 - 34 + 45 - 5 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 0},{time = timer_tag[2] + 500, x = frame_position.x + 1411 + 425 - 34 + 45 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 255},{time = timer_tag[2]+1500, x = frame_position.x + 1411 + 425 - 34 + 45 + 10 - result_r},{time = timer_tag[2]+2000, x = frame_position.x + 1411 + 425 - 34 + 45 + 15 - result_r, a = 0},{time = timer_tag[2]+4000}}},
		{id = "right_yazirusi", loop = timer_tag[2]+2000, dst = {{time = timer_tag[2]+2000, x = frame_position.x + 1411 + 425 - 34 + 45 - 5 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 0},{time = timer_tag[2] + 500+2000, x = frame_position.x + 1411 + 425 - 34 + 45 - result_r, y = frame_position.y+990, w = 34, h = 34, a = 255},{time = timer_tag[2]+1500+2000, x = frame_position.x + 1411 + 425 - 34 + 45 + 10 - result_r},{time = timer_tag[2]+2000+2000, x = frame_position.x + 1411 + 425 - 34 + 45 + 15 - result_r, a = 0},{time = timer_tag[2]+4000+2000}}},

		{id = "end_position", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1671-10 - result_r, y = frame_position.y+924+10, w = 89, h = 12, a = 0},{time = timer_tag[2], y = frame_position.y+924, a = 255}}},
		{id = "gauge_count", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1760+23-123-18+135-9-10 - result_r, y = frame_position.y+1013-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+1013-91, a = 255}}},
		{id = "gauge_count_dot", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1760+21-123+18+135-9-10 - result_r, y = frame_position.y+1013-91+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+1013-91, a = 255}}},
		{id = "mybest_dot", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1760+35-123+135-9-10 - result_r, y = frame_position.y+1013-90+10, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+1013-90, a = 255}}},
		{id = "mybest_per", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1760+31-123+30+135-9-11-10 - result_r, y = frame_position.y+1013-90+10, w = 16, h = 14, a = 0},{time = timer_tag[2], y = frame_position.y+1013-90, a = 255}}},

		{id = "lane_option", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+ 1539 + 32 - 6 - result_r, y = frame_position.y+659+1+10 + 45 - 35, w = 240, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+1+659 + 45 - 35, a = 255}}},

		{id = "duration",  draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1520+23-123-29+135-30+6 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "duration_dot",  draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1520+21-123+18+135-30+6 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "mybest_dot",  draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1520+35-123+135-30+6 - result_r, y = frame_position.y+369-90+10+7, w = 5, h = 5, a = 0},{time = timer_tag[2], y = frame_position.y+369-90+7, a = 255}}},
		{id = "ms", draw = function() return result_mode == 0 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1520+21-123+18+135-30+25+6 - result_r, y = frame_position.y+369-91+10+7, w = 23, h = 12, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},

		{id = "ave_fast",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) >= 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+23-123-29+135-30 - result_r, y = frame_position.y+369-92+10+7, w = 39, h = 17, a = 0},{time = timer_tag[2], y = frame_position.y+369-92+7, a = 255}}},	
		{id = "average",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) > 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+23-123-29+135+5-2 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, r = 0, g = 174, b = 255, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "average_dot",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) > 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+21-123+18+135+5-2 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, r = 0, g = 174, b = 255, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "mybest_dot",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) > 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+35-123+135+5-2 - result_r, y = frame_position.y+369-90+10+7, w = 5, h = 5, r = 0, g = 174, b = 255, a = 0},{time = timer_tag[2], y = frame_position.y+369-90+7, a = 255}}},
		{id = "ms",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) > 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+21-123+18+135+5+25-2 - result_r, y = frame_position.y+369-91+10+7, w = 23, h = 12, r = 0, g = 174, b = 255, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},

		{id = "ave_slow",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) < 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+23-123-29+135-30 - result_r, y = frame_position.y+369-92+10+7, w = 39, h = 17, a = 0},{time = timer_tag[2], y = frame_position.y+369-92+7, a = 255}}},
		{id = "average",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) < 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+23-123-29+135+5-2 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, r = 255, g = 0, b = 84, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "average_dot",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) < 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+21-123+18+135+5-2 - result_r, y = frame_position.y+369-91+10+7, w = 11, h = 15, r = 255, g = 0, b = 84, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},
		{id = "mybest_dot",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) < 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+35-123+135+5-2 - result_r, y = frame_position.y+369-90+10+7, w = 5, h = 5, r = 255, g = 0, b = 84, a = 0},{time = timer_tag[2], y = frame_position.y+369-90+7, a = 255}}},
		{id = "ms",  draw = function() return (result_mode == 0 and (main_state.number(374) + main_state.number(375) * 0.01) < 0) end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1720+21-123+18+135+5+25-2 - result_r, y = frame_position.y+369-91+10+7, w = 23, h = 12, r = 255, g = 0, b = 84, a = 0},{time = timer_tag[2], y = frame_position.y+369-91+7, a = 255}}},

		{id = "replay_1", op = {196, -198},			dst = {{			x = frame_position.x+replay_diff.x+35*0 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, a = 64}}},
		{id = "replay_1", op = {197, -198},			dst = {{			x = frame_position.x+replay_diff.x+35*0 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28}}},
		{id = "replay_1", op = {198}, loop = 0,		dst = {{time = 0,	x = frame_position.x+replay_diff.x+35*0 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, a = 255},{time = 300, a = 50},{time = 600, a = 255}}},
		{id = "replay_1", op = {-198},				dst = {{x = frame_position.x+replay_diff.x+35*0 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, b = 0, g = 0}},mouseRect = {x = 0, y = 0, w = 23, h = 28}},

		{id = "replay_2", op = {1196, -1198},		dst = {{			x = frame_position.x+replay_diff.x+35*1 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, a = 64}}},
		{id = "replay_2", op = {1197, -1198},		dst = {{			x = frame_position.x+replay_diff.x+35*1 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28}}},
		{id = "replay_2", op = {1198}, loop = 0,	dst = {{time = 0,	x = frame_position.x+replay_diff.x+35*1 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28},{time = 300, a = 50},{time = 600, a = 255}}},
		{id = "replay_2", op = {-1198},				dst = {{x = frame_position.x+replay_diff.x+35*1 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, b = 0, g = 0}},mouseRect = {x = 0, y = 0, w = 23, h = 28}},

		{id = "replay_3", op = {1199, -1201},		dst = {{			x = frame_position.x+replay_diff.x+35*2 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, a = 64}}},
		{id = "replay_3", op = {1200, -1201},		dst = {{			x = frame_position.x+replay_diff.x+35*2 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28}}},
		{id = "replay_3", op = {1201}, loop = 0,	dst = {{time = 0,	x = frame_position.x+replay_diff.x+35*2 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28},{time = 300, a = 50},{time = 600, a = 255}}},
		{id = "replay_3", op = {-1201},				dst = {{x = frame_position.x+replay_diff.x+35*2 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, b = 0, g = 0}},mouseRect = {x = 0, y = 0, w = 23, h = 28}},

		{id = "replay_4", op = {1202, -1204},		dst = {{			x = frame_position.x+replay_diff.x+35*3 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, a = 64}}},
		{id = "replay_4", op = {1203, -1204},		dst = {{			x = frame_position.x+replay_diff.x+35*3 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28}}},
		{id = "replay_4", op = {1204}, loop = 0,	dst = {{time = 0,	x = frame_position.x+replay_diff.x+35*3 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28},{time = 300, a = 50},{time = 600, a = 255}}},
		{id = "replay_4", op = {-1204},				dst = {{x = frame_position.x+replay_diff.x+35*3 - result_r, y = frame_position.y+replay_diff.y,  w = 23, h = 28, b = 0, g = 0}},mouseRect = {x = 0, y = 0, w = 23, h = 28}},

		-- pattern off
		{id = "gauge", draw = function() return result_mode == 0 and pattern_mode == 0 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52-35+3, w = 419, h = 170+35-3, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "notes_graph",draw = function() return result_mode == 0 and pattern_mode == 0 end,  acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52-35+3, w = 419, h = (170+35-3)*2/3, a = 0},
			{time = timer_tag[2] , a = 200},
		}},

		{id = "gauge_line", draw = function() return result_mode == 0 and pattern_mode == 0 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52-35+3, w = 420, h = 170+35-3, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		-- pattern on
		{id = "gauge", draw = function() return result_mode == 0 and pattern_mode == 1 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52+3, w = 419, h = 170-3, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "notes_graph",draw = function() return result_mode == 0 and pattern_mode == 1 end,  acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52+3, w = 419, h = (170-3)*2/3, a = 0},
			{time = timer_tag[2] , a = 200},
		}},

		{id = "gauge_line", draw = function() return result_mode == 0 and pattern_mode == 1 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 691 + 1 + 52+3, w = 420, h = 170-3, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		-- 1p 1key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 2key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 3key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 4key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 5key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 6key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- 1p 7key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 1 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 2 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 3 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 4 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 5 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 6 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 7 and (main_state.option(161) or main_state.option(160)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r*0.85, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 1key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(450) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 2key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(451) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 3key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(452) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 4key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(453) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 5key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(454) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 6key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(455) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 1p 7key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(456) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 1key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(460) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*0 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 2key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(461) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*1 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 3key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(462) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*2 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 4key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(463) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*3 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 5key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(464) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*4 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 6key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(465) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*5 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- dp 2p 7key
		{id = "1key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 1 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "2key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 2 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "3key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 3 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "4key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 4 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "5key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 5 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "6key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 6 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},
		{id = "7key", draw = function() return result_mode == 0 and pattern_mode == 1 and main_state.event_index(466) == 7 and (main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
				dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 202 + 27*6 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38, w = 25, h = 35, a = 0},{time = timer_tag[2], a = 255}}},

		-- {id = "random_pattern_warning", draw = function() return result_mode == 0 and pattern_mode == 1 and not(main_state.event_index(42) == 2 or main_state.event_index(42) == 3) and (main_state.option(161) or main_state.option(160) or main_state.option(163) or main_state.option(162)) end,  loop = timer_tag[2], 
		-- 		dst = {{time = timer_tag[1], x = frame_position.x + 1402 + 10 + 15 + 27*3 - 15 - result_r, y = frame_position.y + 691 + 1 + 52 + 1 - 38 + 3, w = 300, h = 30, a = 0},{time = timer_tag[2], a = 255}}},

		{id = "judge_graph", draw = function() return result_mode == 0 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 541 + 2, w = 420, h = 70, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "fast_slow_graph", draw = function() return result_mode == 0 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 541 - 120 + 4, w = 420, h = 70, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "timing_graph", draw = function() return result_mode == 0 end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1402 + 10 - result_r, y = frame_position.y + 538 - 120 * 2 + 7, w = 420, h = 74, a = 0},
			{time = timer_tag[2] , a = 170},
		}},

		{id = "pggrgdbdpr_7keys", draw = function() return result_mode == 0 and not(main_state.option(164)) end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1613 - result_r, y = frame_position.y + 503, w = 205, h = 131, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "pggrgdbdpr_9keys", draw = function() return result_mode == 0 and main_state.option(164) end, acc = 2 ,loop = timer_tag[2] , dst = {
			{time = timer_tag[1] , x = frame_position.x + 1613 - result_r, y = frame_position.y + 503, w = 205, h = 131, a = 0},
			{time = timer_tag[2] , a = 255},
		}},

		{id = "ir_name", draw = function() return result_mode == 1 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1855 - result_r, y = frame_position.y+1200-238-54+10, w = 200, h = 24, a = 0},{time = timer_tag[2], y = frame_position.y+1200-238-54, a = 255}}},

		{id = "current_irrank", draw = function() return result_mode == 1 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1855+23-21-194 - result_r, y = frame_position.y+1200-162-157+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+1200-162-157, a = 255}}},
		{id = "mybest_irrank", draw = function() return result_mode == 1 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1855+23-21-135-155 - result_r, y = frame_position.y+1200-162-157+10, w = 17, h = 25, a = 0},{time = timer_tag[2], y = frame_position.y+1200-162-157, a = 255}}},
		{id = "totalplayer_irrank", draw = function() return result_mode == 1 end, loop = timer_tag[2], dst = {{time = timer_tag[1], x = frame_position.x+1855+23-21-194+95 - result_r, y = frame_position.y+1200-162-155+10, w = 11, h = 15, a = 0},{time = timer_tag[2], y = frame_position.y+1200-162-155, a = 255}}},

		{id = -100,  draw = function() return main_state.text(1003) ~= "" and stagefile_gazou_on == 1 end, dst = {{x = 960-306*0.8/2, y = 190 + 10, w = 306*0.8, h = 228*0.8}}},
		{id = "default_info_title",	draw = function() return main_state.text(1003) ~= "" end, filter = 1, dst = {{x = 960, y = 140 + 20, w = 800, h = 30}}},
		{id = "default_info_artist",	draw = function() return main_state.text(1003) ~= "" end, filter = 1, dst = {{x = 960, y = 110 + 20, w = 800, h = 24}}},
		{id = "default_info_directory",	draw = function() return main_state.text(1003) ~= "" end, filter = 1, dst = {{x = 960, y = 70 + 20, w = 800, h = 24, r = 255, g = 200, b = 220}}},

		{id = -100,  draw = function() return main_state.text(1003) == "" and stagefile_gazou_on == 1 end, dst = {{x = 960-306*0.8/2, y = 190-40 + 20, w = 306*0.8, h = 228*0.8}}},
		{id = "default_info_title",	draw = function() return main_state.text(1003) == "" end, filter = 1, dst = {{x = 960, y = 140-40 + 20, w = 800, h = 30}}},
		{id = "default_info_artist",	draw = function() return main_state.text(1003) == "" end, filter = 1, dst = {{x = 960, y = 110-40 + 20, w = 800, h = 24}}},

		{id = "5k", op = {161}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "7k", op = {160}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "9k", op = {164}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "10k", op = {163}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "14k", op = {162}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "24k", op = {1160}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},
		{id = "48k", op = {1161}, dst = {{x = 700-4, y = 30, w = 40, h = 20}}},

		{id = "ve", op = {184}, dst = {{x = 760-4, y = 30, w = 83, h = 20}}},
		{id = "e", op = {183}, dst = {{x = 760-4, y = 30, w = 83, h = 20}}},
		{id = "n", op = {182}, dst = {{x = 760-4, y = 30, w = 83, h = 20}}},
		{id = "h", op = {181}, dst = {{x = 760-4, y = 30, w = 83, h = 20}}},
		{id = "vh", op = {180}, dst = {{x = 760-4, y = 30, w = 83, h = 20}}},

		{id = "unknown", op = {150}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},
		{id = "beginner", op = {151}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},
		{id = "normal", op = {152}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},
		{id = "hyper", op = {153}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},
		{id = "another", op = {154}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},
		{id = "insane", op = {155}, dst = {{x = 890-4, y = 30-1, w = 100, h = 20}}},

		{id = "difficulty_count", op = {150}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 179, g = 179, b = 179, a = 255}}},
		{id = "difficulty_count", op = {151}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 40, g = 172, b = 68, a = 255}}},
		{id = "difficulty_count", op = {152}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 68, g = 140, b = 222, a = 255}}},
		{id = "difficulty_count", op = {153}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 241, g = 238, b = 16, a = 255}}},
		{id = "difficulty_count", op = {154}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 255, g = 0, b = 72, a = 255}}},
		{id = "difficulty_count", op = {155}, dst = {{x = 996-4, y = 31-1, w = 12, h = 20, r = 150, g = 65, b = 255, a = 255}}},
		
		{id = "totalnotes", dst = {{x = 1070 + 4 -4, y = 31-1, w = 12, h = 20, a = 255}}},

		{id = "big_fullcombo_shadow",  op = {90, -2245, -2244}, loop = 2000 - 350, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255, g = 255-26*2/3, b = 255-78*2/3, a = 0},{time = 180 * 1},{time = 180 * 2, a = 230},{time = 750, a = 255, r = 255, g = 255, b = 255},{time = 1700 - 350, a = 230, r = 255, g = 255-26*1/6, b = 255-78*1/6},{time = 1850 - 350, x = 1920/2-1450/2-1450*0.175, y = 1080/2-1150/2-1150*0.175, w = 1450*1.35, h = 1150*1.35, a = 115},{time = 2000 - 350, x = 1920/2-1450/2-1450*0.25, y = 1080/2-1150/2-1150*0.25, w = 1450*1.5, h = 1150*1.5, a = 0}}},
		{id = "big_fullcombo_2_full",  op = {90, -2245, -2244}, loop = 2000 - 350, dst = {{time = 0, x = 684-1166-64-10, y = 465-35+125, w = 700, h = 125, a = 255},{time = 90 * 1, x = 684-286-64-10},{time = 90 * 2, x = 684-36-64-10},{time = 90 * 3, x = 684-12-64-10},{time = 90 * 4, x = 684-3-64-10},{time = 90 * 5, x = 684-64-10},{time = 1700 - 350},{time = 1800 - 350, x = 970-64-10},{time = 2000 - 350, x = 2850-64-10}}},
		{id = "big_fullcombo_2_combo",  op = {90, -2245, -2244}, loop = 2000 - 350, dst = {{time = 0, x = 1850-64+10, y = 465-35, w = 700, h = 125, a = 255},{time = 90 * 1, x = 970-64+10},{time = 90 * 2, x = 720-64+10},{time = 90 * 3, x = 696-64+10},{time = 90 * 4, x = 687-64+10},{time = 90 * 5, x = 684-64+10},{time = 1700 - 350},{time = 1800 - 350, x = 684-286-64+10},{time = 2000 - 350, x = 684-2166-64+10}}},

		-- {id = "big_clear_shadow",  op = {90, 2244}, loop = 2000, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255-77*2/3, g = 255-13*2/3, b = 255, a = 0},{time = 150},{time = 300, a = 230},{time = 900, a = 255, r = 255, g = 255, b = 255},{time = 1700, a = 230, r = 255-77*1/6, g = 255-13*1/6, b = 255},{time = 1850, x = 1920/2-1450/2-1450*0.175, y = 1080/2-1150/2-1150*0.175, w = 1450*1.35, h = 1150*1.35, a = 115},{time = 2000, x = 1920/2-1450/2-1450*0.25, y = 1080/2-1150/2-1150*0.25, w = 1450*1.5, h = 1150*1.5, a = 0}}},
		{id = "big_clear_shadow",  op = {90, 2244}, loop = 2000 - 350, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255-77*2/3, g = 255-13*2/3, b = 255, a = 0},{time = 180 * 1},{time = 180 * 2, a = 230},{time = 750, a = 255, r = 255, g = 255, b = 255},{time = 1700 - 350, a = 230, r = 255-77*1/6, g = 255-13*1/6, b = 255},{time = 1850 - 350, x = 1920/2-1450/2-1450*0.175, y = 1080/2-1150/2-1150*0.175, w = 1450*1.35, h = 1150*1.35, a = 115},{time = 2000 - 350, x = 1920/2-1450/2-1450*0.25, y = 1080/2-1150/2-1150*0.25, w = 1450*1.5, h = 1150*1.5, a = 0}}},
		-- {id = "big_clear_2",  op = {90, 2244}, loop = 2000, dst = {{time = 0, x = 1850-64, y = 465-35, w = 700, h = 250, a = 255},{time = 100, x = 970-64},{time = 200, x = 720-64},{time = 650, x = 704-64},{time = 1100, x = 690-64},{time = 1700, x = 684-64},{time = 1850, x = 684-64-700*0.175, y = 465-35-250*0.175, w = 700*1.35, h = 250*1.35, a = 127},{time = 2000, x = 684-64-700*0.25, y = 465-35-250*0.25, w = 700*1.5, h = 250*1.5, a = 0}}},
		{id = "big_clear_2",  op = {90, 2244}, loop = 2000 - 350, dst = {{time = 0, x = 1850-64, y = 465-35, w = 700, h = 250, a = 255},{time = 90 * 1, x = 970-64},{time = 90 * 2, x = 720-64},{time = 90 * 3, x = 696-64},{time = 90 * 4, x = 687-64},{time = 90 * 5, x = 684-64},{time = 1700 - 350},{time = 1850 - 350, x = 684-64-700*0.175, y = 465-35-250*0.175, w = 700*1.35, h = 250*1.35, a = 127},{time = 2000 - 350, x = 684-64-700*0.25, y = 465-35-250*0.25, w = 700*1.5, h = 250*1.5, a = 0}}},


		-- {id = "big_clear_shadow",  op = {90, 2245, -2244}, loop = 2000, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255-77*2/3, g = 255-13*2/3, b = 255, a = 0},{time = 150},{time = 300, a = 230},{time = 900, a = 255, r = 255, g = 255, b = 255},{time = 1700, a = 230, r = 255-77*1/3, g = 255-13*1/3, b = 255},{time = 1850, x = 1920/2-1450/2-1450*0.175, y = 1080/2-1150/2-1150*0.175, w = 1450*1.35, h = 1150*1.35, a = 115},{time = 2000, x = 1920/2-1450/2-1450*0.25, y = 1080/2-1150/2-1150*0.25, w = 1450*1.5, h = 1150*1.5, a = 0}}},
		{id = "big_clear_shadow",  op = {90, 2245, -2244}, loop = 2000 - 350, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255-77*2/3, g = 255-13*2/3, b = 255, a = 0},{time = 180 * 1},{time = 180 * 2, a = 230},{time = 750, a = 255, r = 255, g = 255, b = 255},{time = 1700 - 350, a = 230, r = 255-77*1/6, g = 255-13*1/6, b = 255},{time = 1850 - 350, x = 1920/2-1450/2-1450*0.175, y = 1080/2-1150/2-1150*0.175, w = 1450*1.35, h = 1150*1.35, a = 115},{time = 2000 - 350, x = 1920/2-1450/2-1450*0.25, y = 1080/2-1150/2-1150*0.25, w = 1450*1.5, h = 1150*1.5, a = 0}}},
		-- {id = "big_clear_2",  op = {90, 2245, -2244}, loop = 2000, dst = {{time = 0, x = 1850-64, y = 465-35, w = 700, h = 250, a = 255},{time = 100, x = 970-64},{time = 200, x = 720-64},{time = 650, x = 704-64},{time = 1100, x = 690-64},{time = 1700, x = 684-64},{time = 1850, x = 684-64-700*0.175, y = 465-35-250*0.175, w = 700*1.35, h = 250*1.35, a = 127},{time = 2000, x = 684-64-700*0.25, y = 465-35-250*0.25, w = 700*1.5, h = 250*1.5, a = 0}}},
		{id = "big_clear_2",  op = {90, 2245, -2244}, loop = 2000 - 350, dst = {{time = 0, x = 1850-64, y = 465-35, w = 700, h = 250, a = 255},{time = 90 * 1, x = 970-64},{time = 90 * 2, x = 720-64},{time = 90 * 3, x = 696-64},{time = 90 * 4, x = 687-64},{time = 90 * 5, x = 684-64},{time = 1700 - 350},{time = 1850 - 350, x = 684-64-700*0.175, y = 465-35-250*0.175, w = 700*1.35, h = 250*1.35, a = 127},{time = 2000 - 350, x = 684-64-700*0.25, y = 465-35-250*0.25, w = 700*1.5, h = 250*1.5, a = 0}}},

		{id = "big_failed_shadow",  op = {91}, loop = 2000 - 350, dst = {{time = 0, x = 1920/2-1450/2, y = 1080/2-1150/2, w = 1450, h = 1150, r = 255, g = 255-85*2/3, b = 255-102*2/3, a = 0},{time = 180 * 1.5, a = 204},{time = 750, a = 255, r = 255, g = 255, b = 255},{time = 1700 - 350, a = 220, r = 255, g = 255-85*1/6, b = 255-102*1/6},{time = 2000 - 350, a = 0}}},
		{id = "big_failed_2",  op = {91}, loop = 2000 - 350, dst = {{time = 0, x = 684-64, y = 465-40+125, w = 700, h = 250, a = 0},{time = 90 * 1, y = 465-40+12, a = 80},{time = 90 * 2, y = 465-40+3, a = 160},{time = 90 * 3, y = 465-40, a = 255},{time = 1700 - 350},{time = 2000 - 350, y = 465-40-60, a = 0}}},

	}

	
	do
		local ir = {}
		
		ir.image		= {}
		ir.text			= {}
		ir.value		= {}
		ir.slider		= {}
		ir.destination	= {}
		ir.pos			= {}
		
		-- 全体の座標
		ir.pos.x = 1400
		ir.pos.y = 215+50
		
		-- 各要素のx座標
		ir.pos.rank_x	= ir.pos.x + 23
		ir.pos.clear_x	= ir.pos.x + 110
		ir.pos.score_x	= ir.pos.x + 268 - 18
		ir.pos.scorerate_x	= ir.pos.x + 200 - 20
		ir.pos.score_diff_x	= ir.pos.x + 361 + 5 - 12
		ir.pos.name_x	= ir.pos.x + 110
		ir.pos.scroll_x	= ir.pos.x + 429 - 6
		
		-- 各要素のy座標調整用
		ir.pos.rank_offset_y	= 23
		ir.pos.clear_offset_y	= 12
		ir.pos.score_offset_y	= 20
		ir.pos.scorerate_offset_y	= 14
		ir.pos.score_diff_offset_y	= 25
		ir.pos.name_offset_y	= 28
		ir.pos.scroll_offset_y = 560-35-6
		
		-- 行の高さ
		ir.pos.line_h = 57.5 - 5
		
		for i = 1, 35 do
			table.insert(ir.image,	{id = "big_clear_light" .. i, src = "clear_failed_light", x = 20*(i-1), y = 0, w = 20, h = 250})
			table.insert(ir.destination,  {id = "big_clear_light" .. i,	op = {90, 2244}, loop = 1700 - 350, dst = {{time = 0, x = 684-64 + 20*(i-1), y = 465-35, w = 20, h = 250, a = 0}, {time = 90 * 4 + 8 * i}, {time = 90 * 4 + 8 * (i + 1), a = 150}, {time = 1150}, {time = 1700 - 350, a = 0}}})
			table.insert(ir.destination,  {id = "big_clear_light" .. i,	op = {90, 2245, -2244}, loop = 1700 - 350, dst = {{time = 0, x = 684-64 + 20*(i-1), y = 465-35, w = 20, h = 250, a = 0}, {time = 90 * 4 + 8 * i}, {time = 90 * 4 + 8 * (i + 1), a = 150}, {time = 1150}, {time = 1700 - 350, a = 0}}})
			table.insert(ir.image,	{id = "full_light" .. i, src = "clear_failed_light", x = 20*(i-1), y = 500, w = 20, h = 125})
			table.insert(ir.destination,  {id = "full_light" .. i,	op = {90, -2245, -2244}, loop = 1700 - 350, dst = {{time = 0, x = 684-64-10 + 20*(i-1), y = 465-35+125, w = 20, h = 125, a = 0}, {time = 90 * 4 + 8 * i}, {time = 90 * 4 + 8 * (i + 1), a = 150}, {time = 1150}, {time = 1700 - 350, a = 0}}})
			table.insert(ir.image,	{id = "combo_light" .. i, src = "clear_failed_light", x = 20*(i-1), y = 625, w = 20, h = 125})
			table.insert(ir.destination,  {id = "combo_light" .. i,	op = {90, -2245, -2244}, loop = 1700 - 350, dst = {{time = 0, x = 684-64+10 + 20*(i-1), y = 465-35, w = 20, h = 125, a = 0}, {time = 90 * 4 + 8 * i}, {time = 90 * 4 + 8 * (i + 1), a = 150}, {time = 1150}, {time = 1700 - 350, a = 0}}})
		end

		if main_state.option(51) then

			-- {id = "rank1", src = "rank123", x = 0, y = 0, w = 414, h = 52},

			local v = ir.pos.y + (ir.pos.line_h * 10)
			table.insert(ir.slider, {id = "ir_scroll_cursor",	src = "ir_scroll_cursor", x = 0, y = 0, w = 64, h = 64, angle = 2, range = 460, type = 8, changeable = false})
			table.insert(ir.slider, {id = "ir_scroll_collision",	src = "ir_scroll_cursor", x = 0, y = 64, w = 64, h = 64, angle = 2, range = 460, type = 8, changeable = true})
			table.insert(ir.destination,  {id = "ir_scroll_cursor", draw = function() return result_mode == 1 end, loop = 0, blend = 2, dst = {{time = 0, x = ir.pos.scroll_x - result_r, y = ir.pos.y + ir.pos.scroll_offset_y, w = 64, h = 64, a = 255},{time = 350, a = 180},{time = 400, a = 255}}})
			table.insert(ir.destination,  {id = "ir_scroll_collision",	draw = function() return result_mode == 1 end, dst = {{x = ir.pos.scroll_x - result_r, y = ir.pos.y + ir.pos.scroll_offset_y, w = 64, h = 64}}})

			for i = 1, 10 do
				
				table.insert(ir.destination,  {id = "rank1",	draw = function() return result_mode == 1 and (isrank1(i)) end, dst = {{x = ir.pos.x+15 - result_r, y = ir.pos.y+523+10-52.5*(i-1), w = 414+1, h = 52}}})
				table.insert(ir.destination,  {id = "rank2",	draw = function() return result_mode == 1 and (isrank2(i)) end, dst = {{x = ir.pos.x+15 - result_r, y = ir.pos.y+523+10-52.5*(i-1), w = 414+1, h = 52}}})
				table.insert(ir.destination,  {id = "rank3",	draw = function() return result_mode == 1 and (isrank3(i)) end, dst = {{x = ir.pos.x+15 - result_r, y = ir.pos.y+523+10-52.5*(i-1), w = 414+1, h = 52}}})

			end

			for i = 1, 10 do

				-- {id = "ir_you", src = "ir_you", x = 0, y = 0, w = 417, h = 54},

				-- {id = "ir_you_2", src = "ir_you_2", x = 0, y = 0, w = 414 + 3 + 28, h = 54 + 28},

				-- table.insert(ir.destination,	{id = "ir_you", draw = function() return (result_mode == 1 and isMyFrame(i)) end, loop = 0, dst = {{time = 0, x = ir.pos.x+2+11 - result_r, y = ir.pos.y+523+7-52.5*(i-1), w = 417, h = 54, a = 255}, {time = 750, a = 255}, {time = 1500, a = 255}}})

				table.insert(ir.destination,	{id = "ir_you_2", draw = function() return (result_mode == 1 and isMyFrame(i)) end, loop = 0, dst = {{time = 0, x = ir.pos.x+2+11-14 - result_r, y = ir.pos.y+523+7-14-52.5*(i-1), w = 417+28, h = 54+28, a = 255}, {time = 750, a = 255}, {time = 1500, a = 255}}})


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
				table.insert(ir.destination, {id = "ir_state_clear" .. i, draw = function() return result_mode == 1 end, dst = {{x = ir.pos.clear_x - result_r,	y = v + ir.pos.clear_offset_y,	w = 80, h = 16}}})
				table.insert(ir.destination, {id = "ir_rank" .. i, draw = function() return result_mode == 1 and not(is1to3(i)) end, dst = {{x = ir.pos.rank_x - result_r,	y = v + ir.pos.rank_offset_y,	w = 14, h = 20}}})
				table.insert(ir.destination, {id = "ir_score" .. i, draw = function() return result_mode == 1 end, dst = {{x = ir.pos.score_x - result_r,	y = v + ir.pos.score_offset_y,	w = 17, h = 25}}})
				table.insert(ir.destination, {id = "ir_score_diff" .. i, draw = function() return result_mode == 1 and main_state.number(379 + i) >= 0 end, dst = {{x = ir.pos.score_diff_x - result_r,	y = v + ir.pos.score_diff_offset_y,	w = 11, h = 15}}})
				table.insert(ir.destination, {id = "ir_name" .. i, draw = function() return result_mode == 1 end, dst = {{x = ir.pos.name_x - result_r,	y = v + ir.pos.name_offset_y,	w = 170, h = 24}}})
				table.insert(ir.destination, {id = "ir_scorerate" .. i, draw = function() return result_mode == 1 and main_state.number(379 + i) >= 0 end, dst = {{x = ir.pos.scorerate_x+23-18 - result_r, y = v + ir.pos.scorerate_offset_y-1, w = 11, h = 15}}})
				table.insert(ir.destination, {id = "ir_scorerate_dot" .. i, draw = function() return result_mode == 1 and main_state.number(379 + i) >= 0 end, dst = {{x = ir.pos.scorerate_x+21+18 - result_r, y = v + ir.pos.scorerate_offset_y-1, w = 11, h = 15}}})
				table.insert(ir.destination, {id = "mybest_dot", draw = function() return result_mode == 1 and main_state.number(379 + i) >= 0 end, dst = {{x = ir.pos.scorerate_x+35 - result_r, y = v + ir.pos.scorerate_offset_y, w = 5, h = 5}}})
				table.insert(ir.destination, {id = "mybest_per", draw = function() return result_mode == 1 and main_state.number(379 + i) >= 0 end, dst = {{x = ir.pos.scorerate_x+31+30 - result_r, y = v + ir.pos.scorerate_offset_y, w = 16, h = 14}}})

				v = v - ir.pos.line_h
			end

		end
		
		append_all(skin.image, ir.image)
		append_all(skin.value, ir.value)
		append_all(skin.text, ir.text)
		append_all(skin.slider, ir.slider)
		append_all(skin.destination, ir.destination)
		
	end

	-- シャッター稼働時間
	shutter_timer = 700
	
	-- シャッター移動距離
	shutter_move_x = 500

	-- シャッター右x
	shutter_right_x = 0

	-- シャッター右2x
	suntter_right_2_x = 575 - 16 + 24

	-- バー1稼働開始時間
	bar_1_start = 300

	-- バー1稼働時間
	bar_1_timer = 600

	-- バー1右x
	bar_1_right_x = 710

	-- 円稼働開始時間
	circle_start = 200

	-- 円稼働時間
	circle_timer = 700

	-- 円移動距離
	circle_move_y = 150

	-- 円回転角度
	circle_turn = 5

	-- 円1x
	circle_1_x = 1118 / 2

	-- 円1y
	circle_1_y = -680

	-- 円2x
	circle_2_x = 2787 / 2

	-- 円2y
	circle_2_y = 497

	-- ロゴ開始時間
	-- logo_start = 400

	-- -- ロゴx
	-- logo_x = 1360 - 120 + 80

	-- -- ロゴy
	-- logo_y = 88 - 43 + 24

	do
		table.insert(skin.destination,  {id = "shutter", loop = 300, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255},{time = 300, a = 0}}})
		-- {id = "shutter_left",	src = "shutter_frame", x = 0, y = 0, w = 1920, h = 1080},
		-- {id = "shutter_right",	src = "shutter_frame", x = 0, y = 1080, w = 1920, h = 1080},
		-- {id = "shutter_bar_left_1",	src = "shutter_frame", x = 0, y = 1080 * 2, w = 695, h = 695},
		-- {id = "shutter_bar_right_1",	src = "shutter_frame", x = 0, y = 1080 * 2 + 695, w = 1289, h = 1080},
		-- {id = "shutter_bar_2",	src = "shutter_frame", x = 0, y = 3935, w = 1729, h = 1686},
		-- {id = "shutter_circle_1",	src = "shutter_frame", x = 0, y = 5621, w = 1522, h = 1522},
		-- {id = "shutter_circle_2",	src = "shutter_frame", x = 0, y = 7142, w = 788, h = 788},
		table.insert(skin.destination,  {id = "shutter_background", op = {op.SHUTTER_ON}, 	loop = shutter_timer, timer = 2, dst = {{time = 0, x = shutter_move_x * -0.3, y = 0, w = 1920, h = 1080, a = 0},
				{time = shutter_timer*1/5, x = shutter_move_x * -0.3 * (((5-1)/5)^2), a = 255*1/5},
				{time = shutter_timer*2/5, x = shutter_move_x * -0.3 * (((5-2)/5)^2), a = 255*2/5},
				{time = shutter_timer*3/5, x = shutter_move_x * -0.3 * (((5-3)/5)^2), a = 255*3/5},
				{time = shutter_timer*4/5, x = shutter_move_x * -0.3 * (((5-4)/5)^2), a = 255*4/5},
				{time = shutter_timer*5/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*5/5},}})
		table.insert(skin.destination,  {id = "shutter_luster", op = {op.SHUTTER_ON},  blend = 0, loop = shutter_timer*7/5, timer = 2, dst = {{time = 0, x = shutter_move_x * -0.3, y = 0, w = 1920, h = 1080, a = 0},
				{time = shutter_timer*1/5, x = shutter_move_x * -0.3 * (((5-1)/5)^2), a = 255*5/40},
				{time = shutter_timer*2/5, x = shutter_move_x * -0.3 * (((5-2)/5)^2), a = 255*8/40},
				{time = shutter_timer*3/5, x = shutter_move_x * -0.3 * (((5-3)/5)^2), a = 255*10/40},
				{time = shutter_timer*4/5, x = shutter_move_x * -0.3 * (((5-4)/5)^2), a = 255*8/40},
				{time = shutter_timer*5/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*5/40},
				{time = shutter_timer*7/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*0/40},}})
		table.insert(skin.destination,  {id = "shutter_left", op = {op.SHUTTER_ON}, loop = shutter_timer,  timer = 2, dst = {{time = 0, x = shutter_move_x * -1, y = 0, w = 1920, h = 1080, a = 0},
				{time = shutter_timer*1/5, x = shutter_move_x * -1 * (((5-1)/5)^2), a = 255*1/5},
				{time = shutter_timer*2/5, x = shutter_move_x * -1 * (((5-2)/5)^2), a = 255*2/5},
				{time = shutter_timer*3/5, x = shutter_move_x * -1 * (((5-3)/5)^2), a = 255*3/5},
				{time = shutter_timer*4/5, x = shutter_move_x * -1 * (((5-4)/5)^2), a = 255*4/5},
				{time = shutter_timer*5/5, x = shutter_move_x * -1 * (((5-5)/5)^2), a = 255*5/5},}})
		table.insert(skin.destination,  {id = "shutter_right",	op = {op.SHUTTER_ON}, loop = shutter_timer,  timer = 2, dst = {{time = 0, x = shutter_right_x + shutter_move_x * 1, y = 0, w = 1920, h = 1080, a = 0},
				{time = shutter_timer*1/5, x = shutter_right_x + shutter_move_x * 1 * (((5-1)/5)^2), a = 255*1/5},
				{time = shutter_timer*2/5, x = shutter_right_x + shutter_move_x * 1 * (((5-2)/5)^2), a = 255*2/5},
				{time = shutter_timer*3/5, x = shutter_right_x + shutter_move_x * 1 * (((5-3)/5)^2), a = 255*3/5},
				{time = shutter_timer*4/5, x = shutter_right_x + shutter_move_x * 1 * (((5-4)/5)^2), a = 255*4/5},
				{time = shutter_timer*5/5, x = shutter_right_x + shutter_move_x * 1 * (((5-5)/5)^2), a = 255*5/5},}})
		table.insert(skin.destination,  {id = "shutter_bar_left_1", op = {op.SHUTTER_ON}, loop = bar_1_start + bar_1_timer,  timer = 2, dst = {{time = bar_1_start, x = -695, y = (1080 - 695) - 695, w = 695, h = 695, a = 255},
				{time = bar_1_start + bar_1_timer*1/5, x = -695 * (((5-1)/5)^2), y = (1080 - 695) - 695 * (((5-1)/5)^2)},
				{time = bar_1_start + bar_1_timer*2/5, x = -695 * (((5-2)/5)^2), y = (1080 - 695) - 695 * (((5-2)/5)^2)},
				{time = bar_1_start + bar_1_timer*3/5, x = -695 * (((5-3)/5)^2), y = (1080 - 695) - 695 * (((5-3)/5)^2)},
				{time = bar_1_start + bar_1_timer*4/5, x = -695 * (((5-4)/5)^2), y = (1080 - 695) - 695 * (((5-4)/5)^2)},
				{time = bar_1_start + bar_1_timer*5/5, x = -695 * (((5-5)/5)^2), y = (1080 - 695) - 695 * (((5-5)/5)^2)},}})
		table.insert(skin.destination,  {id = "shutter_bar_right_1", op = {op.SHUTTER_ON}, loop = bar_1_start + bar_1_timer,  timer = 2, dst = {{time = bar_1_start, x = bar_1_right_x + 1080, y = 1080, w = 1289, h = 1080, a = 255},
				{time = bar_1_start + bar_1_timer*1/5, x = bar_1_right_x + 1080 * (((5-1)/5)^2), y = 1080 * (((5-1)/5)^2)},
				{time = bar_1_start + bar_1_timer*2/5, x = bar_1_right_x + 1080 * (((5-2)/5)^2), y = 1080 * (((5-2)/5)^2)},
				{time = bar_1_start + bar_1_timer*3/5, x = bar_1_right_x + 1080 * (((5-3)/5)^2), y = 1080 * (((5-3)/5)^2)},
				{time = bar_1_start + bar_1_timer*4/5, x = bar_1_right_x + 1080 * (((5-4)/5)^2), y = 1080 * (((5-4)/5)^2)},
				{time = bar_1_start + bar_1_timer*5/5, x = bar_1_right_x + 1080 * (((5-5)/5)^2), y = 1080 * (((5-5)/5)^2)},}})
		-- table.insert(skin.destination,  {id = "shutter_bar_2", op = {op.SHUTTER_ON}, loop = bar_2_start + bar_2_timer,  timer = 2, dst = {{time = bar_2_start, x = -1729, y = bar_2_left_y + (-1729 - bar_2_left_x), w = 1729, h = 1686, a = 255},
		-- 		{time = bar_2_start + bar_2_timer*1/5, x = bar_2_left_x + (-1729 - bar_2_left_x) * (((5-1)/5)^2), y = bar_2_left_y + (-1729 - bar_2_left_x) * (((5-1)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*2/5, x = bar_2_left_x + (-1729 - bar_2_left_x) * (((5-2)/5)^2), y = bar_2_left_y + (-1729 - bar_2_left_x) * (((5-2)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*3/5, x = bar_2_left_x + (-1729 - bar_2_left_x) * (((5-3)/5)^2), y = bar_2_left_y + (-1729 - bar_2_left_x) * (((5-3)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*4/5, x = bar_2_left_x + (-1729 - bar_2_left_x) * (((5-4)/5)^2), y = bar_2_left_y + (-1729 - bar_2_left_x) * (((5-4)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*5/5, x = bar_2_left_x + (-1729 - bar_2_left_x) * (((5-5)/5)^2), y = bar_2_left_y + (-1729 - bar_2_left_x) * (((5-5)/5)^2)},}})
		-- table.insert(skin.destination,  {id = "shutter_bar_2", op = {op.SHUTTER_ON}, loop = bar_2_start + bar_2_timer,  timer = 2, dst = {{time = bar_2_start, x = 1920, y = bar_2_right_y + (1920 - bar_2_right_x), w = 1729, h = 1686, a = 255},
		-- 		{time = bar_2_start + bar_2_timer*1/5, x = bar_2_right_x + (1920 - bar_2_right_x) * (((5-1)/5)^2), y = bar_2_right_y + (1920 - bar_2_right_x) * (((5-1)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*2/5, x = bar_2_right_x + (1920 - bar_2_right_x) * (((5-2)/5)^2), y = bar_2_right_y + (1920 - bar_2_right_x) * (((5-2)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*3/5, x = bar_2_right_x + (1920 - bar_2_right_x) * (((5-3)/5)^2), y = bar_2_right_y + (1920 - bar_2_right_x) * (((5-3)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*4/5, x = bar_2_right_x + (1920 - bar_2_right_x) * (((5-4)/5)^2), y = bar_2_right_y + (1920 - bar_2_right_x) * (((5-4)/5)^2)},
		-- 		{time = bar_2_start + bar_2_timer*5/5, x = bar_2_right_x + (1920 - bar_2_right_x) * (((5-5)/5)^2), y = bar_2_right_y + (1920 - bar_2_right_x) * (((5-5)/5)^2)},}})
		table.insert(skin.destination,  {id = "shutter_circle_1", op = {op.SHUTTER_ON}, loop = circle_start + circle_timer,  timer = 2, dst = {{time = circle_start, x = circle_1_x, y = circle_1_y - circle_move_y, w = 1522, h = 1522, a = 0},
				{time = circle_start + circle_timer*1/5, y = circle_1_y - circle_move_y * (((5-1)/5)^3), a = 255*1/5},
				{time = circle_start + circle_timer*2/5, y = circle_1_y - circle_move_y * (((5-2)/5)^3), a = 255*2/5},
				{time = circle_start + circle_timer*3/5, y = circle_1_y - circle_move_y * (((5-3)/5)^3), a = 255*3/5},
				{time = circle_start + circle_timer*4/5, y = circle_1_y - circle_move_y * (((5-4)/5)^3), a = 255*4/5},
				{time = circle_start + circle_timer*5/5, y = circle_1_y - circle_move_y * (((5-5)/5)^3), a = 255*5/5},}})
		table.insert(skin.destination,  {id = "shutter_circle_2", op = {op.SHUTTER_ON}, loop = circle_start + circle_timer,  timer = 2, dst = {{time = circle_start, x = circle_2_x, y = circle_2_y - circle_move_y, w = 788, h = 788, a = 0},
				{time = circle_start + circle_timer*1/5, y = circle_2_y + circle_move_y * (((5-1)/5)^3), a = 255*1/5},
				{time = circle_start + circle_timer*2/5, y = circle_2_y + circle_move_y * (((5-2)/5)^3), a = 255*2/5},
				{time = circle_start + circle_timer*3/5, y = circle_2_y + circle_move_y * (((5-3)/5)^3), a = 255*3/5},
				{time = circle_start + circle_timer*4/5, y = circle_2_y + circle_move_y * (((5-4)/5)^3), a = 255*4/5},
				{time = circle_start + circle_timer*5/5, y = circle_2_y + circle_move_y * (((5-5)/5)^3), a = 255*5/5},}})
		-- table.insert(skin.destination,  {id = "shutter_circle_1", op = {op.SHUTTER_ON}, loop = circle_start + circle_timer,  timer = 2, dst = {{time = circle_start, x = circle_1_x, y = circle_1_y - circle_move_y, angle = circle_turn, w = 1522, h = 1522, a = 0},
		-- 		{time = circle_start + circle_timer*1/5, y = circle_1_y - circle_move_y * (((5-1)/5)^2), angle = circle_turn * (((5-1)/5)^2), a = 255*1/5},
		-- 		{time = circle_start + circle_timer*2/5, y = circle_1_y - circle_move_y * (((5-2)/5)^2), angle = circle_turn * (((5-2)/5)^2), a = 255*2/5},
		-- 		{time = circle_start + circle_timer*3/5, y = circle_1_y - circle_move_y * (((5-3)/5)^2), angle = circle_turn * (((5-3)/5)^2), a = 255*3/5},
		-- 		{time = circle_start + circle_timer*4/5, y = circle_1_y - circle_move_y * (((5-4)/5)^2), angle = circle_turn * (((5-4)/5)^2), a = 255*4/5},
		-- 		{time = circle_start + circle_timer*5/5, y = circle_1_y - circle_move_y * (((5-5)/5)^2), angle = circle_turn * (((5-5)/5)^2), a = 255*5/5},}})
		-- table.insert(skin.destination,  {id = "shutter_circle_2", op = {op.SHUTTER_ON}, loop = circle_start + circle_timer,  timer = 2, dst = {{time = circle_start, x = circle_2_x, y = circle_2_y - circle_move_y, angle = circle_turn, w = 788, h = 788, a = 0},
		-- 		{time = circle_start + circle_timer*1/5, y = circle_2_y + circle_move_y * (((5-1)/5)^2), angle = circle_turn * (((5-1)/5)^2), a = 255*1/5},
		-- 		{time = circle_start + circle_timer*2/5, y = circle_2_y + circle_move_y * (((5-2)/5)^2), angle = circle_turn * (((5-2)/5)^2), a = 255*2/5},
		-- 		{time = circle_start + circle_timer*3/5, y = circle_2_y + circle_move_y * (((5-3)/5)^2), angle = circle_turn * (((5-3)/5)^2), a = 255*3/5},
		-- 		{time = circle_start + circle_timer*4/5, y = circle_2_y + circle_move_y * (((5-4)/5)^2), angle = circle_turn * (((5-4)/5)^2), a = 255*4/5},
		-- 		{time = circle_start + circle_timer*5/5, y = circle_2_y + circle_move_y * (((5-5)/5)^2), angle = circle_turn * (((5-5)/5)^2), a = 255*5/5},}})

		-- table.insert(skin.destination,  {id = "shutter_right_2", op = {op.SHUTTER_ON}, loop = shutter_timer,  timer = 2, dst = {{time = 0, x = suntter_right_2_x, y = shutter_move_x * -0.5, w = 1362, h = 1080 + 202, a = 0},
		-- 		{time = shutter_timer*1/5, y = shutter_move_x * -0.5 * (((5-1)/5)^2), a = 255*1/5},
		-- 		{time = shutter_timer*2/5, y = shutter_move_x * -0.5 * (((5-2)/5)^2), a = 255*2/5},
		-- 		{time = shutter_timer*3/5, y = shutter_move_x * -0.5 * (((5-3)/5)^2), a = 255*3/5},
		-- 		{time = shutter_timer*4/5, y = shutter_move_x * -0.5 * (((5-4)/5)^2), a = 255*4/5},
		-- 		{time = shutter_timer*5/5, y = shutter_move_x * -0.5 * (((5-5)/5)^2), a = 255*5/5},}})
		table.insert(skin.destination,  {id = "shutter", loop = 1000, op = {op.SHUTTER_OFF}, timer = 2,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 1000, a = 255}}})
		
	end
	
	return skin
end

return {
	header = header,
	main = main
}
