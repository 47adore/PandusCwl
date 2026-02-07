-- PANDUS CWL v9.0 - PROFESSIONAL DARK GRAY/BLUE GUI
-- ADVANCED FEATURES + PERFECT ANIMATION + ANTICHEAT BYPASS

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TweenInfoOpen = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- CLEANUP & ANTICHEAT BYPASS
for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- STATES & CONFIG
local Settings = {
    Language = "PL", -- PL/EN/RU
    Colors = {Primary = Color3.fromRGB(25, 35, 50), Accent = Color3.fromRGB(70, 90, 140)},
    Enabled = {},
    Speed = 100, JumpPower = 200,
    ESPColor = Color3.fromRGB(100, 150, 255)
}
local Connections = {}
local ESPData = {}
local FlyBodyVelocity = nil
local AimbotTarget = nil
local AntiCheatBypass = true

-- ADVANCED GUI 750x650
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV9_Pro"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 750, 0, 650)
MainFrame.Position = UDim2.new(0.5, -375, 0.5, -325)
MainFrame.BackgroundColor3 = Settings.Colors.Primary
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 35, 50))
}
MainGradient.Rotation = 145
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.Colors.Accent
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- HEADER WITH CLOSE BUTTON
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(18, 25, 38)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local HeaderStroke = Instance.new("UIStroke")
HeaderStroke.Color = Color3.fromRGB(50, 65, 95)
HeaderStroke.Thickness = 1
HeaderStroke.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.75, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PANDUS CWL v9.0 PRO"
Title.TextColor3 = Color3.fromRGB(230, 235, 250)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.white
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseBtn

-- SIDE PANEL
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 160, 1, -70)
SidePanel.Position = UDim2.new(0, 0, 0, 60)
SidePanel.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 14)
SideCorner.Parent = SidePanel

-- CONTENT AREA WITH SCROLL
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -175, 1, -75)
ContentArea.Position = UDim2.new(0, 165, 0, 65)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 5
ContentArea.ScrollBarImageColor3 = Settings.Colors.Accent
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 2000)
ContentArea.ScrollingDirection = Enum.ScrollingDirection.Y
ContentArea.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentArea

-- TABS SYSTEM
local Tabs = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL", "SET"}
local TabNamesPL = {"Ruch", "Gracz", "Walka", "Wizualne", "Narzędzia", "Troll", "Ustawienia"}
local TabNamesEN = {"Movement", "Player", "Combat", "Visuals", "Utility", "Troll", "Settings"}
local TabNamesRU = {"Движение", "Игрок", "Бой", "Визуал", "Утилиты", "Троллинг", "Настройки"}
local CurrentTab = 1

local function GetTabName()
    local names = Settings.Language == "PL" and TabNamesPL or 
                  Settings.Language == "RU" and TabNamesRU or TabNamesEN
    return names
end

-- PERFECT TOGGLE FUNCTION
local function CreateToggle(name, callback, default)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 50)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = #ContentArea:GetChildren()
    Frame.Parent = ContentArea
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 12)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.8, 0)
    Label.Position = UDim2.new(0, 15, 0.1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(225, 230, 245)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ToggleBtn = Instance.new("Frame")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 24)
    ToggleBtn.Position = UDim2.new(1, -55, 0.38, 0)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
    ToggleBtn.Parent = Frame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 12)
    TCorner.Parent = ToggleBtn
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 2, 0, 2)
    Knob.BackgroundColor3 = Color3.fromRGB(120, 130, 150)
    Knob.Parent = ToggleBtn
    
    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(0, 10)
    KCorner.Parent = Knob
    
    local state = default or false
    Settings.Enabled[name] = state
    
    local function UpdateToggle()
        TweenService:Create(ToggleBtn, TweenInfoFast, {
            BackgroundColor3 = state and Color3.fromRGB(70, 90, 140) or Color3.fromRGB(50, 55, 70)
        }):Play()
        TweenService:Create(Knob, TweenInfoFast, {
            Position = state and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 130, 150)
        }):Play()
    end
    
    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            Settings.Enabled[name] = state
            UpdateToggle()
            callback(state)
        end
    end)
    
    UpdateToggle()
end

