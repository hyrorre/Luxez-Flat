local parts = {}

local function load()
	
	local src1_id = "src-default-stateplayoption-parts"
	local parts_position = {x = 32, y = 0}
	--local parts_position = {x = 435, y = 0}
	
	parts.source = {
		{id = src1_id, path = "select_skinparts/default_stateplayoption/stateoption_resize.png"},
	}

	parts.image = {
		{id = "default_stateplayoption_bg",	src = src1_id, x = 0, y = 260, w = 1050, h = 65},
		{id = "default_stateplayoption_item_name",	src = src1_id, x = 0, y = 325, w = 1050, h = 65},
		-- random
		{id = "default_stateplayoption_random_1",	src = src1_id, x = 0, y = 0, w = 138, h = 21},
		{id = "default_stateplayoption_random_2",	src = src1_id, x = 0, y = 25, w = 138, h = 21},
		{id = "default_stateplayoption_random_3",	src = src1_id, x = 0, y = 50, w = 138, h = 21},
		{id = "default_stateplayoption_random_4",	src = src1_id, x = 0, y = 75, w = 138, h = 21},
		{id = "default_stateplayoption_random_5",	src = src1_id, x = 0, y = 100, w = 138, h = 21},
		{id = "default_stateplayoption_random_6",	src = src1_id, x = 0, y = 125, w = 138, h = 21},
		{id = "default_stateplayoption_random_7",	src = src1_id, x = 0, y = 150, w = 138, h = 21},
		{id = "default_stateplayoption_random_8",	src = src1_id, x = 0, y = 175, w = 138, h = 21},
		{id = "default_stateplayoption_random_9",	src = src1_id, x = 0, y = 200, w = 138, h = 21},
		{id = "default_stateplayoption_random_10",	src = src1_id, x = 0, y = 225, w = 138, h = 21},
		
		-- gauge
		{id = "default_stateplayoption_gauge_1",	src = src1_id, x = 150, y = 0, w = 96, h = 21},
		{id = "default_stateplayoption_gauge_2",	src = src1_id, x = 150, y = 25, w = 96, h = 21},
		{id = "default_stateplayoption_gauge_3",	src = src1_id, x = 150, y = 50, w = 96, h = 21},
		{id = "default_stateplayoption_gauge_4",	src = src1_id, x = 150, y = 75, w = 96, h = 21},
		{id = "default_stateplayoption_gauge_5",	src = src1_id, x = 150, y = 100, w = 96, h = 21},
		{id = "default_stateplayoption_gauge_6",	src = src1_id, x = 150, y = 125, w = 96, h = 21},

		-- dp
		{id = "default_stateplayoption_dp_1",		src = src1_id, x = 250, y = 0, w = 129, h = 21},
		{id = "default_stateplayoption_dp_2",		src = src1_id, x = 250, y = 25, w = 129, h = 21},
		{id = "default_stateplayoption_dp_3",		src = src1_id, x = 250, y = 50, w = 129, h = 21},
		{id = "default_stateplayoption_dp_4",		src = src1_id, x = 250, y = 75, w = 129, h = 21},
		
		-- speed
		{id = "default_stateplayoption_speed_1",	src = src1_id, x = 400, y = 0, w = 126, h = 21},
		{id = "default_stateplayoption_speed_2",	src = src1_id, x = 400, y = 25, w = 126, h = 21},
		{id = "default_stateplayoption_speed_3",	src = src1_id, x = 400, y = 50, w = 126, h = 21},
		{id = "default_stateplayoption_speed_4",	src = src1_id, x = 400, y = 75, w = 126, h = 21},
		{id = "default_stateplayoption_speed_5",	src = src1_id, x = 400, y = 100, w = 126, h = 21},
	}

	parts.imageset = {
		{id = "default_stateplayoption_option_random", ref = 42, images = {
			"default_stateplayoption_random_1","default_stateplayoption_random_2",
			"default_stateplayoption_random_3","default_stateplayoption_random_4",
			"default_stateplayoption_random_5","default_stateplayoption_random_6",
			"default_stateplayoption_random_7","default_stateplayoption_random_8",
			"default_stateplayoption_random_9","default_stateplayoption_random_10"
		}, act = 42},
		{id = "default_stateplayoption_option_gauge", ref = 40, images = {
			"default_stateplayoption_gauge_1","default_stateplayoption_gauge_2",
			"default_stateplayoption_gauge_3","default_stateplayoption_gauge_4",
			"default_stateplayoption_gauge_5","default_stateplayoption_gauge_6"
		}, act = 40},
		{id = "default_stateplayoption_option_dp", ref = 54, images = {
			"default_stateplayoption_dp_1","default_stateplayoption_dp_2",
			"default_stateplayoption_dp_3","default_stateplayoption_dp_4"
		}, act = 54},
		{id = "default_stateplayoption_option_hsfix", ref = 55, images = {
			"default_stateplayoption_speed_1","default_stateplayoption_speed_2",
			"default_stateplayoption_speed_3","default_stateplayoption_speed_4",
			"default_stateplayoption_speed_5"
		}, act = 55},
		{id = "default_stateplayoption_option_random2", ref = 43, images = {
			"default_stateplayoption_random_1","default_stateplayoption_random_2",
			"default_stateplayoption_random_3","default_stateplayoption_random_4",
			"default_stateplayoption_random_5","default_stateplayoption_random_6",
			"default_stateplayoption_random_7","default_stateplayoption_random_8",
			"default_stateplayoption_random_9","default_stateplayoption_random_10"
		}, act = 43}
	}

	parts.value = {
		{id = "default_stateplayoption_duration",		src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 4, ref = 312},
		{id = "default_stateplayoption_duration_green",	src = "number_alte", x = 0, y = 25, w = 140, h = 25, divx = 10, digit = 4, ref = 313},
	}
	
	parts.destination = {
		{id = "default_stateplayoption_bg",				dst = {{x = parts_position.x, y = parts_position.y, w = 1050, h = 65}}},
		{id = "default_stateplayoption_item_name",		dst = {{x = parts_position.x, y = parts_position.y, w = 1050, h = 65}}},
		
		{id = "default_stateplayoption_option_random",	dst = {{x = parts_position.x + 37, y = parts_position.y + 10, w = 138, h = 21}}},
		{id = "default_stateplayoption_option_gauge",	dst = {{x = parts_position.x + 222, y = parts_position.y + 10, w = 96, h = 21}}},
		{id = "default_stateplayoption_option_dp",		dst = {{x = parts_position.x + 349, y = parts_position.y + 10, w = 129, h = 21}}},			
		{id = "default_stateplayoption_option_hsfix",	dst = {{x = parts_position.x + 518, y = parts_position.y + 10, w = 126, h = 21}}},
		{id = "default_stateplayoption_option_random2",	dst = {{x = parts_position.x + 689, y = parts_position.y + 10, w = 138, h = 21}}},
		{id = "default_stateplayoption_duration",	dst = {{x = parts_position.x + 865, y = parts_position.y + 7, w = 14, h = 25}}},
		{id = "default_stateplayoption_duration_green",	dst = {{x = parts_position.x + 930, y = parts_position.y + 7, w = 14, h = 25}}},
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}