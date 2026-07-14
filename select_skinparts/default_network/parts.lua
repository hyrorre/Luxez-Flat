local parts = {}

local function load()

	parts.source = {
		{id = "network_connection", path = "select_skinparts/default_network/network_resize.png"},
	}

	parts.image = {
		{id = "network_on",	src = "network_connection", x = 0, y = 0, w = 205, h = 60, ref = 89, act = 89, act = (function() return xxxx() end)},
		{id = "network_off",	src = "network_connection", x = 0, y = 60, w = 205, h = 60, ref = 90, act = 90, act = (function() return xxxx() end)},
	}	

	parts.text = {
		{id = "irname", font = "font_sub_small", size = 18, overflow = 1, ref = 1020, align = 2},
	}

	parts.destination = {
		{id = "network_on",			op = {51},	dst = {{x = 1700, y = 10, w = 205, h = 60}}},
		{id = "network_off",		op = {50},	dst = {{x = 1700, y = 10, w = 205, h = 60}}},
		{id = "irname", 			op = {51},	dst = {{x = 1882, y = 43, w = 140, h = 18}}},
	}

	return parts
end

return {
	parts = parts,
	load = load
}