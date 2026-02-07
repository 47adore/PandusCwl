-- PANDUS CWL - ULTIMATE EDITION
-- PROFESJONALNE CS:GO STYLE MENU

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    TeleportService = game:GetService("TeleportService"),
    Debris = game:GetService("Debris"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
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
    Speed = 100, JumpPower = 50, HipHeight = 0,
    FlySpeed = 50, FOV = 200, ESP = false, Fly = false, Noclip = false
}

local Connections = {}

-- MAIN GUI (LEKKO MNIEJSZE)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCWL"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 780, 0, 520)
MainFrame.Position = UDim2.new(0.5, -390, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- PROFESJONALNE CS:GO STYLE GRADIENTS
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 55)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(120, 150, 255)
MainStroke.Thickness = 1.8
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- DRAG SYSTEM
local Dragging, DragStart, StartPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 15, 30))
}
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 16)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PandusCWL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

-- RÓŻOWY-BIAŁY GRADIENT DLA TYTUŁU
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 230)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 180, 255))
}
TitleGradient.Rotation = 45
TitleGradient.Parent = Title

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseBtn

-- SIDE MENU (CS:GO STYLE)
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0, 140, 1, -55)
SideFrame.Position = UDim2.new(0, 0, 0, 55)
SideFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 14)
SideCorner.Parent = SideFrame

local SideStroke = Instance.new("UIStroke")
SideStroke.Color = Color3.fromRGB(80, 100, 200)
SideStroke.Thickness = 1.2
SideStroke.Parent = SideFrame

-- CONTENT FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -155, 1, -60)
ContentFrame.Position = UDim2.new(0, 145, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 100, 200)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- TABS (CS:GO STYLE)
local TabNames = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL"}
local CurrentTab = 1

local function CreateTabButton(name, index)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -12, 0, 45)
    TabBtn.Position = UDim2.new(0, 6, 0, 12 + (index-1) * 48)
    TabBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 210, 240)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabBtn
    
    local TabGradient = Instance.new("UIGradient")
    TabGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 55, 75)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 40, 55))
    }
    TabGradient.Parent = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = index
        for i, child in pairs(SideFrame:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                    BackgroundColor3 = Color3.fromRGB(40, 45, 60),
                    TextColor3 = Color3.fromRGB(200, 210, 240)
                }):Play()
                TweenService:Create(child.UIGradient, TweenInfo.new(0.2), {
                    Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 55, 75)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 40, 55))
                    }
                }):Play()
            end
        end
        TweenService:Create(TabBtn, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
            BackgroundColor3 = Color3.fromRGB(120, 150, 255),
            TextColor3 = Color3.new(1,1,1)
        }):Play()
        TweenService:Create(TabGradient, TweenInfo.new(0.25), {
            Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 170, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 130, 255))
            }
        }):Play()
    end)
    
    return TabBtn
end

-- PROFESJONALNE TOGGLE (BEZ KÓŁEK STATUSU)
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -24, 0, 48)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = ToggleFrame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 50, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 35, 50))
    }
    Gradient.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.73, 0, 0.6, 0)
    Label.Position = UDim2.new(0, 20, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(240, 245, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 60, 0, 32)
    SwitchFrame.Position = UDim2.new(1, -75, 0.2, 0)
    SwitchFrame.BackgroundColor3 = Color3.fromRGB(70, 75, 95)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = ToggleFrame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 18)
    SwitchCorner.Parent = SwitchFrame
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 26, 0, 26)
    Knob.Position = UDim2.new(0, 3, 0, 3)
    Knob.BackgroundColor3 = Color3.fromRGB(160, 170, 200)
    Knob.Parent = SwitchFrame
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local toggled = false
    SwitchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggled = not toggled
            TweenService:Create(SwitchFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                BackgroundColor3 = toggled and Color3.fromRGB(120, 150, 255) or Color3.fromRGB(70, 75, 95)
            }):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
                Position = toggled and UDim2.new(1, -29, 0, 3) or UDim2.new(0, 3, 0, 3),
                BackgroundColor3 = toggled and Color3.new(1,1,1) or Color3.fromRGB(160, 170, 200)
            }):Play()
            callback(toggled)
        end
    end)
    
    return toggled
end

-- SLIDER (CS:GO STYLE)
local function CreateSlider(name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -24, 0, 55)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.45, 0)
    Label.Position = UDim2.new(0, 20, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(240, 245, 255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.28, 0, 0.45, 0)
    ValueLabel.Position = UDim2.new(0.71, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(120, 150, 255)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.92, 0, 0, 8)
    Track.Position = UDim2.new(0.04, 0, 0.65, 0)
    Track.BackgroundColor3 = Color3.fromRGB(60, 65, 85)
    Track.BorderSizePixel = 0
    Track.Parent = SliderFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 6)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(120, 150, 255)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 6)
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
            local MousePos = Mouse.X - Track.AbsolutePosition.X
            local Percent = math.clamp(MousePos / Track.AbsoluteSize.X, 0, 1)
            local Value = math.floor(min + (max - min) * Percent)
            Fill.Size = UDim2.new(Percent, 0, 1, 0)
            ValueLabel.Text = tostring(Value)
            callback(Value)
        end
    end)
end

-- BUTTON (CS:GO STYLE)
local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 46)
    Button.BackgroundColor3 = Color3.fromRGB(60, 70, 95)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(240, 245, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = ContentFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = Button
    
    local ButtonGradient = Instance.new("UIGradient")
    ButtonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 85, 115)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 60, 85))
    }
    ButtonGradient.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(140, 170, 255)
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(60, 70, 95)
        }):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.08), {
            BackgroundColor3 = Color3.fromRGB(160, 190, 255)
        }):Play()
        task.wait(0.08)
        TweenService:Create(Button, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(140, 170, 255)
        }):Play()
        task.wait(0.12)
        TweenService:Create(Button, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(60, 70, 95)
        }):Play()
        callback()
    end)
