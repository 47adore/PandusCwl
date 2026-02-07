-- PANDUS CWL v10.0 PRO MAX - PROFESJONALNE WYDANIE
-- DRAGGING + ZAKŁADKI + SKOK + ESP + ZERO SPASEJ

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
for i,v in pairs(game.CoreGui:GetChildren()) do
    if v.Name:find("Pandus") then v:Destroy() end
end

-- SETTINGS
local Settings = {Speed=100, JumpPower=50, ESP=false, Fly=false}
local Connections = {}
local ESPTable = {}

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV10_Pro"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,850,0,550)
MainFrame.Position = UDim2.new(0.5,-425,0.5,-275)
MainFrame.BackgroundColor3 = Color3.fromRGB(22,25,32)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- DRAG FUNCTION
local dragging, dragStart, startPos
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
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        updateInput(input)
    end
end)

-- CORNERS & STROKES
local MainCorner = Instance.new("UICorner",MainFrame)
MainCorner.CornerRadius = UDim.new(0,14)

local MainStroke = Instance.new("UIStroke",MainFrame)
MainStroke.Color = Color3.fromRGB(60,75,105)
MainStroke.Thickness = 1.8

-- HEADER
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1,0,0,50)
Header.Position = UDim2.new(0,0,0,0)
Header.BackgroundColor3 = Color3.fromRGB(16,19,26)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner",Header)
HeaderCorner.CornerRadius = UDim.new(0,14)

local HeaderStroke = Instance.new("UIStroke",Header)
HeaderStroke.Color = Color3.fromRGB(45,55,80)
HeaderStroke.Thickness = 1

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.75,0,1,0)
Title.Position = UDim2.new(0,18,0,0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ PANDUS CWL v10.0 PRO MAX ⚡"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,36,0,36)
CloseBtn.Position = UDim2.new(1,-46,0.5,-18)
CloseBtn.BackgroundColor3 = Color3.fromRGB(210,55,55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner",CloseBtn)
CloseCorner.CornerRadius = UDim.new(0,9)

-- SIDE TABS (ZERO SPACE)
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0,135,1,-50)
SideFrame.Position = UDim2.new(0,0,0,50)
SideFrame.BackgroundColor3 = Color3.fromRGB(26,29,38)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner",SideFrame)
SideCorner.CornerRadius = UDim.new(0,12)

-- CONTENT FRAMES (TAB SPECIFIC)
local TabContents = {}
local TabButtons = {}
local CurrentTabIndex = 1

local TabNames = {"MOVEMENT", "PLAYER", "COMBAT", "VISUALS", "UTILITY", "TROLL"}

-- CREATE TAB SYSTEM
for i, tabName in ipairs(TabNames) do
    -- TAB BUTTON
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName
    TabBtn.Size = UDim2.new(1,-6,0,38)
    TabBtn.Position = UDim2.new(0,3,(i-1)*39,0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(36,40,52)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(185,195,215)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner",TabBtn)
    TabCorner.CornerRadius = UDim.new(0,9)
    
    TabButtons[i] = TabBtn
    
    -- TAB CONTENT
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "Content"..i
    ContentFrame.Size = UDim2.new(1,-150,1,-55)
    ContentFrame.Position = UDim2.new(0,140,0,55)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60,75,105)
    ContentFrame.CanvasSize = UDim2.new(0,0,2,0)
    ContentFrame.Visible = (i==1)
    ContentFrame.Parent = MainFrame
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0,6)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = ContentFrame
    
    TabContents[i] = ContentFrame
    
    -- TAB CLICK
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTabIndex = i
        for j,content in pairs(TabContents) do
            content.Visible = (j==i)
        end
        for j,btn in pairs(TabButtons) do
            TweenService:Create(btn,TweenInfo.new(0.2,Enum.EasingStyle.Quart),{BackgroundColor3 = (j==i) and Color3.fromRGB(60,75,105) or Color3.fromRGB(36,40,52), TextColor3 = (j==i) and Color3.fromRGB(255,255,255) or Color3.fromRGB(185,195,215)}):Play()
        end
    end)
end

