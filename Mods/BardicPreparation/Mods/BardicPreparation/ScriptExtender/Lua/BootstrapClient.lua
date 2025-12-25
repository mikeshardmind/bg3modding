Ext.Require("ListMod.lua")
Ext.Require("AMSE_compat.lua")


local function on_swap_level(event)
	if event.FromState == "LoadLevel" and event.ToState == "SwapLevel" then
		RemoveBardSpellsFromBardSecrets()
	end
end

Ext.Events.StatsLoaded:Subscribe(ModifyLists, {Priority = -100})
Ext.Events.StatsLoaded:Subscribe(RemoveBardSpellsFromBardSecrets, {Priority = -600})
Ext.Events.GameStateChanged:Subscribe(on_swap_level, {Priority = -600})
Ext.Events.ResetCompleted:Subscribe(RemoveBardSpellsFromBardSecrets, {Priority = -600})