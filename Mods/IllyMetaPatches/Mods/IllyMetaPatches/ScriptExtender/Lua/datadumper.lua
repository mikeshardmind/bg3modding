

--[[
word of radiance
hand of radiance
create bonfire
frostbite
infestation
magic stone
primal savagery
thunderclap
larloch's minor drain
lightning lure
sword burst
sapping sting
]]


--[[
local data = {}
for _, z in pairs(Ext.StaticData.GetAll("SpellDefaultValues")) do
  local default = Ext.StaticData.Get(z, "SpellDefaultValues")
  data[z] = Ext.Json.Parse(Ext.DumpExport(default))
end
Ext.IO.SaveFile("spellpreps.json", Ext.Json.Stringify(data))
]]--

Static_data_names = {
    "SkillDefaultValues",
    "AbilityDistributionPresets",
    "SkillDefaultValues",
    "PreparedSpellDefaultValues",
    "SpellDefaultValues",
    "EquipmentDefaultValues",
}

local function dump_name(name)
    local data = {}
    for _, resource_id in pairs(Ext.StaticData.GetAll(name)) do
        local default = Ext.StaticData.Get(resource_id, name)
        data[resource_id] = Ext.Json.Parse(Ext.DumpExport(default))
    end
    Ext.IO.SaveFile("StaticDataDump/" .. name .. ".json", Ext.Json.Stringify(data))
end

function Dump_interesting_static_data(_, name)

    if name ~= nil then
        dump_name(name)
    else
        for _, name in ipairs(Static_data_names) do
            dump_name(name)
        end
    end
end

Ext.RegisterConsoleCommand("staticdump", Dump_interesting_static_data)