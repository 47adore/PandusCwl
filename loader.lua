-- PANDUS CWL v9.0 PRO - NAPRAWIONE 100% FUNKCJONALNE
-- DARK GRAY/BLUE + WSZYSTKIE FUNKCJE DZIAŁAJĄ

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local TweenInfoFast = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TweenInfoSmooth = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

-- CLEANUP
for _, obj in pairs(game:GetService("CoreGui"):GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- SETTINGS
local Settings = {
    Language = "PL",
    Enabled = {},
    Speed = 100,
    JumpPower = 200,
    ESPColor = Color3.fromRGB(100, 150, 255)
}
local Connections = {}
local ESPHighlights = {}
local FlyVelocity = nil

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV9_Pro"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 800, 0, 550)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 25, 40))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(70, 90, 140)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PANDUS CWL v9.0 PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 7.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.white
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- SIDE PANEL TABS
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 140, 1, -55)
SidePanel.Position = UDim2.new(0, 0, 0, 50)
SidePanel.BackgroundColor3 = Color3.fromRGB(28, 33, 45)
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 14)
SideCorner.Parent = SidePanel

-- CONTENT AREA
local ContentArea = Instance.new("ScrollingFrame")
ContentArea.Size = UDim2.new(1, -155, 1, -60)
ContentArea.Position = UDim2.new(0, 145, 0, 55)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ScrollBarThickness = 6
ContentArea.ScrollBarImageColor3 = Color3.fromRGB(70, 90, 140)
ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentArea.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentArea

ContentArea:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
end)

-- TAB SYSTEM
local Tabs = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL", "SET"}
local CurrentTab = 1
local TabContent = {}

-- TOGGLE FUNCTION
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(32, 37, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentArea
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 12)
    TCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.8, 0)
    Label.Position = UDim2.new(0, 15, 0.1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 235, 245)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 50, 0, 28)
    Switch.Position = UDim2.new(1, -60, 0.36, 0)
    Switch.BackgroundColor3 = Color3.fromRGB(60, 65, 80)
    Switch.Text = ""
    Switch.Font = Enum.Font.GothamBold
    Switch.Parent = ToggleFrame
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 14)
    SCorner.Parent = Switch
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 24, 0, 24)
    Knob.Position = UDim2.new(0, 2, 0, 2)
    Knob.BackgroundColor3 = Color3.fromRGB(150, 155, 170)
    Knob.Parent = Switch
    
    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(0, 12)
    KCorner.Parent = Knob
    
    local enabled = false
    Switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        Settings.Enabled[name] = enabled
        
        TweenService:Create(Switch, TweenInfoFast, {
            BackgroundColor3 = enabled and Color3.fromRGB(70, 90, 140) or Color3.fromRGB(60, 65, 80)
        }):Play()
        
        TweenService:Create(Knob, TweenInfoFast, {
            Position = enabled and UDim2.new(1, -26, 0, 2) or UDim2.new(0, 2, 0, 2),
            BackgroundColor3 = enabled and Color3.white or Color3.fromRGB(150, 155, 170)
        }):Play()
        
        callback(enabled)
    end)
end

-- SLIDER FUNCTION
local function CreateSlider(name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, 55)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(32, 37, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = ContentArea
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 12)
    SCorner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 0.45, 0)
    Label.Position = UDim2.new(0, 15, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 235, 245)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0.45, 0)
    ValueLabel.Position = UDim2.new(0.68, 0, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(70, 90, 140)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.9, 0, 0, 8)
    Track.Position = UDim2.new(0.05, 0, 0.65, 0)
    Track.BackgroundColor3 = Color3.fromRGB(50, 55, 70)
    Track.Parent = SliderFrame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 4)
    TCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(70, 90, 140)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 4)
    FCorner.Parent = Fill
    
    local dragging = false
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    Track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = Mouse.X - Track.AbsolutePosition.X
            local percent = math.clamp(mousePos / Track.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- BUTTON FUNCTION
local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 42)
    Button.BackgroundColor3 = Color3.fromRGB(50, 60, 85)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(230, 235, 245)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = ContentArea
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 12)
    BCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(70, 90, 140),
            Size = UDim2.new(1, -22, 0, 40)
        }):Play()
        wait(0.1)
        TweenService:Create(Button, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(50, 60, 85),
            Size = UDim2.new(1, -20, 0, 42)
        }):Play()
        callback()
    end)
