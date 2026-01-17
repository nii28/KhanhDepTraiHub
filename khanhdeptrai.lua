-- KHANHDEPTRAI HUB V15 SUPER FIX - Delta Mobile Work 100% - By LQK Dong Thap 2026
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local TS = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local HubName = "KhanhDepTrai Hub V15 FIX"

local Window = Fluent:CreateWindow({
    Title = HubName,
    SubTitle = "By @LqkCam | Delta Mobile OK 🔥",
    Size = UDim2.fromOffset(550, 420),
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl  -- mobile thường dùng icon thay phím này
})

local Tabs = {
    Farm = Window:AddTab({Title = "Farm", Icon = "rbxassetid://7733715400"}),
    Fruit = Window:AddTab({Title = "Fruit", Icon = "rbxassetid://7733774602"}),
    Misc = Window:AddTab({Title = "Misc", Icon = "rbxassetid://7734062584"})
}

getgenv().AutoFarm = false
getgenv().AutoQuest = false
getgenv().FruitSniper = false
getgenv().FastAttack = false
getgenv().NoClip = false

local player = game.Players.LocalPlayer
local CommF_ = RS.Remotes.CommF_

-- LOOP UPDATE CHAR/ROOT (fix nil khi respawn)
spawn(function()
    while wait(0.5) do
        if player.Character then
            getgenv().char = player.Character
            getgenv().root = getgenv().char:WaitForChild("HumanoidRootPart")
        end
    end
end)

local function Tween(cf)
    pcall(function()
        TS:Create(getgenv().root, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {CFrame = cf}):Play()
    end)
end

local function GetMob()
    local mob = nil
    local dist = math.huge
    for _, v in pairs(WS.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local d = (getgenv().root.Position - v.HumanoidRootPart.Position).Magnitude
            if d < dist then
                mob = v
                dist = d
            end
        end
    end
    return mob
end

-- AUTO FARM FIX (bring mob + attack)
spawn(function()
    while wait(0.2) do
        if getgenv().AutoFarm then
            local mob = GetMob()
            if mob and getgenv().root then
                Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0,10,-10))
                -- Bring mob
                for _, m in pairs(WS.Enemies:GetChildren()) do
                    if m.HumanoidRootPart and (m.HumanoidRootPart.Position - getgenv().root.Position).Magnitude < 200 then
                        m.HumanoidRootPart.CFrame = getgenv().root.CFrame * CFrame.new(0,0,-10)
                    end
                end
                -- Attack
                local tool = getgenv().char:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end
end)

-- AUTO QUEST FIX (remote đúng Sea 1 Jungle)
spawn(function()
    while wait(5) do
        if getgenv().AutoQuest then
            pcall(function()
                CommF_:InvokeServer("StartQuest", "JungleQuest", "1")
            end)
        end
    end
end)

-- FRUIT SNIPER FIX
spawn(function()
    while wait(1) do
        if getgenv().FruitSniper then
            for _, f in pairs(WS:GetChildren()) do
                if f:IsA("Tool") and f.Name:find("Fruit") and f:FindFirstChild("Handle") then
                    local hl = Instance.new("Highlight", f)
                    hl.FillColor = Color3.new(1,0,1)
                    Tween(f.Handle.CFrame)
                    firetouchinterest(getgenv().root, f.Handle, 0)
                    firetouchinterest(getgenv().root, f.Handle, 1)
                end
            end
        end
    end
end)

-- FAST ATTACK + NOCLIP
spawn(function()
    while wait(0.05) do
        if getgenv().FastAttack then
            local tool = getgenv().char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if getgenv().NoClip and getgenv().char then
        for _, p in pairs(getgenv().char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- TOGGLES
Tabs.Farm:AddToggle("AutoFarm", {
    Title = "Auto Farm + Bring Mob",
    Default = false,
    Callback = function(v)
        getgenv().AutoFarm = v
        Fluent:Notify({Title = HubName, Content = v and "Farm ON! Cầm tool kiếm bro 🔥" or "OFF"})
    end
})

Tabs.Farm:AddToggle("AutoQuest", {
    Title = "Auto Quest Jungle 1",
    Default = false,
    Callback = function(v)
        getgenv().AutoQuest = v
    end
})

Tabs.Fruit:AddToggle("FruitSniper", {
    Title = "Fruit ESP + Auto Grab",
    Default = false,
    Callback = function(v)
        getgenv().FruitSniper = v
    end
})

Tabs.Misc:AddToggle("FastAttack", {
    Title = "Fast Attack Spam",
    Default = false,
    Callback = function(v)
        getgenv().FastAttack = v
    end
})

Tabs.Misc:AddToggle("NoClip", {
    Title = "No Clip",
    Default = false,
    Callback = function(v)
        getgenv().NoClip = v
    end
})

Tabs.Misc:AddButton({
    Title = "Hop Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end
})

Tabs.Misc:AddButton({
    Title = "Destroy Menu",
    Callback = function()
        Window:Destroy()
    end
})

Fluent:Notify({Title = HubName, Content = "V15 FIX Loaded! Join Sea 1 + Cầm tool → Bật Auto Farm test ngay 🚀"})
Fluent:SelectTab(1)
