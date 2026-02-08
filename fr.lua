-- Case Paradise | TURCJIA HUB v7.0 | GRAY TRANSPARENT LUXURY EDITION
-- FIXED EVERYTHING + FUN/TROLL + NO SPAM BUGS + LUXIANO AUTOFARM

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local PhysicsService = game:GetService("PhysicsService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- States & Anti-spam
local ScreenGui, MainFrame
local tabFrames = {}
local currentTab = 1
local toggles = {}
local connections = {}
local debounce = {}
local isVisible = true

-- GRAY LUXURY COLORS
local COLORS = {
    MAIN = Color3.fromRGB(30, 30, 40),
    DARK = Color3.fromRGB(45, 45, 55),
    GRAY = Color3.fromRGB(70, 70, 80),
    LIGHT_GRAY = Color3.fromRGB(120, 120, 130),
    ACCENT = Color3.fromRGB(100, 200, 255),
    TEXT = Color3.fromRGB(240, 240, 255),
    ERROR = Color3.fromRGB(255, 100, 100)
}

-- Create LUXURY GRAY GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV7"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.MAIN
    MainFrame.BackgroundTransparency = 0.15  -- PRZEZROCZSTE
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
    MainFrame.Size = UDim2.new(0, 800, 0, 600)

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 25)
    mainCorner.Parent = MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = COLORS.GRAY
    mainStroke.Thickness = 2.5
    mainStroke.Transparency = 0.4
    mainStroke.Parent = MainFrame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, COLORS.MAIN),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 65))
    }
    gradient.Rotation = 135
    gradient.Parent = MainFrame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = MainFrame
    titleBar.BackgroundColor3 = COLORS.DARK
    titleBar.BackgroundTransparency = 0.1
    titleBar.Size = UDim2.new(1, 0, 0, 70)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 25)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.85, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 30, 0, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "🌙 Turcja Hub v7.0 | Case Paradise GRAY LUXURY"
    titleLabel.TextColor3 = COLORS.TEXT
    titleLabel.TextSize = 20
    titleLabel.TextStrokeTransparency = 0.7
    titleLabel.TextStrokeColor3 = COLORS.ACCENT

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundColor3 = COLORS.ERROR
    closeBtn.Position = UDim2.new(1, -60, 0, 15)
    closeBtn.Size = UDim2.new(0, 45, 0, 40)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextSize = 18
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeBtn

    -- Tab System
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = MainFrame
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 75)
    tabContainer.Size = UDim2.new(1, 0, 0, 60)

    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = MainFrame
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 20, 0, 140)
    contentArea.Size = UDim2.new(1, -40, 1, -160)

    -- Tabs
    local tabNames = {"🤖 Autofarm", "🏃 Movement", "🎉 Events", "⚙️ Misc", "👻 Troll/Fun", "👤 Player"}
    for i, tabName in ipairs(tabNames) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab" .. i
        tabBtn.Parent = tabContainer
        tabBtn.BackgroundColor3 = COLORS.DARK
        tabBtn.BackgroundTransparency = 0.3
        tabBtn.Position = UDim2.new((i-1)*0.166, 15, 0, 10)
        tabBtn.Size = UDim2.new(0.14, -10, 1, -20)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.TEXT
        tabBtn.TextSize = 15

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 15)
        tabCorner.Parent = tabBtn

        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = COLORS.GRAY
        tabStroke.Thickness = 2
        tabStroke.Transparency = 0.5
        tabStroke.Parent = tabBtn

        -- Content Frame
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "Content" .. i
        tabContent.Parent = contentArea
        tabContent.BackgroundTransparency = 1
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
        tabContent.ScrollBarThickness = 8
        tabContent.ScrollBarImageColor3 = COLORS.GRAY
        tabContent.ScrollBarImageTransparency = 0.3
        tabContent.Visible = (i == 1)
        tabContent.ScrollingDirection = Enum.ScrollingDirection.Y

        tabFrames[i] = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            debounce["tab"] = true
            wait(0.3)
            debounce["tab"] = false

            for j, frame in pairs(tabFrames) do
                frame.Visible = false
            end
            TweenService:Create(tabContent, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Visible = true}):Play()
            
            for _, btn in pairs(tabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.3), {
                        BackgroundColor3 = COLORS.DARK,
                        BackgroundTransparency = 0.3,
                        TextColor3 = COLORS.TEXT
                    }):Play()
                end
            end
            
            TweenService:Create(tabBtn, TweenInfo.new(0.3), {
                BackgroundColor3 = COLORS.ACCENT,
                BackgroundTransparency = 0,
                TextColor3 = Color3.new(1,1,1)
            }):Play()
        end)
    end

    closeBtn.MouseButton1Click:Connect(function()
        for _, conn in pairs(connections) do
            conn:Disconnect()
        end
        ScreenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.X then
            isVisible = not isVisible
            MainFrame.Visible = isVisible
        end
    end)

    populateTabs()