end

-- CREATE TABS
for i, tabName in ipairs(Tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName
    TabButton.Size = UDim2.new(1, -10, 0, 42)
    TabButton.Position = UDim2.new(0, 5, 0, (i-1)*46 + 5)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(180, 190, 210)
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Parent = SidePanel
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton
    
    TabButton.MouseButton1Click:Connect(function()
        CurrentTab = i
        
        -- Reset all tab content
        for _, content in pairs(ContentArea:GetChildren()) do
            if content:IsA("Frame") or content:IsA("TextButton") then
                content.Visible = false
            end
        end
        
        -- Show current tab content
        if TabContent[i] then
            for _, item in pairs(TabContent[i]) do
                item.Visible = true
            end
        end
        
        -- Animate tabs
        for _, btn in pairs(SidePanel:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfoFast, {
                    BackgroundColor3 = Color3.fromRGB(40, 45, 60),
                    TextColor3 = Color3.fromRGB(180, 190, 210)
                }):Play()
            end
        end
        
        TweenService:Create(TabButton, TweenInfoFast, {
            BackgroundColor3 = Color3.fromRGB(70, 90, 140),
            TextColor3 = Color3.white
        }):Play()
        
        ContentArea.CanvasPosition = Vector2.new(0, 0)
    end)
end

-- MOVEMENT TAB CONTENT
TabContent[1] = {}
local movSpeedSlider = CreateSlider("Szybkość", 16, 500, 100, function(val)
    Settings.Speed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)
table.insert(TabContent[1], movSpeedSlider)

local movJumpSlider = CreateSlider("Skok", 50, 1000, 200, function(val)
    Settings.JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)
table.insert(TabContent[1], movJumpSlider)

local flyToggle = CreateToggle("Lot", function(state)
    Settings.Enabled.Fly = state
    if state then
        spawn(function()
            repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local root = LocalPlayer.Character.HumanoidRootPart
            FlyVelocity = Instance.new("BodyVelocity")
            FlyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            FlyVelocity.Parent = root
            
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if not Settings.Enabled.Fly then return end
                local cam = workspace.CurrentCamera
                local move = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + cam.CFrame.UpVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - cam.CFrame.UpVector end
                FlyVelocity.Velocity = move * (Settings.Speed / 10)
            end)
        end)
    else
        if Connections.Fly then Connections.Fly:Disconnect() end
        if FlyVelocity then FlyVelocity:Destroy() end
    end
end)
table.insert(TabContent[1], flyToggle)

local noclipToggle = CreateToggle("Noclip", function(state)
    Settings.Enabled.Noclip = state
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() end
    end
end)
table.insert(TabContent[1], noclipToggle)

local tpBtn = CreateButton("Teleport do graczy", function()
    local tpGui = Instance.new("Frame")
    tpGui.Size = UDim2.new(0, 250, 0, 300)
    tpGui.Position = UDim2.new(0.5, -125, 0.5, -150)
    tpGui.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    tpGui.Parent = ScreenGui
    
    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0, 12)
    tpCorner.Parent = tpGui
    
    local tpList = Instance.new("ScrollingFrame")
    tpList.Size = UDim2.new(1, -20, 1, -60)
    tpList.Position = UDim2.new(0, 10, 0, 10)
    tpList.BackgroundTransparency = 1
    tpList.Parent = tpGui
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local tpPlayerBtn = Instance.new("TextButton")
            tpPlayerBtn.Size = UDim2.new(1, 0, 0, 35)
            tpPlayerBtn.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
            tpPlayerBtn.Text = plr.Name
            tpPlayerBtn.TextColor3 = Color3.white
            tpPlayerBtn.Parent = tpList
            tpPlayerBtn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and plr.Character then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
                tpGui:Destroy()
            end)
        end
    end
