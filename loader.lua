-- PANDUSCWL v6.0 ULTIMATE PROFESSIONAL EDITION
-- ULTRA SMOOTH ANIMATIONS + PROFESSIONAL DESIGN

local TweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer

-- CLEANUP
for _, obj in pairs(CoreGui:GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- STATES
local Enabled = {}
local Connections = {}

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.Parent = CoreGui

-- SHADOW FRAME
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(0, 800, 0, 700)
Shadow.Position = UDim2.new(0.5, -400, 0.5, -350)
Shadow.BackgroundTransparency = 1
Shadow.ZIndex = 1
Shadow.Parent = ScreenGui

-- MAIN FRAME 800x700 (ULTIMATE SIZE)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 800, 0, 700)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -350)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 20, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 10, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 80))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 30)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 140, 255)
MainStroke.Thickness = 3
MainStroke.Transparency = 0.2
MainStroke.Parent = MainFrame

-- SHADOW EFFECT
for i = 1, 15 do
    local shadowPart = Instance.new("Frame")
    shadowPart.Size = UDim2.new(1, i*2, 1, i*2)
    shadowPart.Position = UDim2.new(0, -i, 0, -i)
    shadowPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadowPart.BackgroundTransparency = 0.9 + i*0.02
    shadowPart.BorderSizePixel = 0
    shadowPart.ZIndex = 2
    shadowPart.Parent = Shadow
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 30 + i)
    shadowCorner.Parent = shadowPart
end

-- ANIMATED HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 100)
Header.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 80, 255))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local HeaderCorner = Instance.neww("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 30)
HeaderCorner.Parent = Header

-- HEADER TITLE (ANIMATED)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 0.7, 0)
Title.Position = UDim2.new(0, 40, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "✨ PANDUSCWL v6.0 ULTIMATE ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.fromRGB(255, 100, 255)
Title.Parent = Header

Title:TweenPosition(UDim2.new(0, 40, 0, 10), "Out", "Quad", 0.5, true)

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0.7, 0, 0.3, 0)
Subtitle.Position = UDim2.new(0, 40, 0, 65)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "PROFESSIONAL ESP | FLY | TROLL | PVP"
Subtitle.TextColor3 = Color3.fromRGB(230, 200, 255)
Subtitle.TextScaled = true
Subtitle.Font = Enum.Font.GothamSemibold
Subtitle.Parent = Header

-- CLOSE BUTTON (ANIMATED)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 70, 0, 60)
CloseBtn.Position = UDim2.new(1, -85, 0, 20)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.white
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 20)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo, {Size = UDim2.new(0, 80, 0, 65)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo, {Size = UDim2.new(0, 70, 0, 60)}):Play()
end)

-- SIDE PANEL FOR TABS (SLIDING)
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 160, 1, -110)
SidePanel.Position = UDim2.new(0, 0, 0, 105)
SidePanel.BackgroundColor3 = Color3.fromRGB(40, 30, 90)
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 25)
SideCorner.Parent = SidePanel

local SideGradient = Instance.new("UIGradient")
SideGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 45, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 20, 70))
}
SideGradient.Rotation = 90
SideGradient.Parent = SidePanel

-- CONTENT AREA (MAIN)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -185, 1, -120)
ContentArea.Position = UDim2.new(0, 175, 0, 110)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- TABS (VERTICAL SIDE PANEL)
local Tabs = {"MAIN", "TROLL", "PVP", "MOVEMENT", "VISUALS", "SETTINGS"}
local TabColors = {
    Color3.fromRGB(255, 140, 220), Color3.fromRGB(255, 100, 200),
    Color3.fromRGB(200, 120, 255), Color3.fromRGB(160, 200, 255),
    Color3.fromRGB(140, 220, 255), Color3.fromRGB(120, 180, 255)
}