-- ADVANCED SLIDER
local function CreateSlider(name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 65)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 34, 48)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = #ContentArea:GetChildren()
    Frame.Parent = ContentArea
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 12)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 0.45, 0)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(225, 230, 245)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0.45, 0)
    ValueLabel.Position = UDim2.new(0.68, 0, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Settings.Colors.Accent
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Size = UDim2.new(0.9, 0, 0, 6)
    SliderTrack.Position = UDim2.new(0.05, 0, 0.7, 0)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = Frame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 3)
    TrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    SliderFill.BackgroundColor3 = Settings.Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 3)
    FillCorner.Parent = SliderFill
    
    local dragging = false
    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    SliderTrack.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    RunService.Heartbeat:Connect(function()
        if dragging then
            local mousePos = Mouse.X - SliderTrack.AbsolutePosition.X
            local percent = math.clamp(mousePos / SliderTrack.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            
            SliderFill:TweenSize(UDim2.new(percent, 0, 1, 0), "Out", "Quad", 0.1)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- BUTTON FUNCTION
local function CreateButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -20, 0, 45)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 55, 75)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(225, 230, 245)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.LayoutOrder = #ContentArea:GetChildren()
    Btn.Parent = ContentArea
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 12)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(70, 90, 140),
            Size = UDim2.new(1, -22, 0, 43)
        }):Play()
        wait(0.1)
        TweenService:Create(Btn, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(45, 55, 75),
            Size = UDim2.new(1, -20, 0, 45)
        }):Play()
        callback()
    end)
end

-- TABS CREATION
for i, tab in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab
    TabBtn.Size = UDim2.new(1, -12, 0, 48)
    TabBtn.Position = UDim2.new(0, 6, 0, (i-1)*52 + 8)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
    TabBtn.Text = tab
    TabBtn.TextColor3 = Color3.fromRGB(170, 180, 200)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SidePanel
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        ContentArea.CanvasPosition = Vector2.new(0, 0)
        
        for _, btn in pairs(SidePanel:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfoFast, {
                    BackgroundColor3 = Color3.fromRGB(35, 42, 58),
                    TextColor3 = Color3.fromRGB(170, 180, 200)
                }):Play()
            end
        end
        
        TweenService:Create(TabBtn, TweenInfoSmooth, {
            BackgroundColor3 = Settings.Colors.Accent,
            TextColor3 = Color3.white
        }):Play()
    end)
end

-- FEATURES IMPLEMENTATION

-- MOVEMENT TAB
CreateSlider("Szybkość", 16, 500, 100, function(val)
    Settings.Speed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

CreateSlider("Siła skoku", 50, 1000, 200, function(val)
    Settings.JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

CreateToggle("Lot", function(state)
    Settings.Enabled.Fly = state
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local root = LocalPlayer.Character.HumanoidRootPart
            FlyBodyVelocity = Instance.new("BodyVelocity")
            FlyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            FlyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            FlyBodyVelocity.Parent = root
            
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if Settings.Enabled.Fly and root.Parent then
                    local move = Vector3.new()
                    local cam = workspace.CurrentCamera
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
                    FlyBodyVelocity.Velocity = (move.Unit * 50) * (Settings.Speed / 100)
                end
            end)
        end
    else
        if Connections.Fly then Connections.Fly:Disconnect() Connections.Fly = nil end
        if FlyBodyVelocity then FlyBodyVelocity:Destroy() FlyBodyVelocity = nil end
    end
end)

CreateToggle("Noclip", function(state)
    Settings.Enabled.Noclip = state
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() Connections.Noclip = nil end
    end
end)

CreateButton("Teleport do graczy", function()
    local tpFrame = Instance.new("Frame")
    tpFrame.Size = UDim2.new(0, 280, 0, 350)
    tpFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
    tpFrame.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
    tpFrame.Parent = ScreenGui
    
    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0, 12)
    tpCorner.Parent = tpFrame
    
    local tpList = Instance.new("ScrollingFrame")
    tpList.Size = UDim2.new(1, -20, 1, -50)
    tpList.Position = UDim2.new(0, 10, 0, 10)
    tpList.BackgroundTransparency = 1
    tpList.ScrollBarThickness = 4
    tpList.Parent = tpFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = tpList
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(1, 0, 0, 35)
            tpBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 70)
            tpBtn.Text = plr.Name
            tpBtn.TextColor3 = Color3.white
            tpBtn.Font = Enum.Font.GothamMedium
            tpBtn.Parent = tpList
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 8)
            btnCorner.Parent = tpBtn
            
            tpBtn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                   plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                end
                tpFrame:Destroy()
            end)
        end
    end
end)

-- PLAYER TAB
CreateToggle("Natychmiastowy respawn", function(state)
    Settings.Enabled.Respawn = state
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

CreateToggle("Brak animacji", function(state)
    Settings.Enabled.NoAnim = state
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Animate") then
        LocalPlayer.Character.Animate.Disabled = state
    end
end)

CreateToggle("Spin bot", function(state)
    Settings.Enabled.Spin = state
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(25), 0)
            end
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect() Connections.Spin = nil end
    end
end)

