local filename = "MikeshardmindSpellSniper.json"

---@class config
---@field allow_multitarget_cantrips boolean
---@field allow_weapon_cantrips boolean
---@field containers string
---@field mode string

local defaultConfig = {
    allow_multitarget_cantrips = true,
    allow_weapon_cantrips = true,
    containers = "match_any",
    mode = "extend",
}

local invalid_config_messages = {
    ["boolean"] = '[SpellSniper] Invalid entry for key "%s" (expected: true or false) in config file, disabling mod',
    ["mode"] =  '[SpellSniper] Invalid entry for key "mode" (expected: "extend" or "replace") in config file, disabling mod',
    ["containers"] = '[SpellSniper] Invalid entry for key "containers" (expected: "match_any", "match_all", or "skip") in config file, disabling mod',
}

local string_values = {
    ["mode"] = {
        ["extend"] = true, ["replace"] = true
    },
    ["containers"] = {
        ["match_any"] = true,
        ["match_all"] = true,
        ["skip"] = true,
    },
}

---@return config|nil
local function LoadConfig()
    local file = Ext.IO.LoadFile(filename)
    local ret = file and Ext.Json.Parse(file) or {}

    local needs_rewrite = false

    for key, default in pairs(defaultConfig) do

        local expected_type = type(default)

        if type(ret[key]) == "nil" then
            ret[key] = default
            needs_rewrite = true
        elseif type(ret[key]) ~= expected_type then
            if expected_type == "string" then
                Ext.Utils.PrintWarning(invalid_config_messages[key])
            else
                Ext.Utils.PrintWarning(invalid_config_messages[expected_type]:format(key))
            end
            return nil
        elseif expected_type == "string" then
            if not string_values[key][ret[key]] then
                Ext.Utils.PrintWarning(invalid_config_messages[key])
                return nil
            end
        end

    end

    if needs_rewrite then
        local d = Ext.Json.Stringify(ret)
        Ext.IO.SaveFile(filename, d)
    end

    return ret

end

local function InnerIsValidCantrip(sd, config)

    local is_spell = false
    local is_harmful = false

    for _, flag in pairs(sd.SpellFlags) do
        if flag == "IsSpell" then is_spell = true end
        if flag == "IsHarmful" then is_harmful = true end
    end

    local allowed_types = {
        ["Projectile"] = true,
        ["Target"] = true,
    }

    if not allowed_types[sd.SpellType] then return false end

    local allowed_spell_rolls = {
        ["Attack(AttackType.RangedSpellAttack)"] = true,
        ["Attack(AttackType.MeleeSpellAttack)"] = true,
    }

    if config.allow_weapon_cantrips then
        allowed_spell_rolls["Attack(AttackType.RangedWeaponAttack)"] = true
        allowed_spell_rolls["Attack(AttackType.MeleeWeaponAttack)"] = true
    else
        if #sd.WeaponTypes > 0 then return false end
    end

    if not allowed_spell_rolls[sd.SpellRoll.Default] then return false end

    if not config.allow_multitarget_cantrips then
        if type(sd.AmountOfTargets) == "string" and #sd.AmountOfTargets > 0 then
            local targets = tonumber(sd.AmountOfTargets)
            if targets == nil then return false end
            if targets > 1 then return false end
        end
    end

    return sd.Level == 0 and is_spell and is_harmful

end

local function IsValidCantrip(sd, config)

    if #sd.ContainerSpells > 0 then
        if config.containers == "skip" then
            return false
        else
            local any = config.containers == "match_any"
            local all = config.containers == "match_all"

            for name in sd.ContainerSpells:gmatch("([^;]+)") do
                local spell = Ext.Stats.Get(name)
                local ok, result = pcall(InnerIsValidCantrip, spell, config)
                if ok and result then
                    if any then return true end
                elseif all then return false
                end
            end
        end
        return false
    end

    return InnerIsValidCantrip(sd, config)
end

local cantrip_lists = {
    "3cae2e56-9871-4cef-bba6-96845ea765fa",  -- wiz
    "61f79a30-2cac-4a7a-b5fe-50c89d307dd6",  -- bard
    "485a68b4-c678-4888-be63-4a702efbe391",  -- sorcerer
    "2f43a103-5bf1-4534-b14f-663decc0c525",  -- cleric
    "b8faf12f-ca42-45c0-84f8-6951b526182a",  -- druid
    "f5c4af9c-5d8d-4526-9057-94a4b243cd40",  -- warlock
}

local our_list_id = "64784e08-e31e-4850-a743-ecfb3fd434d7"


function ModifyCantripList()

    local config = LoadConfig()
    if not config then
        return
    end
    local our_list = Ext.StaticData.Get(our_list_id, "SpellList")

    local seen = {}
    local found = {}

    if config.mode == "extend" then
        for _, name in pairs(our_list.Spells) do
            if seen[name] == nil then table.insert(found, name) end
            seen[name] = true
        end
    end


    for _, list_id in ipairs(cantrip_lists) do
        local spelllist = Ext.StaticData.Get(list_id, "SpellList").Spells
        for _, name in pairs(spelllist) do
            if seen[name] == nil then
                local s = Ext.Stats.Get(name)
                local ok, result = pcall(IsValidCantrip, s, config)
                if ok and result then table.insert(found, name) end
            end
            seen[name] = true
        end
    end

    table.sort(found)

    our_list.Spells = found

end

Ext.Events.StatsLoaded:Subscribe(ModifyCantripList, {Priority = -1})