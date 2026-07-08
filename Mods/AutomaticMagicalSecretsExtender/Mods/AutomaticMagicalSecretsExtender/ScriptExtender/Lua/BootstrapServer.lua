Ext.Require("ListMod.lua")

local function on_swap_level(event)
	if event.FromState == "LoadSession" and event.ToState == "LoadLevel" then
		ModifyLists()
	end
end

Ext.Events.GameStateChanged:Subscribe(on_swap_level, { Priority = -200 })
Ext.Events.ResetCompleted:Subscribe(ModifyLists, { Priority = -200 })

-- Speculative fix for https://discord.com/channels/1174823496086470716/1436049814180859974/1524458123006447796
-- I've never seen this issue myself, and am not tracking it down right now, but I *assume* there's a caching issue.
Ext.Events.ResetCompleted:Subscribe(ClearCaches)
