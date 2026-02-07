-- PANDUSCWL v7.0 PROFESSIONAL DARK EDITION
-- DARK BLUE/GRAY + ULTRA SMOOTH ANIMATIONS + ADVANCED FEATURES

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- CLEANUP
for _, obj in pairs(CoreGui:GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- STATES
local Settings = {
    Language = "PL", -- PL/EN/RU
    Colors = {
        Primary = Color3.fromRGB(20, 25, 40),
        Secondary = Color3.fromRGB(35, 45, 70),
        Accent = Color3.fromRGB(100, 150, 255),
        Text = Color3.fromRGB(230, 235, 255)
    },
    Enabled = {}
}

-- MAIN GUI (DARK BLUE/GRAY)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV7"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 900, 0, 750)
MainFrame.Position = UDim2.new(0.5, -450, 0.5, -375)
MainFrame.BackgroundColor3 = Settings.Colors.Primary
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- ADVANCED SHADOW
local ShadowGroup = Instance.new("Frame")
ShadowGroup.Size = MainFrame.Size
ShadowGroup.Position = MainFrame.Position
ShadowGroup.BackgroundTransparency = 1
ShadowGroup.ZIndex = MainFrame.ZIndex - 1
ShadowGroup.Parent = ScreenGui

for i = 1, 20 do
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, i*3, 1, i*3)
    shadow.Position = UDim2.new(0, -i*1.5, 0, -i*1.5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.95 + i*0.0025
    shadow.ZIndex = MainFrame.ZIndex - 2
    shadow.Parent = ShadowGroup
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 25)
    sc.Parent = shadow
end

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 25)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Settings.Colors.Primary),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.Colors.Accent
MainStroke.Thickness = 2.5
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 90)
Header.BackgroundColor3 = Color3.fromRGB(15, 20, 40)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 35, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 15, 35))
}
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 25)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 0.6, 0)
Title.Position = UDim2.new(0, 30, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "PANDUSCWL v7.0 • PROFESSIONAL"
Title.TextColor3 = Settings.Colors.Text
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Header

-- TABS SYSTEM (VERTICAL)
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.new(0, 180, 1, -100)
SidePanel.Position = UDim2.new(0, 0, 0, 95)
SidePanel.BackgroundColor3 = Color3.fromRGB(25, 35, 60)
SidePanel.BorderSizePixel = 0
SidePanel.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 20)
SideCorner.Parent = SidePanel

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -200, 1, -105)
ContentArea.Position = UDim2.new(0, 185, 0, 100)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local Tabs = {
    {name="Movement", icon="🚀"},
    {name="Player", icon="👤"},
    {name="Combat", icon="⚔️"},
    {name="Visuals", icon="👁️"},
    {name="Utility", icon="🔧"},
    {name="Troll", icon="🌀"},
    {name="Settings", icon="⚙️"}
}

local TabContents = {}
local TabButtons = {}

for i, tab in ipairs(Tabs) do
    -- TAB BUTTON
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab.name
    TabBtn.Size = UDim2.new(1, -20, 0, 70)
    TabBtn.Position = UDim2.new(0, 10, 0, (i-1)*80 + 15)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 45, 75)
    TabBtn.Text = tab.icon .. " " .. tab.name
    TabBtn.TextColor3 = Settings.Colors.Text
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SidePanel
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 20)
    TabCorner.Parent = TabBtn
    
    TabButtons[tab.name] = TabBtn
    
    -- CONTENT
    TabContents[tab.name] = Instance.new("ScrollingFrame")
    TabContents[tab.name].Name = tab.name
    TabContents[tab.name].Size = UDim2.new(1, -20, 1, -20)
    TabContents[tab.name].Position = UDim2.new(0, 10, 0, 10)
    TabContents[tab.name].BackgroundTransparency = 1
    TabContents[tab.name].BorderSizePixel = 0
    TabContents[tab.name].ScrollBarThickness = 8
    TabContents[tab.name].ScrollBarImageColor3 = Settings.Colors.Accent
    TabContents[tab.name].Visible = false
    TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContents[tab.name].Parent = ContentArea
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 15)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = TabContents[tab.name]
    
    TabContents[tab.name].ChildAdded:Connect(function()
        TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 40)
    end)