end

-- CREATE TABS
for i, name in ipairs(TabNames) do
    CreateTabButton(name, i)
end

-- MOVEMENT TAB
CreateSlider("WalkSpeed", 16, 650, 100, function(val)
    Settings.Speed = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = val
    end)
end)

CreateSlider("JumpPower", 50, 650, 50, function(val)
    Settings.JumpPower = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.JumpPower = val
    end)
end)

CreateSlider("HipHeight", -10, 50, 0, function(val)
    Settings.HipHeight = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.HipHeight = val
    end)
end)

CreateToggle("Fly", function(state)
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
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
            end
        end)
    end
end)

CreateToggle("Noclip", function(state)
    Settings.Noclip = state
    if state then
        Connections.Noclip = Services.RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
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
CreateToggle("Spin Bot", function(state)
    if state then
        Connections.Spin = Services.RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(35), 0)
                end
            end)
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect(); Connections.Spin = nil end
    end
end)

CreateToggle("Low Gravity", function(state)
    Services.Workspace.Gravity = state and 50 or 196.2
end)

CreateToggle("Fullbright", function(state)
    if state then
        Services.Lighting.Brightness = 3
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
CreateToggle("Aimbot", function(state)
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

CreateSlider("Aimbot FOV", 50, 500, 200, function(val)
    Settings.FOV = val
end)

-- VISUALS TAB
CreateToggle("ESP", function(state)
    Settings.ESP = state
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            pcall(function()
                if state then
                    if plr.Character:FindFirstChild("Highlight") then plr.Character.Highlight:Destroy() end
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(0, 170, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.new(1,1,1)
                    highlight.Parent = plr.Character
                elseif plr.Character:FindFirstChild("Highlight") then
                    plr.Character.Highlight:Destroy()
                end
            end)
        end
    end
end)

-- UTILITY TAB
CreateToggle("Anti-AFK", function(state)
    if state then
        task.spawn(function()
            while state do
                task.wait(0.13)
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bv.Velocity = Vector3.new(0, 0.13, 0)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    bv.Parent = LocalPlayer.Character.HumanoidRootPart
                    task.wait(0.13)
                    bv:Destroy()
                end
                task.wait(58)
            end
        end)
    end
end)

CreateButton("Rejoin", function()
    Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton("Turcja", function()
    pcall(function()
        Services.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer("i Turcja", "All")
    end)
end)

-- TROLL TAB
CreateButton("FLING ALL", function()
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                local root = plr.Character.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Velocity = Vector3.new(math.random(-5e4, 5e4), 5e4, math.random(-5e4, 5e4))
                bv.Parent = root
                Services.Debris:AddItem(bv, 0.2)
            end)
        end
    end
end)

CreateButton("Teleport Players", function()
    local TpGui = Instance.new("Frame")
    TpGui.Size = UDim2.new(0, 240, 0, 320)
    TpGui.Position = UDim2.new(0.5, -120, 0.5, -160)
    TpGui.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
    TpGui.Parent = ScreenGui
    
    local TpCorner = Instance.new("UICorner")
    TpCorner.CornerRadius = UDim.new(0, 14)
    TpCorner.Parent = TpGui
    
    local TpTitle = Instance.new("TextLabel")
    TpTitle.Size = UDim2.new(1, 0, 0, 40)
    TpTitle.BackgroundTransparency = 1
    TpTitle.Text = "Teleport Menu"
    TpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TpTitle.TextScaled = true
    TpTitle.Font = Enum.Font.GothamBold
    TpTitle.Parent = TpGui
    
    local List = Instance.new("ScrollingFrame")
    List.Size = UDim2.new(1, -12, 1, -52)
    List.Position = UDim2.new(0, 6, 0, 46)
    List.BackgroundTransparency = 1
    List.BorderSizePixel = 0
    List.ScrollBarThickness = 4
    List.Parent = TpGui
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 6)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = List
    
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 32)
            Btn.BackgroundColor3 = Color3.fromRGB(50, 55, 75)
            Btn.Text = plr.Name
            Btn.TextColor3 = Color3.new(1,1,1)
            Btn.TextScaled = true
            Btn.Font = Enum.Font.Gotham
            Btn.Parent = List
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 8)
            BtnCorner.Parent = Btn
            
            Btn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                end
                TpGui:Destroy()
            end)
        end
    end
end)

-- CONTROLS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

Services.UserInputService.InputBegan:Connect(function(key, processed)
    if processed then return end
    if key.KeyCode == Enum.KeyCode.LeftShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CHARACTER SPAWN HANDLER
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

-- ESP PLAYER HANDLER
Services.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1.5)
        if Settings.ESP then
            CreateToggle("ESP", function() end)(true)
        end
    end)
end)

-- AUTO CANVAS UPDATE
ContentFrame:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.AbsoluteContentSize.Y + 40)
end)

-- ANTICHEAT BYPASS
task.spawn(function()
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            local n = obj.Name:lower()
            if n:find("anticheat") or n:find("ac") or n:find("exploit") or n:find("cheat") then
                obj:Destroy()
            end
        end)
    end
end)

print("PandusCWL - Ultimate Edition - LOADED PERFECTLY")
print("LeftShift to toggle - CS:GO Style Menu Ready!")
