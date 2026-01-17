local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local HubName = "KhanhDepTrai Hub"

local Window = Fluent:CreateWindow({
    Title = HubName .. " V13 Ultimate",
    SubTitle = "By @LqkCam | Dong Thap God Mode 2026",
    TabWidth = 160,
    Size = UDim2.fromOffset(650, 550),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Farm = Window:AddTab({ Title = "Auto Farm", Icon = "rbxassetid://7733715400" }),
    Combat = Window:AddTab({ Title = "Combat/PVP", Icon = "rbxassetid://7734053495" }),
    Fruit = Window:AddTab({ Title = "Fruit Sniper", Icon = "rbxassetid://7733774602" }),
    Raid = Window:AddTab({ Title = "Raid/Dungeon", Icon = "rbxassetid://7734062584" }),
    Race = Window:AddTab({ Title = "Race V4", Icon = "rbxassetid://7733715400" }),
    Tele = Window:AddTab({ Title = "Teleport", Icon = "rbxassetid://7734053495" }),
    Shop = Window:AddTab({ Title = "Auto Buy/Stats", Icon = "rbxassetid://7733774602" }),
    Misc = Window:AddTab({ Title = "Misc/Hop", Icon = "rbxassetid://7734062584" })
}

local Options = Fluent.Options

getgenv().AutoFarmLevel = false; getgenv().AutoMastery = false; getgenv().AutoBoss = false; getgenv().AutoMaterial = false
getgenv().AutoBones = false; getgenv().AutoChest = false; getgenv().AutoBerries = false; getgenv().AutoQuest = false
getgenv().FruitESP = false; getgenv().FruitSniper = false; getgenv().AutoStoreFruit = false; getgenv().AutoBuyFruit = false
getgenv().AutoRaid = false; getgenv().AutoDungeon = false; getgenv().AutoNextFloor = false; getgenv().AutoAwaken = false
getgenv().AutoRaceV4 = false; getgenv().AutoTrial = false; getgenv().AutoStats = false
getgenv().FastAttack = false; getgenv().NoClip = false; getgenv().KillAura = false; getgenv().Aimbot = false
getgenv().ServerHop = false; getgenv().TweenSpeed = 250; getgenv().Team = "Pirates"

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")
local CommF_ = ReplicatedStorage.Remotes["CommF_"]

local function TweenTo(pos)
    pcall(function()
        local dist = (root.Position - pos).Magnitude
        local tween = TweenService:Create(root, TweenInfo.new(dist / getgenv().TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(pos)})
        tween:Play()
        tween.Completed:Wait()
    end)
end

local function GetNearest(folder, maxDist)
    local nearest, dist = nil, maxDist or 1000
    for _, obj in ipairs(folder:GetChildren()) do
        if obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 and obj:FindFirstChild("HumanoidRootPart") then
            local d = (root.Position - obj.HumanoidRootPart.Position).Magnitude
            if d < dist then nearest = obj; dist = d end
        end
    end
    return nearest
end
spawn(function()
    while wait(0.1) do
        if getgenv().AutoFarmLevel or getgenv().AutoMastery or getgenv().AutoBoss or getgenv().AutoMaterial then
            local target
            if getgenv().AutoBoss then target = GetNearest(Workspace.Bosses) end
            if not target then target = GetNearest(Workspace.Enemies) end
            if target then
                TweenTo(target.HumanoidRootPart.Position + Vector3.new(0, 10, -10))
                for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
                    if mob.HumanoidRootPart and (mob.HumanoidRootPart.Position - root.Position).Magnitude < 300 then
                        mob.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, -10)
                    end
                end
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            elseif getgenv().AutoMaterial then
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name:lower():find("chest") or obj.Name:lower():find("berry") or obj.Name:lower():find("bone") then
                        TweenTo(obj.Position)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while wait(2) do
        if getgenv().AutoQuest then pcall(function() CommF_:InvokeServer("StartQuest") end) end
    end
end)

