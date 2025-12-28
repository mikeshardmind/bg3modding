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


Ext.Events.StatsLoaded:Subscribe(EnsureSubclass, {Priority = -1})