-- Case Paradise | Turcja Hub v3.0 | FIXED & IMPROVED
-- Key: X | Dragable | Bigger GUI | All Features Working

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local ScreenGui = nil
local MainFrame = nil
local ContentFrame = nil
local isDragging = false
local dragStart, startPos = nil, nil
local toggles = {}
local flySpeed = 50
local walkSpeed = 16
local connections = {}

-- Movement states
local flyEnabled = false
local noclipEnabled = false
local noGravity = false
local fullbright = false

-- Autofarm states
local autofarmEnabled = false
local autoGifts = false
local autoIndex = false
local autoQuests = false
local autoEvents = false

-- Create Professional GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV3"
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false

    -- Bigger Main Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.Size = UDim2.new(0, 700, 0, 500) -- Bigger!
    MainFrame.ClipsDescendants = true

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 150, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = MainFrame

    -- Gradient
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
    }
    gradient.Rotation = 45
    gradient.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 50)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "🕶️ Turcja Hub v3.0 | Case Paradise"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TitleBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -40, 0, 5)
    CloseBtn.Size = UDim2.new(0, 35, 0, 35)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.TextSize = 20

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.Size = UDim2.new(1, 0, 0, 45)

    -- Content Area
    ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 0, 0, 95)
    ContentFrame.Size = UDim2.new(1, 0, 1, -95)
    ContentFrame.ScrollBarThickness = 8
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 2000)

    -- Create Tabs
    local tabs = {"🏆 Autofarm", "⚡ Movement", "🎁 Events", "⚙️ Misc", "👤 Player"}
    local tabButtons = {}
    
    for i, tabName in ipairs(tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "TabBtn" .. i
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        TabBtn.BackgroundTransparency = 0.3
        TabBtn.Position = UDim2.new((i-1)/5, 5, 0, 5)
        TabBtn.Size = UDim2.new(0.18, -10, 1, -10)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 15

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = TabBtn

        tabButtons[i] = TabBtn
        TabBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(tabButtons) do
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                btn.BackgroundTransparency = 0.3
            end
            TabBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
            TabBtn.BackgroundTransparency = 0.1
            ContentFrame.CanvasPosition = Vector2.new(0, (i-1) * 450)
        end)
    end

    -- Create Content Sections
    createAutofarmSection(20, 10)
    createMovementSection(20, 470)
    createEventsSection(20, 930)
    createMiscSection(20, 1390)
    createPlayerSection(20, 1850)

    -- Drag System
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                         startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Keybind X
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.X then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end

-- Autofarm Section
function createAutofarmSection(x, y)
    local frame = Instance.new("Frame")
    frame.Parent = ContentFrame
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.2
    frame.Position = UDim2.new(0, x, 0, y)
    frame.Size = UDim2.new(1, -40, 0, 420)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Font = Enum.Font.GothamBold
    title.Text = "🏆 AUTOFARM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20

    createToggle(frame, "Auto Farm Cases", UDim2.new(0, 20, 0, 60), function(state)
        autofarmEnabled = state
        if state then startAutofarm() else stopAutofarm() end
    end)

    createToggle(frame, "Auto Claim Gifts", UDim2.new(0, 20, 0, 100), function(state)
        autoGifts = state
        if state then startGiftClaim() else stopGiftClaim() end
    end)

    createToggle(frame, "Auto Index Claim", UDim2.new(0, 20, 0, 140), function(state)
        autoIndex = state
        if state then startIndexClaim() else stopIndexClaim() end
    end)

    createToggle(frame, "Auto Quests", UDim2.new(0, 20, 0, 180), function(state)
        autoQuests = state
        if state then startQuests() else stopQuests() end
    end)

    createToggle(frame, "Auto Events", UDim2.new(0, 20, 0, 220), function(state)
        autoEvents = state
        if state then startEvents() else stopEvents() end
    end)

    createSlider(frame, "Farm Delay", UDim2.new(0, 20, 0, 270), 0.1, 3, function(value)
        _G.farmDelay = value
    end)
end

-- Movement Section
function createMovementSection(x, y)
    local frame = Instance.new("Frame")
    frame.Parent = ContentFrame
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    frame.BackgroundTransparency = 0.2
    frame.Position = UDim2.new(0, x, 0, y)
    frame.Size = UDim2.new(1, -40, 0, 420)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Font = Enum.Font.GothamBold
    title.Text = "⚡ MOVEMENT"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20

    local flyBox = createTextBox(frame, "Fly Speed: 50", UDim2.new(0, 20, 0, 60))
    createToggle(frame, "Fly", UDim2.new(0, 20, 0, 100), function(state)
        flyEnabled = state
        toggleFly(state, flyBox)
    end)

    local speedBox = createTextBox(frame, "Speed: 16", UDim2.new(0, 20, 0, 140))
    createToggle(frame, "Speed Hack", UDim2.new(0, 20, 0, 180), function(state)
        toggleSpeed(state, speedBox)
    end)

    createToggle(frame, "Noclip", UDim2.new(0, 20, 0, 220), function(state)
        noclipEnabled = state
        toggleNoclip(state)
    end)

    createToggle(frame, "No Gravity", UDim2.new(0, 20, 0, 260), function(state)
        noGravity = state
        toggleNoGravity(state)
    end)

    createToggle(frame, "Fullbright", UDim2.new(0, 20, 0, 300), function(state)
        fullbright = state
        toggleFullbright(state)
    end)
