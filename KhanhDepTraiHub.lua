-- KHANHDEPTRAI HUB - BAY TIẾNG VIỆT - By LQK (@LqkCam) Dong Thap 2026
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local RS = game:GetService("RunService")
local HubName = "KhanhDepTrai Hub"

local Window = Fluent:CreateWindow({
    Title = HubName,
    SubTitle = "Bay + NoClip - By @LqkCam",
    Size = UDim2.fromOffset(400, 300),  -- Menu nhỏ gọn
    Theme = "Dark"
})

local Tab = Window:AddTab({Title = "Bay & NoClip", Icon = "rbxassetid://7733715400"})

-- Biến
getgenv().FlyEnabled = false
getgenv().NoClipEnabled = false
getgenv().FlySpeed = 50  -- Tốc độ bay mặc định

local player = game.Players.LocalPlayer

-- Fly function (CFrame bay mượt)
local function StartFly()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local bodyVelocity = Instance.new("BodyVelocity")
        local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root
        
        bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.Parent = root
        
        local connection
        connection = RS.Heartbeat:Connect(function()
            if getgenv().FlyEnabled and char.Parent and root.Parent then
                local camera = workspace.CurrentCamera
                local vel = camera.CFrame.LookVector * getgenv().FlySpeed
                
                -- WASD + Space/Shift bay
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then vel = vel + camera.CFrame.LookVector * getgenv().FlySpeed end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then vel = vel - camera.CFrame.LookVector * getgenv().FlySpeed end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then vel = vel - camera.CFrame.RightVector * getgenv().FlySpeed end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then vel = vel + camera.CFrame.RightVector * getgenv().FlySpeed end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, getgenv().FlySpeed, 0) end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, getgenv().FlySpeed, 0) end
                
                bodyVelocity.Velocity = vel
            else
                connection:Disconnect()
                if bodyVelocity then bodyVelocity:Destroy() end
                if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
            end
        end)
    end
end

-- NoClip function
local NoClipConnection
NoClipConnection = RS.Stepped:Connect(function()
    if getgenv().NoClipEnabled and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- UI Toggle & Slider (tiếng Việt)
Tab:AddToggle("FlyToggle", {
    Title = "Bật Bay (WASD + Space/Shift)",
    Default = false,
    Callback = function(v)
        getgenv().FlyEnabled = v
        if v then
            StartFly()
            Fluent:Notify({Title = HubName, Content = "Bay đã bật! Dùng WASD + Space bay lên, Shift bay xuống 🚀"})
        else
            Fluent:Notify({Title = HubName, Content = "Bay đã tắt!"})
        end
    end
})

Tab:AddSlider("FlySpeedSlider", {
    Title = "Tốc độ bay",
    Min = 16,
    Max = 200,
    Default = 50,
    Rounding = 1,
    Callback = function(v)
        getgenv().FlySpeed = v
        Fluent:Notify({Title = HubName, Content = "Tốc độ bay: " .. v})
    end
})

Tab:AddToggle("NoClipToggle", {
    Title = "NoClip (Đi xuyên tường)",
    Default = false,
    Callback = function(v)
        getgenv().NoClipEnabled = v
        if v then
            Fluent:Notify({Title = HubName, Content = "NoClip bật - Đi xuyên tường thoải mái! 👻"})
        else
            Fluent:Notify({Title = HubName, Content = "NoClip tắt"})
        end
    end
})

Tab:AddButton({
    Title = "Đóng menu",
    Callback = function()
        Window:Destroy()
        Fluent:Notify({Title = HubName, Content = "Menu đã đóng!"})
    end
})

-- Notify đầu khi load
Fluent:Notify({
    Title = HubName,
    Content = "Script bay + noclip loaded! Menu nhỏ gọn - Bấm icon tròn góc màn hình để mở 😎",
    Duration = 6
})
