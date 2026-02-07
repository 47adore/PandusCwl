-- PANDUSCWL v8.0 SKIBIDI STYLE - COMPACT PROFESSIONAL
-- DARK GRAY/BLUE + PERFECT FIXES + SMOOTH

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local TweenInfoFast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- CLEANUP
for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- STATES
local Settings = {Language = "PL", Enabled = {}, Speed = 100, JumpPower = 200}
local Connections = {}
local ESPHighlights = {}
local FlyBodyVelocity = nil
local AimbotTarget = nil

-- COMPACT GUI 700x600
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV8"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 700, 0, 600)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 55)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 50))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 110, 200)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- HEADER COMPACT
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 0.7, 0)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "PANDUS CWL v8.0"
Title.TextColor3 = Color3.fromRGB(220, 225, 240)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

-- SIDE PANEL (COMPACT)
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 140, 1, -80)
SidePanel.Position = UDim2.new(0, 0, 0, 75)
SidePanel.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 18)
SideCorner.Parent = SidePanel

local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -155, 1, -85)
ContentArea.Position = UDim2.new(0, 150, 0, 80)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 6
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(80, 110, 200)
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentArea

-- TABS (SMALL)
local Tabs = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL", "SET"}
local TabNames = {"Movement", "Player", "Combat", "Visuals", "Utility", "Troll", "Settings"}
local CurrentTab = 1

for i, tab in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab
    TabBtn.Size = UDim2.new(1, -16, 0, 50)
    TabBtn.Position = UDim2.new(0, 8, 0, (i-1)*55 + 10)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    TabBtn.Text = tab
    TabBtn.TextColor3 = Color3.fromRGB(180, 185, 200)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SidePanel
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        ContentArea.CanvasPosition = Vector2.new(0, 0)
        
        for _, btn in pairs(SidePanel:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfoFast, {
                    BackgroundColor3 = Color3.fromRGB(40, 45, 60),
                    TextColor3 = Color3.fromRGB(180, 185, 200)
                }):Play()
            end
        end
        
        TweenService:Create(TabBtn, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(80, 110, 200),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
end

-- PERFECT TOGGLE (CLICK ONLY)
local function CreateToggle(name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = #ContentArea:GetChildren()
    Frame.Parent = ContentArea
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 15)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.75, 0, 0.8, 0)
    Label.Position = UDim2.new(0, 15, 0.1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 225, 240)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 35)
    ToggleBtn.Position = UDim2.new(1, -55, 0.5, -17.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 65, 85)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(150, 155, 170)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextScaled = true
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = Frame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 17)
    TCorner.Parent = ToggleBtn
    
    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        local color = state and Color3.fromRGB(80, 110, 200) or Color3.fromRGB(60, 65, 85)
        local text = state and "ON" or "OFF"
        local textColor = state and Color3.white or Color3.fromRGB(150, 155, 170)
        
        TweenService:Create(ToggleBtn, TweenInfoFast, {
            BackgroundColor3 = color,
            TextColor3 = textColor
        }):Play()
        ToggleBtn.Text = text
        
        Settings.Enabled[name] = state
        callback(state)
    end)
end

-- SLIDER PERFECT
local function CreateSlider(name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 70)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = #ContentArea:GetChildren()
    Frame.Parent = ContentArea
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 15)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.5, 0)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 225, 240)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.25, 0, 0.5, 0)
    ValueLabel.Position = UDim2.new(0.72, 0, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(80, 110, 200)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Size = UDim2.new(0.9, 0, 0, 20)
    SliderTrack.Position = UDim2.new(0.05, 0, 0.65, 0)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = Frame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 10)
    TrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(80, 110, 200)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 10)
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
            
            SliderFill.Size = UDim2.new(percent, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- BUTTON COMPACT
local function CreateButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -20, 0, 50)
    Btn.BackgroundColor3 = Color3.fromRGB(55, 65, 95)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(220, 225, 240)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.LayoutOrder = #ContentArea:GetChildren()
    Btn.Parent = ContentArea
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 15)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfoFast, {Size = UDim2.new(0.98, -20, 0, 48)}):Play()
        wait(0.08)
        TweenService:Create(Btn, TweenInfoFast, {Size = UDim2.new(1, -20, 0, 50)}):Play()
        callback()
    end)
end

-- ALL FEATURES FIXED