spawn(function()
    while wait(1) do
        if getgenv().FruitESP or getgenv().FruitSniper then
            for _, fruit in ipairs(Workspace:GetChildren()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") and fruit.Name:find("Fruit") then
                    if not fruit:FindFirstChild("Highlight") then
                        local hl = Instance.new("Highlight", fruit)
                        hl.FillColor = Color3.new(1,0,1); hl.OutlineColor = Color3.new(1,1,0)
                    end
                    if getgenv().FruitSniper then TweenTo(fruit.Handle.Position); firetouchinterest(root, fruit.Handle, 0) end
                end
            end
        end
        if getgenv().AutoStoreFruit then pcall(function() CommF_:InvokeServer("StoreFruit") end) end
        if getgenv().AutoBuyFruit then pcall(function() CommF_:InvokeServer("PurchaseDealer", "Random") end) end
    end
end)

spawn(function()
    while wait(3) do
        if getgenv().AutoRaid then pcall(function() CommF_:InvokeServer("Raid", "Start") end) end
        if getgenv().AutoAwaken then pcall(function() CommF_:InvokeServer("Awaken") end) end
        if getgenv().AutoDungeon then pcall(function() CommF_:InvokeServer("Dungeon") end) end
        if getgenv().AutoNextFloor then pcall(function() CommF_:InvokeServer("NextFloor") end) end
    end
end)

spawn(function()
    while wait(5) do
        if getgenv().AutoRaceV4 then pcall(function() CommF_:InvokeServer("RaceV4", "Upgrade") end) end
        if getgenv().AutoTrial then TweenTo(Vector3.new(28500, 1500, -5000)) end
        if getgenv().AutoStats then pcall(function() CommF_:InvokeServer("AddStats", "Melee", 2550) end) end
    end
end)

spawn(function()
    while wait(0.03) do
        if getgenv().FastAttack or getgenv().KillAura then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if getgenv().NoClip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)
Tabs.Farm:AddToggle("AutoFarmLevel", {Title="Auto Farm Level", Default=false, Callback=function(v) getgenv().AutoFarmLevel=v Fluent:Notify({Title=HubName, Content=v and "Auto Farm ON 🔥" or "OFF"}) end})
Tabs.Farm:AddToggle("AutoMastery", {Title="Auto Mastery", Default=false, Callback=function(v) getgenv().AutoMastery=v end})
Tabs.Farm:AddToggle("AutoBoss", {Title="Auto Boss", Default=false, Callback=function(v) getgenv().AutoBoss=v end})
Tabs.Farm:AddToggle("AutoMaterial", {Title="Auto Material/Bones/Chest/Berries", Default=false, Callback=function(v) getgenv().AutoMaterial=v; getgenv().AutoBones=v; getgenv().AutoChest=v; getgenv().AutoBerries=v end})
Tabs.Farm:AddToggle("AutoQuest", {Title="Auto Quest", Default=false, Callback=function(v) getgenv().AutoQuest=v end})

Tabs.Combat:AddToggle("FastAttack", {Title="Fast Attack", Default=false, Callback=function(v) getgenv().FastAttack=v end})
Tabs.Combat:AddToggle("KillAura", {Title="Kill Aura", Default=false, Callback=function(v) getgenv().KillAura=v end})
Tabs.Combat:AddToggle("NoClip", {Title="No Clip", Default=false, Callback=function(v) getgenv().NoClip=v end})

Tabs.Fruit:AddToggle("FruitESP", {Title="Fruit ESP", Default=false, Callback=function(v) getgenv().FruitESP=v end})
Tabs.Fruit:AddToggle("FruitSniper", {Title="Auto Sniper Fruit", Default=false, Callback=function(v) getgenv().FruitSniper=v end})
Tabs.Fruit:AddToggle("AutoStoreFruit", {Title="Auto Store Fruit", Default=false, Callback=function(v) getgenv().AutoStoreFruit=v end})
Tabs.Fruit:AddToggle("AutoBuyFruit", {Title="Auto Buy Random Fruit", Default=false, Callback=function(v) getgenv().AutoBuyFruit=v end})

Tabs.Raid:AddToggle("AutoRaid", {Title="Auto Start Raid", Default=false, Callback=function(v) getgenv().AutoRaid=v end})
Tabs.Raid:AddToggle("AutoDungeon", {Title="Auto Dungeon", Default=false, Callback=function(v) getgenv().AutoDungeon=v end})
Tabs.Raid:AddToggle("AutoNextFloor", {Title="Auto Next Floor", Default=false, Callback=function(v) getgenv().AutoNextFloor=v end})
Tabs.Raid:AddToggle("AutoAwaken", {Title="Auto Awaken Fruit", Default=false, Callback=function(v) getgenv().AutoAwaken=v end})

Tabs.Race:AddToggle("AutoRaceV4", {Title="Auto Race V4 Upgrade", Default=false, Callback=function(v) getgenv().AutoRaceV4=v end})
Tabs.Race:AddToggle("AutoTrial", {Title="Auto V4 Trial Energy", Default=false, Callback=function(v) getgenv().AutoTrial=v end})

local Teleports = {
    ["Middle Town"] = CFrame.new(1000, 100, 1000),
    ["Jungle"] = CFrame.new(-500, 50, -500),
    ["Frozen Village"] = CFrame.new(5000, 200, -2000),
    ["Temple of Time"] = CFrame.new(28500, 1500, -5000),
}
Tabs.Tele:AddDropdown("IslandTP", {Title="Teleport Island", Values={"Middle Town","Jungle","Frozen Village","Temple of Time"}, Callback=function(v) TweenTo(Teleports[v].Position) end})

Tabs.Shop:AddToggle("AutoStats", {Title="Auto Max Stats (Melee)", Default=false, Callback=function(v) getgenv().AutoStats=v end})
Tabs.Shop:AddButton({Title="Buy Legendary Sword/Melee/Gun", Callback=function() CommF_:InvokeServer("PurchaseDealerLine", "Legendary") end})

Tabs.Misc:AddToggle("ServerHop", {Title="Auto Server Hop", Default=false, Callback=function(v) getgenv().ServerHop=v end})
Tabs.Misc:AddButton({Title="Hop Now", Callback=function() TeleportService:Teleport(game.PlaceId, player) end})
Tabs.Misc:AddSlider("TweenSpeed", {Title="Tween Speed", Min=100, Max=500, Default=250, Callback=function(v) getgenv().TweenSpeed=v end})
Tabs.Misc:AddButton({Title="Destroy GUI", Callback=function() Window:Destroy() end})

SaveManager:SetLibrary(Fluent)
SaveManager:BuildInterfaceSection(Tabs.Misc)
Fluent:SelectTab(1)

Fluent:Notify({Title=HubName, Content="V13 ULTIMATE Loaded! FULL AUTO như hack xịn - Farm max level ngay bro 😈🚀"})
