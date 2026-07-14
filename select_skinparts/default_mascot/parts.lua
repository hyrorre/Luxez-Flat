local parts = {}	

local PROPERTY_NAME_MASCOT = "マスコットの表示"
local OP_MASCOT_OFF =	get_property_op()
local OP_MASCOT_STOP =	get_property_op()
local OP_MASCOT_JUMP =	get_property_op()
local OP_MASCOT_FLOAT =	get_property_op()
local OP_MASCOT_ROARING =	get_property_op()
local OP_MASCOT_GAMING =	get_property_op()
local OP_MASCOT_MOCHI =	get_property_op()

parts.property = {
	{name = PROPERTY_NAME_MASCOT, item = {
		{name = "OFF",		op = OP_MASCOT_OFF},
		{name = "停止",		op = OP_MASCOT_STOP},
		{name = "ジャンプ",	op = OP_MASCOT_JUMP},
		{name = "浮遊",		op = OP_MASCOT_FLOAT},
		{name = "回転",		op = OP_MASCOT_ROARING},
		{name = "ゲーミング",		op = OP_MASCOT_GAMING},
		{name = "もち",		op = OP_MASCOT_MOCHI},
	},def = "ジャンプ"},
}

parts.filepath = {
	{name = "マスコットの種類", path = "customize/mascot/*.png"},
}
	
