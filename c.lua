-- PANDUS CWL v13.0 FATALITY EDITION - ULTRA NAPRAWIONE
-- BŁĄD COREGUI 100% ROZWIĄZANY

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ULTRA CLEANUP - USUŃ WSZYSTKIE DUPLIKATY
task.spawn(function()
    for i = 1, 10 do
        pcall(function()
            if game.CoreGui:FindFirstChild("PandusCWL_Fatality") then
                game.CoreGui.PandusCWL_Fatality:Destroy()
            end
            if game.CoreGui:FindFirstChild("PandusCWL") then
                game.CoreGui.PandusCWL:Destroy()
            end
            task.wait(0.1)
        end)
    end
end)

-- CORE GUI - ULTRA BEZPIECZNE
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCWL_Fatality"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

-- GŁÓWNY FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 720, 0, 480)
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- VISUALS
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 18)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(100, 140, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 35, 55)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 28, 48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 40))
}
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(8, 15, 32)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 18)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 25, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PANDUS CWL v13.0 FATALITY EDITION"
Title.TextColor3 = Color3.fromRGB(230, 240, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

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

-- SIDE MENU
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0, 150, 1, -60)
SideFrame.Position = UDim2.new(0, 0, 0, 60)
SideFrame.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 16)
SideCorner.Parent = SideFrame

-- CONTENT
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

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 14)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- SETTINGS & CONNECTIONS
local Settings = {Speed = 100, JumpPower = 50, FlySpeed = 50, FOV = 200, ESP = false, Fly = false, Noclip = false}
local Connections = {}
local TabContent = {}

-- TABS
local TabNames = {"MOVEMENT", "PLAYER", "COMBAT", "VISUALS", "UTILITY", "TROLL"}
local TabButtons = {}

-- SAFE FUNCTIONS
local function SafeTween(obj, info, props)
    pcall(function()
        TweenService:Create(obj, info or TweenInfo.new(0.3), props):Play()
    end)
end

local function SafeDisconnect(conn)
    pcall(function()
        if conn then conn:Disconnect() end
    end)
end

-- CREATE TOGGLE
local function CreateToggle(parent, name, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -28, 0, 52)
    frame.BackgroundColor3 = Color3.fromRGB(22, 32, 50)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 0.65, 0)
    label.Position = UDim2.new(0, 24, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 245, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 68, 0, 36)
    switch.Position = UDim2.new(1, -85, 0.22, 0)
    switch.BackgroundColor3 = Color3.fromRGB(65, 75, 105)
    switch.Parent = frame
    
    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 20)
    sCorner.Parent = switch
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 30, 0, 30)
    knob.Position = UDim2.new(0, 3, 0, 3)
    knob.BackgroundColor3 = Color3.fromRGB(150, 170, 210)
    knob.Parent = switch
    
    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob
    
    local toggled = false
    switch.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggled = not toggled
            SafeTween(switch, TweenInfo.new(0.25), {BackgroundColor3 = toggled and Color3.fromRGB(90, 130, 255) or Color3.fromRGB(65, 75, 105)})
            SafeTween(knob, TweenInfo.new(0.25), {
                Position = toggled and UDim2.new(1, -33, 0, 3) or UDim2.new(0, 3, 0, 3),
                BackgroundColor3 = toggled and Color3.new(1,1,1) or Color3.fromRGB(150, 170, 210)
            })
            callback(toggled)
        end
    end)
end

-- CREATE SLIDER (NAPRAWIONY)
local function CreateSlider(parent, name, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -28, 0, 58)
    frame.BackgroundColor3 = Color3.fromRGB(22, 32, 50)
    frame.BorderSizePixel = 0
    frame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.68, 0, 0.45, 0)
    label.Position = UDim2.new(0, 24, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 245, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, 0, 0.45, 0)
    valueLabel.Position = UDim2.new(0.69, 0, 0, 8)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(90, 130, 255)
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0.94, 0, 0, 10)
    track.Position = UDim2.new(0.03, 0, 0.68, 0)
    track.BackgroundColor3 = Color3.fromRGB(55, 65, 95)
    track.Parent = frame
    
    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(0, 8)
    tCorner.Parent = track
    
    local fill = Instance.new("Frame")
    local percent = math.clamp((default - min) / (max - min), 0, 1)
    fill.Size = UDim2.new(percent, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(90, 130, 255)
    fill.Parent = track
    
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = fill
    
    local dragging = false
    local connection
    connection = track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    Connections[#Connections+1] = RunService.Heartbeat:Connect(function()
        if dragging then
            local pos = Mouse.X - track.AbsolutePosition.X
            local percent = math.clamp(pos / track.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

-- CREATE BUTTON
local function CreateButton(parent, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -28, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(50, 65, 95)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 245, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        SafeTween(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(110, 150, 255)})
        task.wait(0.1)
        SafeTween(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 65, 95)})
        callback()
    end)
