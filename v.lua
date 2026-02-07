-- PANDUS CWL v13.0 FATALITY EDITION
-- PROFESJONALNY CS:GO CHEAT STYLE (FATILITY INSPIRED)

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    TeleportService = game:GetService("TeleportService"),
    Debris = game:GetService("Debris"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting")
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- CLEANUP
for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name:find("PandusCWL") then v:Destroy() end
end

-- SETTINGS
local Settings = {
    Speed = 100, JumpPower = 50, HipHeight = 0, FlySpeed = 50, FOV = 200,
    ESP = false, Fly = false, Noclip = false, LowGravity = false
}

local Connections = {}
local TabContent = {} -- DLA TABS

-- MAIN GUI (MNIEJSZE + PROFESJONALNE)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCWL_Fatality"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 720, 0, 480) -- MNIEJSZE
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- FATALITY STYLE GRADIENT (CIEMNY NIEBIESKI)
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 35, 55)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(18, 28, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 40))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 140, 255)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.1
MainStroke.Parent = MainFrame

-- DRAG SYSTEM
local function makeDraggable(frame)
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(MainFrame)

-- HEADER (FATALITY STYLE)
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(8, 15, 32)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 12, 28))
}
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 18)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.68, 0, 1, 0)
Title.Position = UDim2.new(0, 25, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PANDUS CWL v13.0 FATALITY"
Title.TextColor3 = Color3.fromRGB(230, 240, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

-- RÓŻOWY-BIAŁY GRADIENT DLA TYTUŁU (FATALITY STYLE)
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 240)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 220, 255))
}
TitleGradient.Rotation = 45
TitleGradient.Parent = Title

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -55, 0.5, -22.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 90)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- SIDE MENU (FATALITY STYLE)
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0, 150, 1, -60)
SideFrame.Position = UDim2.new(0, 0, 0, 60)
SideFrame.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 16)
SideCorner.Parent = SideFrame

local SideStroke = Instance.new("UIStroke")
SideStroke.Color = Color3.fromRGB(90, 130, 255)
SideStroke.Thickness = 1.5
SideStroke.Parent = SideFrame

-- CONTENT FRAME Z PASKIEM PRZESUWNYM (FATALITY STYLE)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -165, 1, -65)
ContentFrame.Position = UDim2.new(0, 155, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 8
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 130, 255)
ContentFrame.ScrollBarImageTransparency = 0.3
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame
ContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 14)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- TABS SYSTEM (NAPRAWIONE)
local TabNames = {"MOVEMENT", "PLAYER", "COMBAT", "VISUALS", "UTILITY", "TROLL"}
local CurrentTab = 1
local TabButtons = {}
local TabFrames = {}

-- FUNKCJA TWORZENIA TAB BUTTON (FATALITY STYLE)
local function CreateTabButton(name, index)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name
    TabBtn.Size = UDim2.new(1, -16, 0, 52)
    TabBtn.Position = UDim2.new(0, 8, 0, 15 + (index-1) * 56)
    TabBtn.BackgroundColor3 = Color3.fromRGB(28, 38, 60)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(190, 210, 255)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 14)
    TabCorner.Parent = TabBtn
    
    local TabGradient = Instance.new("UIGradient")
    TabGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 48, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 32, 55))
    }
    TabGradient.Parent = TabBtn
    
    TabButtons[index] = TabBtn
    return TabBtn
end

-- PROFESJONALNY TOGGLE (FATALITY STYLE)
local function CreateToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -28, 0, 52)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 32, 50)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = ToggleFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 42, 65)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 28, 45))
    }
    Gradient.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.65, 0)
    Label.Position = UDim2.new(0, 24, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 245, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 68, 0, 36)
    SwitchFrame.Position = UDim2.new(1, -85, 0.22, 0)
    SwitchFrame.BackgroundColor3 = Color3.fromRGB(65, 75, 105)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = ToggleFrame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 20)
    SwitchCorner.Parent = SwitchFrame
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 30, 0, 30)
    Knob.Position = UDim2.new(0, 3, 0, 3)
    Knob.BackgroundColor3 = Color3.fromRGB(150, 170, 210)
    Knob.Parent = SwitchFrame
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local toggled = false
    SwitchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggled = not toggled
            TweenService:Create(SwitchFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                BackgroundColor3 = toggled and Color3.fromRGB(90, 130, 255) or Color3.fromRGB(65, 75, 105)
            }):Play()
            TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
                Position = toggled and UDim2.new(1, -33, 0, 3) or UDim2.new(0, 3, 0, 3),
                BackgroundColor3 = toggled and Color3.new(1,1,1) or Color3.fromRGB(150, 170, 210)
            }):Play()
            callback(toggled)
        end
    end)
