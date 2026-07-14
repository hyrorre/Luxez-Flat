local parts = {}

local function load()

	local window_position = {x = 18, y = 905}

	parts.source = {{id = "src-default-search-parts", path = "select_skinparts/default_search/search_window_resize.png"},
					{id = "src-default-search-parts-2", path = "select_skinparts/default_search/search_area_ver1.2.0_rect.png"}}
	parts.image = {--{id = "default_search_window",	src = "src-default-search-parts", x = 0, y = 0, w = 350+36, h = 50+36},
					{id = "default_search_window",	src = "src-default-search-parts", x = 0, y = 0, w = 350+38, h = 50+38},
					{id = "default_search_window_rect",	src = "src-default-search-parts-2", x = 0, y = 0, w = 350, h = 50}}
	parts.text = {{id = "default_search_search", font = "font_VL-Gothic-Regular", size = 24, ref = 30}}
	
	parts.destination = {
		--{id = "default_search_window",	dst = {{x = window_position.x - 17, y = window_position.y - 18, w = 350+35, h = 50+36}}},
		{id = "default_search_window",	dst = {{x = window_position.x - 18, y = window_position.y - 19, w = 350+38, h = 50+38}}},
		{id = "default_search_window_rect",	dst = {{x = window_position.x, y = window_position.y, w = 350, h = 50}}, mouseRect = {x = 0, y = 0, w = 350, h = 50}},
		{id = "default_search_search",	dst = {{x = window_position.x + 64, y = window_position.y + 14, w = 326, h = 24}}}
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}