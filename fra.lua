-- Case Paradise | Turcja Hub v6.0 | LUXURY PINK + FIXED EVERYTHING
-- Key: X | PERFECT TABS | REAL LUXIANO AUTOFARM | SMOOTH FLY

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- States
local ScreenGui, MainFrame
local tabFrames = {}
local currentTabFrame = nil
local isVisible = true
local farmActive = false
local farmLoops = {}
local noclipConnection = nil
local flyConnection = nil
local infiniteJump = false

-- Movement vars
local flySpeed = 100
local bodyVelocity = nil
local bodyAngularVelocity = nil

-- Pink Colors
local COLORS = {
    MAIN = Color3.fromRGB(25, 15, 35),
    DARK = Color3.fromRGB(35, 20, 50),
    PINK = Color3.fromRGB(255, 100, 180),
    LIGHT_PINK = Color3.fromRGB(255, 150, 200),
    GLOW = Color3.fromRGB(200, 50, 150),
    TEXT = Color3.fromRGB(240, 240, 255),
    SUBTEXT = Color3.fromRGB(200, 180, 220)
}

-- Create LUXURY GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV6"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 1000
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.MAIN
    MainFrame.BackgroundTransparency = 0.1  -- SLIGHTLY TRANSPARENT
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 750, 0, 550)

    -- Smooth corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = MainFrame

    -- Glowing stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.PINK
    stroke.Thickness = 3
    stroke.Transparency = 0.3
    stroke.Parent = MainFrame

    -- Gradient effect
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, COLORS.MAIN),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 25, 60))
    }
    gradient.Rotation = 45
    gradient.Parent = MainFrame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = MainFrame
    titleBar.BackgroundColor3 = COLORS.DARK
    titleBar.BackgroundTransparency = 0.1
    titleBar.Size = UDim2.new(1, 0, 0, 60)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 20)
    titleCorner.Parent = titleBar

    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, COLORS.PINK),
        ColorSequenceKeypoint.new(1, COLORS.LIGHT_PINK)
    }
    titleGradient.Parent = titleBar

    local title = Instance.new("TextLabel")
    title.Parent = titleBar
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(0.8, 0, 1, 0)
    title.Position = UDim2.new(0, 25, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "💎 Turcja Hub v6.0 | Case Paradise LUXURY"
    title.TextColor3 = COLORS.TEXT
    title.TextSize = 18
    title.TextStrokeTransparency = 0.8
    title.TextStrokeColor3 = COLORS.PINK

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position = UDim2.new(1, -50, 0, 10)
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
    closeBtn.TextSize = 22

    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "Tabs"
    tabContainer.Parent = MainFrame
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 65)
    tabContainer.Size = UDim2.new(1, 0, 0, 50)

    -- Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = MainFrame
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 15, 0, 120)
    contentArea.Size = UDim2.new(1, -30, 1, -135)

    -- Create Tabs
    local tabNames = {"🏆 Autofarm", "⚡ Movement", "🎁 Events", "⚙️ Misc", "👤 Player"}
    for i, tabName in ipairs(tabNames) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "TabBtn" .. i
        tabBtn.Parent = tabContainer
        tabBtn.BackgroundColor3 = COLORS.DARK
        tabBtn.BackgroundTransparency = 0.2
        tabBtn.Position = UDim2.new((i-1)*0.2, 10, 0, 5)
        tabBtn.Size = UDim2.new(0.18, -20, 1, -10)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.SUBTEXT
        tabBtn.TextSize = 16

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 12)
        tabCorner.Parent = tabBtn

        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = COLORS.PINK
        tabStroke.Thickness = 1.5
        tabStroke.Transparency = 0.7
        tabStroke.Parent = tabBtn

        -- Tab Content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "TabContent" .. i
        tabContent.Parent = contentArea
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 6
        tabContent.ScrollBarImageColor3 = COLORS.PINK
        tabContent.Visible = (i == 1)
        tabContent.ScrollingDirection = Enum.ScrollingDirection.Y

        tabFrames[i] = tabContent
        currentTabFrame = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            for _, content in pairs(tabFrames) do
                content.Visible = false
            end
            TweenService:Create(tabContent, TweenInfo.new(0.3), {Visible = true}):Play()
            currentTabFrame = tabContent
            
            for j, btn in ipairs(tabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.2), {
                        BackgroundTransparency = 0.2,
                        TextColor3 = COLORS.SUBTEXT
                    }):Play()
                end
            end
            TweenService:Create(tabBtn, TweenInfo.new(0.2), {
                BackgroundTransparency = 0,
                BackgroundColor3 = COLORS.PINK,
                TextColor3 = Color3.new(1,1,1)
            }):Play()
        end)
    end

    -- Close Button
    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- X Toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.X then
            isVisible = not isVisible
            MainFrame.Visible = isVisible
        end
    end)

    -- Populate
    populateAutofarmTab(tabFrames[1])
    populateMovementTab(tabFrames[2])
    populateEventsTab(tabFrames[3])
    populateMiscTab(tabFrames[4])
    populatePlayerTab(tabFrames[5])
