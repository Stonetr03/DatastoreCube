-- Stonetr03

local Api = require(script.Parent.Parent:WaitForChild("Api"))
local DataStoreService = game:GetService("DataStoreService")

Api:RegisterCommand("editor","Opens the datastore editor.",function(p,Args)
    if Api:GetRank(p) >= 4 then
        script:WaitForChild("Editor"):Clone().Parent = p:WaitForChild("PlayerGui"):WaitForChild("__AdminCube_Main")
    else
        Api:InvalidPermissionsNotification(p)
    end
end,"1;[player];",{"datastore"})

local DataStores = {}
Api:OnInvoke("DatastoreEditor-Get",function(p,Hash,Name,Scope)
    if Api:GetRank(p) >= 4 then
        if DataStores[p] == nil then
            DataStores[p] = {}
        end
        local tmp
        local s,e = pcall(function()
            tmp = DataStoreService:GetDataStore(Name,Scope)
        end)
        if s and tmp then
            DataStores[p][Hash] = tmp
            return true
        else
            warn("Error Getting Datastore:",e)
            return false
        end
    end
end)

Api:OnInvoke("DatastoreEditor-Cleanup",function(p,Hash)
    if Api:GetRank(p) >= 4 then
        if DataStores[p] == nil then
            return
        end
        DataStores[p][Hash] = nil;
    end
end)

Api:OnInvoke("DatastoreEditor-GetKey",function(p,Hash,Key)
    if Api:GetRank(p) >= 4 then
        if DataStores[p] == nil or DataStores[p][Hash] == nil then
            warn("Error getting data: No Datastore Loaded")
            return nil
        end

        local Data
        local s,e = pcall(function()
            Data = DataStores[p][Hash]:GetAsync(Key)
        end)
        if s then
            return Data
        else
            warn("Error getting data:",e)
            return nil
        end
    end
end)

Api:OnInvoke("DatastoreEditor-SaveKey",function(p,Hash,Key,Data)
    if Api:GetRank(p) >= 4 then
        if DataStores[p] == nil or DataStores[p][Hash] == nil then
            warn("Error getting data: No Datastore Loaded")
            return nil
        end

        local s,e = pcall(function()
            DataStores[p][Hash]:SetAsync(Key,Data)
        end)
        if not s then
            warn("Error saving data:",e)
            return false
        end
        return true
    end
end)

Api:OnInvoke("DatastoreEditor-Remove",function(p,Hash,Key)
    if Api:GetRank(p) >= 4 then
        if DataStores[p] == nil or DataStores[p][Hash] == nil then
            warn("Error getting data: No Datastore Loaded")
            return nil
        end

        local s,e = pcall(function()
            DataStores[p][Hash]:RemoveAsync(Key)
        end)
        if not s then
            warn("Error deleting data:",e)
            return false
        end
        return true
    end
end)

game.Players.PlayerRemoving:Connect(function(p)
    if DataStores[p] ~= nil then
        DataStores[p] = nil
    end
end)

return true