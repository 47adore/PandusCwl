-- Case Paradise | TURCJIA HUB v12 | PERFECT NO ERROR EDITION
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ZMIENNE
local ScreenGui, MainFrame = nil, nil
local connections = {}
local toggles = {}
local autoFarmActive = false

-- KOLORY
local COLORS = {
    BG_PRIMARY = Color3.fromRGB(25, 35, 55),
    BG_SECONDARY = Color3.fromRGB(40, 50, 75),
    CARD = Color3.fromRGB(30, 40, 60),
    SUCCESS = Color3.fromRGB(60, 220, 120),
    DANGER = Color3.fromRGB(255, 80, 80),
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255)
}

-- FIRE REMOTE
local function fireRemote(name, ...)
    pcall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name:lower():find(name:lower()) and obj:IsA("RemoteEvent") then
                if select("#", ...) > 0 then
                    obj:FireServer(...)
                else
                    obj:FireServer()
                end
            end
        end
    end)
end

-- TWORZENIE GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV12"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.BG_PRIMARY
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = MainFrame

    -- TYTUŁ
    local title = Instance.new("TextLabel")
    title.Parent = MainFrame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "✨ TURCJIA HUB v12 | Case Paradise"
    title.TextColor3 = COLORS.TEXT_PRIMARY
    title.TextSize = 18

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = MainFrame
    closeBtn.BackgroundColor3 = COLORS.DANGER
    closeBtn.Position = UDim2.new(1, -50, 0, 10)
    closeBtn.Size = UDim2.new(0, 40, 0, 30)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextSize = 16
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    -- SCROLL FRAME
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Parent = MainFrame
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.Position = UDim2.new(0, 10, 0, 60)
    scrollFrame.Size = UDim2.new(1, -20, 1, -70)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
    scrollFrame.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = scrollFrame

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingTop = UDim.new(0, 10)
    padding.Parent = scrollFrame

    -- ZAMKNIJ
    closeBtn.MouseButton1Click:Connect(function()
        for _, conn in pairs(connections) do
            if conn then pcall(conn.Disconnect, conn) end
        end
        ScreenGui:Destroy()
    end)

    -- TOGGLES I BUTTONS
    createToggle(scrollFrame, "Auto Farm Cases", function(state)
        autoFarmActive = state
        if connections.farm then connections.farm:Disconnect() end
        if state then
            connections.farm = game:GetService("RunService").Heartbeat:Connect(function()
                fireRemote("case")
                fireRemote("open")
                fireRemote("collect")
            end)
        end
    end)

    createToggle(scrollFrame, "Auto Sell", function(state)
        spawn(function()
            while state do
                fireRemote("sell")
                fireRemote("sellall")
                wait(1)
            end
        end)
    end)

    createToggle(scrollFrame, "Fly", function(state)
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            if connections.fly then 
                connections.fly:Disconnect()
                if root:FindFirstChild("FlyVelocity") then
                    root.FlyVelocity:Destroy()
                end
            end
            if state then
                local bv = Instance.new("BodyVelocity")
                bv.Name = "FlyVelocity"
                bv.MaxForce = Vector3.new(4000,4000,4000)
                bv.Parent = root
                connections.fly = game:GetService("RunService").Heartbeat:Connect(function()
                    local cam = workspace.CurrentCamera
                    local move = Vector3.new(0,0,0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                    bv.Velocity = move * 50
                end)
            end
        end
    end)

    createToggle(scrollFrame, "Speed 50", function(state)
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = state and 50 or 16
        end
    end)

    createToggle(scrollFrame, "Fullbright", function(state)
        Lighting.Brightness = state and 2 or 1
    end)

    createButton(scrollFrame, "Collect All", function()
        fireRemote("collect")
    end)

    createButton(scrollFrame, "Fling Players", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local root = plr.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.AssemblyLinearVelocity = Vector3.new(math.random(-10000,10000), 50000, math.random(-10000,10000))
                end
            end
        end
    end)

    createButton(scrollFrame, "Super Jump", function()
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = 100
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

-- FUNKCJA TOGGLE
function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 45)

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = COLORS.TEXT_PRIMARY
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = COLORS.DANGER
    toggleBtn.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggleBtn.Size = UDim2.new(0, 35, 0, 25)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.TextSize = 12
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        local isOn = toggleBtn.Text == "OFF"
        toggleBtn.Text = isOn and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = isOn and COLORS.SUCCESS or COLORS.DANGER
        callback(isOn)
    end)
end

-- FUNKCJA BUTTON
function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.CARD
    btn.Size = UDim2.new(0.48, -5, 0, 45)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT_PRIMARY
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
        callback()
        wait(0.1)
        btn.BackgroundColor3 = COLORS.CARD
    end)
end

-- TOGGLE X
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        if MainFrame then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)

-- START
createGUI()

pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "TURCJIA HUB v12";
        Text = "Loaded! Press X to toggle";
        Duration = 4;
    })
end)

print("TURCJIA HUB v12 LOADED PERFECT!")