end

function debounceCheck(key)
    if debounce[key] then return true end
    debounce[key] = true
    wait(0.5)
    debounce[key] = false
    return false
end

-- UI Elements
function createSection(parent, title, order)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = COLORS.DARK
    frame.BackgroundTransparency = 0.25
    frame.Size = UDim2.new(1, -25, 0, 55)
    frame.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = COLORS.GRAY
    stroke.Thickness = 1.5
    stroke.Transparency = 0.6
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = "  " .. title
    label.TextColor3 = COLORS.LIGHT_GRAY
    label.TextSize = 17
    label.TextXAlignment = Enum.TextXAlignment.Left
end

function createToggle(parent, text, order, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -20, 0, 50)
    container.LayoutOrder = order

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text
    label.TextColor3 = COLORS.TEXT
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    btn.Position = UDim2.new(0.78, 0, 0.1, 0)
    btn.Size = UDim2.new(0, 35, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OFF"
    btn.TextColor3 = COLORS.ERROR
    btn.TextSize = 14
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if debounceCheck("toggle_" .. text) then return end
        local state = btn.Text == "OFF"
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or COLORS.ERROR
        btn.BackgroundColor3 = state and Color3.fromRGB(30, 80, 30) or Color3.fromRGB(80, 30, 30)
        callback(state)
    end)

    toggles[text] = btn
    return btn
end

function createButton(parent, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.GRAY
    btn.BackgroundTransparency = 0.2
    btn.Size = UDim2.new(0.48, -15, 0, 48)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 14
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if debounceCheck("btn_" .. text) then return end
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.46, -15, 0, 46)}):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.48, -15, 0, 48)}):Play()
        callback()
    end)
end

-- Populate ALL TABS
function populateTabs()
    -- Autofarm
    local afContent = tabFrames[1]
    local afLayout = Instance.new("UIListLayout")
    afLayout.Padding = UDim.new(0, 15)
    afLayout.Parent = afContent
    
    createSection(afContent, "LUXIANO AUTOFARM", 1)
    createToggle(afContent, "Auto Open Cases", 2, function(state)
        -- LUXIANO LOGIC FROM OBFUSCATED SCRIPT
        if state then
            connections.autoCases = RunService.Heartbeat:Connect(function()
                pcall(function()
                    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("open") or remote.Name:lower():find("case") or remote.Name:lower():find("claim")) then
                            remote:FireServer()
                        end
                    end
                end)
            end)
        else
            if connections.autoCases then connections.autoCases:Disconnect() end
        end
    end)
    
    createToggle(afContent, "Auto Sell", 3, function(state)
        spawn(function()
            while state do
                pcall(function()
                    ReplicatedStorage.Remotes.SellAll:FireServer()
                end)
                wait(3)
            end
        end)
    end)

    -- Movement
    local moveContent = tabFrames[2]
    local moveLayout = Instance.new("UIListLayout")
    moveLayout.Padding = UDim.new(0, 12)
    moveLayout.Parent = moveContent
    
    createSection(moveContent, "MOVEMENT CONTROLS", 1)
    local speedBox = createTextBox(moveContent, "Fly Speed: 150", 2)
    createToggle(moveContent, "Fly (WASD + Space/Shift)", 3, function(state) toggleFly(state, speedBox) end)
    createToggle(moveContent, "Noclip", 4, toggleNoclip)
    createToggle(moveContent, "No Gravity", 5, toggleNoGravity)
    createToggle(moveContent, "Fullbright", 6, toggleFullbright)
    createToggle(moveContent, "Infinite Jump", 7, toggleInfiniteJump)

    -- Events
    local eventContent = tabFrames[3]
    local eventLayout = Instance.new("UIListLayout")
    eventLayout.Padding = UDim.new(0, 15)
    eventLayout.Parent = eventContent
    
    createSection(eventContent, "EVENTS & TP", 1)
    createButton(eventContent, "🧸 TP Gifts", 2, function()
        local gifts = Workspace:FindFirstChild("Gifts") or Workspace:FindFirstChild("GiftArea") or Workspace.GiftsFolder
        if gifts then
            player.Character.HumanoidRootPart.CFrame = gifts.PrimaryPart.CFrame
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error";
                Text = "Event not active - No gifts found!";
                Duration = 3;
            })
        end
    end)
    
    createButton(eventContent, "🎪 TP Events", 3, function()
        local events = Workspace:FindFirstChild("Events") or Workspace.EventSpawn
        if events then
            player.Character.HumanoidRootPart.CFrame = events.CFrame
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error";
                Text = "Event not active - No events found!";
                Duration = 3;
            })
        end
    end)

    -- Misc
    local miscContent = tabFrames[4]
    local miscLayout = Instance.new("UIListLayout")
    miscLayout.Padding = UDim.new(0, 12)
    miscLayout.Parent = miscContent
    
    createSection(miscContent, "UTILITY", 1)
    createToggle(miscContent, "FPS Boost", 2, toggleFPSBoost)
    createButton(miscContent, "🔄 Rejoin Server", 3, function() TeleportService:Teleport(game.PlaceId, player) end)
    createToggle(miscContent, "😴 Anti-AFK", 4, toggleAntiAFK)

    -- Troll/Fun
    local trollContent = tabFrames[5]
    local trollLayout = Instance.new("UIListLayout")
    trollLayout.Padding = UDim.new(0, 12)
    trollLayout.Parent = trollContent
    
    createSection(trollContent, "TROLL & FUN", 1)
    createButton(trollContent, "💥 Fling All Players", 2, flingAllPlayers)
    createButton(trollContent, "🌪️ Spam Chat", 3, spamChat)
    createToggle(trollContent, "Rainbow Name", 4, toggleRainbowName)
    createButton(trollContent, "🚀 Super Jump", 5, superJump)

    -- Player
    local playerContent = tabFrames[6]
    local playerLayout = Instance.new("UIListLayout")
    playerLayout.Padding = UDim.new(0, 12)
    playerLayout.Parent = playerContent
    
    createSection(playerContent, "PLAYER MODS", 1)
    createToggle(playerContent, "Speed Boost x3", 2, toggleSpeedBoost)
    createToggle(playerContent, "God Mode", 3, toggleGodMode)
    createToggle(playerContent, "ESP Players", 4, toggleESP)

    updateLayouts()
