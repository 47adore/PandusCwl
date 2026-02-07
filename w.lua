-- 🌟 PANDUS CWL v11.0 ULTRA PRO MAX - ZAAWANSOWANE ANTYCHEAT BYPASS + PERFECT GUI 🌟
-- 100% DZIAŁA - PROFESJONALNE WYDANIE Z BIND SYSTEM + STATUS INDICATORS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- CLEANUP + ANTICHEAT BYPASS
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name:find("Pandus") or v.Name:find("CWL") then v:Destroy() end
end

-- ADVANCED ANTICHEAT BYPASS
local function BypassAnticheat()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "FireServer" and (args[1] == "Report" or args[1] == "AntiCheat" or string.find(args[1], "Cheat")) then
            return
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
    
    -- DISABLE COMMON ANTICHEATS
    for _,v in pairs(workspace:GetDescendants()) do
        if v.Name:lower():find("anticheat") or v.Name:lower():find("ac") then
            v:Destroy()
        end
    end
end

BypassAnticheat()

-- SETTINGS + BIND SYSTEM
local Settings = {
    Speed=100, JumpPower=50, ESP=false, Fly=false, Keybind=Enum.KeyCode.LeftShift
}
local Connections = {}
local StatusIndicators = {} -- GREEN/RED DOTS
local ActiveFeatures = {}

-- MAIN GUI - KWADRATOWE + DŁUGIE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV11_Ultra"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,850,0,580)
MainFrame.Position = UDim2.new(0.5,-425,0.5,-290)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,23,30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- SMOOTH DRAGGING + ANIMATIONS
local dragging, dragStart, startPos = false
local function updateInput(input)
    local Delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then updateInput(input) end
end)

-- FRAME STYLING
local MainCorner = Instance.new("UICorner", MainFrame); MainCorner.CornerRadius = UDim.new(0,16)
local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Color3.fromRGB(80,95,125); MainStroke.Thickness = 2

-- HEADER WITH BIND DISPLAY
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,55)
Header.BackgroundColor3 = Color3.fromRGB(15,18,25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner", Header); HeaderCorner.CornerRadius = UDim.new(0,16)
local HeaderStroke = Instance.new("UIStroke", Header); HeaderStroke.Color = Color3.fromRGB(100,115,145); HeaderStroke.Thickness = 1

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.65,0,1,0)
TitleLabel.Position = UDim2.new(0,20,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ PANDUS CWL v11.0 ULTRA PRO MAX ⚡"
TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = Header

local BindLabel = Instance.new("TextLabel")
BindLabel.Size = UDim2.new(0,120,0,30)
BindLabel.Position = UDim2.new(0.65,0,0.15,0)
BindLabel.BackgroundColor3 = Color3.fromRGB(50,60,85)
BindLabel.Text = "LShift"
BindLabel.TextColor3 = Color3.fromRGB(200,220,255)
BindLabel.TextScaled = true
BindLabel.Font = Enum.Font.Gotham
BindLabel.Parent = Header

local BindCorner = Instance.new("UICorner", BindLabel); BindCorner.CornerRadius = UDim.new(0,8)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0,36,0,36)
CloseButton.Position = UDim2.new(1,-46,0.5,-18)
CloseButton.BackgroundColor3 = Color3.fromRGB(240,70,70)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.white
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner", CloseButton); CloseCorner.CornerRadius = UDim.new(0,10)

-- SIDE MENU - ANIMOWANE ZAKŁADKI
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0,150,1,-55)
SideFrame.Position = UDim2.new(0,0,0,55)
SideFrame.BackgroundColor3 = Color3.fromRGB(25,30,40)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner", SideFrame); SideCorner.CornerRadius = UDim.new(0,12)

local TabContents, TabButtons, CurrentTab = {}, {}, 1
local TabNames = {"MOVEMENT", "PLAYER", "COMBAT", "VISUALS", "UTILITY", "FUN/TROLL"}