end

-- ADVANCED TOGGLE
local function CreateToggle(parent, name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 80)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 20)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.6, 0)
    Label.Position = UDim2.new(0, 25, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Settings.Colors.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Toggle = Instance.new("Frame")
    Toggle.Size = UDim2.new(0, 70, 0, 45)
    Toggle.Position = UDim2.new(1, -85, 0.5, -22.5)
    Toggle.BackgroundColor3 = Color3.fromRGB(80, 90, 120)
    Toggle.Parent = Frame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 22)
    TCorner.Parent = Toggle
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 35, 0, 35)
    Knob.Position = UDim2.new(0, 5, 0.5, -17.5)
    Knob.BackgroundColor3 = Color3.fromRGB(150, 170, 220)
    Knob.Parent = Toggle
    
    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(1, 0)
    KCorner.Parent = Knob
    
    local state = false
    Toggle.InputBegan:Connect(function()
        state = not state
        TweenService:Create(Toggle, TweenInfo, {
            BackgroundColor3 = state and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(80, 90, 120)
        }):Play()
        TweenService:Create(Knob, TweenInfo, {
            Position = state and UDim2.new(0, 30, 0.5, -17.5) or UDim2.new(0, 5, 0.5, -17.5),
            BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 170, 220)
        }):Play()
        callback(state)
        Settings.Enabled[name] = state
    end)
end

-- SLIDER
local function CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 95)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 20)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0.4, 0)
    Label.Position = UDim2.new(0, 25, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Settings.Colors.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.25, 0, 0.4, 0)
    ValueLabel.Position = UDim2.new(0.72, 0, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Settings.Colors.Accent
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 25)
    SliderFrame.Position = UDim2.new(0.05, 0, 0.65, 0)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 60, 90)
    SliderFrame.Parent = Frame
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 12)
    SCorner.Parent = SliderFrame
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    SliderBar.BackgroundColor3 = Settings.Colors.Accent
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = SliderFrame
    
    local SBarCorner = Instance.new("UICorner")
    SBarCorner.CornerRadius = UDim.new(0, 12)
    SBarCorner.Parent = SliderBar
    
    local dragging = false
    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local size = SliderFrame.AbsoluteSize.X
            local pos = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / size, 0, 1)
            local value = math.floor(min + (max - min) * pos)
            SliderBar.Size = UDim2.new(pos, 0, 1, 0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- DROPDOWN
local function CreateDropdown(parent, name, options, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 80)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 20)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -30, 0.6, 0)
    Label.Position = UDim2.new(0, 20, 0, 10)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ":"
    Label.TextColor3 = Settings.Colors.Text
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local DropdownBtn = Instance.new("TextButton")
    DropdownBtn.Size = UDim2.new(0.4, 0, 0.5, 0)
    DropdownBtn.Position = UDim2.new(0.55, 0, 0.25, 0)
    DropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 60, 90)
    DropdownBtn.Text = options[1] or "None"
    DropdownBtn.TextColor3 = Settings.Colors.Text
    DropdownBtn.Font = Enum.Font.GothamSemibold
    DropdownBtn.Parent = Frame
    
    local DCorner = Instance.new("UICorner")
    DCorner.CornerRadius = UDim.new(0, 15)
    DCorner.Parent = DropdownBtn
end

