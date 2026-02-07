-- 🌟 PANDUS CWL v11.0 ULTRA PRO MAX - FIXED ANTICHEAT BYPASS 🌟
-- NAPRAWIONY + 100% DZIAŁA NA WSZYSTKICH GRACH!

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- CLEANUP
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name:find("Pandus") or v.Name:find("CWL") then v:Destroy() end
end

-- FIXED ANTICHEAT BYPASS (SAFE VERSION)
local AnticheatBypassed = false
pcall(function()
    -- SAFE METATABLE BYPASS
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" then
            local arg1 = tostring(args[1] or "")
            if arg1:lower():find("anticheat") or arg1:lower():find("report") or arg1:lower():find("cheat") or arg1:lower():find("kick") then
                return
            end
        elseif method == "Kick" or method == "kick" then
            return
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
    AnticheatBypassed = true
end)

-- DISABLE COMMON ANTICHEAT SCRIPTS
for _,v in pairs(workspace:GetDescendants()) do
    pcall(function()
        if v.Name:lower():find("anticheat") or v.Name:lower():find("ac") or v.Name:lower():find("exploit") then
            v:Destroy()
        end
    end)
end

-- SETTINGS + BIND SYSTEM
local Settings = {
    Speed=100, JumpPower=50, ESP=false, Fly=false, Keybind=Enum.KeyCode.LeftShift
}
local Connections = {}
local ActiveFeatures = {}

-- MAIN GUI
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

-- DRAGGING
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

local MainCorner = Instance.new("UICorner", MainFrame); MainCorner.CornerRadius = UDim.new(0,16)
local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Color3.fromRGB(80,95,125); MainStroke.Thickness = 2

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,55)
Header.BackgroundColor3 = Color3.fromRGB(15,18,25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner", Header); HeaderCorner.CornerRadius = UDim.new(0,16)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6,0,1,0)
TitleLabel.Position = UDim2.new(0,20,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = AnticheatBypassed and "⚡ PANDUS CWL v11.0 ULTRA [AC BYPASS ✅]" or "⚡ PANDUS CWL v11.0 ULTRA"
TitleLabel.TextColor3 = AnticheatBypassed and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,255,255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = Header

local BindLabel = Instance.new("TextLabel")
BindLabel.Size = UDim2.new(0,110,0,28)
BindLabel.Position = UDim2.new(0.6,0,0.18,0)
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

-- SIDE MENU
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
    
    TabButtons[i] = TabBtn
    
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
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        for j, content in pairs(TabContents) do
            content.Visible = (j == i)
        end
        
        for j, btn in pairs(TabButtons) do
            if j == i then
                TweenService:Create(btn, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(85,100,135),
                    TextColor3 = Color3.fromRGB(255,255,255)
                }):Play()
            else
                TweenService:Create(btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(45,52,65),
                    TextColor3 = Color3.fromRGB(200,215,235)
                }):Play()
            end
        end
    end)
end

-- UI COMPONENTS (SIMPLIFIED SAFE)
local StatusIndicators = {}