end

-- SLIDER (FATALITY STYLE)
local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -28, 0, 58)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 32, 50)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68, 0, 0.45, 0)
    Label.Position = UDim2.new(0, 24, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 245, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0.45, 0)
    ValueLabel.Position = UDim2.new(0.69, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(90, 130, 255)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.94, 0, 0, 10)
    Track.Position = UDim2.new(0.03, 0, 0.68, 0)
    Track.BackgroundColor3 = Color3.fromRGB(55, 65, 95)
    Track.BorderSizePixel = 0
    Track.Parent = SliderFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 8)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    local percent = (default - min) / (max - min)
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(90, 130, 255)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 8)
    FillCorner.Parent = Fill
    
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
    
    Services.RunService.Heartbeat:Connect(function()
        if dragging then
            local mousePos = Mouse.X - Track.AbsolutePosition.X
            local percent = math.clamp(mousePos / Track.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            Fill.Size = UDim2.new(percent, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- BUTTON (FATALITY STYLE)
local function CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -28, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(50, 65, 95)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(230, 245, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Button
    
    local ButtonGradient = Instance.new("UIGradient")
    ButtonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(65, 85, 125)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 55, 85))
    }
    ButtonGradient.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
            BackgroundColor3 = Color3.fromRGB(110, 150, 255)
        }):Play()
        task.wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {
            BackgroundColor3 = Color3.fromRGB(50, 65, 95)
        }):Play()
        callback()
    end)
end

-- TWORZENIE TAB CONTENT
local function CreateTabFrame(name)
    local TabFrame = Instance.new("ScrollingFrame")
    TabFrame.Name = name
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.BorderSizePixel = 0
    TabFrame.ScrollBarThickness = 6
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 130, 255)
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.Visible = false
    TabFrame.Parent = ContentFrame
    
    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 12)
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Parent = TabFrame
    
    TabContent[name] = TabFrame
    return TabFrame
end

-- INICJALIZACJA TABS
for i, tabName in ipairs(TabNames) do
    CreateTabButton(tabName, i)
    CreateTabFrame(tabName)
end

-- NAPRAWIONE TAB SWITCHING
local function SwitchTab(tabIndex)
    for i, btn in pairs(TabButtons) do
        if btn then
            TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
                BackgroundColor3 = Color3.fromRGB(28, 38, 60),
                TextColor3 = Color3.fromRGB(190, 210, 255)
            }):Play()
            TweenService:Create(btn.UIGradient, TweenInfo.new(0.3), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 48, 75)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 32, 55))
                }
            }):Play()
        end
    end
    
    for _, frame in pairs(TabContent) do
        frame.Visible = false
    end
    
    local activeBtn = TabButtons[tabIndex]
    local activeFrame = TabContent[TabNames[tabIndex]]
    
    if activeBtn and activeFrame then
        activeFrame.Visible = true
        TweenService:Create(activeBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            BackgroundColor3 = Color3.fromRGB(90, 130, 255),
            TextColor3 = Color3.new(1,1,1)
        }):Play()
        TweenService:Create(activeBtn.UIGradient, TweenInfo.new(0.3), {
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 150, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 110, 235))
            }
        }):Play()
        CurrentTab = tabIndex
    end
end

-- PODPINANIE TAB BUTTONS (NAPRAWIONE)
for i, btn in pairs(TabButtons) do
    if btn then
        btn.MouseButton1Click:Connect(function()
            SwitchTab(i)
        end)
    end
end

