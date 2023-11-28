-- Stonetr03

local Module = {}

local Api = require(game.ReplicatedStorage:WaitForChild("AdminCube"):WaitForChild("Api"))
local HttpService = game:GetService("HttpService")
local Hash = HttpService:GenerateGUID(false);

function Module:GetDataStore(Name,Scope)
    return Api:Invoke("DatastoreEditor-Get",Hash,Name,Scope)
end

function Module:Cleanup()
    Api:Invoke("DatastoreEditor-Cleanup",Hash)
    return true
end

function Module:GetKey(Key)
    return Api:Invoke("DatastoreEditor-GetKey",Hash,Key)
end

function Module:SaveKey(Key,Data)
    return Api:Invoke("DatastoreEditor-SaveKey",Hash,Key,Data)
end

function Module:RemoveKey(Key)
    return Api:Invoke("DatastoreEditor-Remove",Hash,Key)
end

return Module
