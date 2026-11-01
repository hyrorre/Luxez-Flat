local skin_name = "Luxe_Flat"
local folder_name = "Luxe_Flat"
local resolution = {w = 1920, h = 1080}

function append_all(list, t)
	if t then
		for i, v in pairs(t) do
			table.insert(list, v)
		end
	end
end

main_state = require("main_state")
event_util = require("event_util")
timer_util = require("timer_util")
		
function load_parts()

	local PROPERTY_OP = 899
	local OFFSET_ID = 59
	local CUSTOMEVENT_ID = 999
	local CUSTOMTIMER_ID = 9999

	function get_property_op()
		PROPERTY_OP = PROPERTY_OP + 1
		return PROPERTY_OP
	end
			
	function get_offset_id()
		OFFSET_ID = OFFSET_ID + 1
		return OFFSET_ID
	end
	
	function get_customEvent_id()
		CUSTOMEVENT_ID = CUSTOMEVENT_ID + 1
		return CUSTOMEVENT_ID
	end
	
	function get_customTimer_id()
		CUSTOMTIMER_ID = CUSTOMTIMER_ID + 1
		return CUSTOMTIMER_ID
	end

	local skin = {
		type = 5,
		name = skin_name .. "(beta)",
		w = resolution.w,
		h = resolution.h,
		fadeout = 500,
		scene = 3000,
		input = 500,
	}
	
	skin.property = {
		
	}
	
	skin.filepath = {}
	
	skin.offset = {}

	skin.source = {}
	
	skin.font = {}
	
	skin.image = {}
	
	skin.imageset = {}
	
	skin.value = {}
	
	skin.text = {}

	skin.panel = {}

	skin.songlist = {}
	skin.songlist.id = nil
	skin.songlist.center = nil
	skin.songlist.clickable = {}
	skin.songlist.listoff = {}
	skin.songlist.liston = {}
	skin.songlist.text = {}
	skin.songlist.level = {}
	skin.songlist.lamp = {}
	skin.songlist.playerlamp = {}
	skin.songlist.rivallamp = {}
	skin.songlist.trophy = {}
	skin.songlist.label = {}
	skin.songlist.graph = nil
	
	skin.graph = {}

	skin.judgegraph = {}
	
	skin.bpmgraph = {}
	
	skin.slider = {}
	
	skin.customEvents = {}
	
	skin.customTimers = {}

	skin.destination = {}
	
	do
		local f = io.open("skin/" .. folder_name .. "/select_skinparts/enable.txt", "r")
		local load_log = io.open("skin/" .. folder_name .. "/select_skinparts/load_log.txt", "w")
		for l in f:lines() do
			load_log:write(l)
			local path = "skin/" .. folder_name .. "/select_skinparts/" .. l
			if skin_config then
				local parts_status, parts = pcall(function() return dofile(path).load() end)
				if parts_status and parts then
					if parts.bmzBattleInfo == true then skin.bmzBattleInfo = true end
					-- Mark only the two native base panels, not the rival picker or modal windows.
					local slot = l == "default_scoredata/parts.lua" and "sp"
						or ((l == "default_modebotton/parts.lua" or l == "default_irdata/parts.lua") and "dp")
					if slot then
						for _, destination in ipairs(parts.destination or {}) do
							local frame = destination.dst and destination.dst[1]
							if frame and frame.x and frame.y and
								((slot == "sp" and frame.x >= 709 and frame.x < 1123 and frame.y >= 266 and frame.y < 416)
								or (slot == "dp" and not destination.timer and not destination.loop and not destination.mouseRect
									and frame.x >= 302 and frame.x < 714 and frame.y >= 133 and frame.y < 417)) then
								destination.bmzBattleSlot = slot
							end
						end
					end
					if parts.bmzDetailOptions == 1 then
						skin.bmzDetailOptions = 1
						skin.bmzDetailOptionsNumbers = parts.bmzDetailOptionsNumbers == true
						skin.bmzDetailOptionsClose = parts.bmzDetailOptionsClose == true
					end
					append_all(skin.property, parts.property)
					append_all(skin.filepath, parts.filepath)
					append_all(skin.offset, parts.offset)
					append_all(skin.source, parts.source)
					append_all(skin.font, parts.font)
					append_all(skin.image, parts.image)
					append_all(skin.imageset, parts.imageset)
					append_all(skin.value, parts.value)
					append_all(skin.text, parts.text)
					append_all(skin.panel, parts.panel)
					append_all(skin.slider, parts.slider)
					if parts.songlist then
						skin.songlist.id = parts.songlist.id
						skin.songlist.center = parts.songlist.center
						append_all(skin.songlist.clickable, parts.songlist.clickable)
						append_all(skin.songlist.listoff, parts.songlist.listoff)
						append_all(skin.songlist.liston, parts.songlist.liston)
						append_all(skin.songlist.text, parts.songlist.text)
						append_all(skin.songlist.level, parts.songlist.level)
						append_all(skin.songlist.lamp, parts.songlist.lamp)
						append_all(skin.songlist.playerlamp, parts.songlist.playerlamp)
						append_all(skin.songlist.rivallamp, parts.songlist.rivallamp)
						append_all(skin.songlist.trophy, parts.songlist.trophy)
						append_all(skin.songlist.label, parts.songlist.label)
						skin.songlist.graph = parts.songlist.graph
					end				
					append_all(skin.graph, parts.graph)
					append_all(skin.judgegraph, parts.judgegraph)
					append_all(skin.bpmgraph, parts.bpmgraph)
					append_all(skin.customEvents, parts.customEvents)
					append_all(skin.customTimers, parts.customTimers)
					append_all(skin.destination, parts.destination)
					load_log:write("...OK\n")
				else
					load_log:write("...NG\n")
				end
			else
				local parts_status, parts = pcall(function() return dofile(path).parts end)
				if parts_status and parts then
					append_all(skin.property, parts.property)
					append_all(skin.filepath, parts.filepath)
					append_all(skin.offset, parts.offset)
					append_all(skin, parts)
					load_log:write("...OK\n")
				else
					load_log:write("...NG\n")
				end
			end
		end
		f:close()
		load_log:close()
	end
		
	-- Replace only this skin's legacy E2 destinations after successful loading.
	if skin.bmzDetailOptions == 1 then
		local destinations = {}
		for _, destination in ipairs(skin.destination) do
			if not destination.bmzLegacyAssist then
				table.insert(destinations, destination)
			end
		end
		skin.destination = destinations
	end
	-- Keep the original callbacks running: some update values used by other destinations.
	-- If the optional part fails or is disabled, leave both legacy panels untouched.
	if skin.bmzBattleInfo then
		for _, destination in ipairs(skin.destination) do
			if destination.bmzBattleSlot then
				local original, replace_for_dp = destination.draw, destination.bmzBattleSlot == "dp"
				destination.draw = function()
					local original_visible = not original or original()
					local mode = main_state.number(20208)
					local double = mode == 10 or mode == 14
					return original_visible and (not main_state.option(20200) or double ~= replace_for_dp)
				end
			end
		end
	end
	return skin
end

return {
	load_parts = load_parts
}
