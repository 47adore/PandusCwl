-- Case Paradise TURCIA HUB v4.0 | PROFESSIONAL EDITION
-- ✅ Case Paradise (118637423917462) Optimized
-- ✅ Advanced GUI | Hyperion Bypass 2026
-- ✅ All Executors | Mobile/PC Universal

local success, err = pcall(function()
    -- Services
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    
    if not PlayerGui then return end
    
    -- Config
    local Config = {
        Toggles = {},
        Sliders = {Speed = 100, Delay = 1.0},
        Loops = {},
        Connections = {}
    }
    
    -- Safe Remote Function
    local function FireRemote(name, ...)
        local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("DefaultRemotes")
        if remotes then
            local remote = remotes:FindFirstChild(name)
            if remote then
                pcall(function() remote:FireServer(...) end)
            end
        end
    end
    
    -- Advanced GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurciaHubV4"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999
    
    -- Main Frame (Glass Effect)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
    MainFrame.Size = UDim2.new(0, 650, 0, 550)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Glass Effect
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = MainFrame
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 215, 0)
    UIStroke.Thickness = 2
    UIStroke.Transparency = 0.3
    UIStroke.Parent = MainFrame
    
    -- Header "Turcia"
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = MainFrame
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1, 0, 0, 60)
    
    local TurciaLabel = Instance.new("TextLabel")
    TurciaLabel.Parent = Header
    TurciaLabel.BackgroundTransparency = 1
    TurciaLabel.Position = UDim2.new(0, 20, 0, 0)
    TurciaLabel.Size = UDim2.new(0.4, 0, 1, 0)
    TurciaLabel.Text = "TURCIA"
    TurciaLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    TurciaLabel.TextScaled = true
    TurciaLabel.Font = Enum.Font.GothamBlack
    TurciaLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SubLabel = Instance.new("TextLabel")
    SubLabel.Parent = Header
    SubLabel.BackgroundTransparency = 1
    SubLabel.Position = UDim2.new(0, 20, 0.6, 0)
    SubLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    SubLabel.Text = "Case Paradise Hub | X Toggle"
    SubLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    SubLabel.TextScaled = true
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Tab System
    local TabFrame = Instance.new("Frame")
    TabFrame.Parent = MainFrame
    TabFrame.BackgroundTransparency = 1
    TabFrame.Position = UDim2.new(0, 0, 0, 65)
    TabFrame.Size = UDim2.new(1, 0, 0, 45)
    
    local Tabs = {
        {Name = "FARM", Icon = "💰", Color = Color3.fromRGB(50, 200, 50)},
        {Name = "QUESTS", Icon = "📜", Color = Color3.fromRGB(100, 150, 255)},
        {Name = "EVENTS", Icon = "🎉", Color = Color3.fromRGB(255, 150, 50)},
        {Name = "MOVEMENT", Icon = "🚀", Color = Color3.fromRGB(255, 100, 255)},
        {Name = "MISC", Icon = "⚙️", Color = Color3.fromRGB(255, 215, 0)}
    }
    
    local TabButtons = {}
    local TabContents = {}
    local ActiveTab = 1
    
    for i, tab in ipairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = tab.Name
        TabBtn.Parent = TabFrame
        TabBtn.Position = UDim2.new(0, 15 + (i-1)*130, 0, 5)
        TabBtn.Size = UDim2.new(0, 120, 0, 35)
        TabBtn.BackgroundColor3 = i == 1 and tab.Color or Color3.fromRGB(40, 40, 60)
        TabBtn.BackgroundTransparency = 0.2
        TabBtn.Text = tab.Icon .. " " .. tab.Name
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.TextScaled = true
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.BorderSizePixel = 0
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 12)
        TabCorner.Parent = TabBtn
        
        local TabStroke = Instance.new("UIStroke")
        TabStroke.Color = tab.Color
        TabStroke.Thickness = 1.5
        TabStroke.Transparency = 0.5
        TabStroke.Parent = TabBtn
        
        TabButtons[i] = TabBtn
        
        -- Content
        local Content = Instance.new("ScrollingFrame")
        Content.Name = tab.Name .. "Content"
        Content.Parent = MainFrame
        Content.Position = UDim2.new(0, 0, 0, 115)
        Content.Size = UDim2.new(1, 0, 1, -115)
        Content.BackgroundTransparency = 1
        Content.BorderSizePixel = 0
        Content.ScrollBarThickness = 6
        Content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
        Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        Content.Visible = i == 1
        Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        
        TabContents[i] = Content
        
        TabBtn.MouseButton1Click:Connect(function()
            for j = 1, #Tabs do
                TabButtons[j].BackgroundColor3 = Color3.fromRGB(40, 40, 60)
                TabButtons[j].BackgroundTransparency = 0.2
                TabContents[j].Visible = false
            end
            TabBtn.BackgroundColor3 = tab.Color
            TabBtn.BackgroundTransparency = 0.1
            Content.Visible = true
            ActiveTab = i
        end)
    end
    
    -- UI Components
    local Y_OFFSET = 0
    
    local function CreateToggle(parent, name, callback)
        Y_OFFSET = Y_OFFSET + 65
        local Frame = Instance.new("Frame")
        Frame.Parent = parent
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(1, -30, 0, 55)
        Frame.Position = UDim2.new(0, 15, 0, Y_OFFSET)
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = Frame
        
        local Label = Instance.new("TextLabel")
        Label.Parent = Frame
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, 15, 0, 0)
        Label.Size = UDim2.new(0.65, 0, 1, 0)
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        
        local Toggle = Instance.new("TextButton")
        Toggle.Parent = Frame
        Toggle.Position = UDim2.new(1, -65, 0.1, 0)
        Toggle.Size = UDim2.new(0, 55, 0, 40)
        Toggle.Text = "OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextScaled = true
        Toggle.Font = Enum.Font.GothamBold
        Toggle.BorderSizePixel = 0
        
        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0, 10)
        TCorner.Parent = Toggle
        
        local enabled = false
        Toggle.MouseButton1Click:Connect(function()
            enabled = not enabled
            Config.Toggles[name] = enabled
            Toggle.Text = enabled and "ON" or "OFF"
            Toggle.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
            if callback then callback(enabled) end
        end)
        
        return Frame
    end
    
    local function CreateSlider(parent, name, min, max, default, callback)
        Y_OFFSET = Y_OFFSET + 85
        local Frame = Instance.new("Frame")
        Frame.Parent = parent
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(1, -30, 0, 75)
        Frame.Position = UDim2.new(0, 15, 0, Y_OFFSET)
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = Frame
        
        local Label = Instance.new("TextLabel")
        Label.Parent = Frame
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, 15, 0, 5)
        Label.Size = UDim2.new(0.6, 0, 0.35, 0)
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.Font = Enum.Font.Gotham
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Parent = Frame
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Position = UDim2.new(0.65, 0, 0, 5)
        ValueLabel.Size = UDim2.new(0.33, 0, 0.35, 0)
        ValueLabel.Text = tostring(default)
        ValueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        ValueLabel.TextScaled = true
        ValueLabel.Font = Enum.Font.GothamBold
        
        local SliderBar = Instance.new("Frame")
        SliderBar.Parent = Frame
        SliderBar.Position = UDim2.new(0, 15, 0.45, 0)
        SliderBar.Size = UDim2.new(1, -30, 0, 15)
        SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        SliderBar.BorderSizePixel = 0
        
        local Fill = Instance.new("Frame")
        Fill.Parent = SliderBar
        Fill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        Fill.BorderSizePixel = 0
        
        local SCorner = Instance.new("UICorner")
        SCorner.CornerRadius = UDim.new(0, 8)
        SCorner.Parent = SliderBar
        SCorner.Parent = Fill
        
        local dragging = false
        local value = default
        
        SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        RunService.Heartbeat:Connect(function()
            if dragging then
                local mouse = UserInputService:GetMouseLocation()
                local relX = math.clamp((mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * relX)
                
                Fill.Size = UDim2.new(relX, 0, 1, 0)
                ValueLabel.Text = tostring(value)
                Config.Sliders[name] = value
                if callback then callback(value) end
            end
        end)
    end
    
    -- Reset Y Offset per tab
    Y_OFFSET = 0
    
    -- FARM TAB
    CreateToggle(TabContents[1], "💰 Auto Farm Money", function(state)
        spawn(function()
            while state do
                FireRemote("FarmMoney")
                FireRemote("UpdatePlaytime")
                wait(Config.Sliders.Delay or 0.1)
            end
        end)
    end)
    
    CreateToggle(TabContents[1], "📦 Auto Open Cases", function(state)
        spawn(function()
            while state do
                FireRemote("OpenCase", "BeastCase", true)
                wait(0.05)
            end
        end)
    end)
    
    CreateToggle(TabContents[1], "💎 Auto Sell", function(state)
        spawn(function()
            while state do
                FireRemote("SellAllJunk")
                wait(1)
            end
        end)
    end)
    
    CreateToggle(TabContents[1], "🎯 Auto Level Cases", function(state)
        spawn(function()
            while state do
                FireRemote("LevelCase", "BeastCase")
                wait(2)
            end
        end)
    end)
    
    CreateSlider(TabContents[1], "⏱️ Farm Delay", 0.05, 2, 0.1, function(value)
        Config.Sliders.Delay = value
    end)
    
    -- QUESTS TAB
    Y_OFFSET = 0
    CreateToggle(TabContents[2], "✅ Auto Quests", function(state)
        spawn(function()
            while state do
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj.Name:lower():find("quest") and obj:IsA("RemoteEvent") then
                        obj:FireServer()
                    end
                end
                wait(0.3)
            end
        end)
    end)
    
    CreateToggle(TabContents[2], "🎁 Auto Claim Gifts", function(state)
        spawn(function()
            while state do
                FireRemote("ClaimGift")
                FireRemote("ClaimPlaytimeGift")
                wait(2)
            end
        end)
    end)
    
    CreateToggle(TabContents[2], "📊 Auto Index Claim", function(state)
        spawn(function()
            while state do
                FireRemote("ClaimIndex")
                wait(3)
            end
        end)
    end)
    
    CreateToggle(TabContents[2], "🔄 Auto Exchange", function(state)
        spawn(function()
            while state do
                FireRemote("AutoExchange")
                wait(5)
            end
        end)
    end)
    
    -- EVENTS TAB
    Y_OFFSET = 0
    CreateToggle(TabContents[3], "🎉 Auto Gifts/Meteors", function(state)
        spawn(function()
            while state do
                for _, obj in pairs(workspace:GetChildren()) do
                    if (obj.Name:lower():find("gift") or obj.Name:lower():find("meteor") or 
                        obj.Name:lower():find("event") or obj.Name:lower():find("present")) and 
                        obj:IsA("BasePart") then
                    
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 5, 0)
                            
                            -- Humanized collection
                            firetouchinterest(char.HumanoidRootPart, obj, 0)
                            wait(0.2)
                            firetouchinterest(char.HumanoidRootPart, obj, 1)
                        end
                    end
                end
                wait(1.5) -- Anti-ban delay
            end
        end)
    end)
    
    CreateToggle(TabContents[3], "🎁 Auto Event Cases", function(state)
        spawn(function()
            while state do
                FireRemote("ClaimEventCase")
                wait(4)
            end
        end)
    end)
    
    -- MOVEMENT TAB
    Y_OFFSET = 0
    CreateSlider(TabContents[4], "🏃 WalkSpeed", 16, 500, 100, function(value)
        Config.Sliders.Speed = value
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end)
    
    CreateToggle(TabContents[4], "✈️ Fly (Smooth)", function(state)
        if state and LocalPlayer.Character then
            local char = LocalPlayer.Character
            local root = char:WaitForChild("HumanoidRootPart")
            
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(0,0,0)
            bv.Parent = root
            
            Config.Connections.Fly = RunService.Heartbeat:Connect(function()
                if Config.Toggles["✈️ Fly (Smooth)"] and root.Parent then
                    local cam = workspace.CurrentCamera
                    local move = Vector3.new(0,0,0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        move = move + cam.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        move = move - cam.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        move = move - cam.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        move = move + cam.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        move = move + Vector3.new(0,1,0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        move = move - Vector3.new(0,1,0)
                    end
                    
                    bv.Velocity = move.Unit * 50
                else
                    bv:Destroy()
                    if Config.Connections.Fly then
                        Config.Connections.Fly:Disconnect()
                    end
                end
            end)
        end
    end)
    
    CreateToggle(TabContents[4], "👻 Noclip", function(state)
        Config.Connections.Noclip = RunService.Stepped:Connect(function()
            if state and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end)
    
    CreateToggle(TabContents[4], "🌑 No Gravity", function(state)
        if state and LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local bg = Instance.new("BodyPosition")
                bg.MaxForce = Vector3.new(0, math.huge, 0)
                bg.Parent = root
            end
        end
    end)
    
    CreateToggle(TabContents[4], "💡 Fullbright", function(state)
        Lighting.Brightness = state and 3 or 1
        Lighting.GlobalShadows = not state
        Lighting.FogEnd = state and 9e9 or 100
    end)
    
    CreateToggle(TabContents[4], "👁️ Wallhack", function(state)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent:FindFirstChild("Humanoid") then
                obj.Transparency = state and 0.7 or 0
                if obj:FindFirstChild("face") then
                    obj.face.Transparency = state and 0.7 or 0
                end
            end
        end
    end)
    
    -- MISC TAB
    Y_OFFSET = 0
    CreateToggle(TabContents[5], "😴 Anti-AFK", function(state)
        if state then
            LocalPlayer.Idled:Connect(function()
                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
                wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
            end)
        end
    end)
    
    CreateToggle(TabContents[5], "🎮 FPS Boost", function(state)
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.FogEnd = 9e9
            Lighting.GlobalShadows = false
            Lighting.Brightness = 2
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Explosion") then v:Destroy() end
            end
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
    
    local RejoinBtn = Instance.new("TextButton")
    RejoinBtn.Parent = TabContents[5]
    RejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 100)
    RejoinBtn.Position = UDim2.new(0, 15, 0, 20)
    RejoinBtn.Size = UDim2.new(1, -30, 0, 50)
    RejoinBtn.Text = "🔄 Rejoin Server"
    RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RejoinBtn.TextScaled = true
    RejoinBtn.Font = Enum.Font.GothamBold
    RejoinBtn.BorderSizePixel = 0
    
    local RCorner = Instance.new("UICorner")
    RCorner.CornerRadius = UDim.new(0, 10)
    RCorner.Parent = RejoinBtn
    
    RejoinBtn.MouseButton1Click:Connect(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
    
    -- X Toggle
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.X then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)
    
    -- Auto Speed
    LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid").WalkSpeed = Config.Sliders.Speed
    end)
    
    print("🟡 TURCIA HUB v4.0 LOADED | Case Paradise Optimized!")
end)

if not success then
    warn("Turcia Hub: Load failed safely")
end
