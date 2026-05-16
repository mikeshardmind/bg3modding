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

    sortv_cache[spell_name] = { ["Level"] = spell.Level, ["Name"] = sort_name }
    return true
end

---@param name string
---@return boolean
function CheckSpellExists(name)
    local ret = spell_exists_cache[name]
    if ret ~= nil then return ret end
    local spell = Ext.Stats.Get(name)
    if spell then
        -- Bad Spell Data, see oldest @ https://www.nexusmods.com/baldursgate3/mods/21017?tab=bugs
        -- Wish nexus allowed linking directly to a bug
        local ok = pcall(generate_sort_key_for_spell, name, spell)
        spell_exists_cache[name] = ok
        return ok
    end
    spell_exists_cache[name] = false
    return false
end

---@param a string
---@param b string
---@return boolean
function SpellSortFunc(a, b)
    local lhs = sortv_cache[a]
    local rhs = sortv_cache[b]

    if lhs.Level ~= rhs.Level then
        return lhs.Level > rhs.Level
    end
    return lhs.Name < rhs.Name
end
