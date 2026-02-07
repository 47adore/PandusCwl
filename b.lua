-- 🌟 PANDUS CWL v12.0 ULTIMATE PRO 🌟
-- PROFESJONALNY + PEŁNE FUNKCJE + ZERO BŁĘDÓW

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    TeleportService = game:GetService("TeleportService"),
    Debris = game:GetService("Debris"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService")
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- CLEANUP
for _,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name:find("PandusCwl") then pcall(function() v:Destroy() end) end
end

-- ULTIMATE ANTICHEAT BYPASS
spawn(function()
    -- Kill anticheat scripts
    for _,obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            local n = obj.Name:lower()
            if n:find("anticheat") or n:find("ac") or n:find("exploit") or n:find("cheat") then
                obj:Destroy()
            end
        end)
    end
    
    -- Safe hook
    local mt = getrawmetatable(game)
    if mt and mt.__namecall then
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            local arg1 = tostring(args[1] or "")
            
            if method == "FireServer" and (
                arg1:lower():find("anticheat") or arg1:lower():find("kick") or 
                arg1:lower():find("cheat") or arg1:lower():find("exploit")
            ) then return end
            
            if method:lower() == "kick" then return end
            
            return old(self, ...)
        end
        setreadonly(mt, true)
    end
end)

-- CONFIG
local Config = {
    Speed = 100, JumpPower = 50, HipHeight = 0,
    FlySpeed = 75, FOV = 200,
    Keybind = Enum.KeyCode.LeftShift,
    ESP = false, Noclip = false, Fly = false
}

local Connections = {}
local ESPObjects = {}

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwl"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 860, 0, 600)
MainFrame.Position = UDim2.new(0.5, -430, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- GLASS EFFECT
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 30, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 120, 180)
UIStroke.Thickness = 2.5
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

-- DRAG
local Dragging, DragInput, DragStart, StartPos
local function UpdateInput(input)
    local Delta = input.Position - DragStart
    MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
end

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
        UpdateInput(input)
    end
end)

-- HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundColor3 = Color3.fromRGB(12, 16, 28)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 25))
}
HeaderGradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.65, 0, 1, 0)
Title.Position = UDim2.new(0, 25, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ PANDUS CWL v12.0 ULTIMATE"
Title.TextColor3 = Color3.fromRGB(120, 255, 120)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

local BindFrame = Instance.new("Frame")
BindFrame.Size = UDim2.new(0, 120, 0, 35)
BindFrame.Position = UDim2.new(0.65, 0, 0.15, 0)
BindFrame.BackgroundColor3 = Color3.fromRGB(45, 55, 85)
BindFrame.BorderSizePixel = 0
BindFrame.Parent = Header

local BindCorner = Instance.new("UICorner")
BindCorner.CornerRadius = UDim.new(0, 12)
BindCorner.Parent = BindFrame

local BindLabel = Instance.new("TextLabel")
BindLabel.Size = UDim2.new(1, -10, 1, 0)
BindLabel.Position = UDim2.new(0, 5, 0, 0)
BindLabel.BackgroundTransparency = 1
BindLabel.Text = "LShift"
BindLabel.TextColor3 = Color3.fromRGB(220, 240, 255)
BindLabel.TextScaled = true
BindLabel.Font = Enum.Font.GothamSemibold
BindLabel.Parent = BindFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Position = UDim2.new(1, -55, 0.5, -22.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
CloseBtn.Text = "❌"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 14)
CloseCorner.Parent = CloseBtn

-- SIDE MENU
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0, 165, 1, -65)
SideFrame.Position = UDim2.new(0, 0, 0, 65)
SideFrame.BackgroundColor3 = Color3.fromRGB(22, 28, 42)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 16)
SideCorner.Parent = SideFrame

local SideStroke = Instance.new("UIStroke")
SideStroke.Color = Color3.fromRGB(60, 75, 110)
SideStroke.Thickness = 1.5
SideStroke.Parent = SideFrame

-- TABS SYSTEM
local Tabs = {"🏃 MOVEMENT", "👤 PLAYER", "⚔️ COMBAT", "👁️ VISUALS", "🛠️ UTILITY", "😂 FUN"}
local TabContents = {}
local TabButtons = {}
local CurrentTab = 1