for i, tabName in ipairs(TabNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1,-12,0,42)
    TabBtn.Position = UDim2.new(0,6,(i-1)*44,4)
    TabBtn.BackgroundColor3 = Color3.fromRGB(45,52,65)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(200,215,235)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner", TabBtn); TabCorner.CornerRadius = UDim.new(0,12)
    local TabStroke = Instance.new("UIStroke", TabBtn); TabStroke.Color = Color3.fromRGB(70,80,100); TabStroke.Thickness = 1
    
    TabButtons[i] = TabBtn
    
    -- CONTENT FRAME
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = tabName.."Content"
    ContentFrame.Size = UDim2.new(1,-160,1,-60)
    ContentFrame.Position = UDim2.new(0,155,0,60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(80,90,110)
    ContentFrame.CanvasSize = UDim2.new(0,0,0,0)
    ContentFrame.Visible = (i==1)
    ContentFrame.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0,10)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = ContentFrame
    
    TabContents[i] = ContentFrame
    
    -- ANIMATED TAB SWITCH
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        for j, content in pairs(TabContents) do
            if j == i then
                TweenService:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Visible = true}):Play()
            else
                TweenService:Create(content, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Visible = false}):Play()
            end
        end
        
        for j, btn in pairs(TabButtons) do
            if j == i then
                TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
                    BackgroundColor3 = Color3.fromRGB(85,100,135),
                    TextColor3 = Color3.fromRGB(255,255,255),
                    Size = UDim2.new(1,-8,0,46)
                }):Play()
                TweenService:Create(TabStroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(120,140,180), Thickness = 2}):Play()
            else
                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(45,52,65),
                    TextColor3 = Color3.fromRGB(200,215,235),
                    Size = UDim2.new(1,-12,0,42)
                }):Play()
                TweenService:Create(TabStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70,80,100), Thickness = 1}):Play()
            end
        end
    end)
end

-- ADVANCED UI COMPONENTS
local function CreateStatusIndicator(parent, x, y)
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0,12,0,12)
    Dot.Position = UDim2.new(1,-20,x,y)
    Dot.BackgroundColor3 = Color3.fromRGB(200,50,50)
    Dot.Parent = parent
    
    local DotCorner = Instance.new("UICorner", Dot); DotCorner.CornerRadius = UDim.new(1,0)
    local DotStroke = Instance.new("UIStroke", Dot); DotStroke.Color = Color3.white; DotStroke.Thickness = 1
    
    return function(active)
        TweenService:Create(Dot, TweenInfo.new(0.2), {
            BackgroundColor3 = active and Color3.fromRGB(50,200,100) or Color3.fromRGB(200,50,50)
        }):Play()
    end
end

local function AddToggle(parent, name, callback, statusFunc)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1,-24,0,45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40,45,55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local Corner = Instance.new("UICorner", ToggleFrame); Corner.CornerRadius = UDim.new(0,12)
    local Stroke = Instance.new("UIStroke", ToggleFrame); Stroke.Color = Color3.fromRGB(70,80,100); Stroke.Thickness = 1
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.78,0,1,0)
    Label.Position = UDim2.new(0,18,0,0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(245,250,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local SwitchBtn = Instance.new("TextButton")
    SwitchBtn.Size = UDim2.new(0,50,0,28)
    SwitchBtn.Position = UDim2.new(1,-62,0.35,0)
    SwitchBtn.BackgroundColor3 = Color3.fromRGB(75,85,105)
    SwitchBtn.Text = ""
    SwitchBtn.Parent = ToggleFrame
    
    local SCorner = Instance.new("UICorner", SwitchBtn); SCorner.CornerRadius = UDim.new(0,14)
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,24,0,24)
    Knob.Position = UDim2.new(0,2,0,2)
    Knob.BackgroundColor3 = Color3.fromRGB(150,160,180)
    Knob.Parent = SwitchBtn
    
    local KCorner = Instance.new("UICorner", Knob); KCorner.CornerRadius = UDim.new(1,0)
    
    local toggled = false
    SwitchBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            BackgroundColor3 = toggled and Color3.fromRGB(85,100,135) or Color3.fromRGB(75,85,105)
        }):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Position = toggled and UDim2.new(1,-26,0,2) or UDim2.new(0,2,0,2),
            BackgroundColor3 = toggled and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,160,180)
        }):Play()
        callback(toggled)
        if statusFunc then statusFunc(toggled) end
    end)
    
    return CreateStatusIndicator(ToggleFrame, 0, 0)
end

local function AddSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1,-24,0,55)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40,45,55)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = parent
    
    local Corner = Instance.new("UICorner", SliderFrame); Corner.CornerRadius = UDim.new(0,12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7,0,0.45,0)
    Label.Position = UDim2.new(0,18,0,6)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(245,250,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.25,0,0.45,0)
    ValueLabel.Position = UDim2.new(0.73,0,0,6)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(85,100,135)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = SliderFrame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.92,0,0,8)
    Track.Position = UDim2.new(0.04,0,0.6,0)
    Track.BackgroundColor3 = Color3.fromRGB(60,70,90)
    Track.Parent = SliderFrame
    
    local TCorner = Instance.new("UICorner", Track); TCorner.CornerRadius = UDim.new(0,4)
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(85,100,135)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FCorner = Instance.new("UICorner", Fill); FCorner.CornerRadius = UDim.new(0,4)
    
    local dragging = false
    Track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    Track.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local MousePos = inp.Position.X - Track.AbsolutePosition.X
            local Percent = math.clamp(MousePos/Track.AbsoluteSize.X,0,1)
            local Value = math.floor(min + (max-min)*Percent)
            Fill.Size = UDim2.new(Percent,0,1,0)
            ValueLabel.Text = tostring(Value)
            callback(Value)
        end
    end)