-- UI ELEMENTS FUNCTIONS
local function CreateToggle(parent, name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-16,0,42)
    Frame.BackgroundColor3 = Color3.fromRGB(34,38,48)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner",Frame)
    Corner.CornerRadius = UDim.new(0,10)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.72,0,0.9,0)
    Label.Position = UDim2.new(0,14,0.05,0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(235,240,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0,48,0,26)
    Switch.Position = UDim2.new(1,-58,0.37,0)
    Switch.BackgroundColor3 = Color3.fromRGB(65,70,85)
    Switch.Text = ""
    Switch.Parent = Frame
    
    local SCorner = Instance.new("UICorner",Switch)
    SCorner.CornerRadius = UDim.new(0,13)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,22,0,22)
    Knob.Position = UDim2.new(0,2,0,2)
    Knob.BackgroundColor3 = Color3.fromRGB(135,140,155)
    Knob.Parent = Switch
    
    local KCorner = Instance.new("UICorner",Knob)
    KCorner.CornerRadius = UDim.new(0,11)
    
    local toggled = false
    Switch.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(Switch,TweenInfo.new(0.18),{BackgroundColor3 = toggled and Color3.fromRGB(60,75,105) or Color3.fromRGB(65,70,85)}):Play()
        TweenService:Create(Knob,TweenInfo.new(0.18),{Position = toggled and UDim2.new(1,-24,0,2) or UDim2.new(0,2,0,2), BackgroundColor3 = toggled and Color3.white or Color3.fromRGB(135,140,155)}):Play()
        callback(toggled)
    end)
end

local function CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-16,0,52)
    Frame.BackgroundColor3 = Color3.fromRGB(34,38,48)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner",Frame)
    Corner.CornerRadius = UDim.new(0,10)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.68,0,0.42,0)
    Label.Position = UDim2.new(0,14,0,4)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(235,240,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.28,0,0.42,0)
    ValueLabel.Position = UDim2.new(0.72,0,0,4)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(60,75,105)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.92,0,0,7)
    Track.Position = UDim2.new(0.04,0,0.62,0)
    Track.BackgroundColor3 = Color3.fromRGB(52,57,72)
    Track.Parent = Frame
    
    local TCorner = Instance.new("UICorner",Track)
    TCorner.CornerRadius = UDim.new(0,4)
    
    local Fill = Instance.new("Frame")
    local percent = (default-min)/(max-min)
    Fill.Size = UDim2.new(percent,0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(60,75,105)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FCorner = Instance.new("UICorner",Fill)
    FCorner.CornerRadius = UDim.new(0,4)
    
    local dragging = false
    Track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    Track.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = inp.Position.X - Track.AbsolutePosition.X
            local percent = math.clamp(delta/Track.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max-min)*percent)
            Fill.Size = UDim2.new(percent,0,1,0)
            ValueLabel.Text = tostring(value)
            callback(value)
        end
    end)
end

local function CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-16,0,40)
    Button.BackgroundColor3 = Color3.fromRGB(52,62,87)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(235,240,255)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner",Button)
    Corner.CornerRadius = UDim.new(0,10)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(72,82,107),Size=UDim2.new(1,-18,0,38)}):Play()
        wait(0.12)
        TweenService:Create(Button,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(52,62,87),Size=UDim2.new(1,-16,0,40)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB CONTENT
CreateSlider(TabContents[1],"WalkSpeed",16,500,100,function(v) 
    Settings.Speed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

CreateSlider(TabContents[1],"JumpPower",50,500,50,function(v)
    Settings.JumpPower = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)

CreateToggle(TabContents[1],"Fly",function(state)
    Settings.Fly = state
    if state then
        spawn(function()
            repeat wait() until LocalPlayer.Character
            local root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
            bv.Parent = root
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if not Settings.Fly then return end
                local cam = Camera
                local vel = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,1,0) end
                bv.Velocity = vel * (Settings.Speed/16)
            end)
        end)
    else
        if Connections.Fly then Connections.Fly:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyVelocity") then
            LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

CreateToggle(TabContents[1],"Noclip",function(state)
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _,part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect() end
    end
end)

-- PLAYER TAB
CreateToggle(TabContents[2],"SpinBot",function(state)
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(45),0)
            end
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect() end
    end
end)

CreateToggle(TabContents[2],"Low Gravity",function(state)
    workspace.Gravity = state and 35 or 196.2
end)

-- COMBAT TAB
CreateToggle(TabContents[3],"Aimbot",function(state)
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local target, distance = nil, math.huge
            for _,plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local pos, visible = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if visible then
                        local screenPoint = Vector2.new(pos.X, pos.Y)
                        local screenCenter = Vector2.new(Mouse.X, Mouse.Y)
                        local dist = (screenPoint - screenCenter).Magnitude
                        if dist < distance then
                            target = plr
                            distance = dist
                        end
                    end
                end
            end
            if target and target.Character then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
            end
        end)
    else
        if Connections.Aimbot then Connections.Aimbot:Disconnect() end
    end
end)

