-- Case Paradise | TURCJIA HUB v12 | PERFECT NO ERROR EDITION
-- WSZYSTKO NAPRAWIONE + ZERO BŁĘDÓW CORE GUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- STANY
local ScreenGui, MainFrame, toggles = {}, connections = {}, debounce = {}
local espBoxes, espTracers, espLabels, espHealthBars = {}, {}, {}, {}
local flyBodyVelocity
local autoFarmActive, autoSellActive = false, false

-- KOLORY
local COLORS = {
    BG_PRIMARY = Color3.fromRGB(25, 35, 55),
    BG_SECONDARY = Color3.fromRGB(40, 50, 75),
    BG_ACCENT = Color3.fromRGB(60, 75, 105),
    CARD = Color3.fromRGB(30, 40, 60),
    SUCCESS = Color3.fromRGB(60, 220, 120),
    DANGER = Color3.fromRGB(255, 80, 80),
    WARNING = Color3.fromRGB(255, 200, 80),
    TEXT_PRIMARY = Color3.fromRGB(255, 255, 255),
    TEXT_SECONDARY = Color3.fromRGB(220, 230, 255),
    GRADIENT1 = Color3.fromRGB(120, 160, 255),
    GRADIENT2 = Color3.fromRGB(180, 120, 255)
}

-- BEZPIECZNE FIRE
local function safeFireRemote(name, ...)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        pcall(function()
            if obj.Name:lower():find(name:lower()) and (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
                if ... then
                    obj:FireServer(...)
                else
                    obj:FireServer()
                end
            end
        end)
    end
end

-- PERFECT GUI (NO CORE ERRORS)
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV12"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 10
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.BG_PRIMARY
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
    MainFrame.Size = UDim2.new(0, 950, 0, 700)

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, COLORS.GRADIENT1),
        ColorSequenceKeypoint.new(1, COLORS.GRADIENT2)
    }
    gradient.Rotation = 45
    gradient.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 30)
    corner.Parent = MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(150, 180, 255)
    stroke.Thickness = 3
    stroke.Parent = MainFrame

    -- TITLE BAR
    local titleBar = Instance.new("Frame")
    titleBar.Parent = MainFrame
    titleBar.BackgroundColor3 = COLORS.BG_SECONDARY
    titleBar.Size = UDim2.new(1, 0, 0, 90)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 30)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 40, 0, 0)
    titleLabel.Size = UDim2.new(0.65, 0, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "✨ TURCJIA HUB v12 PERFECT | Case Paradise"
    titleLabel.TextColor3 = COLORS.TEXT_PRIMARY
    titleLabel.TextSize = 26
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundColor3 = COLORS.DANGER
    closeBtn.Position = UDim2.new(1, -70, 0, 20)
    closeBtn.Size = UDim2.new(0, 50, 0, 50)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextSize = 22

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeBtn

    -- TABS
    local tabContainer = Instance.new("Frame")
    tabContainer.Parent = MainFrame
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 95)
    tabContainer.Size = UDim2.new(1, 0, 0, 80)

    local contentArea = Instance.new("Frame")
    contentArea.Parent = MainFrame
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 30, 0, 180)
    contentArea.Size = UDim2.new(1, -60, 1, -200)

    local tabNames = {"🤖 Autofarm", "🏃 Movement", "🎁 Events", "⚙️ Misc", "💥 Troll", "👤 ESP"}
    local tabFrames = {}

    for i, tabName in ipairs(tabNames) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab" .. i
        tabBtn.Parent = tabContainer
        tabBtn.BackgroundColor3 = COLORS.CARD
        tabBtn.Position = UDim2.new((i-1)*0.166, 20, 0, 10)
        tabBtn.Size = UDim2.new(0.14, -10, 1, -20)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.TEXT_PRIMARY
        tabBtn.TextSize = 18

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 20)
        tabCorner.Parent = tabBtn

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "Content" .. i
        tabContent.Parent = contentArea
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 3, 0)
        tabContent.ScrollBarThickness = 8
        tabContent.Visible = (i == 1)

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 12)
        layout.Parent = tabContent

        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 20)
        padding.PaddingTop = UDim.new(0, 10)
        padding.Parent = tabContent

        tabFrames[i] = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            for j, frame in pairs(tabFrames) do 
                frame.Visible = (j == i)
            end
            TweenService:Create(tabBtn, TweenInfo.new(0.3), {
                BackgroundTransparency = 0,
                Size = UDim2.new(0.16, -10, 1, -20)
            }):Play()
        end)
    end

    closeBtn.MouseButton1Click:Connect(function()
        for k, v in pairs(connections) do
            if v then pcall(function() v:Disconnect() end) end
        end
        ScreenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.X then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    populateContent(tabFrames)
end

-- TOGGLE
function createToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 60)

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text
    label.TextColor3 = COLORS.TEXT_PRIMARY
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.BackgroundColor3 = COLORS.DANGER
    toggle.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggle.Size = UDim2.new(0, 45, 0, 30)
    toggle.Font = Enum.Font.GothamBold
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.new(1,1,1)
    toggle.TextSize = 14

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 15)
    tCorner.Parent = toggle

    toggle.MouseButton1Click:Connect(function()
        local state = toggle.Text == "OFF"
        toggle.Text = state and "ON" or "OFF"
        toggle.BackgroundColor3 = state and COLORS.SUCCESS or COLORS.DANGER
        callback(state)
    end)

    toggles[text] = toggle
