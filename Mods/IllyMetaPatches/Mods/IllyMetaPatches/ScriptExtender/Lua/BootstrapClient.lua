Ext.Require("datadumper.lua")
Ext.Require("ListSort.lua")



local function on_swap_level(event)
	if event.FromState == "LoadLevel" and event.ToState == "SwapLevel" then
		ModifyLists()
	end
end

Ext.Events.StatsLoaded:Subscribe(ModifyLists, {Priority = -300})
Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -300})
Ext.Events.ResetCompleted:Subscribe(ModifyLists, {Priority = -300})