end

-- LUXIANO INTEGRATION + REAL REMOTES
local function findLuxianoRemotes()
    local remotes = {}
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:lower():match("open") or obj.Name:lower():match("case") or obj.Name:lower():match("claim") or obj.Name:lower():match("quest") or obj.Name:lower():match("sell") then
            table.insert(remotes, obj)
        end
    end
    return remotes
end

-- Populate Tabs
function populateAutofarmTab(content)
    local layout = Instance.new("UIListLayout")
    layout.Parent = content
    layout.Padding = UDim.new(0, 12)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    createSection(content, "💎 LUXIANO AUTOFARM", 1)
    
    createToggle(content, "Auto Open Cases", 2, function(state)
        if state then
            farmLoops.autoOpen = RunService.Heartbeat:Connect(function()
                if farmActive then
                    local remotes = findLuxianoRemotes()
                    for _, remote in pairs(remotes) do
                        pcall(function() remote:FireServer() end)
                    end
                    -- Force case open
                    pcall(function()
                        ReplicatedStorage.Remotes.OpenCase:FireServer("Basic")
                        ReplicatedStorage.Events.SpinWheel:FireServer()
                    end)
                end
            end)
        else
            if farmLoops.autoOpen then farmLoops.autoOpen:Disconnect() end
        end
    end)

    createToggle(content, "Auto Sell All", 3, function(state)
        if state then
            spawn(function()
                while state do
                    pcall(function()
                        ReplicatedStorage.Remotes.SellAll:FireServer()
                    end)
                    wait(5)
                end
            end)
        end
    end)
end

function populateMovementTab(content)
    local layout = Instance.new("UIListLayout")
    layout.Parent = content
    layout.Padding = UDim.new(0, 12)

    createSection(content, "⚡ MOVEMENT", 1)
    
    local flySpeedBox = createTextBox(content, "Fly Speed (150)", 2)
    createToggle(content, "Fly", 3, function(state) toggleFly(state, flySpeedBox) end)
    
    createToggle(content, "Noclip", 4, toggleNoclip)
    createToggle(content, "No Gravity", 5, toggleNoGravity)
    createToggle(content, "Fullbright", 6, toggleFullbright)
end

function populateEventsTab(content)
    local layout = Instance.new("UIListLayout")
    layout.Parent = content
    layout.Padding = UDim.new(0, 12)

    createSection(content, "🎁 EVENTS", 1)
    createButton(content, "TP Gifts", 2, function()
        local gift = Workspace:FindFirstChild("Gifts") or Workspace:FindFirstChild("Gift")
        if gift then
            player.Character.HumanoidRootPart.CFrame = gift.CFrame
        else
            warn("Event not active - No gifts found!")
        end
    end)
    
    createButton(content, "TP Events", 3, function()
        local event = Workspace:FindFirstChild("Events") or Workspace:FindFirstChild("Event")
        if event then
            player.Character.HumanoidRootPart.CFrame = event.CFrame
        else
            warn("Event not active - No events found!")
        end
    end)
end

function populateMiscTab(content)
    local layout = Instance.new("UIListLayout")
    layout.Parent = content
    layout.Padding = UDim.new(0, 12)

    createSection(content, "⚙️ MISC", 1)
    createToggle(content, "FPS Boost", 2, toggleFPSBoost)
    createButton(content, "Rejoin Server", 3, function() TeleportService:Teleport(game.PlaceId) end)
    createToggle(content, "Anti-AFK", 4, toggleAntiAFK)
    createButton(content, "Turcja Kick", 5, function() player:Kick("pdw") end)