-- BUTTON
local function CreateButton(parent, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 75)
    Btn.BackgroundColor3 = Color3.fromRGB(70, 85, 140)
    Btn.Text = "► " .. name
    Btn.TextColor3 = Settings.Colors.Text
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = parent
    
    local BtnGradient = Instance.new("UIGradient")
    BtnGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 110, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 65, 110))
    }
    BtnGradient.Parent = Btn
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 20)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0, 70)}):Play()
        wait(0.1)
        TweenService:Create(Btn, TweenInfo, {Size = UDim2.new(1, 0, 0, 75)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB
CreateSlider(TabContents.Movement, "Speed", 16, 500, 100, function(val)
    Settings.Enabled.Speed = val
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

CreateSlider(TabContents.Movement, "Jump Power", 50, 1000, 200, function(val)
    Settings.Enabled.JumpPower = val
    if LocalPlayer.Character then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

CreateToggle(TabContents.Movement, "Fly", function(state)
    Settings.Enabled.Fly = state
    -- FLY LOGIC (z poprzedniej wersji)
end)

CreateToggle(TabContents.Movement, "Noclip", function(state)
    Settings.Enabled.Noclip = state
    -- NOCLIP LOGIC
end)

CreateButton(TabContents.Movement, "Teleport do gracza", function()
    -- TELEPORT LIST
    local players = {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            table.insert(players, plr.Name)
        end
    end
    -- SHOW DROPDOWN LOGIC
end)

-- PLAYER TAB
CreateToggle(TabContents.Player, "Instant Respawn", function(state) end)
CreateToggle(TabContents.Player, "No Animations", function(state) end)
CreateToggle(TabContents.Player, "Spin Bot", function(state) end)
CreateToggle(TabContents.Player, "Fake Lag", function(state) end)
CreateToggle(TabContents.Player, "Low Gravity", function(state) end)

-- COMBAT TAB
CreateToggle(TabContents.Combat, "Aimbot", function(state) end)
CreateToggle(TabContents.Combat, "Silent Aim", function(state) end)
CreateToggle(TabContents.Combat, "No Recoil", function(state) end)

-- VISUALS TAB
CreateToggle(TabContents.Visuals, "ESP", function(state) end)
CreateToggle(TabContents.Visuals, "Boxes/Tracers", function(state) end)
CreateToggle(TabContents.Visuals, "Name/Health/Distance", function(state) end)

-- UTILITY TAB
CreateToggle(TabContents.Utility, "Anti-AFK", function(state) end)
CreateButton(TabContents.Utility, "Rejoin", function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)
CreateToggle(TabContents.Utility, "Chat Bypass", function(state) end)
CreateButton(TabContents.Utility, "Turcja ❤️", function()
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("i ❤️ Turcja!", "All")
end)

-- TROLL TAB
CreateButton(TabContents.Troll, "FLING ALL ULTRA", function()
    -- FLING LOGIC z poprzedniej wersji
end)

-- SETTINGS TAB
CreateDropdown(TabContents.Settings, "Język", {"Polski", "English", "Русский"}, function(lang)
    Settings.Language = lang
end)

CreateButton(TabContents.Settings, "Zapisz Ustawienia", function() end)
CreateButton(TabContents.Settings, "Reset do domyślnych", function() end)

-- TAB SWITCHING
for _, tab in ipairs(Tabs) do
    TabButtons[tab.name].MouseButton1Click:Connect(function()
        for name, content in pairs(TabContents) do
            content.Visible = false
        end
        TabContents[tab.name].Visible = true
        
        for _, btn in pairs(TabButtons) do
            TweenService:Create(btn, TweenInfo, {
                BackgroundColor3 = Color3.fromRGB(35, 45, 75),
                Size = UDim2.new(1, -20, 0, 70)
            }):Play()
            btn.TextColor3 = Settings.Colors.Text
        end
        
        TweenService:Create(TabButtons[tab.name], TweenInfo, {
            BackgroundColor3 = Settings.Colors.Accent,
            Size = UDim2.new(1, -10, 0, 80)
        }):Play()
        TabButtons[tab.name].TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

-- INIT
TabContents.Movement.Visible = true
TweenService:Create(TabButtons.Movement, TweenInfo, {
    BackgroundColor3 = Settings.Colors.Accent,
    Size = UDim2.new(1, -10, 0, 80)
}):Play()
TabButtons.Movement.TextColor3 = Color3.white

UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("🔥 PANDUSCWL v7.0 PROFESSIONAL DARK EDITION LOADED 🔥")
print("Naciśnij V aby otworzyć/zamknąć")
