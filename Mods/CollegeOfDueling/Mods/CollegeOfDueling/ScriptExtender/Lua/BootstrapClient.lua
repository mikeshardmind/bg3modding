function EnsureSubclass()
    local subclasses = Ext.StaticData.Get("26f64038-6033-48d5-9da7-38e8c95ce712", "Progression").SubClasses
    local set = {}
    for _, value in pairs(subclasses) do
        if value == "563d9b5c-1c61-421a-a4e6-25548ec900a6" then
            return
        end
        table.insert(set, value)
    end
    table.insert(set, "563d9b5c-1c61-421a-a4e6-25548ec900a6")
    Ext.StaticData.Get("26f64038-6033-48d5-9da7-38e8c95ce712", "Progression").SubClasses = set
end

local function IsHarmfulSingleTargetOrProjectileCantrip(sd)

    local is_spell = false
    local is_harmful = false

    local allowed_types = {
        ["Projectile"] = true,
        ["Target"] = true,
    }

    if not allowed_types[sd.SpellType] then return false end
    if #sd.WeaponTypes > 0 then return false end


    for _, flag in pairs(sd.SpellFlags) do
        if flag == "IsSpell" then is_spell = true end
        if flag == "IsHarmful" then is_harmful = true end
    end

    -- AmountOfTargets is annoying, exclude EB and similar intentionally.
    -- empty string = default (1)
    -- if it doesn't convert to a number, we assume a levelmapvalue or similar
    if type(sd.AmountOfTargets) == "string" and #sd.AmountOfTargets > 0 then
        local targets = tonumber(sd.AmountOfTargets)
        if targets == nil then return false end
        if targets > 1 then return false end
    end

    return sd.Level == 0 and is_spell and is_harmful

end

local cantrip_lists = {
    "3cae2e56-9871-4cef-bba6-96845ea765fa",  -- wiz
    "61f79a30-2cac-4a7a-b5fe-50c89d307dd6",  -- bard
    "485a68b4-c678-4888-be63-4a702efbe391",  -- sorcerer
    "2f43a103-5bf1-4534-b14f-663decc0c525",  -- cleric
    "b8faf12f-ca42-45c0-84f8-6951b526182a",  -- druid
    "f5c4af9c-5d8d-4526-9057-94a4b243cd40",  -- warlock
}

local our_list_id = "5a7a26ae-8ec1-4d74-b3a6-d8384ae854bb"


function ModifyCantripList()

    local seen = {}
    local found = {}

    for _, list_id in ipairs(cantrip_lists) do
        local spelllist = Ext.StaticData.Get(list_id, "SpellList").Spells
        for _, name in pairs(spelllist) do
            if seen[name] == nil then
                local s = Ext.Stats.Get(name)
                local ok, result = pcall(IsHarmfulSingleTargetOrProjectileCantrip, s)
                if ok and result then table.insert(found, name) end
            end
            seen[name] = true
        end
    end

    table.sort(found)

    local our_list = Ext.StaticData.Get(our_list_id, "SpellList")
    our_list.Spells = found

end

Ext.Events.StatsLoaded:Subscribe(EnsureSubclass, {Priority = -1})
Ext.Events.StatsLoaded:Subscribe(ModifyCantripList, {Priority = -1})