local TabContents = {}
for i, tabName in ipairs(Tabs) do
    -- TAB BUTTON (VERTICAL)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName
    TabBtn.Size = UDim2.new(1, -20, 0, 65)
    TabBtn.Position = UDim2.new(0, 10, 0, (i-1)*75 + 20)
    TabBtn.BackgroundColor3 = Color3.fromRGB(70, 55, 140)
    TabBtn.Text = "  "..tabName.."  "
    TabBtn.TextColor3 = Color3.white
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SidePanel

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 25)
    TabCorner.Parent = TabBtn

    local TabIcon = Instance.new("TextLabel")
    TabIcon.Size = UDim2.new(0, 30, 1, 0)
    TabIcon.Position = UDim2.new(0, 10, 0, 0)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Text = ({
        "⭐", "🌀", "⚔️", "🚀", "👁️", "⚙️"
    })[i]
    TabIcon.TextColor3 = Color3.fromRGB(255, 200, 255)
    TabIcon.TextScaled = true
    TabIcon.Font = Enum.Font.GothamBold
    TabIcon.Parent = TabBtn

    -- CONTENT
    TabContents[tabName] = Instance.new("ScrollingFrame")
    TabContents[tabName].Name = tabName.."Content"
    TabContents[tabName].Size = UDim2.new(1, 0, 1, 0)
    TabContents[tabName].BackgroundTransparency = 1
    TabContents[tabName].BorderSizePixel = 0
    TabContents[tabName].ScrollBarThickness = 10
    TabContents[tabName].ScrollBarImageColor3 = Color3.fromRGB(255, 180, 255)
    TabContents[tabName].Visible = false
    TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContents[tabName].Parent = ContentArea

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 18)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContents[tabName]

    TabContents[tabName].ChildAdded:Connect(function()
        TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 50)
    end)

    -- TAB ANIMATION
    TabBtn.MouseButton1Click:Connect(function()
        for name, content in pairs(TabContents) do
            content.Visible = (name == tabName)
        end
        
        for _, btn in pairs(SidePanel:GetChildren()) do
            if btn:IsA("TextButton") then
                TweenService:Create(btn, TweenInfo, {
                    BackgroundColor3 = Color3.fromRGB(70, 55, 140),
                    Size = UDim2.new(1, -20, 0, 65)
                }):Play()
                btn.TextColor3 = Color3.white
            end
        end
        
        TweenService:Create(TabBtn, TweenInfo, {
            BackgroundColor3 = TabColors[i],
            Size = UDim2.new(1, -10, 0, 75)
        }):Play()
        TabBtn.TextColor3 = Color3.fromRGB(20, 15, 50)
    end)
end

-- ULTIMATE TOGGLE (FULL ANIMATED)
local function CreateToggle(parent, name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -30, 0, 85)
    Frame.BackgroundColor3 = Color3.fromRGB(55, 45, 120)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 25)
    FCorner.Parent = Frame

    local FGradient = Instance.new("UIGradient")
    FGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 60, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 35, 100))
    }
    FGradient.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 0.6, 0)
    Label.Position = UDim2.new(0, 25, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.white
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 60, 0, 60)
    ToggleCircle.Position = UDim2.new(1, -80, 0.5, -30)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 150, 220)
    ToggleCircle.Parent = Frame

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle

    local ToggleText = Instance.new("TextLabel")
    ToggleText.Size = UDim2.new(1, 0, 1, 0)
    ToggleText.BackgroundTransparency = 1
    ToggleText.Text = "OFF"
    ToggleText.TextColor3 = Color3.white
    ToggleText.TextScaled = true
    ToggleText.Font = Enum.Font.GothamBold
    ToggleText.Parent = ToggleCircle

    local active = false
    ToggleCircle.InputBegan:Connect(function()
        active = not active
        local targetColor = active and Color3.fromRGB(255, 80, 180) or Color3.fromRGB(255, 150, 220)
        local targetText = active and "ON" or "OFF"
        
        TweenService:Create(ToggleCircle, TweenInfo, {
            BackgroundColor3 = targetColor
        }):Play()
        ToggleText.Text = targetText
        
        callback(active)
    end)
