
local bard_guid = "92cd50b6-eb1b-4824-8adb-853e90c34c90"

local magical_secrets_select = {["BardMagicalSecrets"] = true}

---@class config
---@field enabled boolean
---@field with_scroll_learning boolean
---@field rituals_always_prepared boolean


local defaultConfig = {
    enabled = true,
    with_scroll_learning = false,
    rituals_always_prepared = true,
}

---@param filename string
---@return config
local function LoadConfig(filename)
    local file = Ext.IO.LoadFile(filename)
    local ret = file and Ext.Json.Parse(file) or {}

    for key, default in pairs(defaultConfig) do

        local expected_type = type(default)

        if type(ret[key]) == "nil" then
            ret[key] = default
        elseif type(ret[key]) ~= expected_type then
            ret.enabled = false
            return ret
        end
    end

    return ret

end

local function MagicalSecretsLists()

    local ret = {}
    local ids = {}
    local all_bard = ""
    for _, resourceGuid in pairs(Ext.StaticData.GetAll("ClassDescription")) do
        local desc = Ext.StaticData.Get(resourceGuid, "ClassDescription")
        if resourceGuid == bard_guid or desc.ParentGuid == bard_guid then
            ids[desc.ProgressionTableUUID] = true
        end

        if resourceGuid == bard_guid then
            all_bard = desc.SpellList
        end

    end

    for _, progguid in pairs(Ext.StaticData.GetAll("Progression")) do
        local pd = Ext.StaticData.Get(progguid, "Progression")
        if ids[pd.TableUUID] ~= nil then
            for _, this_select in ipairs(pd["SelectSpells"]) do
                if magical_secrets_select[this_select.SelectorId] ~= nil then
                    table.insert(ret, this_select.SpellUUID)
                end
            end
        end
    end

    return all_bard, ret
end

local list_cache = {}

function RemoveBardSpellsFromBardSecrets()

    local config = LoadConfig("BardicPreparation.json")
    if not config.enabled then return end

    local bard_list_id, secrets_lists_ids = MagicalSecretsLists()

    local bard_spell_list = {}
    if list_cache[bard_list_id] ~= nil then
        bard_spell_list = list_cache[bard_spell_list]
    else
        for _, spell_name in pairs(Ext.StaticData.Get(bard_list_id, "SpellList").Spells) do
            bard_spell_list[spell_name] = true
        end
        list_cache[bard_list_id] = bard_spell_list
    end


    for _, list_id in ipairs(secrets_lists_ids) do
        local SecretList = Ext.StaticData.Get(list_id, "SpellList")
        if list_cache[list_id] ~= nil then
            SecretList.Spells = list_cache[list_id]
        else
            local working_list = {}
            for idx, spell_name in pairs(SecretList.Spells) do
                if bard_spell_list[spell_name] == nil then
                    table.insert(working_list, spell_name)
                end
            end
            list_cache[list_id] = working_list
            SecretList.Spells = working_list
        end
    end
end

