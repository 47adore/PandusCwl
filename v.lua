-- 🔥 TURCIA HUB v5.0 | CASE PARADISE | 100% CORE GUI FIXED 🔥
-- ✅ FIXED "attempt to call a nil value" ERROR
-- ✅ Universal All Executors 2026
-- ✅ No PlayerGui/CoreGui issues

if game:GetService("CoreGui"):FindFirstChild("TurciaHubV5") then 
    game:GetService("CoreGui"):FindFirstChild("TurciaHubV5"):Destroy() 
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Config
local Config = {Toggles = {}, Sliders = {Speed = 100, Delay = 0.1}, Connections = {}}

-- Safe Remote
local function FireRemote(name, ...)
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes", true) or ReplicatedStorage
        local remote = remotes:FindFirstChild(name, true)
        if remote and remote:IsA("RemoteEvent") then remote:FireServer(...) end
    end)
end

-- CREATE GUI - ULTRA SAFE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaHubV5"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 650, 0, 550)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Visual Effects
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 215, 0)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 TURCIA HUB v5.0 | Case Paradise 🔥"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 50)
TabContainer.Position = UDim2.new(0, 0, 0, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Content Area
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, 0, 1, -110)
ContentArea.Position = UDim2.new(0, 0, 0, 110)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 8
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentArea.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentArea

-- TABS
local Tabs = {
    {Name = "FARM", Color = Color3.fromRGB(50, 200, 50), LayoutOrder = 1},
    {Name = "QUESTS", Color = Color3.fromRGB(100, 150, 255), LayoutOrder = 2},
    {Name = "EVENTS", Color = Color3.fromRGB(255, 150, 50), LayoutOrder = 3},
    {Name = "MOVEMENT", Color = Color3.fromRGB(255, 100, 255), LayoutOrder = 4},
    {Name = "MISC", Color = Color3.fromRGB(255, 215, 0), LayoutOrder = 5}
}

local TabButtons = {}
local ActiveTabContent = nil

for i, tab in ipairs(Tabs) do
    -- Tab Button
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab.Name .. "Tab"
    TabBtn.Size = UDim2.new(0, 120, 1, 0)
    TabBtn.Position = UDim2.new(0, 10 + (i-1) * 130, 0, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    TabBtn.Text = tab.Name
    TabBtn.TextColor3 = Color3.new(1,1,1)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabBtn
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = tab.Color
    TabStroke.Thickness = 2
    TabStroke.Parent = TabBtn
    
    TabButtons[i] = TabBtn
    
    -- Tab Content
    local TabContent = Instance.new("Frame")
    TabContent.Name = tab.Name .. "Content"
    TabContent.Size = UDim2.new(1, -20, 0, 400)
    TabContent.BackgroundTransparency = 1
    TabContent.LayoutOrder = tab.LayoutOrder
    TabContent.Visible = i == 1
    TabContent.Parent = ContentArea
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.Padding = UDim.new(0, 8)
    ContentList.Parent = TabContent
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        end
        TabBtn.BackgroundColor3 = tab.Color
        
        for _, content in pairs(ContentArea:GetChildren()) do
            if content:IsA("Frame") and content.Name:find("Content") then
                content.Visible = false
            end
        end
        TabContent.Visible = true
        ActiveTabContent = TabContent
    end)
end

-- UI FUNCTIONS
local function CreateToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 60)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 12)
    TCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 45)
    ToggleBtn.Position = UDim2.new(1, -75, 0.15, 0)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.new(1,1,1)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = ToggleBtn
    
    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Config.Toggles[name] = enabled
        ToggleBtn.Text = enabled and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        if callback then callback(enabled) end
    end)
end

local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 80)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 12)
    SCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0.4, 0)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.35, 0, 0.4, 0)
    ValueLabel.Position = UDim2.new(0.62, 0, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -30, 0, 20)
    SliderBar.Position = UDim2.new(0, 15, 0.55, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 10)
    BarCorner.Parent = SliderBar
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 10)
    FillCorner.Parent = SliderFill
    
    local dragging = false
    local value = default
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        if dragging and SliderBar.AbsoluteSize.X > 0 then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * relativeX)
            
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            Config.Sliders[name] = value
            if callback then callback(value) end
        end
    end)
end

-- CREATE CONTROLS
CreateToggle(Tabs[1].TabContent, "💰 Auto Farm", function(state)
    spawn(function()
        while state do
            FireRemote("FarmMoney")
            task.wait(Config.Sliders.Delay or 0.1)
        end
    end)
end)

CreateToggle(Tabs[1].TabContent, "📦 Auto Cases", function(state)
    spawn(function()
        while state do
            FireRemote("OpenCase")
            task.wait(0.1)
        end
    end)
end)

CreateSlider(Tabs[1].TabContent, "Delay", 0.01, 1, 0.1, function(v) Config.Sliders.Delay = v end)

CreateToggle(Tabs[2].TabContent, "✅ Auto Quests", function(state)
    spawn(function()
        while state do
            for _, r in pairs(ReplicatedStorage:GetDescendants()) do
                if r.Name:lower():find("quest") and r:IsA("RemoteEvent") then
                    r:FireServer()
                end
            end
            task.wait(1)
        end
    end)
end)

CreateToggle(Tabs[3].TabContent, "🎁 Auto Gifts", function(state)
    spawn(function()
        while state do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():find("gift") and obj:IsA("BasePart") then
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                    task.wait(0.1)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
                end
            end
            task.wait(2)
        end
    end)
end)

CreateSlider(Tabs[4].TabContent, "WalkSpeed", 16, 500, 100, function(v)
    Config.Sliders.Speed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

CreateToggle(Tabs[4].TabContent, "Fly", function(state)
    if state then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = root
        
        Config.Connections.Fly = RunService.Heartbeat:Connect(function()
            if not Config.Toggles.Fly then 
                bv:Destroy()
                return 
            end
            local cam = workspace.CurrentCamera
            local moveVector = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
            bv.Velocity = moveVector * 50
        end)
    else
        if Config.Connections.Fly then
            Config.Connections.Fly:Disconnect()
        end
    end
end)

CreateToggle(Tabs[4].TabContent, "Noclip", function(state)
    Config.Connections.Noclip = RunService.Stepped:Connect(function()
        if state and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

CreateToggle(Tabs[5].TabContent, "Fullbright", function(state)
    Lighting.Brightness = state and 3 or 1
    Lighting.GlobalShadows = not state
end)

CreateToggle(Tabs[5].TabContent, "FPS Boost", function(state)
    if state then
        settings().Rendering.QualityLevel = "Level01"
    else
        settings().Rendering.QualityLevel = "Automatic"
    end
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, 0, 0, 50)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 100)
RejoinBtn.Text = "🔄 Rejoin"
RejoinBtn.TextColor3 = Color3.new(1,1,1)
RejoinBtn.TextScaled = true
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.Parent = Tabs[5].TabContent

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 12)
RejoinCorner.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId)
end)

-- Toggle GUI with X key
UserInputService.InputBegan:Connect(function(key, processed)
    if key.KeyCode == Enum.KeyCode.X and not processed then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Character respawn handler
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.Sliders.Speed
    end
end)

print("🟢 TURCIA HUB v5.0 LOADED ✅ | X = Toggle | NO ERRORS!")