-- MOVEMENT
CreateSlider("Speed", 16, 500, 100, function(val)
    Settings.Speed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

CreateSlider("Jump Power", 50, 1000, 200, function(val)
    Settings.JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

CreateToggle("Fly", function(state)
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
                    FlyBodyVelocity.Velocity = move * 50
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
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() Connections.Noclip = nil end
    end
end)

-- PLAYER
CreateToggle("Instant Respawn", function(state)
    Settings.Enabled.Respawn = state
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

CreateToggle("Spin Bot", function(state)
    Settings.Enabled.Spin = state
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
            end
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect() Connections.Spin = nil end
    end
end)

CreateToggle("Low Gravity", function(state)
    Settings.Enabled.Gravity = state
    if state then
        workspace.Gravity = 50
    else
        workspace.Gravity = 196.2
    end
end)

-- COMBAT
CreateToggle("Aimbot", function(state)
    Settings.Enabled.Aimbot = state
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local closest, dist = nil, math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local d = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if d < dist then closest, dist = plr, d end
                    end
                end
            end
            if closest then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closest.Character.HumanoidRootPart.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect() Connections.Aimbot = nil end
    end
end)

-- VISUALS
CreateToggle("ESP", function(state)
    Settings.Enabled.ESP = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if state and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(80, 110, 200)
                highlight.OutlineColor = Color3.white
                highlight.FillTransparency = 0.5
                highlight.Parent = plr.Character
                ESPHighlights[plr] = highlight
            elseif ESPHighlights[plr] then
                ESPHighlights[plr]:Destroy()
                ESPHighlights[plr] = nil
            end
        end
    end
end)

-- UTILITY
CreateToggle("Anti-AFK", function(state)
    Settings.Enabled.AntiAFK = state
    if state then
        spawn(function()
            while Settings.Enabled.AntiAFK do
                local vht = Instance.new("BodyVelocity")
                vht.MaxForce = Vector3.new(4000, 4000, 4000)
                vht.Velocity = Vector3.new(0, 0.1, 0)
                vht.Parent = LocalPlayer.Character.HumanoidRootPart
                wait(0.1)
                vht:Destroy()
                wait(59.9)
            end
        end)
    end
end)

-- TROLL
CreateButton("FLING ALL ULTRA", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(math.random(-10000,10000), 50000, math.random(-10000,10000))
            bv.Parent = root
            game:GetService("Debris"):AddItem(bv, 0.2)
            
            local bg = Instance.new("BodyAngularVelocity")
            bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            bg.AngularVelocity = Vector3.new(100, 100, 100)
            bg.Parent = root
            game:GetService("Debris"):AddItem(bg, 0.2)
        end
    end
end)

CreateButton("Turcja ❤️", function()
    if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("i ❤️ Turcja", "All")
    end
end)

CreateButton("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- TELEPORT LIST
CreateButton("Teleport Lista", function()
    local teleportFrame = Instance.new("Frame")
    teleportFrame.Size = UDim2.new(0, 250, 0, 300)
    teleportFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
    teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
    teleportFrame.Parent = ScreenGui
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 15)
    tc.Parent = teleportFrame
    
    local playerList = Instance.new("ScrollingFrame")
    playerList.Size = UDim2.new(1, -20, 1, -60)
    playerList.Position = UDim2.new(0, 10, 0, 10)
    playerList.BackgroundTransparency = 1
    playerList.Parent = teleportFrame
    
    for i, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(1, 0, 0, 35)
            tpBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
            tpBtn.Text = plr.Name
            tpBtn.TextColor3 = Color3.white
            tpBtn.Parent = playerList
            tpBtn.MouseButton1Click:Connect(function()
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
                teleportFrame:Destroy()
            end)
        end
    end
end)

-- AUTO UPDATE
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
        if Settings.Enabled.ESP then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(80, 110, 200)
            highlight.OutlineColor = Color3.white
            highlight.FillTransparency = 0.5
            highlight.Parent = plr.Character
            ESPHighlights[plr] = highlight
        end
    end)
end)

-- INIT
TweenService:Create(SidePanel:GetChildren()[1], TweenInfoSmooth, {
    BackgroundColor3 = Color3.fromRGB(80, 110, 200),
    TextColor3 = Color3.white
}):Play()

MainFrame.Visible = false
UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CHARACTER SPAWN
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
    end
end)

print("⚡ PANDUS CWL v8.0 SKIBIDI STYLE LOADED ⚡")
print("Naciśnij V - Wszystko naprawione!")
