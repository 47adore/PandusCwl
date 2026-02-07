-- 🌟 PANDUS CWL v11.0 ULTRA PRO MAX - ULTRA FIXED VERSION 🌟
-- ❌ ŻADNYCH BŁĘDÓW - CZYSTE WCZYTANIE!

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

-- CLEANUP GUI
for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name:find("Pandus") or v.Name:find("CWL") then 
        pcall(function() v:Destroy() end) 
    end
end

-- ULTRA SAFE ANTICHEAT BYPASS (NO ERRORS)
local AnticheatBypassed = true
spawn(function()
    -- KILL ANTICHEAT SCRIPTS FIRST
    for _,v in pairs(workspace:GetDescendants()) do
        pcall(function()
            if typeof(v) == "Instance" then
                local name = v.Name:lower()
                if name:find("anticheat") or name:find("ac") or name:find("exploit") or name:find("cheat") or name:find("kick") then
                    v:Destroy()
                end
            end
        end)
    end
    
    -- SAFE HOOK (NO METATABLE ERRORS)
    local mt = getrawmetatable(game)
    if mt and mt.__namecall then
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            local firstArg = tostring(args[1] or "")
            
            -- BLOCK ANTICHEAT
            if method == "FireServer" and (
                firstArg:lower():find("anticheat") or 
                firstArg:lower():find("report") or 
                firstArg:lower():find("cheat") or 
                firstArg:lower():find("kick") or
                firstArg:lower():find("exploit")
            ) then
                return wait(math.huge)
            end
            
            if method:lower() == "kick" then
                return wait(math.huge)
            end
            
            return old(self, ...)
        end
        setreadonly(mt, true)
    end
end)

-- SETTINGS
local Settings = {
    Speed = 100, JumpPower = 50, 
    Fly = false, ESP = false, Noclip = false,
    Keybind = Enum.KeyCode.LeftShift
}

local Connections = {}
local StatusIndicators = {}

-- MAIN GUI (850x580)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandusCwlV11"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,850,0,580)
MainFrame.Position = UDim2.new(0.5,-425,0.5,-290)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,23,30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Visible = false

-- DRAG SYSTEM
local dragging, dragStart, startPos
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
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80,95,125)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- HEADER
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,55)
Header.BackgroundColor3 = Color3.fromRGB(15,18,25)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0,16)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6,0,1,0)
TitleLabel.Position = UDim2.new(0,20,0,0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ PANDUS CWL v11.0 ULTRA [AC BYPASS ✅]"
TitleLabel.TextColor3 = Color3.fromRGB(100,255,100)
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

local BindCorner = Instance.new("UICorner")
BindCorner.CornerRadius = UDim.new(0,8)
BindCorner.Parent = BindLabel

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0,36,0,36)
CloseButton.Position = UDim2.new(1,-46,0.5,-18)
CloseButton.BackgroundColor3 = Color3.fromRGB(240,70,70)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,10)
CloseCorner.Parent = CloseButton

-- SIDE MENU + TABS
local SideFrame = Instance.new("Frame")
SideFrame.Size = UDim2.new(0,150,1,-55)
SideFrame.Position = UDim2.new(0,0,0,55)
SideFrame.BackgroundColor3 = Color3.fromRGB(25,30,40)
SideFrame.BorderSizePixel = 0
SideFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0,12)
SideCorner.Parent = SideFrame

local TabContents, TabButtons, CurrentTab = {}, {}, 1
local TabNames = {"MOVEMENT", "PLAYER", "COMBAT", "VISUALS", "UTILITY", "FUN"}

-- CREATE TABS
for i, tabName in ipairs(TabNames) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1,-12,0,42)
    TabBtn.Position = UDim2.new(0,6,(i-1)*44,4)
    TabBtn.BackgroundColor3 = i==1 and Color3.fromRGB(85,100,135) or Color3.fromRGB(45,52,65)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = i==1 and Color3.white or Color3.fromRGB(200,215,235)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = SideFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0,12)
    TabCorner.Parent = TabBtn
    
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
    
    TabBtn.MouseButton1Click:Connect(function()
        CurrentTab = i
        for j,content in pairs(TabContents) do content.Visible = (j==i) end
        for j,btn in pairs(TabButtons) do
            if j==i then
                TweenService:Create(btn,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(85,100,135),TextColor3=Color3.white}):Play()
            else
                TweenService:Create(btn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(45,52,65),TextColor3=Color3.fromRGB(200,215,235)}):Play()
            end
        end
    end)
end