local function load()
		
	-- マスコットの表示
	local mascot_x = 16
	local mascot_y = 150
	local mascot_w = 256
	local mascot_h = 256

	parts.source = {
		{id = "src-default-mascot-mascot", path = "customize/mascot/*.png"},
	}
	
	parts.image = {
		{id = "default_mascot_mascot", src = "src-default-mascot-mascot", x = 0, y = 0, w = -1, h = -1},
	}
	
	parts.destination = {
		{id = "default_mascot_mascot", filter = 1, op = {OP_MASCOT_STOP}, dst = {
			{x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h}
		}},
			
		{id = "default_mascot_mascot", filter = 1, loop = 0, op = {OP_MASCOT_JUMP}, dst = {
			{time = 0, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h, acc = 2},
			{time = 100, h = mascot_h - 8, acc = 1},
			{time = 350, y = mascot_y + 17,	h = mascot_h, acc = 1},
			{time = 400, y = mascot_y + 18,	h = mascot_h, acc = 1},
			{time = 450, y = mascot_y + 17,	h = mascot_h, acc = 1},
			{time = 650, y = mascot_y, h = mascot_h},
			{time = 725, y = mascot_y, h = mascot_h - 6, acc = 1},
			{time = 800, y = mascot_y, h = mascot_h, acc = 2},
			{time = 4000},				
		}},
		
		{id = "default_mascot_mascot", filter = 1, loop = 0, op = {OP_MASCOT_FLOAT}, dst = {
			{time = 0, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h, acc = 2},
			{time = (12*500/90)*1.3, y = mascot_y+2},
			{time = (23*500/90)*1.3, y = mascot_y+4},
			{time = (37*500/90)*1.3, y = mascot_y+6},
			{time = (53*500/90)*1.3, y = mascot_y+8},
			{time = (90*500/90)*1.3, y = mascot_y+10},
			{time = (1000 - 53*500/90)*1.3, y = mascot_y+8},
			{time = (1000 - 37*500/90)*1.3, y = mascot_y+6},
			{time = (1000 - 23*500/90)*1.3, y = mascot_y+4},
			{time = (1000 - 12*500/90)*1.3, y = mascot_y+2},
			{time = (1000)*1.3, y = mascot_y},

			{time = (12*500/90 + 1000)*1.3, y = mascot_y-2},
			{time = (23*500/90 + 1000)*1.3, y = mascot_y-4},
			{time = (37*500/90 + 1000)*1.3, y = mascot_y-6},
			{time = (53*500/90 + 1000)*1.3, y = mascot_y-8},
			{time = (90*500/90 + 1000)*1.3, y = mascot_y-10},
			{time = (1000 - 53*500/90 + 1000)*1.3, y = mascot_y-8},
			{time = (1000 - 37*500/90 + 1000)*1.3, y = mascot_y-6},
			{time = (1000 - 23*500/90 + 1000)*1.3, y = mascot_y-4},
			{time = (1000 - 12*500/90 + 1000)*1.3, y = mascot_y-2},
			{time = (2000)*1.3, y = mascot_y},
		}},

		{id = "default_mascot_mascot", filter = 1, loop = 0, op = {OP_MASCOT_ROARING}, dst = {
			{time = 0, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h, angle = 0},
			{time = 10000, angle = -360},
		}},

		{id = "default_mascot_mascot", filter = 1, loop = 0, op = {OP_MASCOT_GAMING}, dst = {
			{time = 0, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h, acc = 2, r = (255*3/3)/2+127, g = (255*1/3)/2+127, b = (255*1/3)/2+127},
			{time = 60*1, r = (255*2/3)/2+127, g = (255*0/3)/2+127, b = (255*2/3)/2+127},
			{time = 60*2, r = (255*1/3)/2+127, g = (255*1/3)/2+127, b = (255*3/3)/2+127},
			{time = 60*3, r = (255*0/3)/2+127, g = (255*2/3)/2+127, b = (255*2/3)/2+127},
			{time = 60*4, r = (255*1/3)/2+127, g = (255*3/3)/2+127, b = (255*1/3)/2+127},
			{time = 60*5, r = (255*2/3)/2+127, g = (255*2/3)/2+127, b = (255*0/3)/2+127},
			{time = 60*6, r = (255*3/3)/2+127, g = (255*1/3)/2+127, b = (255*1/3)/2+127},
		}},

		{id = "default_mascot_mascot", filter = 1, loop = 0, op = {OP_MASCOT_MOCHI}, dst = {
			{time = 0, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h},
			{time = 200*1, x = mascot_x+8, y = mascot_y, w = mascot_w-16, h = mascot_h+32},
			{time = 200*2, x = mascot_x+8+4, y = mascot_y, w = mascot_w-16-8, h = mascot_h+32+16},
			{time = 200*3, x = mascot_x+8+4+2, y = mascot_y, w = mascot_w-16-8-4, h = mascot_h+32+16+8},
			{time = 200*4, x = mascot_x+8+4+2+1, y = mascot_y, w = mascot_w-16-8-4-2, h = mascot_h+32+16+8+4},
			{time = 200*5, x = mascot_x+8+4+2+1, y = mascot_y, w = mascot_w-16-8-4-2, h = mascot_h+32+16+8+4+2},
			{time = 200*6, x = mascot_x+8+4+2+1, y = mascot_y, w = mascot_w-16-8-4-2, h = mascot_h+32+16+8+4+2+1},
			{time = 200*7, x = mascot_x+8+4+2+1, y = mascot_y, w = mascot_w-16-8-4-2, h = mascot_h+32+16+8+4+2},
			{time = 200*8, x = mascot_x+8+4+2+1, y = mascot_y, w = mascot_w-16-8-4-2, h = mascot_h+32+16+8+4},
			{time = 200*9, x = mascot_x+8+4+2, y = mascot_y, w = mascot_w-16-8-4, h = mascot_h+32+16+8},
			{time = 200*10, x = mascot_x+8+4, y = mascot_y, w = mascot_w-16-8, h = mascot_h+32+16},
			{time = 200*11, x = mascot_x+8, y = mascot_y, w = mascot_w-16, h = mascot_h+32},
			{time = 200*12, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h},
			{time = 200*13, x = mascot_x-16, y = mascot_y, w = mascot_w+32, h = mascot_h-16},
			{time = 200*14, x = mascot_x-16-8, y = mascot_y, w = mascot_w+32+16, h = mascot_h-16-8},
			{time = 200*15, x = mascot_x-16-8-4, y = mascot_y, w = mascot_w+32+16+8, h = mascot_h-16-8-4},
			{time = 200*16, x = mascot_x-16-8-4-2, y = mascot_y, w = mascot_w+32+16+8+4, h = mascot_h-16-8-4-2},
			{time = 200*17, x = mascot_x-16-8-4-2-1, y = mascot_y, w = mascot_w+32+16+8+4+2, h = mascot_h-16-8-4-2},
			{time = 200*18, x = mascot_x-16-8-4-2-1, y = mascot_y, w = mascot_w+32+16+8+4+2+1, h = mascot_h-16-8-4-2},
			{time = 200*19, x = mascot_x-16-8-4-2-1, y = mascot_y, w = mascot_w+32+16+8+4+2, h = mascot_h-16-8-4-2},
			{time = 200*20, x = mascot_x-16-8-4-2, y = mascot_y, w = mascot_w+32+16+8+4, h = mascot_h-16-8-4-2},
			{time = 200*21, x = mascot_x-16-8-4, y = mascot_y, w = mascot_w+32+16+8, h = mascot_h-16-8-4},
			{time = 200*22, x = mascot_x-16-8, y = mascot_y, w = mascot_w+32+16, h = mascot_h-16-8},
			{time = 200*23, x = mascot_x-16, y = mascot_y, w = mascot_w+32, h = mascot_h-16},
			{time = 200*24, x = mascot_x, y = mascot_y, w = mascot_w, h = mascot_h},

		}},


	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}