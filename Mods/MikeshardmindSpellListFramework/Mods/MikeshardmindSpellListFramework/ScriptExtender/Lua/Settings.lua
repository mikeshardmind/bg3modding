Ext.Require("Utils.lua")

---@class (exact) SLFrameworkUserConfig
---@field user_rule_namespaces string[]
---@field active_user_rules string[]
---@field inactive_user_rules string[]
---@field active_mod_provided_rules string[]
---@field inactive_mod_provided_rules string[]
---@field use_mod_provided_settings string[]

---@class (exact) SLFrameworkModConfig
---@field default_enabled_rules string[]

---@type SLFrameworkUserConfig
local default_user_settings = {
    user_rule_namespaces = {"examples"},
    active_user_rules = {},
    inactive_user_rules = {"examples.BladeCantrips"},
    active_mod_provided_rules = {},
    inactive_mod_provided_rules = {},
    use_mod_provided_settings = {"*"},
}

---@return boolean
local function is_alphanum_string_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
        if t[i]:match("%W") then return false end
    end
    return true
end

---@return boolean
local function is_array_of_dot_sep_strings(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
        local lhs , rhs = t[i]:match("^([%w]+)%.([%w]+)$")
        if not (lhs and rhs) then return false end
    end
    return true
end

local uuid_pattern = table.concat({
    ("%x"):rep(8),
    ("%x"):rep(4),
    ("%x"):rep(4),
    '89ab' .. ("%x"):rep(3),
    ("%x"):rep(12)
}, '%-')

local uuid_dotsep_match = "^(" ..uuid_pattern.. ")%.([%w]+)$"

---@return boolean
local function is_uuid_dotsep_name_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
        local lhs , rhs = t[i]:match(uuid_dotsep_match)
        if not (lhs and rhs) then return false end
    end
    return true

end


---@return boolean
local function is_string_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if type(t[i]) ~= "string" then return false end
    end
    return true
end

local expected_type_validators = {
    user_rule_namespaces = is_alphanum_string_array,
    active_user_rules = is_array_of_dot_sep_strings,
    inactive_user_rules = is_array_of_dot_sep_strings,
    active_mod_provided_rules = is_uuid_dotsep_name_array,
    inactive_mod_provided_rules = is_uuid_dotsep_name_array,
    use_mod_provided_settings = is_string_array,
}

local fatal_config_format = [[
[SpellListFramework]Invalid settings in %s
Error: %s
Mod will not take effect.
]]

local expected_type_error_messages = {
    user_rule_namespaces = "user_rule_namespaces should be a list of strings",
    active_user_rules = "active_user_rules should be a list of strings",
    inactive_user_rules = "inactive_user_rules should be a list of strings",
    active_mod_provided_rules = "active_mod_provided_rules should be a list of strings",
    inactive_mod_provided_rules = "active_mod_provided_rules should be a list of strings",
    use_mod_provided_settings = "use_mod_provided_settings should be a list of strings",
}

---@return SLFrameworkUserConfig
function LoadUserSettings()
    WriteExamples()
    local mod_dir = Ext.Mod.GetMod("c78d58b7-2bc5-4a13-975c-cd7cf9a42630").Info.Directory
    local filename = mod_dir .. "/user_settings.json"
    local needs_rewrite = false

    local file = Ext.IO.LoadFile(filename)
    local loaded = file and Ext.Json.Parse(file) or nil

    ---@type SLFrameworkUserConfig
    local ret = DeepCopy(default_user_settings)

    if not loaded then
        needs_rewrite = true
    else
        for key, _ in pairs(default_user_settings) do
            if type(ret[key]) == "nil" then
                needs_rewrite = true
            elseif not expected_type_validators[key](ret[key]) then
                local msg = fatal_config_format:format(filename, expected_type_error_messages[key])
                error(msg)
            end
        end
    end

    if needs_rewrite then
        local d = Ext.Json.Stringify(ret)
        Ext.IO.SaveFile(filename, d)
    end

    return ret
end

---@param rule_file_name string
---@return string
function GetUserRuleFilePath(rule_file_name)
    local mod_dir = Ext.Mod.GetMod("c78d58b7-2bc5-4a13-975c-cd7cf9a42630").Info.Directory
    return ("%s/user_rules/%s.txt"):format(mod_dir, rule_file_name)
end


---@param mod_id string
---@return string?
function GetModProvidedRuleFilePath(mod_id)
    local mod = Ext.Mod.GetMod(mod_id)
    if not mod then return nil end
    local mod_dir = mod.Info.Directory
    return ("%s/SpellListFrameworkRules.txt"):format(mod_dir)
end


---@param mod_id string
---@return string?
function GetModProvidedConfigPath(mod_id)
    local mod = Ext.Mod.GetMod(mod_id)
    if not mod then return nil end
    local mod_dir = mod.Info.Directory
    return ("%s/SpellListFramework.json"):format(mod_dir)
end


local example_text = [[
[rulegroup]
name: BladeCantrips
description: Add Blade Cantrips to anyone with any blade cantrip, trimming to preferences
has_any: Target_BoomingBlade_5e, Target_BoomingBlade, Target_Sparking_Blade, Target_GreenFlameBlade, Target_BoomingBladeMove, Target_GreenFlameBlade
add: Target_BoomingBlade_5e, Target_BoomingBlade, Target_Sparking_Blade, Target_GreenFlameBlade, Target_BoomingBladeMove, Target_GreenFlameBlade
prefer: Target_BoomingBlade_5e, Target_BoomingBlade, Target_BoomingBladeMove, Target_BoomingBlade_ClassSpell

[rulegroup]
name: MindSliver
description: prefer mindsliver from 5eSpells, then Spells Extra, then Mystra's Spells
prefer: Target_MindSliver, Target_LHB_SEL_Mind_Sliver, Projectile_MindSliver
]]

function WriteExamples()
    local filename = GetUserRuleFilePath("examples")
    local file = Ext.IO.LoadFile(filename)
    if not file or file == "" then
        Ext.IO.SaveFile(filename, example_text)
    end
end


local mod_provided_config_validators = {
    default_enabled_rules = is_alphanum_string_array,
}

local mod_key_errors = {
    default_enabled_rules = "default_enabled_rules should be a list of strings"
}

local warn_mod_config_format = [[
[SpellListFramework]Invalid settings provided by mod with id %s
Error: %s
Mod provided settings cannot be applied
]]

---@param uuid string
---@return SLFrameworkModConfig?
local function parse_mod_provided_settings(uuid)

    local filename = GetModProvidedConfigPath(uuid)
    if not filename then return end

    local file = Ext.IO.LoadFile(filename)
    if not file or file == "" then return end

    local loaded = file and Ext.Json.Parse(file)
    if not loaded then return end

    ---@type SLFrameworkModConfig
    local ret = {default_enabled_rules = {}}

    for k, v in pairs(loaded) do
        local validator = mod_provided_config_validators[k]
        if validator then
            if validator(v) then
                ret[k] = v
            else
                local msg = warn_mod_config_format:format(uuid, mod_key_errors[k])
                Ext.Utils.PrintWarning(msg)
                return nil
            end
        end
        -- otherwise, assume possible evolution, don't error for extra keys
    end

    return ret


end


---@param user_config SLFrameworkUserConfig
---@return table<string, string[]>
function GetEnabledModRules(user_config)
    ---@type table<string, string[]>
    local ret = {}

    local all = false
    for _, v in ipairs(user_config.use_mod_provided_settings) do
        if v == "*" then all = true end
    end

    ---@type table<string, SLFrameworkModConfig>
    local collected = {}

    if all then
        for _, uuid in pairs(Ext.Mod.GetLoadOrder()) do
            local filename = GetModProvidedConfigPath(uuid)
            local config = Ext.IO.LoadFile(filename)
            if config and config ~= "" then
                collected[uuid] = parse_mod_provided_settings(config)
            end
        end
    else
        for _, uuid in ipairs(user_config.use_mod_provided_settings) do
            local mod = Ext.GetMod(uuid)
            if mod then
                local filename = GetModProvidedConfigPath(uuid)
                local config = Ext.IO.LoadFile(filename)
                if config and config ~= "" then
                    collected[uuid] = parse_mod_provided_settings(config)
                end
            end
        end
    end

    local disabled = {}
    for _, rule in ipairs(user_config.inactive_mod_provided_rules) do
        local uuid, rulename = rule:match(uuid_dotsep_match)
        if uuid and rulename then
            local rd = disabled[uuid] or {}
            rd[rulename] = true
            disabled[uuid] = rd
        end

    end

    local seen = {}

    for uuid, settings in pairs(collected) do
        ret[uuid] = {}
        seen[uuid] = {}
        for _, rule in ipairs(settings.default_enabled_rules) do
            if not (disabled[uuid] and disabled[uuid][rule]) then
                table.insert(ret[uuid], rule)
                seen[uuid][rule] = true
            end
        end
    end

    for _, rule in ipairs(user_config.active_mod_provided_rules) do
        local uuid, rulename = rule:match(uuid_dotsep_match)
        if uuid and rulename then
            if not (uuid[seen] and uuid[seen][rulename]) then
                local rd = ret[uuid] or {}
                table.insert(rd, rulename)
                ret[uuid] = rd
            end
        end
    end

    return ret
end