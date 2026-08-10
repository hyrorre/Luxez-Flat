local parts = {}

local function load()
	
	local src1_id = "src-default-stateplayoption-parts"
	local random_bmz_src_id = "src-default-stateplayoption-random-bmz"
	local parts_position = {x = 32, y = 0}
	--local parts_position = {x = 435, y = 0}
	
	parts.source = {
		{id = src1_id, path = "select_skinparts/default_stateplayoption/stateoption_resize.png"},
		{id = random_bmz_src_id, path = "select_skinparts/default_stateplayoption/random_bmz.png"},
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
		{id = "default_stateplayoption_random_11",	src = random_bmz_src_id, x = 0, y = 0, w = 138, h = 21},
		{id = "default_stateplayoption_random_12",	src = random_bmz_src_id, x = 0, y = 21, w = 138, h = 21},
		
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
		{id = "default_stateplayoption_random", ref = 344, images = {
			"default_stateplayoption_random_1",
			"default_stateplayoption_random_2",
			"default_stateplayoption_random_3",
			"default_stateplayoption_random_4",
			"default_stateplayoption_random_5",
			"default_stateplayoption_random_6",
			"default_stateplayoption_random_7",
			"default_stateplayoption_random_8",
			"default_stateplayoption_random_9",
			"default_stateplayoption_random_10",
			"default_stateplayoption_random_11",
			"default_stateplayoption_random_12",
		}},
		{id = "default_stateplayoption_random_2p", ref = 345, images = {
			"default_stateplayoption_random_1",
			"default_stateplayoption_random_2",
			"default_stateplayoption_random_3",
			"default_stateplayoption_random_4",
			"default_stateplayoption_random_5",
			"default_stateplayoption_random_6",
			"default_stateplayoption_random_7",
			"default_stateplayoption_random_8",
			"default_stateplayoption_random_9",
			"default_stateplayoption_random_10",
			"default_stateplayoption_random_11",
			"default_stateplayoption_random_12",
		}},
		{id = "default_stateplayoption_option_gauge", ref = 40, images = {
			"default_stateplayoption_gauge_1",
			"default_stateplayoption_gauge_2",
			"default_stateplayoption_gauge_3",
			"default_stateplayoption_gauge_4",
			"default_stateplayoption_gauge_5",
			"default_stateplayoption_gauge_6",
		}},
		{id = "default_stateplayoption_option_dp", ref = 54, images = {
			"default_stateplayoption_dp_1",
			"default_stateplayoption_dp_2",
			"default_stateplayoption_dp_3",
			"default_stateplayoption_dp_4",
		}},
		{id = "default_stateplayoption_option_hsfix", ref = 55, images = {
			"default_stateplayoption_speed_1",
			"default_stateplayoption_speed_2",
			"default_stateplayoption_speed_3",
			"default_stateplayoption_speed_4",
			"default_stateplayoption_speed_5",
		}},
	}

	parts.value = {
		{id = "default_stateplayoption_duration",		src = "number_alte", x = 0, y = 0, w = 140, h = 25, divx = 10, digit = 4, ref = 312},
		{id = "default_stateplayoption_duration_green",	src = "number_alte", x = 0, y = 25, w = 140, h = 25, divx = 10, digit = 4, ref = 313},
	}

	parts.panel = {
		{id = "bmz_select_option_hit", color = "00000000"}
	}

	parts.destination = {
		{id = "default_stateplayoption_bg",				dst = {{x = parts_position.x, y = parts_position.y, w = 1050, h = 65}}},
		{id = "default_stateplayoption_item_name",		dst = {{x = parts_position.x, y = parts_position.y, w = 1050, h = 65}}},
		{id = "default_stateplayoption_duration",	dst = {{x = parts_position.x + 865, y = parts_position.y + 7, w = 14, h = 25}}},
		{id = "default_stateplayoption_duration_green",	dst = {{x = parts_position.x + 930, y = parts_position.y + 7, w = 14, h = 25}}},
		{id = "default_stateplayoption_random",	dst = {{x = parts_position.x + 37, y = parts_position.y + 10, w = 138, h = 21}}},
		{id = "default_stateplayoption_option_gauge",	dst = {{x = parts_position.x + 222, y = parts_position.y + 10, w = 96, h = 21}}},
		{id = "default_stateplayoption_option_dp",	dst = {{x = parts_position.x + 349, y = parts_position.y + 10, w = 129, h = 21}}},
		{id = "default_stateplayoption_option_hsfix",	dst = {{x = parts_position.x + 518, y = parts_position.y + 10, w = 126, h = 21}}},
		{id = "default_stateplayoption_random_2p",	dst = {{x = parts_position.x + 689, y = parts_position.y + 10, w = 138, h = 21}}},
	}

	local function append_option_hit(act, x, w)
		table.insert(parts.destination, {id = "bmz_select_option_hit", act = act, dst = {{x = x, y = parts_position.y + 10, w = w, h = 21}}})
	end
	append_option_hit(42, parts_position.x + 37, 138)
	append_option_hit(40, parts_position.x + 222, 96)
	append_option_hit(54, parts_position.x + 349, 129)
	append_option_hit(55, parts_position.x + 518, 126)
	append_option_hit(43, parts_position.x + 689, 138)

	return parts
end

return {
	parts = parts,
	load = load
}
