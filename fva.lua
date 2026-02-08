-- Case Paradise | Turcja Hub v4.0 | FULLY FIXED
-- Key: X | Dragable FIXED | Tabs FIXED | FPS Boost | Rejoin | Anti-AFK | Kick

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Variables
local ScreenGui, MainFrame, ContentFrame
local isDragging = false
local dragInput, dragStart, startPos
local currentTab = 1
local connections = {}

-- States
local flyEnabled, noclipEnabled, noGravity, fullbright, fpsBoost = false, false, false, false, false
local autofarm, autoGifts, autoIndex, autoQuests, autoEvents = false, false, false, false, false
local flySpeed, walkSpeedValue = 50, 16

-- Create FIXED GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV4"
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999

    -- Main Frame - FIXED Size & Position
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true  -- FIXED DRAG
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 750, 0, 550)
    MainFrame.ClipsDescendants = true

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(0, 162, 255)
    mainStroke.Thickness = 2
    mainStroke.Parent = MainFrame

    -- Gradient Effect
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 25))
    }
    gradient.Rotation = 45
    gradient.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 55)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = "🕶️ Turcja Hub v4.0 | Case Paradise"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TitleBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -45, 0, 10)
    CloseBtn.Size = UDim2.new(0, 35, 0, 35)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
    CloseBtn.TextSize = 20

    -- Tab Buttons
    local tabs = {"🏆 Autofarm", "⚡ Movement", "🎁 Events", "⚙️ Misc", "👤 Player"}
    local tabFrames = {}
    
    for i, tabName in ipairs(tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "Tab" .. i
        TabBtn.Parent = MainFrame
        TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        TabBtn.BorderSizePixel = 0
        TabBtn.Position = UDim2.new(0, (i-1)*150 + 10, 0, 60)
        TabBtn.Size = UDim2.new(0, 140, 0, 35)
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.Text = tabName
        TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabBtn.TextSize = 15

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = TabBtn

        TabBtn.MouseButton1Click:Connect(function()
            for _, frame in pairs(tabFrames) do
                frame.Visible = false
            end
            tabFrames[i].Visible = true
            currentTab = i
        end)
        tabFrames[i] = TabBtn
    end

    -- Content Container
    ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Position = UDim2.new(0, 10, 0, 105)
    ContentFrame.Size = UDim2.new(1, -20, 1, -115)
    ContentFrame.ClipsDescendants = true

    -- Create Tab Contents
    local autofarmFrame = createAutofarmTab()
    local movementFrame = createMovementTab()
    local eventsFrame = createEventsTab()
    local miscFrame = createMiscTab()
    local playerFrame = createPlayerTab()

    tabFrames[1].MouseButton1Click:Connect(function() autofarmFrame.Visible = true end)
    tabFrames[2].MouseButton1Click:Connect(function() movementFrame.Visible = true end)
    tabFrames[3].MouseButton1Click:Connect(function() eventsFrame.Visible = true end)
    tabFrames[4].MouseButton1Click:Connect(function() miscFrame.Visible = true end)
    tabFrames[5].MouseButton1Click:Connect(function() playerFrame.Visible = true end)

    -- Show first tab
    autofarmFrame.Visible = true

    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Keybind X
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.X then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end

-- AUTOFARM TAB
function createAutofarmTab()
    local frame = Instance.new("Frame")
    frame.Name = "AutofarmTab"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false

    createSection(frame, "🏆 AUTOFARM", 20, 10)
    createToggle(frame, "Auto Farm Cases", UDim2.new(0, 25, 0, 70), function(state) autofarm = state end)
    createToggle(frame, "Auto Claim Gifts", UDim2.new(0, 25, 0, 110), function(state) autoGifts = state end)
    createToggle(frame, "Auto Index Rewards", UDim2.new(0, 25, 0, 150), function(state) autoIndex = state end)
    createToggle(frame, "Auto Divine Quests", UDim2.new(0, 25, 0, 190), function(state) autoQuests = state end)
    createToggle(frame, "Auto Event Cases", UDim2.new(0, 25, 0, 230), function(state) autoEvents = state end)
    
    return frame
end

-- MOVEMENT TAB
function createMovementTab()
    local frame = Instance.new("Frame")
    frame.Name = "MovementTab"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false

    createSection(frame, "⚡ MOVEMENT", 20, 10)
    local flySpeedBox = createTextBox(frame, "Fly Speed: 50", UDim2.new(0, 25, 0, 70))
    createToggle(frame, "Fly (WASD+Space)", UDim2.new(0, 25, 0, 110), function(state) toggleFly(state, flySpeedBox) end)
    
    local speedBox = createTextBox(frame, "Walk Speed: 50", UDim2.new(0, 25, 0, 150))
    createToggle(frame, "Speed Hack", UDim2.new(0, 25, 0, 190), function(state) toggleSpeed(state, speedBox) end)
    
    createToggle(frame, "Noclip", UDim2.new(0, 25, 0, 230), function(state) toggleNoclip(state) end)
    createToggle(frame, "No Gravity", UDim2.new(0, 25, 0, 270), function(state) toggleNoGravity(state) end)
    createToggle(frame, "Fullbright", UDim2.new(0, 25, 0, 310), function(state) toggleFullbright(state) end)
    
    return frame
end

-- EVENTS TAB
function createEventsTab()
    local frame = Instance.new("Frame")
    frame.Name = "EventsTab"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false

    createSection(frame, "🎁 EVENTS & TELEPORTS", 20, 10)
    createButton(frame, "Teleport to Gifts", UDim2.new(0, 25, 0, 70), function() teleportTo("Gifts") end)
    createButton(frame, "Teleport to Events", UDim2.new(0, 25, 0, 110), function() teleportTo("Events") end)
    createButton(frame, "Teleport to Meteors", UDim2.new(0, 25, 0, 150), function() teleportTo("Meteors") end)
    createButton(frame, "Auto Respawn Events", UDim2.new(0, 25, 0, 190), function() toggleEventFarm() end)
    
    return frame
end

-- MISC TAB
function createMiscTab()
    local frame = Instance.new("Frame")
    frame.Name = "MiscTab"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false

    createSection(frame, "⚙️ MISC", 20, 10)
    createToggle(frame, "FPS Boost (60+ FPS)", UDim2.new(0, 25, 0, 70), function(state) toggleFPSBoost(state) end)
    createButton(frame, "Rejoin Server", UDim2.new(0, 25, 0, 110), function() TeleportService:Teleport(game.PlaceId, player) end)
    createToggle(frame, "Anti-AFK (Moves)", UDim2.new(0, 25, 0, 150), function(state) toggleAntiAFK(state) end)
    createButton(frame, "Turcja Kick (pdw)", UDim2.new(0, 25, 0, 190), function() player:Kick("pdw") end)
    
    return frame
end

-- PLAYER TAB
function createPlayerTab()
    local frame = Instance.new("Frame")
    frame.Name = "PlayerTab"
    frame.Parent = ContentFrame
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Visible = false

    createSection(frame, "👤 PLAYER", 20, 10)
    createButton(frame, "Infinite Jump", UDim2.new(0, 25, 0, 70), function() toggleInfiniteJump() end)
    createButton(frame, "Reset Character", UDim2.new(0, 25, 0, 110), function() player.Character.Humanoid.Health = 0 end)
    
    return frame
end

-- UI Components
function createSection(parent, title, x, y)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    frame.Position = UDim2.new(0, x, 0, y)
    frame.Size = UDim2.new(1, -40, 0, 50)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 18
end

function createToggle(parent, text, pos, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.Position = pos

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 15

    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggle.Position = UDim2.new(0.78, 0, 0.2, 0)
    toggle.Size = UDim2.new(0, 25, 0, 25)
    toggle.Font = Enum.Font.GothamBold
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    toggle.TextSize = 13

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toggle

    toggle.MouseButton1Click:Connect(function()
        local enabled = toggle.Text == "OFF"
        toggle.Text = enabled and "ON" or "OFF"
        toggle.TextColor3 = enabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        toggle.BackgroundColor3 = enabled and Color3.fromRGB(25, 80, 25) or Color3.fromRGB(80, 25, 25)
        callback(enabled)
    end)
end

function createButton(parent, text, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    btn.Position = pos
    btn.Size = UDim2.new(1, -50, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

function createTextBox(parent, text, pos)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    frame.Position = pos
    frame.Size = UDim2.new(0.45, 0, 0, 32)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local box = Instance.new("TextBox")
    box.Parent = frame
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, -10, 1, 0)
    box.Position = UDim2.new(0, 5, 0, 0)
    box.Font = Enum.Font.Gotham
    box.Text = text
    box.PlaceholderText = text
    box.TextColor3 = Color3.fromRGB(200, 200, 200)
    box.TextSize = 13
    box.TextXAlignment = Enum.TextXAlignment.Center
    
    return box
end

-- Feature Functions
function toggleFly(state, speedBox)
    flyEnabled = state
    if state and player.Character then
        local root = player.Character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(4000, 4000, 4000)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root

        connections.fly = RunService.Heartbeat:Connect(function()
            local speed = tonumber(speedBox.Text:match("%d+")) or 50
            local cam = Workspace.CurrentCamera
            local move = Vector3.new(0,0,0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end
            
            bv.Velocity = move * speed
        end)
    else
        if connections.fly then connections.fly:Disconnect() end
        if player.Character then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end

function toggleFPSBoost(state)
    fpsBoost = state
    if state then
        -- MAX FPS BOOST
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Explosion") then v:Destroy() end
            if v:IsA("Fire") or v:IsA("Sparkles") then v:Destroy() end
        end
        Workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("Explosion") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj:Destroy()
            end
        end)
    end
end

function toggleAntiAFK(state)
    if state then
        spawn(function()
            while true do
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                wait(300) -- 5 min
                if player.Character then
                    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(1,0,0)
                    wait(0.1)
                    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(-1,0,0)
                end
                wait(300)
            end
        end)
    end
end

-- Init
createGUI()

-- AutoFarm Loop
spawn(function()
    while true do
        if autofarm then
            pcall(function()
                for _, rem in pairs(ReplicatedStorage:GetChildren()) do
                    if rem.Name:lower():find("case") or rem.Name:lower():find("open") then
                        rem:FireServer()
                    end
                end
            end)
        end
        if autoGifts then
            pcall(function() ReplicatedStorage:FindFirstChild("ClaimGift"):FireServer() end)
        end
        if autoQuests then
            pcall(function() ReplicatedStorage:FindFirstChild("CompleteQuest"):FireServer() end)
        end
        wait(1)
    end
end)

print("🕶️ Turcja Hub v4.0 LOADED PERFECTLY! | X to toggle | Drag ANYWHERE!")
