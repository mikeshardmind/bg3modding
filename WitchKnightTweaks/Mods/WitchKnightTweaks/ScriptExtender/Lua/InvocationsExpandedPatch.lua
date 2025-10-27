
local shout_bind_props = [[ApplyEquipmentStatus(MainHand,PACT_BLADE,100, -1);
TARGET:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and ClassLevelHigherOrEqualThan(1,'Warlock') and not ClassLevelHigherOrEqualThan(7,'Warlock')):
ApplyEquipmentStatus(MainHand,IMPROVED_PACT_WEAPON_1,100, -1);
TARGET:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and ClassLevelHigherOrEqualThan(7,'Warlock') and not ClassLevelHigherOrEqualThan(12,'Warlock')):
ApplyEquipmentStatus(MainHand,IMPROVED_PACT_WEAPON_2,100, -1);
TARGET:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and ClassLevelHigherOrEqualThan(12,'Warlock')):ApplyEquipmentStatus(MainHand, IMPROVED_PACT_WEAPON_3,100, -1);
Target:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and (HasPassive('LHB_SanguineOffering_Unlock') or HasPassive('LHB_GreaterSanguineOffering_Unlock'))
 and ClassLevelHigherOrEqualThan(1,'Fighter') and not ClassLevelHigherOrEqualThan(7,'Fighter')
 and not ClassLevelHigherOrEqualThan(1,'Warlock'):ApplyEquipmentStatus(MainHand, IMPROVED_PACT_WEAPON_1,100, -1);
Target:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and (HasPassive('LHB_SanguineOffering_Unlock') or HasPassive('LHB_GreaterSanguineOffering_Unlock'))
 and ClassLevelHigherOrEqualThan(7,'Fighter') and not ClassLevelHigherOrEqualThan(12,'Fighter')
 and not ClassLevelHigherOrEqualThan(1,'Warlock'):ApplyEquipmentStatus(MainHand, IMPROVED_PACT_WEAPON_2,100, -1);
Target:IF(HasPassive('ImprovedPactWeapon') and not HasWeaponProperty(WeaponProperties.Magical,GetActiveWeapon())
 and (HasPassive('LHB_SanguineOffering_Unlock') or HasPassive('LHB_GreaterSanguineOffering_Unlock'))
 and ClassLevelHigherOrEqualThan(12,'Fighter')
 and not ClassLevelHigherOrEqualThan(1,'Warlock'):ApplyEquipmentStatus(MainHand, IMPROVED_PACT_WEAPON_3,100, -1);
]]

local replacements = {
  ["Shout_PactOfTheBlade_Bind"] = shout_bind_props
}


if Ext.Mod.IsModLoaded("67fbbd53-7c7d-4cfa-9409-6d737b4d92a9") then

  local function OnStatsLoaded()

    for spell_name, spell_properties in pairs(replacements) do

      local spell = Ext.Stats.Get(name)
      if spell ~= nil then
        spell:SetRawAttribute("SpellProperties", spell_properties)
      end
    end

  end

  Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)
end