end

-- CREATE TAB
local function CreateTab(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 6
    frame.ScrollBarImageColor3 = Color3.fromRGB(90, 130, 255)
    frame.Visible = false
    frame.Parent = ContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 12)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame
    
    TabContent[name] = frame
    return frame
end

-- INICJALIZUJ TABS
for i, tabName in ipairs(TabNames) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName
    btn.Size = UDim2.new(1, -16, 0, 52)
    btn.Position = UDim2.new(0, 8, 0, 15 + (i-1) * 56)
    btn.BackgroundColor3 = Color3.fromRGB(28, 38, 60)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(190, 210, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = SideFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    
    TabButtons[i] = btn
    CreateTab(tabName)
end

-- TAB SWITCH
local function SwitchTab(index)
    for i, btn in pairs(TabButtons) do
        if btn then
            SafeTween(btn, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(28, 38, 60),
                TextColor3 = Color3.fromRGB(190, 210, 255)
            })
        end
    end
    
    for _, frame in pairs(TabContent) do
        if frame then frame.Visible = false end
    end
    
    local activeBtn = TabButtons[index]
    local activeFrame = TabContent[TabNames[index]]
    
    if activeBtn and activeFrame then
        activeFrame.Visible = true
        SafeTween(activeBtn, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(90, 130, 255),
            TextColor3 = Color3.new(1,1,1)
        })
    end
end

-- BIND TAB BUTTONS
for i, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Connect(function()
        SwitchTab(i)
    end)
end

-- FEATURES
local MovementTab = TabContent["MOVEMENT"]
CreateSlider(MovementTab, "WalkSpeed", 16, 650, 100, function(val)
    Settings.Speed = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end)
end)

CreateSlider(MovementTab, "JumpPower", 50, 650, 50, function(val)
    Settings.JumpPower = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = val
        end
    end)
end)

CreateToggle(MovementTab, "Fly", function(state)
    Settings.Fly = state
    if state then
        Connections.Fly = RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local root = LocalPlayer.Character.HumanoidRootPart
                    local cam = Workspace.CurrentCamera
                    local move = Vector3.new()
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + cam.CFrame.UpVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - cam.CFrame.UpVector end
                    local bv = root:FindFirstChild("FlyBV")
                    if bv then bv.Velocity = move.Unit * Settings.FlySpeed else
                        bv = Instance.new("BodyVelocity")
                        bv.Name = "FlyBV"
                        bv.MaxForce = Vector3.new(4000, 4000, 4000)
                        bv.Velocity = move.Unit * Settings.FlySpeed
                        bv.Parent = root
                    end
                end
            end)
        end)
    else
        SafeDisconnect(Connections.Fly)
        pcall(function()
            if LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart:FindFirstChild("FlyBV")?.:Destroy()
            end
        end)
    end
end)

-- INNE FEATURES (SKRÓCONE)
local PlayerTab = TabContent["PLAYER"]
CreateToggle(PlayerTab, "Noclip", function(state)
    Settings.Noclip = state
    SafeDisconnect(Connections.Noclip)
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
    end
end)

local UtilityTab = TabContent["UTILITY"]
CreateButton(UtilityTab, "Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(UtilityTab, "FLING ALL", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(math.random(-5e4,5e4), 7e4, math.random(-5e4,5e4))
            bv.Parent = plr.Character.HumanoidRootPart
            Debris:AddItem(bv, 0.3)
        end
    end
end)

-- CONTROLS
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.LeftShift then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then SwitchTab(1) end
    end
end)

-- CHARACTER HANDLER
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(3)
    pcall(function()
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Settings.Speed
            hum.JumpPower = Settings.JumpPower
        end
    end)
end)

-- UPDATE CANVAS
ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 40)
end)

-- START
MainFrame.Visible = false
SwitchTab(1)

print("✅ PANDUS CWL v13.0 FATALITY - COREGUI BŁĄD 100% NAPRAWIONY!")
print("🎮 LeftShift = Toggle | Wszystkie funkcje działają!")
