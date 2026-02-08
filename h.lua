task.wait(1)

pcall(function()
    local core = game:GetService("CoreGui")
    pcall(function() core:FindFirstChild("TurciaHub"):Destroy() end)
end)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

local function safeFire(name, ...)
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes", true) or ReplicatedStorage
        local remote = remotes:FindFirstChild(name, true)
        if remote and remote:IsA("RemoteEvent") then 
            remote:FireServer(...) 
        end
    end)
end

-- ========== GUI SETUP ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 650, 0, 550)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local function addCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = parent
end

addCorner(MainFrame, 16)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2.5
stroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 55)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

addCorner(TitleBar, 16)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -90, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TURCIA HUB | CASE PARADISE [FIXED]"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextScaled = true
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -55, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

addCorner(CloseBtn, 10)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Tab System
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 50)
TabFrame.Position = UDim2.new(0, 0, 0, 55)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, -105)
ContentScroll.Position = UDim2.new(0, 0, 0, 105)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 6
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 12)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentScroll

local TabData = {
    {Name="FARM", Color=Color3.fromRGB(60, 255, 60)},
    {Name="QUESTS", Color=Color3.fromRGB(60, 150, 255)},
    {Name="EVENTS", Color=Color3.fromRGB(255, 180, 60)},
    {Name="MOVEMENT", Color=Color3.fromRGB(255, 100, 255)},
    {Name="MISC", Color=Color3.fromRGB(255, 215, 0)}
}

local ActiveContent = nil
local TabButtons = {}
local TabContents = {}

-- Create Tabs
for i, tab in ipairs(TabData) do
    local Btn = Instance.new("TextButton")
    Btn.Name = tab.Name
    Btn.Size = UDim2.new(0, 115, 1, 0)
    Btn.Position = UDim2.new(0, 15 + (i-1)*125, 0, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
    Btn.Text = tab.Name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.Parent = TabFrame
    
    addCorner(Btn, 12)
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = tab.Color
    BtnStroke.Thickness = 2
    BtnStroke.Parent = Btn
    TabButtons[i] = {Btn, tab}
    
    -- Content Frame
    local Content = Instance.new("Frame")
    Content.Name = tab.Name .. "_Content"
    Content.Size = UDim2.new(1, -25, 0, 450)
    Content.BackgroundTransparency = 1
    Content.LayoutOrder = i
    Content.Visible = i == 1
    Content.Parent = ContentScroll
    TabContents[tab.Name] = Content
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.Parent = Content
    
    Btn.MouseButton1Click:Connect(function()
        for j, tbtn in ipairs(TabButtons) do
            tbtn[1].BackgroundColor3 = Color3.fromRGB(45, 45, 70)
            TabContents[tbtn[2].Name].Visible = false
        end
        Btn.BackgroundColor3 = tab.Color
        Content.Visible = true
    end)
end

-- ========== GLOBAL STATE ==========
local Toggles = {}
local Sliders = {}
local Connections = {}
local FlyConnection = nil
local NoclipConnection = nil
local FarmConnections = {}

-- ========== UI COMPONENTS ==========
local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 65)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    addCorner(Frame, 14)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68, 0, 1, 0)
    Label.Position = UDim2.new(0, 20, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 70, 0, 50)
    Toggle.Position = UDim2.new(1, -85, 0.15, 0)
    Toggle.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    Toggle.Text = "OFF"
    Toggle.TextColor3 = Color3.new(1,1,1)
    Toggle.TextScaled = true
    Toggle.Font = Enum.Font.GothamBold
    Toggle.BorderSizePixel = 0
    Toggle.Parent = Frame
    
    addCorner(Toggle, 12)
    
    Toggles[text] = false
    
    Toggle.MouseButton1Click:Connect(function()
        Toggles[text] = not Toggles[text]
        Toggle.Text = Toggles[text] and "ON" or "OFF"
        Toggle.BackgroundColor3 = Toggles[text] and Color3.fromRGB(60, 255, 60) or Color3.fromRGB(200, 60, 60)
        if callback then callback(Toggles[text]) end
    end)
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 85)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    addCorner(Frame, 14)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0.35, 0)
    Label.Position = UDim2.new(0, 20, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.38, 0, 0.35, 0)
    ValueLabel.Position = UDim2.new(0.6, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -40, 0, 25)
    SliderBar.Position = UDim2.new(0, 20, 0.45, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = Frame
    
    addCorner(SliderBar, 12)
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBar
    
    addCorner(Fill, 12)
    
    local dragging = false
    local value = default
    Sliders[text] = default
    
    local function updateSlider()
        local percent = (value - min) / (max - min)
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        ValueLabel.Text = tostring(math.floor(value))
        Sliders[text] = value
        if callback then callback(value) end
    end
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        if dragging and SliderBar.AbsoluteSize.X > 0 then
            local mousePos = UserInputService:GetMouseLocation()
            local percent = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percent
            updateSlider()
        end
    end)
