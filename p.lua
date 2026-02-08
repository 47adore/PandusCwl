local services = {
    Players = game:GetService("Players"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
    VirtualInputManager = game:GetService("VirtualInputManager")
}

local LocalPlayer = services.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Config
local Config = {
    Toggles = {},
    Sliders = {},
    Speed = 100,
    Delay = 1.0,
    Connections = {}
}

-- Safe Remote Caller
local function SafeRemoteCall(remoteName, ...)
    local success, err = pcall(function()
        local remote = services.ReplicatedStorage:FindFirstChild("Remotes") 
            and services.ReplicatedStorage.Remotes:FindFirstChild(remoteName)
        if remote then
            remote:FireServer(...)
        end
    end)
    if not success then
        warn("Remote call failed: " .. remoteName)
    end
end

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaHubCP"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 480)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Rounding
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 215, 0)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 50)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Text = "🟡 TURCIA HUB | Case Paradise Pro | X Toggle"
TitleLabel.TextColor3 = Color3.fromRGB(20, 20, 30)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Tab System
local Tabs = {
    {Name = "FARM", Icon = "💰"},
    {Name = "QUESTS", Icon = "📜"}, 
    {Name = "EVENTS", Icon = "🎉"},
    {Name = "MOVEMENT", Icon = "🏃"},
    {Name = "MISC", Icon = "⚙️"}
}

local TabButtons = {}
local TabContents = {}
local ActiveTab = 1

for i, tab in ipairs(Tabs) do
    -- Tab Button
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab.Name .. "Tab"
    TabBtn.Parent = MainFrame
    TabBtn.Position = UDim2.new(0, 15 + (i-1) * 100, 0, 60)
    TabBtn.Size = UDim2.new(0, 90, 0, 40)
    TabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(50, 150, 255) or Color3.fromRGB(40, 40, 60)
    TabBtn.Text = tab.Icon .. "\n" .. tab.Name
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn
    
    TabButtons[i] = TabBtn
    
    -- Tab Content
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Name = tab.Name .. "Content"
    TabContent.Parent = MainFrame
    TabContent.Position = UDim2.new(0, 0, 0, 110)
    TabContent.Size = UDim2.new(1, 0, 1, -110)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 6
    TabContent.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
    TabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
    TabContent.Visible = i == 1
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    TabContents[i] = TabContent
    
    TabBtn.MouseButton1Click:Connect(function()
        for j = 1, #Tabs do
            TabButtons[j].BackgroundColor3 = Color3.fromRGB(40, 40, 60)
            TabContents[j].Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        TabContent.Visible = true
        ActiveTab = i
    end)
end

-- UI Components
local function CreateToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    ToggleFrame.Size = UDim2.new(1, -20, 0, 50)
    ToggleFrame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = ToggleFrame
    ToggleBtn.Position = UDim2.new(1, -55, 0, 7)
    ToggleBtn.Size = UDim2.new(0, 45, 0, 35)
    ToggleBtn.Text = "OFF"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.BorderSizePixel = 0
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = ToggleBtn
    
    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Config.Toggles[name] = enabled
        ToggleBtn.Text = enabled and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        if callback then callback(enabled) end
    end)
    
    ToggleFrame.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 60)
end

local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    SliderFrame.Size = UDim2.new(1, -20, 0, 70)
    SliderFrame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = SliderFrame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.Size = UDim2.new(0.6, 0, 0.4, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = SliderFrame
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Position = UDim2.new(0.65, 0, 0, 5)
    ValueLabel.Size = UDim2.new(0.33, 0, 0.4, 0)
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Parent = SliderFrame
    SliderBar.Position = UDim2.new(0, 15, 0.55, 0)
    SliderBar.Size = UDim2.new(1, -30, 0, 12)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SliderBar.BorderSizePixel = 0
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Parent = SliderBar
    SliderFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BorderSizePixel = 0
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 6)
    SliderCorner.Parent = SliderBar
    SliderCorner.Parent = SliderFill
    
    local dragging = false
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
        if dragging then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * relativeX)
            
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            Config.Sliders[name] = value
            if callback then callback(value) end
        end
    end)
    
    SliderFrame.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() - 1) * 80)
