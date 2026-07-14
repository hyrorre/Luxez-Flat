local parts = {}

local function load()
	parts.source = {
			{id = "src-default-favorite-parts", path = "select_skinparts/default_favorite/favorite_resize.png"},
		}
		
	parts.image = {
		{id = "default_favoritesong_button",	src = "src-default-favorite-parts", x = 200, y = 0, w = 200, h = 90, divy = 3, len = 3, ref = 89, act = 89},
		{id = "default_favoritechart_button",	src = "src-default-favorite-parts", x = 0, y = 0, w = 200, h = 90, divy = 3, len = 3, ref = 90, act = 90},
		{id = "default_favorite_button_rect",	src = "src-default-favorite-parts", x = 0, y = 90, w = 200, h = 30}
	}	
	
	local fsbutton_x = 450
	local fsbutton_y = 935-20
	local fcbutton_y = 898-20
	
	parts.destination = {
		{id = "default_favoritesong_button",	dst = {{x = fsbutton_x, y = fsbutton_y, w = 200, h = 30}}},
		{id = "default_favorite_button_rect", op = {2},	dst = {{x = fsbutton_x, y = fsbutton_y, w = 200, h = 30}}, mouseRect = {x = 0, y = 0, w = 200, h = 30}},
		{id = "default_favoritechart_button",	dst = {{x = fsbutton_x, y = fcbutton_y, w = 200, h = 30}}},
		{id = "default_favorite_button_rect", op = {2},	dst = {{x = fsbutton_x, y = fcbutton_y, w = 200, h = 30}}, mouseRect = {x = 0, y = 0, w = 200, h = 30}},
	}	
	
	return parts	
end

return {
	parts = parts,
	load = load
}