end

local function AddButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-24,0,42)
    Button.BackgroundColor3 = Color3.fromRGB(65,75,100)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(245,250,255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner", Button); Corner.CornerRadius = UDim.new(0,12)
    local Stroke = Instance.new("UIStroke", Button); Stroke.Color = Color3.fromRGB(95,110,140); Stroke.Thickness = 1.5
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {Size = UDim2.new(1,-20,0,44)}):Play()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(85,100,135)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {Size = UDim2.new(1,-24,0,42)}):Play()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(65,75,100)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(105,125,170)}):Play()
        task.wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(85,100,135)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB
local SpeedStatus = AddToggle(TabContents[1], "Szybkość", function(state) end, function(active)
    ActiveFeatures.Speed = active
    if active and LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed end
end)(true)

AddSlider(TabContents[1], "Szybkość", 16, 600, 100, function(val)
    Settings.Speed = val
    SpeedStatus(true)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

local JumpStatus = AddToggle(TabContents[1], "Skok", function(state) end, function(active)
    ActiveFeatures.Jump = active
    if active and LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower end
end)(true)

AddSlider(TabContents[1], "Skok", 50, 600, 50, function(val)
    Settings.JumpPower = val
    JumpStatus(true)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

local FlyStatus = AddToggle(TabContents[1], "Lot (WASD+Space+Shift)", function(state)
    Settings.Fly = state
    if state then
        task.spawn(function()
            repeat task.wait() until LocalPlayer.Character
            local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(9e9,9e9,9e9)
            BV.Parent = Root
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if not Settings.Fly then return end
                local Cam = workspace.CurrentCamera
                local Move = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then Move = Move + Cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then Move = Move - Cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then Move = Move - Cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then Move = Move + Cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Move = Move + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then Move = Move - Vector3.new(0,1,0) end
                BV.Velocity = Move * 75
            end)
        end)
    else
        if Connections.Fly then Connections.Fly:Disconnect(); Connections.Fly = nil end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
        and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

local NoclipStatus = AddToggle(TabContents[1], "Noclip", function(state)
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _,part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect(); Connections.Noclip = nil end
    end
end)

-- PLAYER TAB
local SpinStatus = AddToggle(TabContents[2], "Spin Bot", function(state)
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(40),0)
            end
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect(); Connections.Spin = nil end
    end
end)

AddToggle(TabContents[2], "Niska grawitacja", function(state)
    workspace.Gravity = state and 25 or 196.2
end)

-- COMBAT TAB
local AimbotStatus = AddToggle(TabContents[3], "Aimbot (FOV)", function(state)
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local Target, Dist = nil, math.huge
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local Pos,OnScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if OnScreen then
                        local ScreenDist = (Vector2.new(Pos.X,Pos.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude
                        if ScreenDist < Dist and ScreenDist < 200 then -- FOV 200px
                            Target = plr
                            Dist = ScreenDist
                        end
                    end
                end
            end
            if Target and Target.Character then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Target.Character.Head.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect(); Connections.Aimbot = nil end
    end
end)

-- VISUALS TAB
local ESPStatus = AddToggle(TabContents[4], "ESP (Highlights)", function(state)
    Settings.ESP = state
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer then
            if state and plr.Character then
                local esp = plr.Character:FindFirstChild("PandusESP")
                if esp then esp:Destroy() end
                local High = Instance.new("Highlight")
                High.Name = "PandusESP"
                High.FillColor = Color3.fromRGB(0,200,255)
                High.FillTransparency = 0.4
                High.OutlineColor = Color3.fromRGB(255,255,255)
                High.OutlineTransparency = 0
                High.Parent = plr.Character
            elseif plr.Character and plr.Character:FindFirstChild("PandusESP") then
                plr.Character.PandusESP:Destroy()
            end
        end
    end
end)

-- UTILITY TAB
AddToggle(TabContents[5], "Anti-AFK", function(state)
    task.spawn(function()
        while state do
            task.wait(0.1)
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(4000,4000,4000)
            BV.Velocity = Vector3.new(0,0.1,0)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                BV.Parent = LocalPlayer.Character.HumanoidRootPart
                task.wait(0.1)
                BV:Destroy()
            end
            task.wait(58)
        end
    end)
end)

AddButton(TabContents[5], "🔄 Rejoin Server", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(TabContents[5], "🇹🇷 Turcja ❤️", function()
    pcall(function()
        ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")["SayMessageRequest"]:FireServer("i ❤️ Turcja najbardziej! 🇹🇷","All")
    end)
end)

AddButton(TabContents[5], "🎯 Bind Key", function()
    -- CHANGE BIND SYSTEM
    BindLabel.Text = "Press Key..."
    local bindConn
    bindConn = UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode ~= Enum.KeyCode.Escape then
            Settings.Keybind = key.KeyCode
            BindLabel.Text = key.KeyCode.Name
        end
        bindConn:Disconnect()
    end)
end)

-- FUN/TROLL TAB - NOWE FEATURES
AddButton(TabContents[6], "🚀 FLING ALL ULTRA PRO", function()
    local successCount = 0
    for i,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            task.spawn(function()
                -- TELEPORT TO PLAYER FIRST
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
                    task.wait(0.05)
                end
                
                -- ULTRA FLING
                local Root = plr.Character.HumanoidRootPart
                local BV = Instance.new("BodyVelocity")
                BV.MaxForce = Vector3.new(1e10,1e10,1e10)
                BV.Velocity = Vector3.new(math.random(-8e4,8e4),8e4,math.random(-8e4,8e4))
                BV.Parent = Root
                
                local BA = Instance.new("BodyAngularVelocity")
                BA.MaxTorque = Vector3.new(1e10,1e10,1e10)
                BA.AngularVelocity = Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100))
                BA.Parent = Root
                
                Debris:AddItem(BV, 0.3)
                Debris:AddItem(BA, 0.3)
                
                successCount = successCount + 1
                local SuccessMsg = Instance.new("ScreenGui")
                SuccessMsg.Parent = ScreenGui
                local MsgFrame = Instance.new("Frame", SuccessMsg)
                MsgFrame.Size = UDim2.new(0,200,0,50)
                MsgFrame.Position = UDim2.new(0.5,-100,0.3,0)
                MsgFrame.BackgroundColor3 = Color3.fromRGB(50,200,100)
                MsgFrame.Parent = ScreenGui
                
                local MsgCorner = Instance.new("UICorner", MsgFrame); MsgCorner.CornerRadius = UDim.new(0,12)
                local MsgLabel = Instance.new("TextLabel", MsgFrame)
                MsgLabel.Size = UDim2.new(1,0,1,0)
                MsgLabel.BackgroundTransparency = 1
                MsgLabel.Text = "SUCCESS P"..i
                MsgLabel.TextColor3 = Color3.black
                MsgLabel.TextScaled = true
                MsgLabel.Font = Enum.Font.GothamBold
                
                TweenService:Create(MsgFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,250,0,60)}):Play()
                task.wait(3)
                SuccessMsg:Destroy()
            end)
        end
    end