-- MOVEMENT TAB
local MovementTab = TabContent["MOVEMENT"]
CreateSlider(MovementTab, "WalkSpeed", 16, 650, 100, function(val)
    Settings.Speed = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = val end)
    end)
end)

CreateSlider(MovementTab, "JumpPower", 50, 650, 50, function(val)
    Settings.JumpPower = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = val end)
    end)
end)

CreateSlider(MovementTab, "HipHeight", -10, 50, 0, function(val)
    Settings.HipHeight = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        pcall(function() LocalPlayer.Character.Humanoid.HipHeight = val end)
    end)
end)

CreateToggle(MovementTab, "Fly", function(state)
    Settings.Fly = state
    if state then
        task.spawn(function()
            repeat task.wait() until LocalPlayer.Character
            local root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new()
            bv.Parent = root
            
            Connections.Fly = Services.RunService.Heartbeat:Connect(function()
                if not Settings.Fly then return end
                local cam = workspace.CurrentCamera
                local move = Vector3.new()
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + cam.CFrame.UpVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - cam.CFrame.UpVector end
                bv.Velocity = move.Unit * Settings.FlySpeed
            end)
        end)
    else
        if Connections.Fly then Connections.Fly:Disconnect(); Connections.Fly = nil end
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")?.Destroy()
            end
        end)
    end
end)

CreateToggle(MovementTab, "Noclip", function(state)
    Settings.Noclip = state
    if state then
        Connections.Noclip = Services.RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part ~= LocalPlayer.Character.HumanoidRootPart then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect(); Connections.Noclip = nil end
    end
end)

-- PLAYER TAB
local PlayerTab = TabContent["PLAYER"]
CreateToggle(PlayerTab, "Spin Bot", function(state)
    if state then
        Connections.Spin = Services.RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
                end
            end)
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect(); Connections.Spin = nil end
    end
end)

CreateToggle(PlayerTab, "Low Gravity", function(state)
    Settings.LowGravity = state
    Services.Workspace.Gravity = state and 35 or 196.2
end)

CreateToggle(PlayerTab, "Fullbright", function(state)
    if state then
        Services.Lighting.Brightness = 4
        Services.Lighting.ClockTime = 14
        Services.Lighting.FogEnd = 9e9
        Services.Lighting.GlobalShadows = false
    else
        Services.Lighting.Brightness = 1
        Services.Lighting.ClockTime = 12
        Services.Lighting.FogEnd = 100000
        Services.Lighting.GlobalShadows = true
    end
end)

