local parts = {}

parts.filepath = {
	{name = "ステージファイルが無い場合に表示する画像", path = "customize/no_stagefile_image/*"}
}

local function load()
	local parts_position = {x = 14, y = 660}
	
	parts.source = {
		{id = "image_back", path = "select_skinparts/default_stagefile/stagefile_back.png"},
		{id = "src-default-stagefile2-img", path = "customize/no_stagefile_image/*"},
	}
	
	parts.image = {
		{id = "default_stagefile2_img", src = "src-default-stagefile2-img", x = 0, y = 0, w = -1, h = -1},
		--{id = "image_back", src = "image_back", x = 0, y = 0, w = 297, h = 225},
		{id = "image_back", src = "image_back", x = 0, y = 0, w = 328, h = 256},
	}

	parts.destination = {		
		--{id = "image_back", timer = 11, op = {2,191}, dst = {{x = parts_position.x, y = parts_position.y, w = 297, h = 225}}},
		--{id = "image_back", timer = 11, op = {2,190}, dst = {{x = parts_position.x, y = parts_position.y, w = 297, h = 225}}},	
		{id = "image_back", timer = 11, op = {2,191}, dst = {{x = parts_position.x-15, y = parts_position.y-16, w = 328, h = 256}}},
		{id = "image_back", timer = 11, op = {2,190}, dst = {{x = parts_position.x-15, y = parts_position.y-16, w = 328, h = 256}}},	
		
		{id = "default_stagefile2_img", stretch = 1, filter = 1, op = {2,190}, dst = {{x = parts_position.x + 4, y = parts_position.y + 4, w = 297-8, h = 225-8}}},
		{id = -100, stretch = 1, filter = 1, timer = 11, loop = 250,  dst = {{time = 0, x = parts_position.x + 4, y = parts_position.y + 4, w = 297-8, h = 225-8, acc = 2, a = 0},{time = 250, a = 255}}},
	}				
	
	return parts	
end

return {
	parts = parts,
	load = load
}