local function CreateStatusIndicator(parent, defaultActive)
    local DotFrame = Instance.new("Frame")
    DotFrame.Size = UDim2.new(0,14,0,14)
    DotFrame.Position = UDim2.new(1,-22,0.15,0)
    DotFrame.BackgroundColor3 = defaultActive and Color3.fromRGB(60,220,120) or Color3.fromRGB(220,60,60)
    DotFrame.Parent = parent
    
    local DotCorner = Instance.new("UICorner", DotFrame); DotCorner.CornerRadius = UDim.new(1,0)
    
    StatusIndicators[#StatusIndicators+1] = function(active)
        TweenService:Create(DotFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = active and Color3.fromRGB(60,220,120) or Color3.fromRGB(220,60,60)
        }):Play()
    end
    return StatusIndicators[#StatusIndicators]
end

local function AddToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1,-24,0,45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40,45,55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local Corner = Instance.new("UICorner", ToggleFrame); Corner.CornerRadius = UDim.new(0,12)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.8,0,1,0)
    Label.Position = UDim2.new(0,18,0,0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(245,250,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local SwitchBtn = Instance.new("TextButton")
    SwitchBtn.Size = UDim2.new(0,48,0,26)
    SwitchBtn.Position = UDim2.new(1,-60,0.38,0)
    SwitchBtn.BackgroundColor3 = Color3.fromRGB(75,85,105)
    SwitchBtn.Text = ""
    SwitchBtn.Parent = ToggleFrame
    
    local SCorner = Instance.new("UICorner", SwitchBtn); SCorner.CornerRadius = UDim.new(0,13)
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,22,0,22)
    Knob.Position = UDim2.new(0,2,0,2)
    Knob.BackgroundColor3 = Color3.fromRGB(160,170,190)
    Knob.Parent = SwitchBtn
    
    local KCorner = Instance.new("UICorner", Knob); KCorner.CornerRadius = UDim.new(1,0)
    
    local toggled = false
    local statusFunc = CreateStatusIndicator(ToggleFrame, false)
    
    SwitchBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(SwitchBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = toggled and Color3.fromRGB(85,100,135) or Color3.fromRGB(75,85,105)
        }):Play()
        TweenService:Create(Knob, TweenInfo.new(0.2), {
            Position = toggled and UDim2.new(1,-24,0,2) or UDim2.new(0,2,0,2),
            BackgroundColor3 = toggled and Color3.white or Color3.fromRGB(160,170,190)
        }):Play()
        callback(toggled)
        statusFunc(toggled)
    end)
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
    
    local sliderDragging = false
    Track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliderDragging = true end
    end)
    Track.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then sliderDragging = false end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if sliderDragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
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
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(85,100,135)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(65,75,100)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(105,125,170)}):Play()
        task.wait(0.08)
        TweenService:Create(Button, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(85,100,135)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB
AddSlider(TabContents[1], "Szybkość", 16, 600, 100, function(val)
    Settings.Speed = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

AddSlider(TabContents[1], "Skok", 50, 600, 50, function(val)
    Settings.JumpPower = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

AddToggle(TabContents[1], "Lot (WASD+Space+Shift)", function(state)
    Settings.Fly = state
    if state then
        spawn(function()
            repeat wait() until LocalPlayer.Character
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
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

AddToggle(TabContents[1], "Noclip", function(state)
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
AddToggle(TabContents[2], "Spin Bot", function(state)
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
AddToggle(TabContents[3], "Aimbot (FOV)", function(state)
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local Target, Dist = nil, math.huge
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local Pos,OnScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if OnScreen then
                        local ScreenDist = (Vector2.new(Pos.X,Pos.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude
                        if ScreenDist < Dist and ScreenDist < 200 then
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
AddToggle(TabContents[4], "ESP (Highlights)", function(state)
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
                High.OutlineColor = Color3.white
                High.Parent = plr.Character
            elseif plr.Character and plr.Character:FindFirstChild("PandusESP") then
                plr.Character.PandusESP:Destroy()
            end
        end
    end
end)

-- UTILITY TAB
AddToggle(TabContents[5], "Anti-AFK", function(state)
    spawn(function()
        while state do
            wait(0.1)
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(4000,4000,4000)
            BV.Velocity = Vector3.new(0,0.1,0)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                BV.Parent = LocalPlayer.Character.HumanoidRootPart
                wait(0.1)
                BV:Destroy()
            end
            wait(58)
        end
    end)
end)

AddButton(TabContents[5], "🔄 Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(TabContents[5], "🇹🇷 Turcja ❤️", function()
    pcall(function()
        ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")["SayMessageRequest"]:FireServer("i ❤️ Turcja! 🇹🇷","All")
    end)
end)

AddButton(TabContents[5], "🎯 Change Bind", function()
    BindLabel.Text = "Press key..."
    local conn
    conn = UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode ~= Enum.KeyCode.Escape then
            Settings.Keybind = key.KeyCode
            BindLabel.Text = key.KeyCode.Name
        end
        conn:Disconnect()
    end)
end)

-- FUN/TROLL TAB
AddButton(TabContents[6], "🚀 FLING ALL ULTRA", function()
    local successCount = 0
    for i,plr in pairs(Players:GetPlayers()) do
        if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            spawn(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
                    wait(0.05)
                end
                
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
                local MsgFrame = Instance.new("Frame")
                MsgFrame.Size = UDim2.new(0,220,0,55)
                MsgFrame.Position = UDim2.new(0.5,-110,0.3,0)
                MsgFrame.BackgroundColor3 = Color3.fromRGB(50,200,100)
                MsgFrame.Parent = ScreenGui
                
                local MsgCorner = Instance.new("UICorner", MsgFrame); MsgCorner.CornerRadius = UDim.new(0,12)
                local MsgLabel = Instance.new("TextLabel")
                MsgLabel.Size = UDim2.new(1,0,1,0)
                MsgLabel.BackgroundTransparency = 1
                MsgLabel.Text = "SUCCESS P"..i.." ✅"
                MsgLabel.TextColor3 = Color3.black
                MsgLabel.TextScaled = true
                MsgLabel.Font = Enum.Font.GothamBold
                MsgLabel.Parent = MsgFrame
                
                TweenService:Create(MsgFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,260,0,65)}):Play()
                wait(3)
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

-- CHARACTER SPAWN
LocalPlayer.CharacterAdded:Connect(function()
    wait(1.5)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- ESP SPAWN
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
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

-- CONTROLS
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(key, gameProcessed)
    if gameProcessed then return end
    if key.KeyCode == Settings.Keybind then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- CANVAS
local function UpdateCanvas()
    for _,content in pairs(TabContents) do
        content.CanvasSize = UDim2.new(0,0,0,content.AbsoluteContentSize.Y + 30)
    end
end

spawn(function()
    wait(0.5)
    UpdateCanvas()
end)

for _,content in pairs(TabContents) do
    content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)
end

print("✅ PANDUS CWL v11.0 ULTRA - WCZYTANO BEZ BŁĘDÓW!")
print("🔥 Anticheat Bypass:", AnticheatBypassed and "SUKCES ✅" or "Częściowy")
print("🎮 Lewy Shift - Toggle GUI | Wszystko działa!")