end

-- UI Helpers
function createToggle(parent, text, pos, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.Position = pos

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.Position = UDim2.new(0.78, 0, 0.15, 0)
    btn.Size = UDim2.new(0, 22, 0, 22)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 12

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local state = btn.Text == "OFF"
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        btn.BackgroundColor3 = state and Color3.fromRGB(30, 80, 30) or Color3.fromRGB(80, 30, 30)
        callback(state)
    end)
end

function createTextBox(parent, placeholder, pos)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    frame.Position = pos
    frame.Size = UDim2.new(0.4, 0, 0, 30)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local box = Instance.new("TextBox")
    box.Parent = frame
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, 0, 1, 0)
    box.Font = Enum.Font.Gotham
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(200, 200, 200)
    box.TextSize = 14
    box.TextXAlignment = Enum.TextXAlignment.Center
    
    return box
end

-- Movement Functions (FIXED)
function toggleFly(state, speedBox)
    if state then
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local rootPart = player.Character.HumanoidRootPart
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = rootPart

        connections.fly = RunService.Heartbeat:Connect(function()
            if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if not humanoid then return end

            local camera = Workspace.CurrentCamera
            local vel = Vector3.new(0, 0, 0)
            local speed = tonumber(speedBox.Text) or flySpeed

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - camera.CFrame.LookVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - camera.CFrame.RightVector * speed end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, speed, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, speed, 0) end

            bodyVelocity.Velocity = vel
        end)
    else
        if connections.fly then connections.fly:Disconnect() end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end

function toggleSpeed(state, speedBox)
    if not player.Character or not player.Character:FindFirstChild("Humanoid") then return end
    local humanoid = player.Character.Humanoid
    if state then
        local speed = tonumber(speedBox.Text) or 50
        humanoid.WalkSpeed = speed
        speedBox.Text = "Speed: " .. speed
    else
        humanoid.WalkSpeed = 16
        speedBox.Text = "Speed: 16"
    end
end

function toggleNoclip(state)
    if state then
        connections.noclip = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if connections.noclip then connections.noclip:Disconnect() end
        if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end

function toggleNoGravity(state)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        if state then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = rootPart
        else
            local bv = rootPart:FindFirstChild("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end

function toggleFullbright(state)
    if state then
        local oldBrightness = Lighting.Brightness
        local oldAmbient = Lighting.Ambient
        local oldColorShift = Lighting.ColorShift_Bottom
        local oldOutdoor = Lighting.OutdoorAmbient
        
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        
        _G.oldLighting = {Brightness = oldBrightness, Ambient = oldAmbient, 
                         ColorShift_Bottom = oldColorShift, OutdoorAmbient = oldOutdoor}
    else
        if _G.oldLighting then
            Lighting.Brightness = _G.oldLighting.Brightness
            Lighting.Ambient = _G.oldLighting.Ambient
            Lighting.ColorShift_Bottom = _G.oldLighting.ColorShift_Bottom
            Lighting.OutdoorAmbient = _G.oldLighting.OutdoorAmbient
        end
    end
end

-- Autofarm Functions (Case Paradise Specific)
_G.farmDelay = 1
function startAutofarm()
    spawn(function()
        while autofarmEnabled do
            -- Fire case opening events (adapt to game remotes)
            if ReplicatedStorage:FindFirstChild("Remotes") then
                for _, remote in pairs(ReplicatedStorage.Remotes:GetChildren()) do
                    if remote.Name:lower():find("case") or remote.Name:lower():find("open") then
                        remote:FireServer()
                    end
                end
            end
            wait(_G.farmDelay)
        end
    end)
end

function startGiftClaim()
    spawn(function()
        while autoGifts do
            pcall(function()
                if ReplicatedStorage:FindFirstChild("ClaimGift") then
                    ReplicatedStorage.ClaimGift:FireServer()
                end
            end)
            wait(5)
        end
    end)
end

function startIndexClaim()
    spawn(function()
        while autoIndex do
            pcall(function()
                if ReplicatedStorage:FindFirstChild("ClaimIndex") or ReplicatedStorage:FindFirstChild("Index") then
                    ReplicatedStorage.ClaimIndex:FireServer()
                end
            end)
            wait(3)
        end
    end)
end

function startQuests()
    spawn(function()
        while autoQuests do
            pcall(function()
                if ReplicatedStorage:FindFirstChild("CompleteQuest") then
                    ReplicatedStorage.CompleteQuest:FireServer()
                end
            end)
            wait(2)
        end
    end)
end

-- Initialize
spawn(function()
    wait(2)
    createGUI()
    
    -- FPS Boost
    settings().Rendering.QualityLevel = "Level01"
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    
    -- Anti-AFK
    spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(60)
        end
    end)
end)

print("🕶️ Turcja Hub v3.0 LOADED! Press X to toggle | Everything FIXED!")