end

-- ULTIMATE BUTTON (FULL ANIMATED)
local function CreateButton(parent, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -30, 0, 85)
    Btn.BackgroundColor3 = Color3.fromRGB(200, 120, 255)
    Btn.Text = "  "..name.."  "
    Btn.TextColor3 = Color3.white
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local BtnGradient = Instance.new("UIGradient")
    BtnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 140, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 90, 255))
    }
    BtnGradient.Parent = Btn

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 25)
    BtnCorner.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo, {Size = UDim2.new(1, -20, 0, 90)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo, {Size = UDim2.new(1, -30, 0, 85)}):Play()
    end)
end

-- ALL FEATURES (OPTIMIZED)
CreateToggle(TabContents.MAIN, "✈️ FLY (WASD + SPACE/SHIFT)", function(state)
    Enabled.Fly = state
    if state then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
            bv.Velocity = Vector3.new()

            Connections.Fly = RunService.Heartbeat:Connect(function()
                if Enabled.Fly and root.Parent then
                    local moveVector = Vector3.new()
                    local cam = workspace.CurrentCamera
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.yAxis end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - Vector3.yAxis end
                    bv.Velocity = moveVector.Unit * 100
                end
            end)
        end
    else
        if Connections.Fly then Connections.Fly:Disconnect() Connections.Fly = nil end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local bv = char.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bv then bv:Destroy() end
        end
    end
end)

CreateToggle(TabContents.MAIN, "👻 NOCLIP ULTRA", function(state)
    Enabled.Noclip = state
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() Connections.Noclip = nil end
    end
end)

CreateButton(TabContents.TROLL, "🌀 FLING ALL (ULTRA)", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e7, 1e7, 1e7)
            bv.Velocity = Vector3.new(math.random(-5e4,5e4), 5e4, math.random(-5e4,5e4))
            bv.Parent = root
            game:GetService("Debris"):AddItem(bv, 0.3)
        end
    end
end)

CreateToggle(TabContents.MOVEMENT, "⚡ SPEED 300", function(state)
    Enabled.Speed = state
    spawn(function()
        while Enabled.Speed do
            pcall(function()
                LocalPlayer.Character.Humanoid.WalkSpeed = 300
            end)
            wait()
        end
        pcall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end)
    end)
end)

CreateToggle(TabContents.PVP, "🛡️ GODMODE", function(state)
    Enabled.God = state
    spawn(function()
        while Enabled.God do
            pcall(function()
                LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                LocalPlayer.Character.Humanoid.Health = math.huge
            end)
            wait()
        end
    end)
end)

CreateToggle(TabContents.VISUALS, "👁️ ESP PLAYERS", function(state)
    Enabled.ESP = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if state and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.Parent = plr.Character
                highlight.FillColor = Color3.fromRGB(255, 100, 200)
                highlight.OutlineColor = Color3.white
            elseif not state and plr.Character then
                pcall(function() plr.Character:FindFirstChild("Highlight"):Destroy() end)
            end
        end
    end
end)

CreateButton(TabContents.SETTINGS, "🔥 DESTROY GUI", function()
    ScreenGui:Destroy()
end)

-- EVENTS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- INIT FIRST TAB
TabContents.MAIN.Visible = true
local firstBtn = SidePanel:FindFirstChild("MAIN")
if firstBtn then
    TweenService:Create(firstBtn, TweenInfo, {
        BackgroundColor3 = TabColors[1],
        Size = UDim2.new(1, -10, 0, 75)
    }):Play()
    firstBtn.TextColor3 = Color3.fromRGB(20, 15, 50)
end

MainFrame.Visible = true
print("✨ PANDUSCWL v6.0 ULTIMATE LOADED ✨ - Press V")