-- VISUALS TAB
CreateToggle(TabContents[4],"ESP Players",function(state)
    Settings.ESP = state
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if state and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "PandusESP"
                highlight.FillColor = Color3.fromRGB(0,162,255)
                highlight.FillTransparency = 0.45
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.OutlineTransparency = 0
                highlight.Parent = plr.Character
                ESPTable[plr] = highlight
            elseif ESPTable[plr] then
                ESPTable[plr]:Destroy()
                ESPTable[plr] = nil
            end
        end
    end
end)

-- UTILITY TAB
CreateToggle(TabContents[5],"Anti-AFK",function(state)
    spawn(function()
        while state do
            local args = {[1] = "SetPlayerAfkStatus", [2] = LocalPlayer, [3] = false}
            -- Anti-AFK movement
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4e3,4e3,4e3)
                bv.Velocity = Vector3.new(0.3,0,0)
                bv.Parent = LocalPlayer.Character.HumanoidRootPart
                game:GetService("Debris"):AddItem(bv,0.1)
            end
            wait(300)
        end
    end)
end)

CreateButton(TabContents[5],"Rejoin Server",function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(TabContents[5],"Say Turcja ❤️",function()
    pcall(function()
        ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer("Turcja najlepsza ❤️","All")
    end)
end)

-- TROLL TAB
CreateButton(TabContents[6],"FLING ALL ULTRA",function()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9,1e9,1e9)
            bv.Velocity = Vector3.new(math.random(-3e4,3e4),5e4,math.random(-3e4,3e4))
            bv.Parent = root
            Debris:AddItem(bv,0.15)
        end
    end
end)

CreateButton(TabContents[6],"Teleport To Players",function()
    local TpFrame = Instance.new("ScrollingFrame")
    TpFrame.Size = UDim2.new(0,240,0,320)
    TpFrame.Position = UDim2.new(0.5,-120,0.5,-160)
    TpFrame.BackgroundColor3 = Color3.fromRGB(22,25,32)
    TpFrame.BorderSizePixel = 0
    TpFrame.ScrollBarThickness = 4
    TpFrame.Parent = ScreenGui
    
    local TpCorner = Instance.new("UICorner",TpFrame)
    TpCorner.CornerRadius = UDim.new(0,12)
    
    local TpLayout = Instance.new("UIListLayout")
    TpLayout.Padding = UDim.new(0,4)
    TpLayout.Parent = TpFrame
    
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local TpBtn = Instance.new("TextButton")
            TpBtn.Size = UDim2.new(1,-12,0,32)
            TpBtn.BackgroundColor3 = Color3.fromRGB(45,52,68)
            TpBtn.Text = plr.Name.." ["..math.floor((plr.Character.HumanoidRootPart.Position - (LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.Position or Vector3.new())).Magnitude).."]"
            TpBtn.TextColor3 = Color3.white
            TpBtn.TextScaled = true
            TpBtn.Font = Enum.Font.Gotham
            TpBtn.Parent = TpFrame
            
            local BtnCorner = Instance.new("UICorner",TpBtn)
            BtnCorner.CornerRadius = UDim.new(0,8)
            
            TpBtn.MouseButton1Click:Connect(function()
                if LocalPlayer.Character and plr.Character then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
                end
            end)
        end
    end
    
    TpFrame.CanvasSize = UDim2.new(0,0,0,TpLayout.AbsoluteContentSize.Y)
end)

-- EVENTS
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        MainFrame.Visible = not MainFrame.Visible
        if MainFrame.Visible then
            TabContents[1].Visible = true
            TweenService:Create(TabButtons[1],TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,75,105),TextColor3=Color3.white}):Play()
        end
    end
end)

-- CHARACTER HANDLING
LocalPlayer.CharacterAdded:Connect(function()
    wait(2)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Settings.Speed
        char.Humanoid.JumpPower = Settings.JumpPower
    end
end)

-- ESP HANDLING
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        wait(1)
        if Settings.ESP then
            local highlight = Instance.new("Highlight")
            highlight.Name = "PandusESP"
            highlight.FillColor = Color3.fromRGB(0,162,255)
            highlight.FillTransparency = 0.45
            highlight.OutlineColor = Color3.white
            highlight.Parent = plr.Character
            ESPTable[plr] = highlight
        end
    end)
end)

print("🎯 PANDUS CWL v10.0 PRO MAX - WCZYTANO!")
print("👆 PRZESUWANIE: Przeciągaj główną ramkę")
print("🔄 ZAKŁADKI: Klikaj nazwy po lewej (ZERO SPASEJ)")
print("✈️ Z - Otwórz/Zamknij | WSZYSTKO DZIAŁA!")