end

function populatePlayerTab(content)
    local layout = Instance.new("UIListLayout")
    layout.Parent = content
    layout.Padding = UDim.new(0, 12)

    createSection(content, "👤 PLAYER", 1)
    createButton(content, "Infinite Jump", 2, toggleInfiniteJump)
    createToggle(content, "God Mode", 3, toggleGodMode)
    createToggle(content, "Speed Boost", 4, toggleSpeedBoost)
end

-- UI Helpers
function createSection(parent, title, order)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = COLORS.DARK
    frame.BackgroundTransparency = 0.15
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = title
    label.TextColor3 = COLORS.LIGHT_PINK
    label.TextSize = 16
end

function createToggle(parent, text, order, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 0, 45)
    container.LayoutOrder = order

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = COLORS.TEXT
    label.TextSize = 15

    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(80, 40, 100)
    btn.Position = UDim2.new(0.78, 0, 0.15, 0)
    btn.Size = UDim2.new(0, 28, 0, 28)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 120, 120)
    btn.TextSize = 13
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local enabled = btn.Text == "OFF"
        btn.Text = enabled and "ON" or "OFF"
        btn.TextColor3 = enabled and Color3.fromRGB(120, 255, 120) or Color3.fromRGB(255, 120, 120)
        btn.BackgroundColor3 = enabled and Color3.fromRGB(20, 100, 20) or Color3.fromRGB(100, 20, 20)
        callback(enabled)
    end)
end

function createButton(parent, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.PINK
    btn.BackgroundTransparency = 0.1
    btn.Size = UDim2.new(1, -20, 0, 42)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 15
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

function createTextBox(parent, text, order)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = COLORS.DARK
    frame.BackgroundTransparency = 0.2
    frame.Size = UDim2.new(0.45, 0, 0, 40)
    frame.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local box = Instance.new("TextBox")
    box.Parent = frame
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, -10, 1, 0)
    box.Position = UDim2.new(0, 5, 0, 0)
    box.Font = Enum.Font.Gotham
    box.Text = text
    box.PlaceholderText = text
    box.TextColor3 = COLORS.TEXT
    box.TextSize = 14
    
    return box
end

-- FIXED FEATURES
function toggleFly(enabled, speedBox)
    flyConnection = flyConnection and flyConnection:Disconnect()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        if enabled then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = root

            bodyAngularVelocity = Instance.new("BodyAngularVelocity")
            bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            bodyAngularVelocity.Parent = root

            flyConnection = RunService.Heartbeat:Connect(function()
                local speed = math.max(50, tonumber(speedBox.Text:match("%d+")) or 150)
                local move = player.Character.Humanoid.MoveDirection * speed
                local camLook = camera.CFrame.LookVector
                bodyVelocity.Velocity = Vector3.new(move.X, move.Z * camLook.Y + (UserInputService:IsKeyDown(Enum.KeyCode.Space) and speed or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and -speed or 0), move.Z)
            end)
        else
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyAngularVelocity then bodyAngularVelocity:Destroy() end
        end
    end
end

function toggleNoclip(enabled)
    if noclipConnection then noclipConnection:Disconnect() end
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end

function toggleFullbright(enabled)
    if enabled then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
    else
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = true
    end
end

function toggleNoGravity(enabled)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        if enabled then
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
end

-- Other functions...
function toggleFPSBoost(enabled) -- Already works
    if enabled then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for i,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Explosion") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Smoke") then
                v:Destroy()
            end
        end
    end
end

function toggleAntiAFK(enabled)
    spawn(function()
        while enabled do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(60)
        end
    end)
end

function toggleInfiniteJump(enabled)
    infiniteJump = enabled
    UserInputService.JumpRequest:Connect(function()
        if infiniteJump and player.Character then
            player.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end

-- Init
spawn(function()
    wait(2)
    createGUI()
    toggleFullbright(true)
    toggleFPSBoost(true)
end)

print("💎 Turcja Hub v6.0 LUXURY - PINK + FIXED FLY/NOCLIP/FULLBRIGHT + LUXIANO!")
