local parts = {}

local function load()

	parts.property = {
		{name = "表示情報", item = {
			{name = "IR DATA（NETWORK OFF時のみJUDGE DETAIL）",		op = 900},
			{name = "JUDGE DETAIL",		op = 901},
		},def = "IR DATA（NETWORK OFF時のみJUDGE DETAIL）"},
	}

	parts.source = {
		{id = "number_1", path = "select_skinparts/default_commonparts/number1_resize.png"},
		{id = "number_1_small", path = "select_skinparts/default_commonparts/number1_resize_small.png"},
		{id = "number_alte", path = "select_skinparts/default_commonparts/number_alte_resize.png"},

	}
		
	parts.font = {
		{id = "font_VL-Gothic-Regular",	path = "select_skinparts/default_commonparts/font_ver1.2.0/VL-Gothic-Regular.ttf"},
		{id = "font_Title",	path = "select_skinparts/default_commonparts/font_ver1.2.0/font_Title/Title.fnt"},
		{id = "font_songlist",	path = "select_skinparts/default_commonparts/font_ver1.2.0/font_songlist/songlist.fnt"},
		{id = "font_sub",	path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub/sub.fnt"},
		{id = "font_sub_small",	path = "select_skinparts/default_commonparts/font_ver1.2.0/font_sub_small/sub_small.fnt"},

	}

	timer_nochart = {
		on	= get_customTimer_id(),
		off	= get_customTimer_id(),
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}