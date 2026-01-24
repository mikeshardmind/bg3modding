Ext.Require("ListMod.lua")

local function on_swap_level(event)
	if event.FromState == "LoadSession" and event.ToState == "LoadLevel" then
		SortLists()
	end
end

Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -50000})
Ext.Events.ResetCompleted:Subscribe(SortLists(), {Priority = -50000})