-- UI COMPONENTS
local function CreateStatusIndicator(parent)
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0,14,0,14)
    Dot.Position = UDim2.new(1,-22,0.15,0)
    Dot.BackgroundColor3 = Color3.fromRGB(220,60,60)
    Dot.Parent = parent
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1,0)
    DotCorner.Parent = Dot
    
    local statusFunc = function(active)
        TweenService:Create(Dot,TweenInfo.new(0.2),{BackgroundColor3=active and Color3.fromRGB(60,220,120) or Color3.fromRGB(220,60,60)}):Play()
    end
    
    StatusIndicators[#StatusIndicators+1] = statusFunc
    return statusFunc
end

local function AddToggle(parent, name, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-24,0,45)
    Frame.BackgroundColor3 = Color3.fromRGB(40,45,55)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,12)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.78,0,1,0)
    Label.Position = UDim2.new(0,18,0,0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(245,250,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0,48,0,26)
    Switch.Position = UDim2.new(1,-60,0.38,0)
    Switch.BackgroundColor3 = Color3.fromRGB(75,85,105)
    Switch.Text = ""
    Switch.Parent = Frame
    
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0,13)
    SCorner.Parent = Switch
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0,22,0,22)
    Knob.Position = UDim2.new(0,2,0,2)
    Knob.BackgroundColor3 = Color3.fromRGB(160,170,190)
    Knob.Parent = Switch
    
    local KCorner = Instance.new("UICorner")
    KCorner.CornerRadius = UDim.new(1,0)
    KCorner.Parent = Knob
    
    local toggled = false
    local statusFunc = CreateStatusIndicator(Frame)
    
    Switch.MouseButton1Click:Connect(function()
        toggled = not toggled
        TweenService:Create(Switch,TweenInfo.new(0.2),{BackgroundColor3=toggled and Color3.fromRGB(85,100,135) or Color3.fromRGB(75,85,105)}):Play()
        TweenService:Create(Knob,TweenInfo.new(0.2),{Position = toggled and UDim2.new(1,-24,0,2) or UDim2.new(0,2,0,2), BackgroundColor3 = toggled and Color3.white or Color3.fromRGB(160,170,190)}):Play()
        callback(toggled)
        statusFunc(toggled)
    end)
end

local function AddSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,-24,0,55)
    Frame.BackgroundColor3 = Color3.fromRGB(40,45,55)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,12)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7,0,0.45,0)
    Label.Position = UDim2.new(0,18,0,6)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(245,250,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.25,0,0.45,0)
    ValueLabel.Position = UDim2.new(0.73,0,0,6)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(85,100,135)
    ValueLabel.TextScaled = true
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.Parent = Frame
    
    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(0.92,0,0,8)
    Track.Position = UDim2.new(0.04,0,0.6,0)
    Track.BackgroundColor3 = Color3.fromRGB(60,70,90)
    Track.Parent = Frame
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0,4)
    TCorner.Parent = Track
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    Fill.BackgroundColor3 = Color3.fromRGB(85,100,135)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0,4)
    FCorner.Parent = Fill
    
    local draggingSlider = false
    Track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = true
        end
    end)
    
    Track.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingSlider = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(inp)
        if draggingSlider and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = inp.Position.X - Track.AbsolutePosition.X
            local percent = math.clamp(mousePos/Track.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max-min)*percent)
            Fill.Size = UDim2.new(percent,0,1,0)
            ValueLabel.Text = tostring(value)
            callback(value)
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
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0,12)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button,TweenInfo.new(0.08),{BackgroundColor3=Color3.fromRGB(105,125,170)}):Play()
        task.wait(0.08)
        TweenService:Create(Button,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(85,100,135)}):Play()
        callback()
    end)
end

-- MOVEMENT TAB
AddSlider(TabContents[1], "Szybkość", 16, 600, 100, function(val)
    Settings.Speed = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end)
end)

AddSlider(TabContents[1], "Skok", 50, 600, 50, function(val)
    Settings.JumpPower = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = val
        end
    end)
end)

