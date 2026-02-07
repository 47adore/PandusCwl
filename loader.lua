-- PANDUSCWL v5.0 ULTRA PROFESSIONAL
-- NO LOADING - GUI NATYCHMIAST - WSZYSTKO NAPRAWIONE 100%

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CLEANUP
for _, obj in pairs(CoreGui:GetChildren()) do
    if obj.Name:find("PandusCwl") then obj:Destroy() end
end

-- STATES
local Enabled = {
    Fly = false, Noclip = false, Speed = false, InfJump = false, 
    God = false, ESP = false, Fullbright = false, ClickAura = false
}
local Connections = {}

-- CREATE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV5"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = CoreGui

-- MAIN FRAME 750x650 (DŁUŻSZE)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 750, 0, 650)
MainFrame.Position = UDim2.new(0.5, -375, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 25)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 150, 255)
MainStroke.Thickness = 4
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- HEADER BAR
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 80)
Header.BackgroundColor3 = Color3.fromRGB(180, 80, 255)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 25)
HeaderCorner.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -120, 0.6, 0)
HeaderTitle.Position = UDim2.new(0, 30, 0, 10)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "✦ PANDUSCWL v5.0 ULTRA ✦"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextScaled = true
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextStrokeTransparency = 0.7
HeaderTitle.TextStrokeColor3 = Color3.fromRGB(255, 100, 255)
HeaderTitle.Parent = Header

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Size = UDim2.new(1, -120, 0.4, 0)
HeaderSub.Position = UDim2.new(0, 30, 0, 45)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "PROFESSIONAL HACK SCRIPT"
HeaderSub.TextColor3 = Color3.fromRGB(220, 180, 255)
HeaderSub.TextScaled = true
HeaderSub.Font = Enum.Font.GothamBold
HeaderSub.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 60, 0, 50)
CloseBtn.Position = UDim2.new(1, -75, 0, 15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.Text = "CLOSE"
CloseBtn.TextColor3 = Color3.white
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseBtn

-- TAB BAR (PRZEJRZYSTE)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 65)
TabBar.Position = UDim2.new(0, 0, 0, 85)
TabBar.BackgroundColor3 = Color3.fromRGB(60, 45, 120)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 20)
TabCorner.Parent = TabBar

-- CONTENT
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -25, 1, -165)
ContentFrame.Position = UDim2.new(0, 12, 0, 155)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- TABS DATA
local TabInfo = {
    {name="MAIN", color=Color3.fromRGB(255, 140, 220)},
    {name="TROLL", color=Color3.fromRGB(255, 100, 200)},
    {name="PVP", color=Color3.fromRGB(200, 120, 255)},
    {name="MOVEMENT", color=Color3.fromRGB(160, 180, 255)},
    {name="VISUALS", color=Color3.fromRGB(140, 220, 255)},
    {name="SETTINGS", color=Color3.fromRGB(120, 160, 255)}
}

local TabContents = {}
for i, tab in ipairs(TabInfo) do
    -- TAB BUTTON (LADNIEJSZE)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tab.name
    TabBtn.Size = UDim2.new(1/#TabInfo-0.01, 0, 0.85, 0)
    TabBtn.Position = UDim2.new((i-1)/#TabInfo+0.005, 0, 0.075, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(90, 70, 160)
    TabBtn.Text = tab.name
    TabBtn.TextColor3 = Color3.white
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = TabBar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 20)
    BtnCorner.Parent = TabBtn

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(255, 200, 255)
    BtnStroke.Thickness = 2
    BtnStroke.Transparency = 0.5
    BtnStroke.Parent = TabBtn

    -- CONTENT FRAME
    TabContents[tab.name] = Instance.new("ScrollingFrame")
    TabContents[tab.name].Name = tab.name.."Tab"
    TabContents[tab.name].Size = UDim2.new(1, 0, 1, 0)
    TabContents[tab.name].BackgroundTransparency = 1
    TabContents[tab.name].BorderSizePixel = 0
    TabContents[tab.name].ScrollBarThickness = 8
    TabContents[tab.name].ScrollBarImageColor3 = Color3.fromRGB(255, 180, 255)
    TabContents[tab.name].Visible = false
    TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContents[tab.name].Parent = ContentFrame

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 15)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = TabContents[tab.name]

    TabContents[tab.name].ChildAdded:Connect(function()
        TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 40)
    end)

    -- TAB CLICK
    TabBtn.MouseButton1Click:Connect(function()
        for name, content in pairs(TabContents) do
            content.Visible = (name == tab.name)
        end
        for _, btn in pairs(TabBar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(90, 70, 160)
                btn.TextColor3 = Color3.white
            end
        end
        TabBtn.BackgroundColor3 = tab.color
        TabBtn.TextColor3 = Color3.fromRGB(25, 20, 60)
    end)
end

-- PERFECT TOGGLE (LADNIEJSZE)
local function CreateToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -30, 0, 70)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(70, 55, 140)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 20)
    TCorner.Parent = ToggleFrame

    local TStroke = Instance.new("UIStroke")
    TStroke.Color = Color3.fromRGB(255, 180, 255)
    TStroke.Thickness = 2
    TStroke.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68, 0, 0.6, 0)
    Label.Position = UDim2.new(0, 25, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.white
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 55, 0, 45)
    ToggleBtn.Position = UDim2.new(1, -70, 0, 12)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 200)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.white
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = ToggleFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 25)
    BtnCorner.Parent = ToggleBtn

    local active = false
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        ToggleBtn.Text = active and "ON" or "OFF"
        ToggleBtn.BackgroundColor3 = active and Color3.fromRGB(255, 80, 180) or Color3.fromRGB(255, 120, 200)
        callback(active)
    end)
end

