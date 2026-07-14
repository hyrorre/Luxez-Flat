local parts = {}

local OP_SHUTTER_OFF =	get_property_op()
local OP_SHUTTER_ON =	get_property_op()

parts.filepath = {
	{name = "シャッター画像",			path = "customize/shutter/*.png"},
	{name = "シャッターフレーム", path = "result/png/shutter/*.png",def = "shutter_default"},
}

parts.property = {
	{name = "シャッター演出", item = {
		{name = "OFF",		op = OP_SHUTTER_OFF},
		{name = "ON",		op = OP_SHUTTER_ON},
	},def = "ON"},
}

local function load()

	parts.source = {
		{id = "black", path = "select_skinparts/default_shutter/black.png"},
		{id = "shutter_frame", path = "result/png/shutter/*.png"},
		{id = "shutter_background",	path = "customize/shutter/*.png"},
	}
	
	parts.image = {
		{id = "shutter", src = "black", x = 0, y = 0, w = 1, h = 1},
		{id = "shutter_left",	src = "shutter_frame", x = 0, y = 0, w = 1920, h = 1080},
		{id = "shutter_right",	src = "shutter_frame", x = 0, y = 1080, w = 1920, h = 1080},
		{id = "shutter_bar_left_1",	src = "shutter_frame", x = 0, y = 1080 * 2, w = 695, h = 695},
		{id = "shutter_bar_right_1",	src = "shutter_frame", x = 0, y = 1080 * 2 + 695, w = 1289, h = 1080},
		{id = "shutter_circle_1",	src = "shutter_frame", x = 0, y = 3935, w = 1522, h = 1522},
		{id = "shutter_circle_2",	src = "shutter_frame", x = 0, y = 5456, w = 788, h = 788},
		{id = "shutter_background",	src = "shutter_background", x = 0, y = 0, w = 1920, h = 1080},
	}

	--シャッター開始時間
	shutter_start = 500

	-- シャッター稼働時間
	shutter_timer = 700/2
		
	-- シャッター移動距離
	shutter_move_x = 500

	-- シャッター右x
	shutter_right_x = 0

	-- シャッター右2x
	suntter_right_2_x = 575 - 16 + 24

	-- バー1稼働開始時間
	bar_1_start = -300/2

	-- バー1稼働時間
	bar_1_timer = 600/2

	-- バー1右x
	bar_1_right_x = 710

	-- 円稼働開始時間
	circle_start = -200/2

	-- 円稼働時間
	circle_timer = 700/2

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

	parts.destination = {
			{id = "shutter_background", op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
					{time = shutter_start},
					{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*4/5},
					{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*3/5},
					{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*2/5},
					{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*1/5},
					{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*0/5},}},
			{id = "shutter_left", op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
					{time = shutter_start},		
					{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -1 * (((5-4)/5)^2), a = 255*4/5},
					{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -1 * (((5-3)/5)^2), a = 255*3/5},
					{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -1 * (((5-2)/5)^2), a = 255*2/5},
					{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -1 * (((5-1)/5)^2), a = 255*1/5},
					{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -1 * (((5-0)/5)^2), a = 255*0/5},}},
			{id = "shutter_right",	op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_right_x + shutter_move_x * 1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
					{time = shutter_start},		
					{time = shutter_start + shutter_timer*1/5, x = shutter_right_x + shutter_move_x * 1 * (((5-4)/5)^2), a = 255*4/5},
					{time = shutter_start + shutter_timer*2/5, x = shutter_right_x + shutter_move_x * 1 * (((5-3)/5)^2), a = 255*3/5},
					{time = shutter_start + shutter_timer*3/5, x = shutter_right_x + shutter_move_x * 1 * (((5-2)/5)^2), a = 255*2/5},
					{time = shutter_start + shutter_timer*4/5, x = shutter_right_x + shutter_move_x * 1 * (((5-1)/5)^2), a = 255*1/5},
					{time = shutter_start + shutter_timer*5/5, x = shutter_right_x + shutter_move_x * 1 * (((5-0)/5)^2), a = 255*0/5},}},
			{id = "shutter_bar_left_1", op = {OP_SHUTTER_ON}, loop = shutter_start + bar_1_start + bar_1_timer, dst = {{time = 0, x = -695 * (((5-5)/5)^2), y = (1080 - 695) - 695 * (((5-5)/5)^2), w = 695, h = 695, a = 255},
					{time = shutter_start + bar_1_start},	
					{time = shutter_start + bar_1_start + bar_1_timer*1/5, x = -695 * (((5-4)/5)^2), y = (1080 - 695) - 695 * (((5-4)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*2/5, x = -695 * (((5-3)/5)^2), y = (1080 - 695) - 695 * (((5-3)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*3/5, x = -695 * (((5-2)/5)^2), y = (1080 - 695) - 695 * (((5-2)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*4/5, x = -695 * (((5-1)/5)^2), y = (1080 - 695) - 695 * (((5-1)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*5/5, x = -695 * (((5-0)/5)^2), y = (1080 - 695) - 695 * (((5-0)/5)^2)},}},
			{id = "shutter_bar_right_1", op = {OP_SHUTTER_ON}, loop = shutter_start + bar_1_start + bar_1_timer, dst = {{time = 0, x = bar_1_right_x + 1080 * (((5-5)/5)^2), y = 1080 * (((5-5)/5)^2), w = 1289, h = 1080, a = 255},
					{time = shutter_start + bar_1_start},			
					{time = shutter_start + bar_1_start + bar_1_timer*1/5, x = bar_1_right_x + 1080 * (((5-4)/5)^2), y = 1080 * (((5-4)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*2/5, x = bar_1_right_x + 1080 * (((5-3)/5)^2), y = 1080 * (((5-3)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*3/5, x = bar_1_right_x + 1080 * (((5-2)/5)^2), y = 1080 * (((5-2)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*4/5, x = bar_1_right_x + 1080 * (((5-1)/5)^2), y = 1080 * (((5-1)/5)^2)},
					{time = shutter_start + bar_1_start + bar_1_timer*5/5, x = bar_1_right_x + 1080 * (((5-0)/5)^2), y = 1080 * (((5-0)/5)^2)},}},		
			{id = "shutter_circle_1", op = {OP_SHUTTER_ON}, loop = shutter_start + circle_start + circle_timer, dst = {{time = 0, x = circle_1_x, y = circle_1_y - circle_move_y * (((5-5)/5)^3), w = 1522, h = 1522, a = 255},
					{time = shutter_start + circle_start},	
					{time = shutter_start + circle_start + circle_timer*1/5, y = circle_1_y - circle_move_y * (((5-4)/5)^3), a = 255*4/5},
					{time = shutter_start + circle_start + circle_timer*2/5, y = circle_1_y - circle_move_y * (((5-3)/5)^3), a = 255*3/5},
					{time = shutter_start + circle_start + circle_timer*3/5, y = circle_1_y - circle_move_y * (((5-2)/5)^3), a = 255*2/5},
					{time = shutter_start + circle_start + circle_timer*4/5, y = circle_1_y - circle_move_y * (((5-1)/5)^3), a = 255*1/5},
					{time = shutter_start + circle_start + circle_timer*5/5, y = circle_1_y - circle_move_y * (((5-0)/5)^3), a = 255*0/5},}},
			{id = "shutter_circle_2", op = {OP_SHUTTER_ON}, loop = shutter_start + circle_start + circle_timer, dst = {{time = 0, x = circle_2_x, y = circle_2_y + circle_move_y * (((5-5)/5)^3), w = 788, h = 788, a = 255},
					{time = shutter_start + circle_start},	
					{time = shutter_start + circle_start + circle_timer*1/5, y = circle_2_y + circle_move_y * (((5-4)/5)^3), a = 255*4/5},
					{time = shutter_start + circle_start + circle_timer*2/5, y = circle_2_y + circle_move_y * (((5-3)/5)^3), a = 255*3/5},
					{time = shutter_start + circle_start + circle_timer*3/5, y = circle_2_y + circle_move_y * (((5-2)/5)^3), a = 255*2/5},
					{time = shutter_start + circle_start + circle_timer*4/5, y = circle_2_y + circle_move_y * (((5-1)/5)^3), a = 255*1/5},
					{time = shutter_start + circle_start + circle_timer*5/5, y = circle_2_y + circle_move_y * (((5-0)/5)^3), a = 255*0/5},}},
			{id = "shutter", op = {OP_SHUTTER_OFF}, loop = 300, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255},{time = 300, a = 0}}},
	}	
	
	-- parts.destination = {
	-- 		{id = "shutter_background", op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 				{time = shutter_start},
	-- 				{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -0.3 * (((5-4)/5)^2), a = 255*4/5},
	-- 				{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -0.3 * (((5-3)/5)^2), a = 255*3/5},
	-- 				{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -0.3 * (((5-2)/5)^2), a = 255*2/5},
	-- 				{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -0.3 * (((5-1)/5)^2), a = 255*1/5},
	-- 				{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -0.3 * (((5-0)/5)^2), a = 255*0/5},}},
	-- 		{id = "shutter_left", op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 				{time = shutter_start},		
	-- 				{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -1 * (((5-4)/5)^2), a = 255*4/5},
	-- 				{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -1 * (((5-3)/5)^2), a = 255*3/5},
	-- 				{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -1 * (((5-2)/5)^2), a = 255*2/5},
	-- 				{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -1 * (((5-1)/5)^2), a = 255*1/5},
	-- 				{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -1 * (((5-0)/5)^2), a = 255*0/5},}},
	-- 		{id = "shutter_right",	op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_right_x + shutter_move_x * 1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 				{time = shutter_start},		
	-- 				{time = shutter_start + shutter_timer*1/5, x = shutter_right_x + shutter_move_x * 1 * (((5-4)/5)^2), a = 255*4/5},
	-- 				{time = shutter_start + shutter_timer*2/5, x = shutter_right_x + shutter_move_x * 1 * (((5-3)/5)^2), a = 255*3/5},
	-- 				{time = shutter_start + shutter_timer*3/5, x = shutter_right_x + shutter_move_x * 1 * (((5-2)/5)^2), a = 255*2/5},
	-- 				{time = shutter_start + shutter_timer*4/5, x = shutter_right_x + shutter_move_x * 1 * (((5-1)/5)^2), a = 255*1/5},
	-- 				{time = shutter_start + shutter_timer*5/5, x = shutter_right_x + shutter_move_x * 1 * (((5-0)/5)^2), a = 255*0/5},}},
	-- 		{id = "shutter_right_2", op = {OP_SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = suntter_right_2_x, y = shutter_move_x * -0.5 * (((5-5)/5)^2), a = 255*5/5, w = 1362, h = 1080 + 202},
	-- 				{time = shutter_start},		
	-- 				{time = shutter_start + shutter_timer*1/5, y = shutter_move_x * -0.5 * (((5-4)/5)^2), a = 255*4/5},
	-- 				{time = shutter_start + shutter_timer*2/5, y = shutter_move_x * -0.5 * (((5-3)/5)^2), a = 255*3/5},
	-- 				{time = shutter_start + shutter_timer*3/5, y = shutter_move_x * -0.5 * (((5-2)/5)^2), a = 255*2/5},
	-- 				{time = shutter_start + shutter_timer*4/5, y = shutter_move_x * -0.5 * (((5-1)/5)^2), a = 255*1/5},
	-- 				{time = shutter_start + shutter_timer*5/5, y = shutter_move_x * -0.5 * (((5-0)/5)^2), a = 255*0/5},}},
	-- 		 {id = "shutter", op = {OP_SHUTTER_OFF}, loop = 300, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255},{time = 300, a = 0}}},
	-- }	

	-- do
	-- 	table.insert(parts.destination,  {id = "shutter_background", op = {op.SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -0.3 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 			{time = shutter_start},
	-- 			{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -0.3 * (((5-4)/5)^2), a = 255*4/5},
	-- 			{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -0.3 * (((5-3)/5)^2), a = 255*3/5},
	-- 			{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -0.3 * (((5-2)/5)^2), a = 255*2/5},
	-- 			{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -0.3 * (((5-1)/5)^2), a = 255*1/5},
	-- 			{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -0.3 * (((5-0)/5)^2), a = 255*0/5},}})
	-- 	table.insert(parts.destination,  {id = "shutter_left", op = {op.SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_move_x * -1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 			{time = shutter_start},		
	-- 			{time = shutter_start + shutter_timer*1/5, x = shutter_move_x * -1 * (((5-4)/5)^2), a = 255*4/5},
	-- 			{time = shutter_start + shutter_timer*2/5, x = shutter_move_x * -1 * (((5-3)/5)^2), a = 255*3/5},
	-- 			{time = shutter_start + shutter_timer*3/5, x = shutter_move_x * -1 * (((5-2)/5)^2), a = 255*2/5},
	-- 			{time = shutter_start + shutter_timer*4/5, x = shutter_move_x * -1 * (((5-1)/5)^2), a = 255*1/5},
	-- 			{time = shutter_start + shutter_timer*5/5, x = shutter_move_x * -1 * (((5-0)/5)^2), a = 255*0/5},}})
	-- 	table.insert(parts.destination,  {id = "shutter_right",	op = {op.SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = shutter_right_x + shutter_move_x * 1 * (((5-5)/5)^2), a = 255*5/5, y = 0, w = 1920, h = 1080},
	-- 			{time = shutter_start},		
	-- 			{time = shutter_start + shutter_timer*1/5, x = shutter_right_x + shutter_move_x * 1 * (((5-4)/5)^2), a = 255*4/5},
	-- 			{time = shutter_start + shutter_timer*2/5, x = shutter_right_x + shutter_move_x * 1 * (((5-3)/5)^2), a = 255*3/5},
	-- 			{time = shutter_start + shutter_timer*3/5, x = shutter_right_x + shutter_move_x * 1 * (((5-2)/5)^2), a = 255*2/5},
	-- 			{time = shutter_start + shutter_timer*4/5, x = shutter_right_x + shutter_move_x * 1 * (((5-1)/5)^2), a = 255*1/5},
	-- 			{time = shutter_start + shutter_timer*5/5, x = shutter_right_x + shutter_move_x * 1 * (((5-0)/5)^2), a = 255*0/5},}})
	-- 	table.insert(parts.destination,  {id = "shutter_right_2", op = {op.SHUTTER_ON}, loop = shutter_start + shutter_timer, dst = {{time = 0, x = suntter_right_2_x, y = shutter_move_x * -0.5 * (((5-5)/5)^2), a = 255*5/5, w = 1362, h = 1080 + 202},
	-- 			{time = shutter_start},		
	-- 			{time = shutter_start + shutter_timer*1/5, y = shutter_move_x * -0.5 * (((5-4)/5)^2), a = 255*4/5},
	-- 			{time = shutter_start + shutter_timer*2/5, y = shutter_move_x * -0.5 * (((5-3)/5)^2), a = 255*3/5},
	-- 			{time = shutter_start + shutter_timer*3/5, y = shutter_move_x * -0.5 * (((5-2)/5)^2), a = 255*2/5},
	-- 			{time = shutter_start + shutter_timer*4/5, y = shutter_move_x * -0.5 * (((5-1)/5)^2), a = 255*1/5},
	-- 			{time = shutter_start + shutter_timer*5/5, y = shutter_move_x * -0.5 * (((5-0)/5)^2), a = 255*0/5},}})
	-- 	table.insert(skin.destination,  {id = "shutter", op = {op.SHUTTER_OFF}, loop = 3000, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255},{time = 3000, a = 0}}})
	-- end
	
	return parts	
end

return {
	parts = parts,
	load = load
}