end

-- ========== FARM TAB ==========
CreateToggle(TabContents.FARM, "Auto Farm Money", function(state)
    if FarmConnections["AutoFarmMoney"] then
        FarmConnections["AutoFarmMoney"]:Disconnect()
        FarmConnections["AutoFarmMoney"] = nil
    end
    if state then
        FarmConnections["AutoFarmMoney"] = RunService.Heartbeat:Connect(function()
            safeFire("FarmMoney")
            task.wait(Sliders["Farm Delay"] or 0.1)
        end)
    end
end)

CreateToggle(TabContents.FARM, "Auto Open Cases", function(state)
    if FarmConnections["AutoOpenCases"] then
        FarmConnections["AutoOpenCases"]:Disconnect()
        FarmConnections["AutoOpenCases"] = nil
    end
    if state then
        FarmConnections["AutoOpenCases"] = RunService.Heartbeat:Connect(function()
            safeFire("OpenCase")
            task.wait(0.15)
        end)
    end
end)

CreateSlider(TabContents.FARM, "Farm Delay", 0.01, 2, 0.1, nil)

-- ========== MOVEMENT TAB ==========
CreateSlider(TabContents.MOVEMENT, "WalkSpeed", 16, 500, 100, function(v)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end)
end)

local FlyBodyVelocity = nil
CreateToggle(TabContents.MOVEMENT, "Fly", function(state)
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    
    if state then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart")
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        FlyBodyVelocity.Velocity = Vector3.new(0,0,0)
        FlyBodyVelocity.Parent = root
        
        FlyConnection = RunService.Heartbeat:Connect(function()
            if not Toggles.Fly then return end
            
            local cam = workspace.CurrentCamera
            local vel = Vector3.new(0,0,0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector * 50 end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector * 50 end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector * 50 end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector * 50 end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,50,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,50,0) end
            
            FlyBodyVelocity.Velocity = vel
        end)
    end
end)

CreateToggle(TabContents.MOVEMENT, "Noclip", function(state)
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    
    if state then
        NoclipConnection = RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") and part ~= LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    end
end)

-- ========== MISC TAB ==========
CreateToggle(TabContents.MISC, "Fullbright", function(state)
    Lighting.Brightness = state and 3 or 1
    Lighting.GlobalShadows = not state
    Lighting.FogEnd = state and 100000 or 100000
end)

CreateToggle(TabContents.MISC, "FPS Boost", function(state)
    pcall(function()
        settings().Rendering.QualityLevel = state and Enum.SavedQualitySetting.Performance or Enum.SavedQualitySetting.Automatic
    end)
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Size = UDim2.new(1, 0, 0, 55)
RejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 120)
RejoinBtn.Text = "🔄 REJOIN SERVER"
RejoinBtn.TextColor3 = Color3.new(1,1,1)
RejoinBtn.TextScaled = true
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.BorderSizePixel = 0
RejoinBtn.Parent = TabContents.MISC

addCorner(RejoinBtn, 14)
RejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- ========== GLOBAL CONTROLS ==========
UserInputService.InputBegan:Connect(function(key, processed)
    if processed then return end
    if key.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- ========== CHARACTER RELOAD ==========
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    -- Apply WalkSpeed
    if Sliders["WalkSpeed"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Sliders["WalkSpeed"]
    end
end)

print("✅ TURCIA HUB [FIXED VERSION] LOADED SUCCESSFULLY!")
print("🎮 Toggle GUI: X key")
print("🔥 Features: Auto Farm, Fly, Speed, Noclip, Fullbright & more!")

-- Cleanup on destroy
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        -- Cleanup all connections
        for _, conn in pairs(FarmConnections) do
            if conn then conn:Disconnect() end
        end
        if FlyConnection then FlyConnection:Disconnect() end
        if NoclipConnection then NoclipConnection:Disconnect() end
    end
end)