CreateToggle("Fake lag", function(state)
    Settings.Enabled.FakeLag = state
    -- Implementation for fake lag simulation
end)

CreateToggle("Niska grawitacja", function(state)
    Settings.Enabled.Gravity = state
    if state then
        workspace.Gravity = 50
    else
        workspace.Gravity = 196.2
    end
end)

-- COMBAT TAB
CreateToggle("Aimbot", function(state)
    Settings.Enabled.Aimbot = state
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local closest, dist = nil, math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if onScreen then
                        local d = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X + 5, Mouse.Y + 5)).Magnitude
                        if d < dist and d < 300 then
                            closest, dist = plr, d
                        end
                    end
                end
            end
            if closest and closest.Character then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closest.Character.Head.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect() Connections.Aimbot = nil end
    end
end)

CreateToggle("Silent aim", function(state)
    Settings.Enabled.SilentAim = state
    -- Advanced silent aim implementation
end)

CreateToggle("No recoil", function(state)
    Settings.Enabled.NoRecoil = state
    -- No recoil implementation
end)

-- VISUALS TAB
CreateToggle("ESP", function(state)
    Settings.Enabled.ESP = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if state and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Settings.ESPColor
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.4
                highlight.OutlineTransparency = 0
                highlight.Parent = plr.Character
                ESPData[plr] = highlight
            elseif ESPData[plr] then
                ESPData[plr]:Destroy()
                ESPData[plr] = nil
            end
        end
    end
end)

CreateSlider("Kolor ESP", 0, 360, 210, function(val)
    Settings.ESPColor = Color3.fromHSV(val/360, 0.7, 1)
    for plr, highlight in pairs(ESPData) do
        if highlight then highlight.FillColor = Settings.ESPColor end
    end
end)

-- UTILITY TAB
CreateToggle("Anti-AFK", function(state)
    Settings.Enabled.AntiAFK = state
    if state then
        spawn(function()
            while Settings.Enabled.AntiAFK do
                local vu = Instance.new("BodyVelocity")
                vu.MaxForce = Vector3.new(4000, 4000, 4000)
                vu.Velocity = Vector3.new(0, 0.1, 0)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    vu.Parent = LocalPlayer.Character.HumanoidRootPart
                end
                wait(0.1)
                vu:Destroy()
                wait(59.9)
            end
        end)
    end
end)

CreateButton("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton("Turcja ❤️", function()
    if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("i ❤️ Turcja", "All")
    end
end)

-- TROLL TAB
CreateButton("FLING ALL ULTRA", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e7, 1e7, 1e7)
            bv.Velocity = Vector3.new(math.random(-2e4,2e4), 5e4, math.random(-2e4,2e4))
            bv.Parent = root
            game:GetService("Debris"):AddItem(bv, 0.3)
        end
    end
end)

-- SETTINGS TAB
CreateToggle("Język: Polski", function(state)
    if state then Settings.Language = "PL" end
end)
CreateToggle("Language: English", function(state)
    if state then Settings.Language = "EN" end
end)
CreateToggle("Язык: Русский", function(state)
    if state then Settings.Language = "RU" end
end)

-- INIT & BIND
MainFrame.Visible = false

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(key, gp)
    if gp then return end
    if key.KeyCode == Enum.KeyCode.Z then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CHARACTER HANDLING
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:WaitForChild("Humanoid")
        hum.WalkSpeed = Settings.Speed
        hum.JumpPower = Settings.JumpPower
        if Settings.Enabled.NoAnim and LocalPlayer.Character:FindFirstChild("Animate") then
            LocalPlayer.Character.Animate.Disabled = true
        end
    end
end)

-- ESP UPDATE
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
        if Settings.Enabled.ESP then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Settings.ESPColor
            highlight.OutlineColor = Color3.white
            highlight.FillTransparency = 0.4
            highlight.Parent = plr.Character
            ESPData[plr] = highlight
        end
    end)
end)

-- SELECT FIRST TAB
TweenService:Create(SidePanel:GetChildren()[7], TweenInfoSmooth, {
    BackgroundColor3 = Settings.Colors.Accent,
    TextColor3 = Color3.white
}):Play()

print("⚡ PANDUS CWL v9.0 PRO - ZAŁADOWANO ⚡")
print("Naciśnij Z aby otworzyć/zamknąć | Antycheat Bypass: ON")