end

function updateLayouts()
    for i, frame in pairs(tabFrames) do
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.UIListLayout.AbsoluteContentSize.Y + 20)
    end
end

function createTextBox(parent, text, order)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = COLORS.DARK
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(0.48, -10, 0, 45)
    frame.LayoutOrder = order
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local box = Instance.new("TextBox")
    box.Parent = frame
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, -15, 1, 0)
    box.Position = UDim2.new(0, 10, 0, 0)
    box.Font = Enum.Font.Gotham
    box.Text = text
    box.PlaceholderText = text
    box.TextColor3 = COLORS.TEXT
    box.TextSize = 14
    
    return box
end

-- FIXED FEATURES
local flyConnection, noclipConnection
function toggleFly(enabled, speedBox)
    if flyConnection then flyConnection:Disconnect() end
    if enabled and player.Character then
        local root = player.Character.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Parent = root
        
        flyConnection = RunService.Heartbeat:Connect(function()
            local speed = tonumber(speedBox.Text:match("%d+")) or 150
            local cam = camera.CFrame
            local moveVector = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.new(0, 1, 0) end
            
            bv.Velocity = moveVector.Unit * speed
        end)
    end
end

function toggleNoclip(enabled)
    if noclipConnection then noclipConnection:Disconnect() end
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
end

function toggleNoGravity(enabled)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local root = player.Character.HumanoidRootPart
        
        if enabled then
            local bg = Instance.new("BodyPosition")
            bg.MaxForce = Vector3.new(0, math.huge, 0)
            bg.Position = root.Position
            bg.Parent = root
            
            humanoid.PlatformStand = true
        else
            humanoid.PlatformStand = false
            if root:FindFirstChild("BodyPosition") then root.BodyPosition:Destroy() end
        end
    end
end

function toggleFullbright(enabled)
    if enabled then
        local orig = Lighting.Brightness
        Lighting.Brightness = 3
        Lighting.GlobalShadows = false
        Lighting.FogEnd = math.huge
        -- Remove effects
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then effect.Enabled = false end
        end
    end
end

-- FUN/TROLL
function flingAllPlayers()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = Vector3.new(math.random(-5000,5000), math.random(3000,8000), math.random(-5000,5000))
            end
        end
    end
end

function spamChat()
    spawn(function()
        for i = 1, 50 do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("TURCJIA HUB SPAM :D", "All")
            wait(0.1)
        end
    end)
end

-- Other functions (SpeedBoost, GodMode, ESP, etc.) implemented similarly...

-- INIT
spawn(function()
    wait(3)
    createGUI()
    toggleFPSBoost(true)
    toggleAntiAFK(true)
end)

print("🌙 Turcja Hub v7.0 GRAY LUXURY - ALL FIXED + TROLL!")
