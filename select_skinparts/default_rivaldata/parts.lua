local parts = {}

local function load()

	local pos = {x = 333, y = 198}
	
	parts.source = {
		{id = "rival_select", path = "select_skinparts/default_rivaldata/rival_name_resize.png"},
	}
	
	parts.image = {
		{id = "rival_name_panel",	src = "rival_select",	x = 0, y = 0, w = 225, h = 35, act = 79, click = 2},
		{id = "rival_name_panel_rect",	src = "rival_select",	x = 0, y = 35, w = 225, h = 35},
		{id = "rival_name_panel_rect_left",	src = "rival_select",	x = 0, y = 70, w = 112, h = 35},
		{id = "rival_name_panel_rect_right",	src = "rival_select",	x = 112, y = 70, w = 113, h = 35},
	}
	
	parts.text = {
		{id = "default_rivaldata_rivalname",	font = "font_sub_small", align = 1, ref = 1, size = 18, overflow = 1},
		{id = "default_rivaldata_rivalselect",	font = "font_sub_small", size = 18, align = 1, constantText = "ライバル選択"},
	}
	
	parts.destination = {
		{id = "rival_name_panel",	op = {51}, dst = {{x = 1304, y = 1004, w = 225, h = 35}}},
		{id = "rival_name_panel_rect",	op = {51}, dst = {{x = 1304, y = 1004, w = 225, h = 35}}, mouseRect = {x = 0, y = 0, w = 225, h = 35}},
		{id = "rival_name_panel_rect_left",	op = {51}, dst = {{x = 1304, y = 1004, w = 112, h = 35}}, mouseRect = {x = 0, y = 0, w = 112, h = 35}},
		{id = "rival_name_panel_rect_right",	op = {51}, dst = {{x = 1416, y = 1004, w = 113, h = 35}}, mouseRect = {x = 0, y = 0, w = 113, h = 35}},

		{id = "default_rivaldata_rivalname",			filter = 1, op = {51, 625}, dst = {{x = 1416, y = 1010+1, w = 180, h = 18}}},
		{id = "default_rivaldata_rivalselect",			filter = 1, op = {51, -625}, dst = {{x = 1416, y = 1010+1, w = 180, h = 18}}},
	}
	
	return parts
end

return {
	parts = parts,
	load = load
}