for i, tabName in ipairs(Tabs) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -16, 0, 52)
    TabBtn.Position = UDim2.new(0, 8, (i-1) * 54, 8)
    TabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(90, 110, 160) or Color3.fromRGB(40, 48, 70)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = i == 1 and Color3.new(1,1,1) or Color3.fromRGB(190, 205, 235)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.Ubuntu
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 16)
    TabCorner.Parent = TabBtn
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = i == 1 and Color3.fromRGB(120, 150, 220) or Color3.fromRGB(50, 60, 85)
    TabStroke.Thickness = 1.8
    TabStroke.Parent = TabBtn
    
    TabButtons[i] = TabBtn
    
    -- CONTENT
    local Content = Instance.new("ScrollingFrame")
    Content.Name = tabName .. "_Content"
    Content.Size = UDim2.new(1, -175, 1, -70)
    Content.Position = UDim2.new(0, 170, 0, 70)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 8
    Content.ScrollBarImageColor3 = Color3.fromRGB(70, 85, 120)
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.Visible = i == 1
    Content.Parent = MainFrame
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 14)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = Content
    
    TabContents[i] = Content
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        for j, content in pairs(TabContents) do
            content.Visible = j == i
        end
        for j, btn in pairs(TabButtons) do
            if j == i then
                TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    BackgroundColor3 = Color3.fromRGB(90, 110, 160),
                    TextColor3 = Color3.new(1,1,1)
                }):Play()
                TweenService:Create(btn.UIStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(120, 150, 220)}):Play()
            else
                TweenService:Create(btn, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(40, 48, 70),
                    TextColor3 = Color3.fromRGB(190, 205, 235)
                }):Play()
                TweenService:Create(btn.UIStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(50, 60, 85)}):Play()
            end
        end
    end)
end

-- UI COMPONENTS
local function CreateToggle(parent, name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -24, 0, 55)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 42, 62)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Frame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 50, 72)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 35, 52))
    }
    Gradient.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.72, 0, 0.55, 0)
    Label.Position = UDim2.new(0, 22, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(240, 250, 270)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    -- STATUS DOT (LEWO)
    local StatusDot = Instance.new("Frame")
    StatusDot.Size = UDim2.new(0, 16, 0, 16)
    StatusDot.Position = UDim2.new(0, 18, 0.42, 0)
    StatusDot.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    StatusDot.Parent = Frame
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = StatusDot
    
    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0, 56, 0, 32)
    SwitchFrame.Position = UDim2.new(1, -70, 0.35, 0)
    SwitchFrame.BackgroundColor3 = Color3.fromRGB(65, 75, 105)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = Frame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 18)
    SwitchCorner.Parent = SwitchFrame
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 26, 0, 26)
    Knob.Position = UDim2.new(0, 3, 0, 3)
    Knob.BackgroundColor3 = Color3.fromRGB(180, 190, 220)
    Knob.Parent = SwitchFrame
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local toggled = false
    local function Toggle()
        toggled = not toggled
        TweenService:Create(SwitchFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            BackgroundColor3 = toggled and Color3.fromRGB(95, 120, 175) or Color3.fromRGB(65, 75, 105)
        }):Play()
        TweenService:Create(Knob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = toggled and UDim2.new(1, -29, 0, 3) or UDim2.new(0, 3, 0, 3),
            BackgroundColor3 = toggled and Color3.new(1,1,1) or Color3.fromRGB(180, 190, 220)
        }):Play()
        TweenService:Create(StatusDot, TweenInfo.new(0.25), {
            BackgroundColor3 = toggled and Color3.fromRGB(60, 230, 120) or Color3.fromRGB(220, 60, 60)
        }):Play()
        callback(toggled)
    end
    
    SwitchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggle()
        end
    end)
    
    return Toggle
end

local function CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -24, 0, 65)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 42, 62)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.75, 0, 0.45, 0)
    Label.Position = UDim2.new(0, 22, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(240, 250, 270)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.22, 0, 0.45, 0)
    ValueLabel.Position = UDim2.new(0.76, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(100, 130, 200)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.92, 0, 0, 10)
    Track.Position = UDim2.new(0.04, 0, 0.65, 0)
    Track.BackgroundColor3 = Color3.fromRGB(55, 65, 95)
    Track.BorderSizePixel = 0
    Track.Parent = Frame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 6)
    TrackCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(100, 130, 200)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 6)
    FillCorner.Parent = Fill
    
    local SliderDragging = false
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            SliderDragging = true
        end
    end)
    
    Track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            SliderDragging = false
        end
    end)
    
    Services.UserInputService.InputChanged:Connect(function(input)
        if SliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local MousePos = input.Position.X - Track.AbsolutePosition.X
            local Percent = math.clamp(MousePos / Track.AbsoluteSize.X, 0, 1)
            local Value = math.floor(min + (max - min) * Percent)
            Fill.Size = UDim2.new(Percent, 0, 1, 0)
            ValueLabel.Text = tostring(Value)
            callback(Value)
        end
    end)