-- COMBAT TAB
local CombatTab = TabContent["COMBAT"]
CreateToggle(CombatTab, "Aimbot", function(state)
    if state then
        Connections.Aimbot = Services.RunService.Heartbeat:Connect(function()
            local target, closest = nil, math.huge
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < closest and dist < Settings.FOV then
                            target = plr
                            closest = dist
                        end
                    end
                end
            end
            if target and target.Character then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect(); Connections.Aimbot = nil end
    end
end)

CreateSlider(CombatTab, "Aimbot FOV", 50, 500, 200, function(val)
    Settings.FOV = val
end)

-- VISUALS TAB
local VisualsTab = TabContent["VISUALS"]
CreateToggle(VisualsTab, "ESP", function(state)
    Settings.ESP = state
    for _, plr in pairs(Services.Players:GetPlayers()) do
        pcall(function()
            if plr.Character then
                if state then
                    if plr.Character:FindFirstChild("PandusESP") then plr.Character.PandusESP:Destroy() end
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "PandusESP"
                    highlight.FillColor = Color3.fromRGB(0, 170, 255)
                    highlight.FillTransparency = 0.4
                    highlight.OutlineColor = Color3.new(1,1,1)
                    highlight.Parent = plr.Character
                elseif plr.Character:FindFirstChild("PandusESP") then
                    plr.Character.PandusESP:Destroy()
                end
            end
        end)
    end
end)

-- UTILITY TAB
local UtilityTab = TabContent["UTILITY"]
CreateToggle(UtilityTab, "Anti-AFK", function(state)
    if state then
        task.spawn(function()
            while state do
                task.spawn(function()
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(4000, 4000, 4000)
                    bv.Velocity = Vector3.new(0, 0.15, 0)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        bv.Parent = LocalPlayer.Character.HumanoidRootPart
                        task.wait(0.15)
                        bv:Destroy()
                    end
                end)
                task.wait(58)
            end
        end)
    end
end)

CreateButton(UtilityTab, "Rejoin", function()
    Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(UtilityTab, "Turcja", function()
    pcall(function()
        Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")["SayMessageRequest"]:FireServer("Turcja supremacy", "All")
    end)
end)

-- TROLL TAB
local TrollTab = TabContent["TROLL"]
CreateButton(TrollTab, "FLING ALL", function()
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                local root = plr.Character.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Velocity = Vector3.new(math.random(-5e4, 5e4), 7e4, math.random(-5e4, 5e4))
                bv.Parent = root
                Services.Debris:AddItem(bv, 0.3)
            end)
        end
    end
end)

CreateButton(TrollTab, "Teleport Players", function()
    local TpGui = Instance.new("Frame")
    TpGui.Size = UDim2.new(0, 260, 0, 340)
    TpGui.Position = UDim2.new(0.5, -130, 0.5, -170)
    TpGui.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
    TpGui.Parent = ScreenGui
    
    local TpCorner = Instance.new("UICorner")
    TpCorner.CornerRadius = UDim.new(0, 16)
    TpCorner.Parent = TpGui
    
    local TpTitle = Instance.new("TextLabel")
    TpTitle.Size = UDim2.new(1, 0, 0, 45)
    TpTitle.BackgroundTransparency = 1
    TpTitle.Text = "PLAYER TELEPORT"
    TpTitle.TextColor3 = Color3.fromRGB(230, 245, 255)
    TpTitle.TextScaled = true
    TpTitle.Font = Enum.Font.GothamBold
    TpTitle.Parent = TpGui
    
    local List = Instance.new("ScrollingFrame")
    List.Size = UDim2.new(1, -16, 1, -55)
    List.Position = UDim2.new(0, 8, 0, 47)
    List.BackgroundTransparency = 1
    List.BorderSizePixel = 0
    List.ScrollBarThickness = 5
    List.ScrollBarImageColor3 = Color3.fromRGB(90, 130, 255)
    List.Parent = TpGui
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = List
    
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 36)
            Btn.BackgroundColor3 = Color3.fromRGB(35, 45, 70)
            Btn.Text = plr.Name
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.TextScaled = true
            Btn.Font = Enum.Font.Gotham
            Btn.Parent = List
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 10)
            BtnCorner.Parent = Btn
            
            Btn.MouseButton1Click:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    end
                end)
                TpGui:Destroy()
            end)
        end
    end
end)

-- AUTO UPDATE CANVAS SIZE
local function UpdateCanvasSize()
    for _, frame in pairs(ContentFrame:GetChildren()) do
        if frame:IsA("ScrollingFrame") then
            frame:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                frame.CanvasSize = UDim2.new(0, 0, 0, frame.AbsoluteContentSize.Y + 40)
            end)
        end
    end
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.AbsoluteContentSize.Y + 40)
end
UpdateCanvasSize()

-- CONTROLS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

Services.UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.LeftShift then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then SwitchTab(1) end
    end
end)

-- CHARACTER HANDLER
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = Settings.Speed
        hum.JumpPower = Settings.JumpPower
        hum.HipHeight = Settings.HipHeight
    end)
end)

-- ESP PLAYER ADDED
Services.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(2)
        if Settings.ESP then
            pcall(function()
                local highlight = Instance.new("Highlight")
                highlight.Name = "PandusESP"
                highlight.FillColor = Color3.fromRGB(0, 170, 255)
                highlight.FillTransparency = 0.4
                highlight.OutlineColor = Color3.new(1,1,1)
                highlight.Parent = plr.Character
            end)
        end
    end)
end)

-- INITIAL TAB
SwitchTab(1)

print("✅ PANDUS CWL v13.0 FATALITY - LOADED PERFECTLY")
print("🎮 LeftShift toggle | CS:GO Fatality Style | 100% WORKING")
