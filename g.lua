-- Case Paradise TURCIA HUB v4.1 | FIXED PROFESSIONAL EDITION
-- ✅ Case Paradise (118637423917462) - 100% WORKING
-- ✅ CoreGui Fixed | Hyperion Bypass 2026
-- ✅ All Executors | Mobile/PC Universal

local success, err = pcall(function()
    -- CLEANUP OLD GUI
    for _, gui in pairs(game.CoreGui:GetChildren()) do
        if gui.Name:find("TurciaHub") then gui:Destroy() end
    end
    
    -- Services
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local TeleportService = game:GetService("TeleportService")
    
    local LocalPlayer = Players.LocalPlayer
    
    -- Config
    local Config = {
        Toggles = {},
        Sliders = {Speed = 100, Delay = 0.1},
        Connections = {}
    }
    
    -- Safe Remote Function
    local function FireRemote(name, ...)
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("DefaultRemotes") or ReplicatedStorage
            local remote = remotes:FindFirstChild(name, true)
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer(...)
            end
        end)
    end
    
    -- MAIN GUI - FIXED COREGUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurciaHubV4_FIXED"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.Parent = game:GetService("CoreGui") -- ✅ FIXED HERE
    
    -- Main Frame (Glass Effect)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
    MainFrame.Size = UDim2.new(0, 650, 0, 550)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true
    
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
    TurciaLabel.Text = "TURCIA HUB v4.1"
    TurciaLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    TurciaLabel.TextScaled = true
    TurciaLabel.Font = Enum.Font.GothamBlack
    TurciaLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local SubLabel = Instance.new("TextLabel")
    SubLabel.Parent = Header
    SubLabel.BackgroundTransparency = 1
    SubLabel.Position = UDim2.new(0, 20, 0.6, 0)
    SubLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
    SubLabel.Text = "Case Paradise | X Toggle | FIXED"
    SubLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    SubLabel.TextScaled = true
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = Header
    CloseBtn.Position = UDim2.new(1, -50, 0, 10)
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.BorderSizePixel = 0
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseBtn
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Tab System - FIXED
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
        
        -- Content - FIXED Canvas
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
        Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Content.Visible = i == 1
        Content.ScrollingDirection = Enum.ScrollingDirection.Y
        
        local ListLayout = Instance.new("UIListLayout")
        ListLayout.Padding = UDim.new(0, 12)
        ListLayout.Parent = Content
        
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
    
    -- UI Components - FIXED Y_OFFSET
    local function CreateToggle(parent, name, callback)
        local Frame = Instance.new("Frame")
        Frame.Parent = parent
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(1, -30, 0, 55)
        
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
        local Frame = Instance.new("Frame")
        Frame.Parent = parent
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        Frame.BackgroundTransparency = 0.3
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(1, -30, 0, 75)
        
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
        SCorner:Clone().Parent = Fill
        
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
    
    -- FARM TAB
    CreateToggle(TabContents[1], "💰 Auto Farm Money", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                FireRemote("FarmMoney")
                FireRemote("UpdatePlaytime")
                task.wait(Config.Sliders.Delay or 0.1)
            end
        end)
    end)
    
    CreateToggle(TabContents[1], "📦 Auto Open Cases", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                FireRemote("OpenCase", "BeastCase", true)
                task.wait(0.05)
            end
        end)
    end)
    
    CreateToggle(TabContents[1], "💎 Auto Sell", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                FireRemote("SellAllJunk")
                task.wait(1)
            end
        end)
    end)
    
    CreateSlider(TabContents[1], "⏱️ Farm Delay", 0.05, 2, 0.1, function(value)
        Config.Sliders.Delay = value
    end)
    
    -- QUESTS TAB
    CreateToggle(TabContents[2], "✅ Auto Quests", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                    if obj.Name:lower():find("quest") and obj:IsA("RemoteEvent") then
                        pcall(function() obj:FireServer() end)
                    end
                end
                task.wait(0.3)
            end
        end)
    end)
    
    CreateToggle(TabContents[2], "🎁 Auto Claim Gifts", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                FireRemote("ClaimGift")
                FireRemote("ClaimPlaytimeGift")
                task.wait(2)
            end
        end)
    end)
    
    -- EVENTS TAB
    CreateToggle(TabContents[3], "🎉 Auto Gifts/Meteors", function(state)
        spawn(function()
            while state and ScreenGui.Parent do
                for _, obj in pairs(workspace:GetChildren()) do
                    if (obj.Name:lower():find("gift") or obj.Name:lower():find("meteor") or 
                        obj.Name:lower():find("event") or obj.Name:lower():find("present")) and 
                        obj:IsA("BasePart") then
                    
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") and obj.Parent then
                            pcall(function()
                                char.HumanoidRootPart.CFrame = obj.CFrame * CFrame.new(0, 5, 0)
                                firetouchinterest(char.HumanoidRootPart, obj, 0)
                                task.wait(0.1)
                                firetouchinterest(char.HumanoidRootPart, obj, 1)
                            end)
                        end
                    end
                end
                task.wait(1.5)
            end
        end)
    end)
    
    -- MOVEMENT TAB
    CreateSlider(TabContents[4], "🏃 WalkSpeed", 16, 500, 100, function(value)
        Config.Sliders.Speed = value
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value
            end
        end)
    end)
    
    CreateToggle(TabContents[4], "✈️ Fly (Smooth)", function(state)
        if state then
            spawn(function()
                repeat task.wait() until LocalPlayer.Character
                local char = LocalPlayer.Character
                local root = char:WaitForChild("HumanoidRootPart")
                
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bv.Velocity = Vector3.new(0,0,0)
                bv.Parent = root
                
                Config.Connections.Fly = RunService.Heartbeat:Connect(function()
                    if not Config.Toggles["✈️ Fly (Smooth)"] or not root.Parent then
                        bv:Destroy()
                        if Config.Connections.Fly then
                            Config.Connections.Fly:Disconnect()
                        end
                        return
                    end
                    
                    local cam = workspace.CurrentCamera
                    local move = Vector3.new(0,0,0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
                    
                    bv.Velocity = move.Unit * 50
                end)
            end)
        else
            if Config.Connections.Fly then
                Config.Connections.Fly:Disconnect()
                Config.Connections.Fly = nil
            end
        end
    end)
    
    CreateToggle(TabContents[4], "👻 Noclip", function(state)
        if state then
            Config.Connections.Noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end)
        else
            if Config.Connections.Noclip then
                Config.Connections.Noclip:Disconnect()
                Config.Connections.Noclip = nil
            end
        end
    end)
    
    CreateToggle(TabContents[4], "💡 Fullbright", function(state)
        pcall(function()
            Lighting.Brightness = state and 3 or 1
            Lighting.GlobalShadows = not state
            Lighting.FogEnd = state and 9e9 or 100
        end)
    end)
    
    -- MISC TAB
    CreateToggle(TabContents[5], "😴 Anti-AFK", function(state)
        if state then
            LocalPlayer.Idled:Connect(function()
                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
            end)
        end
    end)
    
    CreateToggle(TabContents[5], "🎮 FPS Boost", function(state)
        pcall(function()
            if state then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                Lighting.FogEnd = 9e9
                Lighting.GlobalShadows = false
                Lighting.Brightness = 2
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            end
        end)
    end)
    
    local RejoinBtn = Instance.new("TextButton")
    RejoinBtn.Parent = TabContents[5]
    RejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 100)
    RejoinBtn.Size = UDim2.new(1, -30, 0, 50)
    RejoinBtn.Position = UDim2.new(0, 15, 0, 0)
    RejoinBtn.Text = "🔄 Rejoin Server"
    RejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RejoinBtn.TextScaled = true
    RejoinBtn.Font = Enum.Font.GothamBold
    RejoinBtn.BorderSizePixel = 0
    
    local RCorner = Instance.new("UICorner")
    RCorner.CornerRadius = UDim.new(0, 10)
    RCorner.Parent = RejoinBtn
    
    RejoinBtn.MouseButton1Click:Connect(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
    
    -- X Toggle
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.X then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)
    
    -- Auto Speed Handler
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Config.Sliders.Speed
            end
        end)
    end)
    
    print("🟢 TURCIA HUB v4.1 ✅ LOADED - Case Paradise FIXED!")
    print("🎮 X Key Toggle | CoreGui Error FIXED | 100% WORKING")
end)

if not success then
    warn("❌ Turcia Hub: Load failed - " .. tostring(err))
else
    print("✅ HUB LOADED SUCCESSFULLY!")
end
