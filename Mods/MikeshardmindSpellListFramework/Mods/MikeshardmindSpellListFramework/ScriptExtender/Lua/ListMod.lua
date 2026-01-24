

local fname = "MikeshardmindSpellListFramework.json"

---@type table<string, boolean>
local spell_exists_cache = {}

---@class SortEntry
---@field Level number
---@field Name string

---@type table<string, SortEntry>
local sortv_cache = {}


---@param spell_name string
---@param spell any
local function generate_sort_key_for_spell(spell_name, spell)

    if sortv_cache[spell_name] ~= nil then
        return true
    end

    local translated_name = Ext.Loca.GetTranslatedString(spell.DisplayName)
    local sort_name = (translated_name or "") .. spell_name

    sortv_cache[spell_name] = {["Level"] = spell.Level, ["Name"] = sort_name}
    return true
end


---@param name string
---@return boolean
local function CheckSpellExists(name)
    local ret = spell_exists_cache[name]
    if ret ~= nil then return ret end
    local spell = Ext.Stats.Get(name)
    if spell then
        generate_sort_key_for_spell(name, spell)
        spell_exists_cache[name] = true
        return true
    end
    spell_exists_cache[name] = false
    return false
end


local function sort_func(a, b)
    local lhs = sortv_cache[a]
    local rhs = sortv_cache[b]

    if lhs.Level ~= rhs.Level then
        return lhs.Level > rhs.Level
    end
    return lhs.Name < rhs.Name
end

---@return table?
function LoadConfig()
    local file = Ext.IO.LoadFile(fname)
    return file and Ext.Json.Parse(file)
end


---@param config table
---@return string[][]?
function LoadSimpleBest(config)
    local replace_list = config["replace_with_best"]
    if not replace_list then return nil end

    local ret = {}

    for _, rule in ipairs(replace_list) do
        local rule_spells = {}
        for _, spell_name in ipairs(rule) do
            if CheckSpellExists(spell_name) then
                table.insert(rule_spells, spell_name)
            end
        end
        if #rule_spells > 1 then
            table.insert(ret, rule_spells)
        end
    end

    if #ret > 0 then return ret end
end

---@param config table
---@return string[][]?
function LoadSimpleDedupe(config)

    local dedupe_list = config["deduplicate"]
    if not dedupe_list then return nil end

    local ret = {}

    for _, rule in ipairs(dedupe_list) do
        local rule_spells = {}
        for _, spell_name in ipairs(rule) do
            if CheckSpellExists(spell_name) then
                table.insert(rule_spells, spell_name)
            end
        end
        if #rule_spells > 1 then
            table.insert(ret, rule_spells)
        end
    end

    if #ret > 0 then return ret end
end

---@param config table
---@return table<string, boolean>?
function LoadSimpleRemove(config)
    local removals = config["remove"]
    if not removals then return nil end

    local ret = {}

    for _, spell_name in ipairs(removals) do
        if CheckSpellExists(spell_name) then
            ret[spell_name] = true
        end
    end

    if #ret > 0 then return ret end

end

---@param best string[][]
---@param spell_list string[]
---@return string[]
function ApplyBest(best, spell_list)

    for _, rule in ipairs(best) do
        local index = {}

        for idx, spell_name in ipairs(rule) do
            index[spell_name] = idx
        end

        local seen_any = false

        local working_list = {}

        for _, spell_name in ipairs(spell_list) do
            local priority = index[spell_name]
            if priority == nil then
                table.insert(working_list, spell_name)
            else
                seen_any = true
            end
        end
        if seen_any then table.insert(working_list, rule[1]) end
        spell_list = working_list
    end

    return spell_list
end

---@param dedupe string[][]
---@param spell_list string[]
---@return string[]
function ApplyDedupe(dedupe, spell_list)

    for _, rule in ipairs(dedupe) do
        local index = {}

        for idx, spell_name in ipairs(rule) do
            index[spell_name] = idx
        end

        local best_seen_index = #rule + 1

        local working_list = {}

        for _, spell_name in ipairs(spell_list) do
            local priority = index[spell_name]
            if priority == nil then table.insert(working_list, spell_name) end
            best_seen_index = (best_seen_index > priority) and priority or best_seen_index
        end

        local best = rule[best_seen_index]
        if best then table.insert(working_list, best) end

        spell_list = working_list
    end

    return spell_list
end

---@param removals table<string, boolean>
---@param list string[]
function ApplyRemovals(removals, list)

    local working_list = {}
    for _, spell_name in ipairs(list) do
        if not removals[spell_name] then
            table.insert(working_list, spell_name)
        end
    end
    return working_list
end


function ModifyLists()

    local config = LoadConfig()
    local ok, best_rules = pcall(LoadSimpleBest, config)
    best_rules = ok and best_rules or nil
    local ok, dedupe_rules = pcall(LoadSimpleDedupe, config)
    dedupe_rules = ok and dedupe_rules or nil
    local ok, removal_rules = pcall(LoadSimpleRemove, config)
    removal_rules = ok and removal_rules or nil

    for _, uuid in Ext.StaticData.GetAll("SpellList") do
        local spell_list = Ext.StaticData.Get(uuid, "SpellList")
        if spell_list then

            local working_list = {}
            for _, spell in pairs(spell_list.Spells) do
                if CheckSpellExists(spell) then
                    table.insert(working_list, spell)
                end
            end
            if best_rules then
                working_list = ApplyBest(best_rules, working_list)
            end
            if dedupe_rules then
                working_list = ApplyDedupe(dedupe_rules, working_list)
            end
            if removal_rules then
                working_list = ApplyRemovals(removal_rules, working_list)
            end

            table.sort(working_list, sort_func)
            spell_list.Spells = working_list
        end
    end
end

function SortLists()
    for _, uuid in Ext.StaticData.GetAll("SpellList") do
        local spell_list = Ext.StaticData.Get(uuid, "SpellList")
        if spell_list then
            local working_list = {}

            for _, spell in pairs(spell_list.Spells) do
                if CheckSpellExists(spell) then
                    table.insert(working_list, spell)
                end
            end

            table.sort(working_list, sort_func)
            spell_list.Spells = working_list
        end

    end
end