-- PERFECT BUTTON
local function CreateButton(parent, name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -30, 0, 70)
    Btn.BackgroundColor3 = Color3.fromRGB(190, 110, 255)
    Btn.Text = name
    Btn.TextColor3 = Color3.white
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 20)
    BtnCorner.Parent = Btn

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(255, 200, 255)
    BtnStroke.Thickness = 2
    BtnStroke.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
    Btn.MouseEnter:Connect(function() Btn.BackgroundColor3 = Color3.fromRGB(220, 140, 255) end)
    Btn.MouseLeave:Connect(function() Btn.BackgroundColor3 = Color3.fromRGB(190, 110, 255) end)
end

-- ALL FEATURES (NAPRAWIONE 100%)

-- MAIN TAB
CreateToggle(TabContents.MAIN, "FLY (WASD+Space+Shift)", function(state)
    Enabled.Fly = state
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if state then
        local root = char.HumanoidRootPart
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root

        Connections.Fly = RunService.Heartbeat:Connect(function()
            if Enabled.Fly and root.Parent then
                local cam = workspace.CurrentCamera
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.yAxis end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.yAxis end
                bv.Velocity = vel.Unit * 90
            end
        end)
    else
        if Connections.Fly then Connections.Fly:Disconnect() Connections.Fly = nil end
        if char:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity") then
            char.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

CreateToggle(TabContents.MAIN, "NOCLIP (ULTRA)", function(state)
    Enabled.Noclip = state
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() Connections.Noclip = nil end
    end
end)

-- MOVEMENT TAB
CreateToggle(TabContents.MOVEMENT, "SPEED 250", function(state)
    Enabled.Speed = state
    spawn(function()
        while Enabled.Speed do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 250 end
            wait()
        end
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end)
end)

CreateToggle(TabContents.MOVEMENT, "INFINITE JUMP", function(state)
    Enabled.InfJump = state
    if state then
        Connections.InfJump = UserInputService.JumpRequest:Connect(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState("Jumping") end
        end)
    else
        if Connections.InfJump then Connections.InfJump:Disconnect() Connections.InfJump = nil end
    end
end)

-- TROLL TAB (POPRAWIONE FLING)
CreateButton(TabContents.TROLL, "🌀 FLING ALL PLAYERS", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(5e6, 5e6, 5e6)
            bv.Velocity = Vector3.new(
                math.random(-2e4, 2e4), 3e4, math.random(-2e4, 2e4)
            )
            bv.Parent = root
            
            local bg = Instance.new("BodyAngularVelocity")
            bg.MaxTorque = Vector3.new(5e6, 5e6, 5e6)
            bg.AngularVelocity = Vector3.new(math.random(-200,200), math.random(-200,200), math.random(-200,200))
            bg.Parent = root
            
            Debris:AddItem(bv, 0.5)
            Debris:AddItem(bg, 0.5)
        end
    end
end)

CreateButton(TabContents.TROLL, "💀 KILL ALL", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = 0 end
        end
    end
end)

CreateButton(TabContents.TROLL, "🧊 FREEZE ALL", function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.Anchored = true
        end
    end
end)

-- PVP TAB
CreateToggle(TabContents.PVP, "GODMODE", function(state)
    Enabled.God = state
    spawn(function()
        while Enabled.God do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            end
            wait()
        end
    end)
end)

CreateButton(TabContents.PVP, "🎯 TELEPORT TO MOUSE", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 6, 0))
    end
end)

-- VISUALS TAB
CreateToggle(TabContents.VISUALS, "ESP ALL PLAYERS", function(state)
    Enabled.ESP = state
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            spawn(function()
                if state and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "PandusESP"
                    highlight.Adornee = plr.Character
                    highlight.FillColor = Color3.fromRGB(255, 100, 200)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.4
                    highlight.OutlineTransparency = 0
                    highlight.Parent = plr.Character
                elseif not state and plr.Character then
                    local esp = plr.Character:FindFirstChild("PandusESP")
                    if esp then esp:Destroy() end
                end
            end)
        end
    end
end)

CreateButton(TabContents.VISUALS, "☀️ FULLBRIGHT", function()
    Enabled.Fullbright = not Enabled.Fullbright
    Lighting.Brightness = Enabled.Fullbright and 8 or 2
    Lighting.FogEnd = Enabled.Fullbright and math.huge or 100
    Lighting.GlobalShadows = not Enabled.Fullbright
end)

-- SETTINGS TAB
CreateButton(TabContents.SETTINGS, "❌ DESTROY GUI", function()
    ScreenGui:Destroy()
end)

CreateButton(TabContents.SETTINGS, "🔄 RELOAD SCRIPT", function()
    ScreenGui:Destroy()
    loadstring(game:HttpGet("YOUR_PASTE_LINK"))()
end)

-- EVENTS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CHARACTER RELOAD
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if Enabled.Speed then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 250 end
    end
    if Enabled.God then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.MaxHealth = math.huge hum.Health = math.huge end
    end
end)

-- NEW PLAYER ESP
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if Enabled.ESP then
            wait(1)
            local highlight = Instance.new("Highlight")
            highlight.Name = "PandusESP"
            highlight.Adornee = plr.Character
            highlight.FillColor = Color3.fromRGB(255, 100, 200)
            highlight.OutlineColor = Color3.white
            highlight.FillTransparency = 0.4
            highlight.Parent = plr.Character
        end
    end)
end)

-- SHOW FIRST TAB
MainFrame.Visible = true
TabContents.MAIN.Visible = true
local firstTab = TabBar:FindFirstChild("MAIN")
if firstTab then
    firstTab.BackgroundColor3 = TabInfo[1].color
    firstTab.TextColor3 = Color3.fromRGB(25, 20, 60)
end

print("✦ PANDUSCWL v5.0 LOADED ✦ - Press V to toggle")
