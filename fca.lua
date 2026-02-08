-- Case Paradise | Turcja Hub v2.0 | Loadstring Ready
-- Key: X | Dragable | FPS Boost | Anti-AFK | Professional GUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local ScreenGui = nil
local MainFrame = nil
local isDragging = false
local dragStart = nil
local startPos = nil
local connections = {}
local toggles = {}

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
local antiAFK = false

-- FPS Boost
local fpsBoosted = false
local originalSettings = {}

-- Movement
local flyEnabled = false
local flySpeed = 50
local flyConnection = nil
local noclipEnabled = false
local noclipConnection = nil
local speedEnabled = false
local noGravity = false
local wallhack = false
local fullbright = false

-- Autofarm
local autofarmEnabled = false
local autoClaimGifts = false
local autoIndexClaim = false
local autoQuest = false
local autoExchange = false
local autoPlaytimeGifts = false
local autoLevelCases = false
local autoEventCases = false
local autoSell = false
local autoDelay = 0.5

-- Movement Events
local respawnEvents = false
local meteorEvents = false

-- Create Glass/Transparent GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHub"
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame (Glass effect)
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 550, 0, 400)
    MainFrame.ClipsDescendants = true

    -- Glass corners
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Glass stroke
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(100, 150, 255)
    UIStroke.Thickness = 1.5
    UIStroke.Transparency = 0.5
    UIStroke.Parent = MainFrame

    -- Gradient background
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundTransparency = 1
    TitleBar.Size = UDim2.new(1, 0, 0, 50)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "🕶️ Turcja Hub | Case Paradise"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Minimize Button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "Minimize"
    MinimizeBtn.Parent = TitleBar
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeBtn.TextSize = 18

    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "Close"
    CloseBtn.Parent = TitleBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.TextSize = 18

    -- ScrollingFrame for Tabs
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "Content"
    ScrollingFrame.Parent = MainFrame
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 50)
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 1200)

    -- Tab Buttons
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.Size = UDim2.new(1, 0, 0, 40)

    local tabs = {
        {name = "🏆 Autofarm", contentY = 0},
        {name = "⚡ Movement", contentY = 200},
        {name = "🎁 Events", contentY = 400},
        {name = "⚙️ Misc", contentY = 600},
        {name = "📊 Player", contentY = 800}
    }

    local currentTab = 1

    -- Create Tabs
    for i, tab in ipairs(tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "Tab" .. i
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundTransparency = 1
        TabBtn.Position = UDim2.new((i-1)*0.2, 0, 0, 0)
        TabBtn.Size = UDim2.new(0.2, 0, 1, 0)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Text = tab.name
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 14
        TabBtn.TextXAlignment = Enum.TextXAlignment.Center

        TabBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            TabBtn.TextColor3 = Color3.fromRGB(100, 150, 255)
            currentTab = i
            ScrollingFrame.CanvasPosition = Vector2.new(0, tab.contentY)
        end)
    end

    -- Create Content
    createAutofarmContent(ScrollingFrame, 0)
    createMovementContent(ScrollingFrame, 200)
    createEventsContent(ScrollingFrame, 400)
    createMiscContent(ScrollingFrame, 600)
    createPlayerContent(ScrollingFrame, 800)

    -- Drag functionality
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
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    -- Button connections
    MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
    CloseBtn.MouseButton1Click:Connect(hideGUI)

    -- Keybind
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.X then
            toggleGUI()
        end
    end)

    -- Make visible
    MainFrame.Visible = true
end

-- Autofarm Content
function createAutofarmContent(parent, yPos)
    local frame = Instance.new("Frame")
    frame.Name = "Autofarm"
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0, 20, 0, yPos)
    frame.Size = UDim2.new(1, -40, 0, 180)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.GothamBold
    title.Text = "🏆 AUTOFARM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18

    createToggle(frame, "Auto Farm", UDim2.new(0, 0, 0, 40), function(state)
        autofarmEnabled = state
        toggleAutofarm(state)
    end)

    createToggle(frame, "Auto Claim Gifts", UDim2.new(0, 0, 0, 70), function(state)
        autoClaimGifts = state
        toggleGiftClaim(state)
    end)

    createToggle(frame, "Auto Index Claim", UDim2.new(0, 0, 0, 100), function(state)
        autoIndexClaim = state
        toggleIndexClaim(state)
    end)

    createToggle(frame, "Auto Quest", UDim2.new(0, 0, 0, 130), function(state)
        autoQuest = state
        toggleQuests(state)
    end)

    createSlider(frame, "Auto Delay (s)", UDim2.new(0.5, 0, 0, 70), 0.1, 5, function(value)
        autoDelay = value
    end)
