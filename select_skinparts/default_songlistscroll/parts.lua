local parts = {}

local function load()
	
	local parts_position = {x = 1868, y = 190}
	
	parts.source = {
		{id = "src-default-songlistscroll2-parts", path = "select_skinparts/default_songlistscroll/parts.png"},
		{id = "song_scroll_frame", path = "select_skinparts/default_songlistscroll/songscroll_resize.png"},
		{id = "song_scroll_cursor", path = "select_skinparts/default_songlistscroll/songscroll_cursor_resize.png"},
	}
	parts.image = {{id = "song_scroll_frame", src = "song_scroll_frame", x = 0, y = 0, w = 52, h = 714, act = (function() return xxxx() end)}}
	parts.slider = {
		{id = "song_scroll_cursor", src = "song_scroll_cursor", x = 0, y = 0, w = 64, h = 64, angle = 2, range = 512, type = 1, changeable = false},
		{id = "default_songlistscroll2_collision", src = "song_scroll_cursor", x = 0, y = 64, w = 64, h = 64, angle = 2, range = 512, type = 1},
	}
	parts.destination = {
		{id = "song_scroll_frame", dst = {{x = parts_position.x, y = parts_position.y, w = 52, h = 714}}},
		{id = "song_scroll_cursor", loop = 0, blend = 2, dst = {{time = 0, x = parts_position.x - 5, y = parts_position.y + 560, w = 64, h = 64, a = 255},{time = 350, a = 180},{time = 400, a = 255}}},
		{id = "default_songlistscroll2_collision", dst = {{time = 0, x = parts_position.x - 5, y = parts_position.y + 560, w = 64, h = 64}}},
	}
	
	return parts
end

return {
	parts = parts,
	load = load
}