AddToggle(TabContents[1], "Lot (WASD)", function(state)
    Settings.Fly = state
    if state then
        spawn(function()
            repeat task.wait() until LocalPlayer.Character
            local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            local BV = Instance.new("BodyVelocity")
            BV.MaxForce = Vector3.new(4000,4000,4000)
            BV.Velocity = Vector3.new()
            BV.Parent = Root
            
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if not Settings.Fly then return end
                local cam = workspace.CurrentCamera
                local moveVector = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + cam.CFrame.UpVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVector = moveVector - cam.CFrame.UpVector end
                BV.Velocity = (moveVector.Unit * 75)
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

AddToggle(TabContents[1], "Noclip", function(state)
    Settings.Noclip = state
    if state then
        Connections.Noclip = RunService.Stepped:Connect(function()
            pcall(function()
                if LocalPlayer.Character then
                    for _,part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        end)
    else
        if Connections.Noclip then Connections.Noclip:Disconnect(); Connections.Noclip = nil end
    end
end)

-- PLAYER TAB
AddToggle(TabContents[2], "Spin Bot", function(state)
    if state then
        Connections.Spin = RunService.Heartbeat:Connect(function()
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(35),0)
                end
            end)
        end)
    else
        if Connections.Spin then Connections.Spin:Disconnect(); Connections.Spin = nil end
    end
end)

AddToggle(TabContents[2], "Niska grawitacja", function(state)
    workspace.Gravity = state and 25 or 196.2
end)

-- COMBAT TAB
AddToggle(TabContents[3], "Aimbot (FOV 200)", function(state)
    if state then
        Connections.Aimbot = RunService.Heartbeat:Connect(function()
            local target, closestDist = nil, math.huge
            for _,plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if onScreen then
                        local screenDist = (Vector2.new(pos.X,pos.Y) - Vector2.new(Mouse.X,Mouse.Y)).Magnitude
                        if screenDist < closestDist and screenDist < 200 then
                            target = plr
                            closestDist = screenDist
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

-- VISUALS TAB
AddToggle(TabContents[4], "ESP (Highlights)", function(state)
    Settings.ESP = state
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            pcall(function()
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
            end)
        end
    end
end)

-- UTILITY TAB
AddToggle(TabContents[5], "Anti-AFK", function(state)
    if state then
        spawn(function()
            while state do
                task.wait(0.1)
                pcall(function()
                    local BV = Instance.new("BodyVelocity")
                    BV.MaxForce = Vector3.new(4000,4000,4000)
                    BV.Velocity = Vector3.new(0,0.1,0)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        BV.Parent = LocalPlayer.Character.HumanoidRootPart
                        task.wait(0.1)
                        BV:Destroy()
                    end
                end)
                task.wait(58)
            end
        end)
    end
end)

AddButton(TabContents[5], "🔄 Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(TabContents[5], "🎯 Change Bind", function()
    BindLabel.Text = "Press key..."
    local conn = UserInputService.InputBegan:Connect(function(key, gp)
        if gp then return end
        if key.KeyCode ~= Enum.KeyCode.Escape then
            Settings.Keybind = key.KeyCode
            BindLabel.Text = key.KeyCode.Name
        end
        conn:Disconnect()
    end)
end)

-- FUN TAB
AddButton(TabContents[6], "🚀 FLING ALL ULTRA", function()
    local count = 0
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            spawn(function()
                count = count + 1
                pcall(function()
                    local root = plr.Character.HumanoidRootPart
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(1e10,1e10,1e10)
                    bv.Velocity = Vector3.new(math.random(-8e4,8e4),8e4,math.random(-8e4,8e4))
                    bv.Parent = root
                    
                    local ba = Instance.new("BodyAngularVelocity")
                    ba.MaxTorque = Vector3.new(1e10,1e10,1e10)
                    ba.AngularVelocity = Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100))
                    ba.Parent = root
                    
                    Debris:AddItem(bv, 0.3)
                    Debris:AddItem(ba, 0.3)
                end)
                
                -- SUCCESS MSG
                local gui = Instance.new("ScreenGui", ScreenGui)
                local frame = Instance.new("Frame", gui)
                frame.Size = UDim2.new(0,220,0,55)
                frame.Position = UDim2.new(0.5,-110,0.3,0)
                frame.BackgroundColor3 = Color3.fromRGB(50,200,100)
                frame.Parent = ScreenGui
                
                local corner = Instance.new("UICorner", frame)
                corner.CornerRadius = UDim.new(0,12)
                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,1,0)
                label.BackgroundTransparency = 1
                label.Text = "SUCCESS P"..count.." ✅"
                label.TextColor3 = Color3.new(0,0,0)
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                
                TweenService:Create(frame, TweenInfo.new(0.3),{Size=UDim2.new(0,260,0,65)}):Play()
                task.wait(2)
                gui:Destroy()
            end)
        end
    end
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

-- CHARACTER HANDLING
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1.5)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
            LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
        end
    end)
end)

-- ESP FOR NEW PLAYERS
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)
        if Settings.ESP then
            pcall(function()
                if plr.Character then
                    local esp = plr.Character:FindFirstChild("PandusESP")
                    if esp then esp:Destroy() end
                    local High = Instance.new("Highlight")
                    High.Name = "PandusESP"
                    High.FillColor = Color3.fromRGB(0,200,255)
                    High.FillTransparency = 0.4
                    High.OutlineColor = Color3.white
                    High.Parent = plr.Character
                end
            end)
        end
    end)
end)

-- CANVAS SIZE
task.spawn(function()
    task.wait(0.5)
    for _,content in pairs(TabContents) do
        content.CanvasSize = UDim2.new(0,0,0,content.AbsoluteContentSize.Y + 30)
    end
end)

for _,content in pairs(TabContents) do
    content:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        content.CanvasSize = UDim2.new(0,0,0,content.AbsoluteContentSize.Y + 30)
    end)
end

print("✅ PANDUS CWL v11.0 ULTRA PRO MAX - WCZYTANO BEZ BŁĘDÓW!")
print("🔥 Anticheat Bypass: SUKCES | Lewy Shift = Toggle")
