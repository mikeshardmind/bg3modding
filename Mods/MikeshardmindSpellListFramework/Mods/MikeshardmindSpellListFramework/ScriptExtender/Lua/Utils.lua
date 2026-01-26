
-- Contains structural typing for the fields used
-- not comprehensive, despite listing (exact) as it's intended
-- to limit api surface I should both use and care about

---@class (exact) ExtStaticData_SpellSelector
---@field SpellUUID string

---@class (exact) ExtStaticData_UUIDSelector
---@field UUID string

---@class (exact) ExtStaticData_Progression
---@field AddSpells ExtStaticData_SpellSelector[]
---@field SelectSpells ExtStaticData_SpellSelector[]
---@field PassivesAdded string
---@field SelectPassives ExtStaticData_UUIDSelector[]
---@field TableUUID string

---@class (exact) ExtStaticData_ClassDescription
---@field ProgressionTableUUID string

---@class (exact) ExtStaticData_SpellList
---@field Spells string[]

---@overload fun(kind: "ClassDescription"): fun(): string, ExtStaticData_ClassDescription
---@overload fun(kind: "Progression"): fun(): string, ExtStaticData_Progression
---@overload fun(kind: "SpellList"): fun(): string, ExtStaticData_SpellList
function StaticDataIterator(kind)
    local co = coroutine.create(
        function()
            for _, uuid in pairs(Ext.StaticData.GetAll(kind)) do
                coroutine.yield(uuid, Ext.StaticData.Get(uuid, kind))
            end
        end
    )
    return function()
        local ok, uuid, data = coroutine.resume(co)
        return uuid, data
    end
end

---@class (Exact) ExtStaticData_PassiveList
---@field Passives string[]


---@param uuid string
---@return ExtStaticData_PassiveList?
function GetExtPassiveList(uuid)
    return Ext.StaticData.Get(uuid, "PassiveList")
end


---@class (exact) ExtStats_PassiveData
---@field Boosts string

---@overload fun(kind: "PassiveData"): fun(): string, ExtStats_PassiveData
function StatsIterator(kind)
    local co = coroutine.create(
        function()
            for _, name in pairs(Ext.Stats.GetStats(kind)) do
                local stats = Ext.Stats.Get(name)
                if stats then
                    coroutine.yield(name, stats)
                end
            end
        end
    )
    return function()
        local ok, name, stats = coroutine.resume(co)
        return name, stats
    end
end


---@generic T
---@param t T
---@return T
function DeepCopy(t)
    local typ = type(t)

    if typ == "thread" then error("unsupported type") end
    if typ == "userdata" then error("unsupported type") end
    if typ ~= "table" then return t end

    local ret = {}
    for k, v in pairs(t) do
        ret[k] = DeepCopy(v)
    end
    return ret
end

---@param s string
---@param sep string
---@param plain boolean?
function StringSplit(s, sep, plain)
   local start = 1
   local done = false
   local function pass(i, j, ...)
      if i then
         local seg = s:sub(start, i - 1)
         start = j + 1
         return seg, ...
      else
         done = true
         return s:sub(start)
      end
   end
   return function()
      if done then
         return
       end
      if sep == '' then
         done = true
         return s
      end
      return pass(s:find(sep, start, plain))
   end
end


local function pattern_escape(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

---@param s string
---@return string
function Trim(s)
    return s:match("^%s*(.-)%s*$")
end

---@param s string
---@param target string
---@param replacement string
---@return string
function PlainReplace(s, target, replacement)
    local tr = pattern_escape(target)
    local rr = replacement:gsub("%%", "%%%%")
    local r, c = s:gsub(tr, rr)
    return r
end