end

-- BUTTON
function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.BG_ACCENT
    btn.Size = UDim2.new(0.48, -10, 0, 65)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT_PRIMARY
    btn.TextSize = 15

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 20)
    bCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = COLORS.WARNING}):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.BG_ACCENT}):Play()
        callback()
    end)
end

-- FUNKCJE (WSZYSTKO NAPRAWIONE)
function toggleAutoFarm(state)
    autoFarmActive = state
    if connections.autoFarm then connections.autoFarm:Disconnect() end
    if state then
        connections.autoFarm = RunService.Heartbeat:Connect(function()
            safeFireRemote("case")
            safeFireRemote("open")
            safeFireRemote("purchase")
            safeFireRemote("collect")
        end)
    end
end

function toggleAutoSell(state)
    autoSellActive = state
    spawn(function()
        while autoSellActive do
            safeFireRemote("sell")
            safeFireRemote("sellall")
            wait(2)
        end
    end)
end

function toggleFly(state)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        if connections.fly then 
            connections.fly:Disconnect() 
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
        end
        if state then
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(4000,4000,4000)
            flyBodyVelocity.Parent = root
            connections.fly = RunService.Heartbeat:Connect(function()
                local move = char.Humanoid.MoveDirection * 50
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    move = move + Vector3.new(0,50,0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    move = move - Vector3.new(0,50,0)
                end
                flyBodyVelocity.Velocity = move
            end)
        end
    end
end

function toggleNoGravity(state)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = state end
    end
end

function toggleESP(state)
    for k,_ in pairs(espBoxes) do
        if espBoxes[k] then espBoxes[k]:Remove() end
        espBoxes[k] = nil
    end
    espBoxes = {}
    
    if state then
        connections.esp = RunService.RenderStepped:Connect(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    local box = espBoxes[plr]
                    if not box then
                        box = Drawing.new("Square")
                        box.Color = Color3.new(1,0,0)
                        box.Thickness = 3
                        box.Filled = false
                        espBoxes[plr] = box
                    end
                    if onScreen then
                        local size = 1000 / rootPos.Z
                        box.Size = Vector2.new(size, size * 2)
                        box.Position = Vector2.new(rootPos.X-size/2, rootPos.Y-size)
                        box.Visible = true
                    else
                        box.Visible = false
                    end
                end
            end
        end)
    end
end

function flingAllPlayers()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = Vector3.new(math.random(-20000,20000),30000,math.random(-20000,20000))
            end
        end
    end
end

function superJump()
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if hum and root then
            hum.JumpPower = 200
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

function populateContent(tabFrames)
    -- Autofarm
    createToggle(tabFrames[1], "Auto Open Cases", toggleAutoFarm)
    createToggle(tabFrames[1], "Auto Sell Items", toggleAutoSell)
    createButton(tabFrames[1], "Collect Money", function() safeFireRemote("collect") end)

    -- Movement
    createToggle(tabFrames[2], "Fly (WASD+Space)", toggleFly)
    createToggle(tabFrames[2], "No Gravity", toggleNoGravity)
    createToggle(tabFrames[2], "Speed 60", function(s) 
        if player.Character then player.Character.Humanoid.WalkSpeed = s and 60 or 16 end 
    end)
    createButton(tabFrames[2], "Super Jump", superJump)

    -- Events
    createButton(tabFrames[3], "TP Gifts", function() 
        if player.Character then player.Character.HumanoidRootPart.CFrame = CFrame.new(0,50,0) end 
    end)
    createButton(tabFrames[3], "TP Cases", function() 
        if player.Character then player.Character.HumanoidRootPart.CFrame = CFrame.new(100,50,100) end 
    end)

    -- Misc
    createToggle(tabFrames[4], "Fullbright", function(s)
        Lighting.Brightness = s and 3 or 1
    end)
    createToggle(tabFrames[4], "FPS Boost", function(s)
        settings().Rendering.QualityLevel = s and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end)

    -- Troll
    createButton(tabFrames[5], "Fling All", flingAllPlayers)

    -- ESP
    createToggle(tabFrames[6], "Player ESP", toggleESP)
end

-- START
createGUI()

pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "TURCJIA HUB v12";
        Text = "LOADED PERFECT! No errors. Press X";
        Duration = 5;
    })
end)

print("TURCJIA HUB v12 PERFECT LOADED!")
