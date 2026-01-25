
function StaticDataIterator(kind)
    local co = coroutine.create(
        function()
            for _, uuid in Ext.StaticData.GetAll(kind) do
                coroutine.yield(uuid, Ext.StaticData.Get(uuid, kind))
            end
        end
    )
    return function()
        local ok, result = coroutine.resume(co)
        if ok then return result end
    end
end

function StatsIterator(kind)
    local co = coroutine.create(
        function()
            for _, name in Ext.Stats.GetStats(kind) do
                local stats = Ext.Stats.Get(name)
                if stats then
                    coroutine.yield(name, stats)
                end
            end
        end
    )
    return function()
        local ok, result = coroutine.resume(co)
        if ok then return result end
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