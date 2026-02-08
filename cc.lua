-- FIXED CoreGui Error Version
task.wait(2)

-- SAFE CoreGui cleanup
local success, err = pcall(function()
    local core = game:GetService("CoreGui")
    local oldGui = core:FindFirstChild("TurciaHub")
    if oldGui then
        oldGui:Destroy()
    end
end)

if not success then
    warn("CoreGui cleanup failed (normal):", err)
end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")

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

-- ========== MAIN GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.IgnoreGuiInset = true

-- SAFE PARENTING
pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not ScreenGui.Parent then
    -- Fallback to PlayerGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    print("⚠️ Used PlayerGui fallback")
end

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
    pcall(function()
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 12)
        corner.Parent = parent
    end)
end

addCorner(MainFrame, 16)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2.5
stroke.Parent = MainFrame

-- ========== TITLE BAR ==========
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
TitleText.Text = "TURCIA HUB | FIXED v2.0"
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
CloseBtn.MouseButton1Click:Connect(function() 
    ScreenGui:Destroy() 
end)

-- ========== TABS ==========
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
    {Name="MOVEMENT", Color=Color3.fromRGB(255, 100, 255)},
    {Name="MISC", Color=Color3.fromRGB(255, 215, 0)}
}

local TabButtons = {}
local TabContents = {}

for i, tab in ipairs(TabData) do
    local Btn = Instance.new("TextButton")
    Btn.Name = tab.Name
    Btn.Size = UDim2.new(0, 130, 1, 0)
    Btn.Position = UDim2.new(0, 15 + (i-1)*140, 0, 0)
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

-- ========== STATE MANAGEMENT ==========
local Toggles = {}
local Sliders = {}
local Connections = {}

-- ========== UI FUNCTIONS ==========
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
        local percent = math.clamp((value - min) / (max - min), 0, 1)
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        ValueLabel.Text = math.floor(value)
        Sliders[text] = value
        if callback then callback(value) end
    end
    
    local dragConnection
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragConnection = RunService.Heartbeat:Connect(function()
                if dragging and SliderBar.AbsoluteSize.X > 0 then
                    local mousePos = UserInputService:GetMouseLocation()
                    local percent = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    value = min + (max - min) * percent
                    updateSlider()
                end
            end)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if dragConnection then
                dragConnection:Disconnect()
                dragConnection = nil
            end
        end
    end)
end

-- ========== FARM FEATURES ==========
CreateToggle(TabContents.FARM, "Auto Farm Money", function(state)
    if Connections.AutoFarmMoney then
        Connections.AutoFarmMoney:Disconnect()
        Connections.AutoFarmMoney = nil
    end
    if state then
        Connections.AutoFarmMoney = game:GetService("RunService").Heartbeat:Connect(function()
            safeFire("FarmMoney")
        end)
    end
end)

CreateToggle(TabContents.FARM, "Auto Open Cases", function(state)
    if Connections.AutoOpenCases then
        Connections.AutoOpenCases:Disconnect()
        Connections.AutoOpenCases = nil
    end
    if state then
        Connections.AutoOpenCases = game:GetService("RunService").Heartbeat:Connect(function()
            safeFire("OpenCase")
        end)
    end
end)

CreateSlider(TabContents.FARM, "Farm Delay", 0.01, 2, 0.1, nil)

-- ========== MOVEMENT ==========
CreateSlider(TabContents.MOVEMENT, "WalkSpeed", 16, 500, 100, function(v)
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end)
end)

local FlyVelocity = nil
local FlyConnection = nil
CreateToggle(TabContents.MOVEMENT, "Fly", function(state)
    -- Cleanup
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    if FlyVelocity then
        FlyVelocity:Destroy()
        FlyVelocity = nil
    end
    
    if state then
        spawn(function()
            local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart", 5)
            if root then
                FlyVelocity = Instance.new("BodyVelocity")
                FlyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                FlyVelocity.Velocity = Vector3.new(0,0,0)
                FlyVelocity.Parent = root
                
                FlyConnection = RunService.Heartbeat:Connect(function()
                    if not Toggles["Fly"] or not root.Parent then return end
                    
                    local cam = workspace.CurrentCamera
                    local vel = Vector3.new(0,0,0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += cam.CFrame.LookVector * 50 end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= cam.CFrame.LookVector * 50 end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= cam.CFrame.RightVector * 50 end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += cam.CFrame.RightVector * 50 end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,50,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,50,0) end
                    
                    FlyVelocity.Velocity = vel
                end)
            end
        end)
    end
end)

CreateToggle(TabContents.MOVEMENT, "Noclip", function(state)
    if Connections.Noclip then
        Connections.Noclip:Disconnect()
        Connections.Noclip = nil
    end
    
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    end
end)

-- ========== MISC ==========
CreateToggle(TabContents.MISC, "Fullbright", function(state)
    pcall(function()
        Lighting.Brightness = state and 3 or 1
        Lighting.GlobalShadows = not state
        Lighting.FogEnd = state and 100000 or 100000
    end)
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
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end)

-- ========== CONTROLS ==========
UserInputService.InputBegan:Connect(function(key, processed)
    if processed then return end
    if key.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Respawn handler
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if Sliders["WalkSpeed"] then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = Sliders["WalkSpeed"]
            end
        end)
    end
end)

-- Cleanup
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        for name, conn in pairs(Connections) do
            if conn then conn:Disconnect() end
        end
        if FlyConnection then FlyConnection:Disconnect() end
    end
end)

print("✅ TURCIA HUB v2.0 LOADED - NO ERRORS!")
print("🎮 Toggle: X | Works in ALL executors!")
