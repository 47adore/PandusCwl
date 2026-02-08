-- Case Paradise | TURCJIA HUB v12 | 100% CORE GUI SAFE
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ZMIENNE
local ScreenGui = nil
local toggles = {}
local connections = {}
local autoFarm = false

-- FIRE REMOTE
local function fireRemote(name)
    pcall(function()
        for _, obj in pairs(ReplicatedStorage:GetChildren()) do
            if obj.Name:lower():find(name:lower()) and obj:IsA("RemoteEvent") then
                obj:FireServer()
            end
        end
    end)
end

-- TWORZ GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = ScreenGui
    mainFrame.Size = UDim2.new(0, 500, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.Active = true
    mainFrame.Draggable = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Parent = mainFrame
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    title.Text = "TURCJIA HUB v12"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 15)
    titleCorner.Parent = title

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = title
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -45, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 20)
    closeCorner.Parent = closeBtn

    local scroll = Instance.new("ScrollingFrame")
    scroll.Parent = mainFrame
    scroll.Size = UDim2.new(1, -20, 1, -70)
    scroll.Position = UDim2.new(0, 10, 0, 60)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
    scroll.ScrollBarThickness = 8

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = scroll

    -- TOGGLE FUNKCJA
    local function makeToggle(name, callback)
        local frame = Instance.new("Frame")
        frame.Parent = scroll
        frame.Size = UDim2.new(1, 0, 0, 50)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

        local corner2 = Instance.new("UICorner")
        corner2.CornerRadius = UDim.new(0, 10)
        corner2.Parent = frame

        local label = Instance.new("TextLabel")
        label.Parent = frame
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.Gotham
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left

        local btn = Instance.new("TextButton")
        btn.Parent = frame
        btn.Size = UDim2.new(0, 60, 0, 35)
        btn.Position = UDim2.new(1, -70, 0.15, 0)
        btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 15)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            local on = btn.Text == "OFF"
            btn.Text = on and "ON" or "OFF"
            btn.BackgroundColor3 = on and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
            callback(on)
        end)

        toggles[name] = btn
    end

    -- BUTTON FUNKCJA
    local function makeButton(name, callback)
        local btn = Instance.new("TextButton")
        btn.Parent = scroll
        btn.Size = UDim2.new(1, 0, 0, 50)
        btn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
        btn.Text = name
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16

        local corner3 = Instance.new("UICorner")
        corner3.CornerRadius = UDim.new(0, 10)
        corner3.Parent = btn

        btn.MouseButton1Click:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            callback()
            wait(0.1)
            btn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
        end)
    end

    -- FUNKCJE
    makeToggle("Auto Farm", function(on)
        autoFarm = on
        if connections.farm then connections.farm:Disconnect() end
        if on then
            connections.farm = RunService.Heartbeat:Connect(function()
                fireRemote("case")
                fireRemote("open")
                fireRemote("collect")
            end)
        end
    end)

    makeToggle("Auto Sell", function(on)
        spawn(function()
            while on do
                fireRemote("sell")
                fireRemote("sellall")
                wait(2)
            end
        end)
    end)

    makeToggle("Fly", function(on)
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            if connections.fly then 
                connections.fly:Disconnect()
                if root:FindFirstChild("FlyForce") then root.FlyForce:Destroy() end
            end
            if on then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "FlyForce"
                bv.MaxForce = Vector3.new(4000,4000,4000)
                bv.Parent = root
                connections.fly = RunService.Heartbeat:Connect(function()
                    local speed = 50
                    local dir = Vector3.new(0,0,0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0)*speed end
                    bv.Velocity = dir * speed
                end)
            end
        end
    end)

    makeToggle("Speed", function(on)
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = on and 100 or 16
        end
    end)

    makeToggle("Fullbright", function(on)
        Lighting.Brightness = on and 3 or 1
    end)

    makeButton("Collect", function()
        fireRemote("collect")
    end)

    makeButton("Fling Players", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,50000,0)
            end
        end
    end)

    makeButton("Super Jump", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 100
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        for _, conn in pairs(connections) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        ScreenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.X then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)
end

-- START
createGUI()

game.StarterGui:SetCore("SendNotification", {
    Title = "TURCJIA HUB v12";
    Text = "Loaded! Press X";
    Duration = 3
})

print("HUB LOADED!")