end

local function CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 52)
    Button.BackgroundColor3 = Color3.fromRGB(70, 85, 125)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(245, 255, 275)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Button
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 105, 155)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 70, 110))
    }
    Gradient.Parent = Button
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(110, 135, 195)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 85, 125)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(130, 160, 230)}):Play()
        task.wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(110, 135, 195)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB 🏃
CreateSlider(TabContents[1], "WalkSpeed", 16, 650, 100, function(val)
    Config.Speed = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = val
    end)
end)

CreateSlider(TabContents[1], "JumpPower", 50, 650, 50, function(val)
    Config.JumpPower = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.JumpPower = val
    end)
end)

CreateSlider(TabContents[1], "HipHeight", -10, 50, 0, function(val)
    Config.HipHeight = val
    task.spawn(function()
        repeat task.wait() until LocalPlayer.Character
        local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
        humanoid.HipHeight = val
    end)
end)

local FlyToggle = CreateToggle(TabContents[1], "Fly (WASD + Space)", function(state)
    Config.Fly = state
    if state then
        task.spawn(function()
            repeat task.wait() until LocalPlayer.Character
            local root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new()
            bv.Parent = root
            
            Connections.Fly = Services.RunService.Heartbeat:Connect(function()
                if not Config.Fly then return end
                local cam = workspace.CurrentCamera
                local move = Vector3.new()
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + cam.CFrame.UpVector end
                if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - cam.CFrame.UpVector end
                bv.Velocity = move.Unit * Config.FlySpeed
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

local NoclipToggle = CreateToggle(TabContents[1], "Noclip", function(state)
    Config.Noclip = state
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

-- PLAYER TAB 👤
CreateToggle(TabContents[2], "SpinBot", function(state)
    if state then
        Connections.Spin = Services.RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(40), 0)
                end
            end)
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect(); Connections.Spin = nil end
    end
end)

CreateToggle(TabContents[2], "Low Gravity", function(state)
    Services.Workspace.Gravity = state and 25 or 196.2
end)

CreateToggle(TabContents[2], "Fullbright", function(state)
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

-- COMBAT TAB ⚔️
CreateToggle(TabContents[3], "Aimbot (FOV " .. Config.FOV .. ")", function(state)
    if state then
        Connections.Aimbot = Services.RunService.Heartbeat:Connect(function()
            local target, closest = nil, math.huge
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if dist < closest and dist < Config.FOV then
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

CreateSlider(TabContents[3], "Aimbot FOV", 50, 500, 200, function(val)
    Config.FOV = val
end)

-- VISUALS TAB 👁️
local ESPToggle = CreateToggle(TabContents[4], "ESP (Box + Name)", function(state)
    Config.ESP = state
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            pcall(function()
                if state and plr.Character then
                    -- Remove old ESP
                    if plr.Character:FindFirstChild("PandusESP") then plr.Character.PandusESP:Destroy() end
                    
                    local espFolder = Instance.new("Folder")
                    espFolder.Name = "PandusESP"
                    espFolder.Parent = plr.Character
                    
                    -- Box ESP
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "Box"
                    box.Size = plr.Character:GetExtentsSize()
                    box.Color3 = Color3.fromRGB(0, 255, 200)
                    box.Transparency = 0.6
                    box.ZIndex = 10
                    box.AlwaysOnTop = true
                    box.Adornee = plr.Character
                    box.Parent = espFolder
                    
                    -- Name ESP
                    local nameTag = Instance.new("BillboardGui")
                    nameTag.Name = "NameTag"
                    nameTag.Size = UDim2.new(0, 200, 0, 50)
                    nameTag.StudsOffset = Vector3.new(0, 3, 0)
                    nameTag.Parent = plr.Character.Head
                    nameTag.Adornee = plr.Character.Head
                    
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = plr.Name
                    nameLabel.TextColor3 = Color3.new(1, 1, 1)
                    nameLabel.TextScaled = true
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = nameTag
                elseif plr.Character and plr.Character:FindFirstChild("PandusESP") then
                    plr.Character.PandusESP:Destroy()
                    if plr.Character.Head:FindFirstChild("NameTag") then
                        plr.Character.Head.NameTag:Destroy()
                    end
                end
            end)
        end
    end
end)

-- UTILITY TAB 🛠️
CreateToggle(TabContents[5], "Anti-AFK", function(state)
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

CreateButton(TabContents[5], "🔄 Rejoin Server", function()
    Services.TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(TabContents[5], "🎯 Bind Key", function()
    BindLabel.Text = "Press Key..."
    local connection
    connection = Services.UserInputService.InputBegan:Connect(function(key, processed)
        if processed then return end
        if key.KeyCode ~= Enum.KeyCode.Escape then
            Config.Keybind = key.KeyCode
            BindLabel.Text = key.KeyCode.Name
        end
        connection:Disconnect()
    end)
end)

CreateButton(TabContents[5], "🌙 Night Vision", function()
    Services.Lighting.Brightness = 3
    Services.Lighting.Ambient = Color3.fromRGB(100, 100, 100)
end)

-- FUN TAB 😂
CreateButton(TabContents[6], "🚀 FLING ALL ULTRA", function()
    local successCount = 0
    for i, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                successCount = successCount + 1
                local root = plr.Character.HumanoidRootPart
                
                -- Teleport close first
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, -4)
                    task.wait(0.05)
                end
                
                -- Fling
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bv.Velocity = Vector3.new(math.random(-5e4, 5e4), 5e4, math.random(-5e4, 5e4))
                bv.Parent = root
                
                local ba = Instance.new("BodyAngularVelocity")
                ba.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                ba.AngularVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
                ba.Parent = root
                
                Services.Debris:AddItem(bv, 0.4)
                Services.Debris:AddItem(ba, 0.4)
                
                -- Success notification
                local noti = Instance.new("ScreenGui", ScreenGui)
                local frame = Instance.new("Frame", noti)
                frame.Size = UDim2.new(0, 280, 0, 70)
                frame.Position = UDim2.new(0.5, -140, 0.2, 0)
                frame.BackgroundColor3 = Color3.fromRGB(40, 220, 100)
                frame.Parent = ScreenGui
                
                local nCorner = Instance.new("UICorner", frame)
                nCorner.CornerRadius = UDim.new(0, 16)
                
                local nLabel = Instance.new("TextLabel", frame)
                nLabel.Size = UDim2.new(1, 0, 1, 0)
                nLabel.BackgroundTransparency = 1
                nLabel.Text = "FLING SUCCESS #" .. successCount .. " ✅"
                nLabel.TextColor3 = Color3.new(0, 0, 0)
                nLabel.TextScaled = true
                nLabel.Font = Enum.Font.GothamBold
                
                TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 80)}):Play()
                task.wait(2.5)
                noti:Destroy()
            end)
        end
    end
end)

CreateButton(TabContents[6], "💥 EXPLODE NEAREST", function()
    local nearest, dist = nil, math.huge
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local d = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then nearest = plr; dist = d end
        end
    end
    if nearest then
        local explosion = Instance.new("Explosion")
        explosion.Position = nearest.Character.HumanoidRootPart.Position
        explosion.BlastRadius = 150
        explosion.BlastPressure = 500000
        explosion.Parent = workspace
    end
end)

CreateButton(TabContents[6], "🌀 RANDOM YEET", function()
    local targets = {}
    for _, plr in pairs(Services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then table.insert(targets, plr) end
    end
    if #targets > 0 then
        local target = targets[math.random(1, #targets)]
        if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            target.Character.HumanoidRootPart.CFrame = CFrame.new(math.random(-500, 500), 10000, math.random(-500, 500))
        end
    end
end)

-- CHARACTER HANDLER
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char:WaitForChild("Humanoid")
        hum.WalkSpeed = Config.Speed
        hum.JumpPower = Config.JumpPower
        hum.HipHeight = Config.HipHeight
    end)
end)

-- ESP HANDLER
Services.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1.5)
        if Config.ESP then
            ESPToggle(true)
        end
    end)
end)

-- CONTROLS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

Services.UserInputService.InputBegan:Connect(function(key, processed)
    if processed then return end
    if key.KeyCode == Config.Keybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- AUTO UPDATE CANVAS
task.spawn(function()
    task.wait(1)
    for _, content in pairs(TabContents) do
        content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            content.CanvasSize = UDim2.new(0, 0, 0, content.AbsoluteContentSize.Y + 40)
        end)
        content.CanvasSize = UDim2.new(0, 0, 0, content.AbsoluteContentSize.Y + 40)
    end
end)

print("🌟 PANDUS CWL v12.0 ULTIMATE - LOADED PERFECTLY!")
print("✅ Full features | Professional UI | LeftShift Toggle")