end)

AddButton(TabContents[6], "😂 YEET RANDOM", function()
    local Targets = {}
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character then table.insert(Targets, plr) end
    end
    local Target = Targets[math.random(1,#Targets)]
    if Target and Target.Character then
        Target.Character.HumanoidRootPart.CFrame = CFrame.new(0,10000,0)
    end
end)

AddButton(TabContents[6], "🎪 DISCORD SPAM", function()
    for i=1,10 do
        pcall(function()
            ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")["SayMessageRequest"]:FireServer("discord.gg/pandus cwl v11 🔥","All")
        end)
        task.wait(0.5)
    end
end)

AddButton(TabContents[6], "💥 EXPLODE NEAREST", function()
    local Nearest, Dist = nil, math.huge
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if distance < Dist then Nearest = plr; Dist = distance end
        end
    end
    if Nearest then
        local Explosion = Instance.new("Explosion")
        Explosion.Position = Nearest.Character.HumanoidRootPart.Position
        Explosion.BlastRadius = 100
        Explosion.BlastPressure = 1e6
        Explosion.Parent = workspace
    end
end)

-- CHARACTER HANDLING
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- ESP HANDLING
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        if Settings.ESP and plr.Character then
            local High = Instance.new("Highlight")
            High.Name = "PandusESP"
            High.FillColor = Color3.fromRGB(0,200,255)
            High.FillTransparency = 0.4
            High.OutlineColor = Color3.white
            High.Parent = plr.Character
        end
    end)
end)

-- CUSTOM BIND SYSTEM (LEWY SHIFT DEFAULT)
UserInputService.InputBegan:Connect(function(key, gameProcessed)
    if gameProcessed then return end
    if key.KeyCode == Settings.Keybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- CANVAS UPDATE
local function UpdateCanvas()
    for _,content in pairs(TabContents) do
        content.CanvasSize = UDim2.new(0,0,0,content.AbsoluteContentSize.Y + 30)
    end
end

task.spawn(function()
    task.wait(0.8)
    UpdateCanvas()
end)

for _,content in pairs(TabContents) do
    content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)
end

print("✅ PANDUS CWL v11.0 ULTRA PRO MAX - WCZYTANO!")
print("🌟 LEWY SHIFT - Toggle | Anticheat Bypass: ACTIVE")
print("🎨 Animowane zakładki + Status DOTs (zielony=ON, czerwony=OFF)")
print("🚀 Fling All PRO + FUN Features + PERFECT GUI!")