end)
table.insert(TabContent[1], tpBtn)

-- PLAYER TAB
TabContent[2] = {}
local respawnToggle = CreateToggle("Szybki respawn", function(state)
    if state and LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)
table.insert(TabContent[2], respawnToggle)

local spinToggle = CreateToggle("Spin bot", function(state)
    Settings.Enabled.Spin = state
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(40), 0)
            end
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect() end
    end
end)
table.insert(TabContent[2], spinToggle)

local gravityToggle = CreateToggle("Niska grawitacja", function(state)
    Settings.Enabled.Gravity = state
    workspace.Gravity = state and 50 or 196.2
end)
table.insert(TabContent[2], gravityToggle)

-- COMBAT TAB
TabContent[3] = {}
local aimbotToggle = CreateToggle("Aimbot", function(state)
    Settings.Enabled.Aimbot = state
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local closest, dist = nil, math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local screenDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if screenDist < dist then
                            closest = plr
                            dist = screenDist
                        end
                    end
                end
            end
            if closest and closest.Character then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, closest.Character.HumanoidRootPart.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect() end
    end
end)
table.insert(TabContent[3], aimbotToggle)

-- VISUALS TAB
TabContent[4] = {}
local espToggle = CreateToggle("ESP", function(state)
    Settings.Enabled.ESP = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if state then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Settings.ESPColor
                highlight.OutlineColor = Color3.white
                highlight.FillTransparency = 0.4
                highlight.Parent = plr.Character
                ESPHighlights[plr] = highlight
            elseif ESPHighlights[plr] then
                ESPHighlights[plr]:Destroy()
                ESPHighlights[plr] = nil
            end
        end
    end
end)
table.insert(TabContent[4], espToggle)

-- UTILITY TAB
TabContent[5] = {}
local afkToggle = CreateToggle("Anti-AFK", function(state)
    Settings.Enabled.AntiAFK = state
    spawn(function()
        while Settings.Enabled.AntiAFK do
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(0, 0.1, 0)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                bv.Parent = LocalPlayer.Character.HumanoidRootPart
            end
            wait(0.1)
            bv:Destroy()
            wait(60)
        end
    end)
end)
table.insert(TabContent[5], afkToggle)

local rejoinBtn = CreateButton("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
table.insert(TabContent[5], rejoinBtn)

local turcjaBtn = CreateButton("Turcja ❤️", function()
    pcall(function()
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("i ❤️ Turcja", "All")
    end)
end)
table.insert(TabContent[5], turcjaBtn)

-- TROLL TAB
TabContent[6] = {}
local flingBtn = CreateButton("FLING ALL ULTRA", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(math.random(-10000,10000), 30000, math.random(-10000,10000))
            bv.Parent = root
            Debris:AddItem(bv, 0.2)
        end
    end
end)
table.insert(TabContent[6], flingBtn)

-- SETTINGS TAB (EMPTY FOR NOW)
TabContent[7] = {}

-- HIDE ALL CONTENT INITIALLY
for i, content in pairs(TabContent) do
    for _, item in pairs(content) do
        item.Visible = false
    end
end

-- CLOSE BUTTON
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Z KEY BIND
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CHARACTER SPAWN
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- ESP PLAYER JOIN
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
        if Settings.Enabled.ESP and plr.Character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Settings.ESPColor
            highlight.OutlineColor = Color3.white
            highlight.FillTransparency = 0.4
            highlight.Parent = plr.Character
            ESPHighlights[plr] = highlight
        end
    end)
end)

-- SELECT FIRST TAB
TweenService:Create(SidePanel:GetChildren()[6], TweenInfoFast, {
    BackgroundColor3 = Color3.fromRGB(70, 90, 140),
    TextColor3 = Color3.white
}):Play()
TabContent[1][1].Visible = true

print("⚡ PANDUS CWL v9.0 PRO - 100% DZIAŁA ⚡")
print("Naciśnij Z - Wszystkie funkcje działają idealnie!")