end

-- FEATURES IMPLEMENTATION
local Loops = {}

local function StartLoop(name, func, delay)
    if Loops[name] then Loops[name]:Disconnect() end
    Loops[name] = RunService.Heartbeat:Connect(function()
        if Config.Toggles[name] then
            pcall(func)
            task.wait(delay or Config.Delay)
        end
    end)
end

-- FARM TAB
CreateToggle(TabContents[1], "💰 Auto Farm Money", function(enabled)
    if enabled then
        StartLoop("AutoFarm", function()
            SafeRemoteCall("FarmMoney")
            SafeRemoteCall("UpdatePlaytime")
        end, 0.1)
    else
        if Loops.AutoFarm then Loops.AutoFarm:Disconnect() end
    end
end)

CreateToggle(TabContents[1], "📦 Auto Open Cases", function(enabled)
    if enabled then
        StartLoop("AutoOpen", function()
            SafeRemoteCall("OpenCase", "BeastCase", true)
        end, 0.05)
    end
end)

CreateToggle(TabContents[1], "💎 Auto Sell", function(enabled)
    if enabled then
        StartLoop("AutoSell", function()
            SafeRemoteCall("SellAllJunk")
        end, 1)
    end
end)

-- QUESTS TAB
CreateToggle(TabContents[2], "✅ Auto Quests", function(enabled)
    if enabled then
        StartLoop("AutoQuests", function()
            for _, obj in pairs(services.ReplicatedStorage:GetDescendants()) do
                if obj.Name:lower():find("quest") and obj:IsA("RemoteEvent") then
                    obj:FireServer()
                end
            end
        end, 0.3)
    end
end)

CreateToggle(TabContents[2], "🎁 Auto Claims", function(enabled)
    if enabled then
        StartLoop("AutoClaims", function()
            SafeRemoteCall("ClaimGift")
            SafeRemoteCall("ClaimIndex")
            SafeRemoteCall("AutoExchange")
        end, 2)
    end
end)

-- EVENTS TAB
CreateToggle(TabContents[3], "🎉 Auto Events", function(enabled)
    if enabled then
        StartLoop("AutoEvents", function()
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():match("gift") or obj.Name:lower():match("event") or obj.Name:lower():match("meteor") then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 5, 0)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        task.wait(0.1)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
                    end
                end
            end
        end, 0.8)
    end
end)

-- MOVEMENT TAB
CreateSlider(TabContents[4], "🏃 WalkSpeed", 16, 500, 100, function(value)
    Config.Speed = value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateToggle(TabContents[4], "✈️ Fly", function(enabled)
    if enabled and LocalPlayer.Character then
        local char = LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(4000, 4000, 4000)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        
        Config.Connections.Fly = RunService.Heartbeat:Connect(function()
            if Config.Toggles["✈️ Fly"] and root.Parent then
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
            else
                bv:Destroy()
                Config.Connections.Fly:Disconnect()
            end
        end)
    end
end)

CreateToggle(TabContents[4], "👻 Noclip", function(enabled)
    Config.Connections.Noclip = RunService.Stepped:Connect(function()
        if Config.Toggles["👻 Noclip"] and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

CreateToggle(TabContents[4], "💡 Fullbright", function(enabled)
    Lighting.Brightness = enabled and 3 or 1
    Lighting.GlobalShadows = not enabled
    Lighting.FogEnd = enabled and 9e9 or 100
end)

-- MISC TAB
CreateSlider(TabContents[5], "⏱️ Global Delay", 0.1, 5, 1, function(value)
    Config.Delay = value
end)

CreateToggle(TabContents[5], "😴 Anti-AFK", function(enabled)
    if enabled then
        LocalPlayer.Idled:Connect(function()
            services.VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
            task.wait(0.1)
            services.VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
        end)
    end
end)

-- X Toggle Keybind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Auto Speed Update
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").WalkSpeed = Config.Speed
end)

if LocalPlayer.Character then
    LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Config.Speed
end

print("🟡 TURCIA HUB v3.0 LOADED SUCCESSFULLY!")
print("✅ All Executors Compatible | X to Toggle | Professional GUI")

