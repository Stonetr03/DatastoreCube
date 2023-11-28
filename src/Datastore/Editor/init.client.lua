-- Stonetr03

local Api = require(game.ReplicatedStorage:WaitForChild("AdminCube"):WaitForChild("Api"))
local Config = require(script:WaitForChild("Config"))
local Ui = require(script:WaitForChild("Ui"))
local Datastore = require(script:WaitForChild("Datastore"))
local Fusion = Config.Fusion

local New = Fusion.New
local Children = Fusion.Children

local Window = Api:CreateWindow({
    Size = Vector2.new(350,250);
    Title = "Datastore Editor";
    Position = UDim2.new(0.5,-50,0,0);
    Resizeable = true;
    ResizeableMinimum = Vector2.new(155,155)
},New "Frame" {
    BackgroundTransparency = 1;
    Size = UDim2.new(1,0,1,0);

    [Children] = Ui.MainUi();
})

Window.OnClose:Connect(function()
    Window.unmount()
    Datastore:Cleanup()
    script:Destroy()
end)