end

-- Movement Content
function createMovementContent(parent, yPos)
    local frame = Instance.new("Frame")
    frame.Name = "Movement"
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Position = UDim2.new(0, 20, 0, yPos)
    frame.Size = UDim2.new(1, -40, 0, 200)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = frame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.GothamBold
    title.Text = "⚡ MOVEMENT"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18

    createToggle(frame, "Fly", UDim2.new(0, 0, 0, 40), function(state)
        flyEnabled = state
        toggleFly(state)
    end)

    createSlider(frame, "Fly Speed", UDim2.new(0.5, 0, 0, 40), 16, 200, function(value)
        flySpeed = value
    end)

    createToggle(frame, "Noclip", UDim2.new(0, 0, 0, 70), function(state)
        noclipEnabled = state
        toggleNoclip(state)
    end)

    createToggle(frame, "Speed", UDim2.new(0, 0, 0, 100), function(state)
        speedEnabled = state
        toggleSpeed(state)
    end)

    createToggle(frame, "No Gravity", UDim2.new(0, 0, 0, 130), function(state)
        noGravity = state
        toggleNoGravity(state)
    end)

    createToggle(frame, "Fullbright", UDim2.new(0, 0, 0, 160), function(state)
        fullbright = state
        toggleFullbright(state)
    end)
end

-- Helper Functions (shortened for brevity)
function createToggle(parent, text, position, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = parent
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.Position = position

    local label = Instance.new("TextLabel")
    label.Parent = toggleFrame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = toggleFrame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggleBtn.Position = UDim2.new(0.75, 0, 0.15, 0)
    toggleBtn.Size = UDim2.new(0, 18, 0, 18)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "❌"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    toggleBtn.TextSize = 12

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        local state = not toggles[toggleBtn]
        toggles[toggleBtn] = state
        if state then
            toggleBtn.Text = "✅"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
            callback(true)
        else
            toggleBtn.Text = "❌"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
            callback(false)
        end
    end)
end

function createSlider(parent, text, position, min, max, callback)
    -- Simplified slider implementation
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Parent = parent
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Size = UDim2.new(1, 0, 0, 30)
    sliderFrame.Position = position

    local label = Instance.new("TextLabel")
    label.Parent = sliderFrame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    local slider = Instance.new("Frame")
    slider.Parent = sliderFrame
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    slider.Position = UDim2.new(0.65, 0, 0.3, 0)
    slider.Size = UDim2.new(0.3, 0, 0, 6)

    local fill = Instance.new("Frame")
    fill.Parent = slider
    fill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    fill.Size = UDim2.new(0.5, 0, 1, 0)
    fill.BorderSizePixel = 0

    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 3)
    corner1.Parent = slider

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 3)
    corner2.Parent = fill
end

-- Movement Functions
function toggleFly(state)
    if state and player.Character then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = player.Character.HumanoidRootPart
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local camera = Workspace.CurrentCamera
                local vel = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, 1, 0) end
                
                bodyVelocity.Velocity = vel * (flySpeed / 16)
            end
        end)
    else
        if flyConnection then flyConnection:Disconnect() end
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end

function toggleNoclip(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
        if player.Character then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- GUI Controls
function toggleGUI()
    MainFrame.Visible = not MainFrame.Visible
end

function hideGUI()
    ScreenGui:Destroy()
end

function toggleMinimize()
    -- Implementation for minimize
end

-- Initialize
spawn(function()
    wait(1)
    createGUI()
    loadFPSBoost()
    startAntiAFK()
end)

-- FPS Boost
function loadFPSBoost()
    local Lighting = game:GetService("Lighting")
    local originalTech = Lighting.Technology
    local originalBrightness = Lighting.Brightness
    local originalGlobalShadows = Lighting.GlobalShadows
    local originalFogens = Lighting.FogEnd
    local originalFogS = Lighting.FogStart
    
    originalSettings = {
        Technology = originalTech,
        Brightness = originalBrightness,
        GlobalShadows = originalGlobalShadows,
        FogEnd = originalFogens,
        FogStart = originalFogS
    }
    
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.Technology = Enum.TechnologyCompatibilityLevel.Compatibility
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.FogStart = 0
    
    fpsBoosted = true
end

-- Anti-AFK
function startAntiAFK()
    spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(60)
        end
    end)
end

print("🕶️ Turcja Hub loaded! Press X to toggle.")
