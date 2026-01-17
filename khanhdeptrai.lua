-- KHANHDEPTRAI HUB V16 CLEAN - WORK MOBILE 2026 - By LQK Dong Thap
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local TS = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local HubName = "KhanhDepTrai Hub V16"

local Window = Fluent:CreateWindow({
    Title = HubName,
    SubTitle = "By @LqkCam | Clean & Work Mobile",
    Size = UDim2.fromOffset(500, 380),
    Theme = "Dark"
})

local Tab = Window:AddTab({Title = "Main", Icon = "rbxassetid://7733715400"})

getgenv().AutoFarm = false
getgenv().FruitSniper = false
getgenv().FastAttack = false
getgenv().NoClip = false

local player = game.Players.LocalPlayer
local CommF_ = RS.Remotes.CommF_

-- Update char/root loop
spawn(function()
    while wait(0.5) do
        if player.Character then
            getgenv().char = player.Character
            getgenv().root = char:WaitForChild("HumanoidRootPart")
        end
    end
end)

local function Tween(cf)
    pcall(function()
        TS:Create(getgenv().root, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {CFrame = cf}):Play()
    end)
end

local function GetNearestMob()
    local mob, dist = nil, math.huge
    for _, v in pairs(WS.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            local d = (getgenv().root.Position - v.HumanoidRootPart.Position).Magnitude
            if d < dist then mob = v; dist = d end
        end
    end
    return mob
end

-- Auto Farm + Bring
spawn(function()
    while wait(0.15) do
        if getgenv().AutoFarm and getgenv().root then
            local mob = GetNearestMob()
            if mob then
                Tween(mob.HumanoidRootPart.CFrame * CFrame.new(0,8,-8))
                for _, m in pairs(WS.Enemies:GetChildren()) do
                    if m.HumanoidRootPart and (m.HumanoidRootPart.Position - getgenv().root.Position).Magnitude < 150 then
                        m.HumanoidRootPart.CFrame = getgenv().root.CFrame * CFrame.new(0,0,-8)
                    end
                end
                local tool = getgenv().char:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
            end
        end
    end
end)

-- Fruit Sniper
spawn(function()
    while wait(1) do
        if getgenv().FruitSniper then
            for _, f in pairs(WS:GetChildren()) do
                if f:IsA("Tool") and f.Name:find("Fruit") and f:FindFirstChild("Handle") then
                    local hl = Instance.new("Highlight", f)
                    hl.FillColor = Color3.fromRGB(255,0,255)
                    Tween(f.Handle.CFrame)
                    firetouchinterest(getgenv().root, f.Handle, 0)
                    firetouchinterest(getgenv().root, f.Handle, 1)
                end
            end
        end
    end
end)

-- Fast Attack
spawn(function()
    while wait(0.04) do
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

-- UI
Tab:AddToggle("AutoFarm", {
    Title = "Auto Farm + Bring Mob",
    Default = false,
    Callback = function(v)
        getgenv().AutoFarm = v
        Fluent:Notify({Title = HubName, Content = v and "Farm ON - Cầm kiếm đi bro 🔥" or "OFF"})
    end
})

Tab:AddToggle("FruitSniper", {
    Title = "Fruit ESP + Auto Grab",
    Default = false,
    Callback = function(v) getgenv().FruitSniper = v end
})

Tab:AddToggle("FastAttack", {
    Title = "Fast Attack Spam",
    Default = false,
    Callback = function(v) getgenv().FastAttack = v end
})

Tab:AddToggle("NoClip", {
    Title = "No Clip",
    Default = false,
    Callback = function(v) getgenv().NoClip = v end
})

Tab:AddButton({
    Title = "Hop Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, player)
    end
})

Fluent:Notify({Title = HubName, Content = "V16 Clean Loaded! Icon tròn góc màn hình để mở menu - Bật Auto Farm test ngay 🚀"})
