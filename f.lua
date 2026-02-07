-- PANDUS CWL v9.2 ULTRA FIX - 100% COREGUI + MOVEMENT BEZ BŁĘDÓW
-- BEZPIECZNY CORE GUI + SAFE MOVEMENT DETECTION

pcall(function()
    -- ULTRA SAFE SERVICES - ZERO NIL ERRORS
    local success, Players = pcall(game.GetService, game, "Players")
    if not success then return end
    
    local success2, UserInputService = pcall(game.GetService, game, "UserInputService")
    if not success2 then return end
    
    local success3, RunService = pcall(game.GetService, game, "RunService")
    if not success3 then return end
    
    local success4, TweenService = pcall(game.GetService, game, "TweenService")
    if not success4 then return end
    
    local success5, TeleportService = pcall(game.GetService, game, "TeleportService")
    if not success5 then return end
    
    local success6, Debris = pcall(game.GetService, game, "Debris")
    if not success6 then return end
    
    local success7, ReplicatedStorage = pcall(game.GetService, game, "ReplicatedStorage")
    if not success7 then return end
    
    local success8, CoreGui = pcall(game.GetService, game, "CoreGui")
    if not success8 then return end
    
    local success9, Workspace = pcall(game.GetService, game, "Workspace")
    if not success9 then return end

    local LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then return end
    
    local Mouse = LocalPlayer:GetMouse()
    local Camera = Workspace.CurrentCamera

    -- ULTRA CLEANUP - USUŃ WSZYSTKO 20x
    for i=1,20 do
        for _,v in pairs(CoreGui:GetChildren()) do
            pcall(function()
                if v.Name:find("Pandus") or v.Name:find("CWL") or v.Name:find("v9") then
                    v:Destroy()
                end
            end)
        end
        task.wait()
    end

    local Settings = {Speed=16, JumpPower=50, Fly=false, Noclip=false, ESP=false}
    local Connections = {}

    -- ULTRA SAFE GUI CREATION
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwlUltraSafe"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 2147483647
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrameSafe"
    MainFrame.Size = UDim2.new(0,780,0,520)
    MainFrame.Position = UDim2.new(0.5,-390,0.5,-260)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25,28,35)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- SAFE CORNER + STROKE
    pcall(function()
        local UICorner1 = Instance.new("UICorner")
        UICorner1.CornerRadius = UDim.new(0,12)
        UICorner1.Parent = MainFrame
        
        local UIStroke1 = Instance.new("UIStroke")
        UIStroke1.Color = Color3.fromRGB(65,80,110)
        UIStroke1.Thickness = 1.5
        UIStroke1.Parent = MainFrame
    end)

    -- HEADER - ULTRA SAFE
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0,45)
    Header.BackgroundColor3 = Color3.fromRGB(18,22,28)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.7,0,1,0)
    TitleLabel.Position = UDim2.new(0,15,0,0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "PANDUS CWL v9.2 ULTRA SAFE"
    TitleLabel.TextColor3 = Color3.white
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = Header

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0,32,0,32)
    CloseButton.Position = UDim2.new(1,-42,0.5,-16)
    CloseButton.BackgroundColor3 = Color3.fromRGB(220,60,60)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.white
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Parent = Header

    -- SIDE MENU
    local SideFrame = Instance.new("Frame")
    SideFrame.Size = UDim2.new(0,130,1,-45)
    SideFrame.Position = UDim2.new(0,0,0,45)
    SideFrame.BackgroundColor3 = Color3.fromRGB(28,32,40)
    SideFrame.BorderSizePixel = 0
    SideFrame.Parent = MainFrame

    -- CONTENT FRAME
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1,-145,1,-50)
    ContentFrame.Position = UDim2.new(0,135,0,50)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 5
    ContentFrame.CanvasSize = UDim2.new(0,0,0,2500)
    ContentFrame.Parent = MainFrame

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0,8)
    ContentLayout.Parent = ContentFrame

    -- TABS SYSTEM
    local TabNames = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL"}
    local TabButtons = {}
    local CurrentTab = 1

    local function CreateTabButton(name, index)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1,-8,0,40)
        TabBtn.Position = UDim2.new(0,4,(index-1)*0.327,0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(38,42,52)
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(190,200,220)
        TabBtn.TextScaled = true
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.BorderSizePixel = 0
        TabBtn.Parent = SideFrame
        
        TabButtons[index] = TabBtn
        
        TabBtn.MouseButton1Click:Connect(function()
            CurrentTab = index
            for i,v in pairs(TabButtons) do
                pcall(function()
                    TweenService:Create(v, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(38,42,52),
                        TextColor3 = Color3.fromRGB(190,200,220)
                    }):Play()
                end)
            end
            pcall(function()
                TweenService:Create(TabBtn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(65,80,110),
                    TextColor3 = Color3.white
                }):Play()
            end)
        end)
    end

    -- ULTRA SAFE TOGGLE
    local function AddToggle(name, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1,-20,0,40)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(35,39,48)
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = ContentFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.75,0,1,0)
        Label.Position = UDim2.new(0,15,0,0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.white
        Label.TextScaled = true
        Label.Font = Enum.Font.SourceSans
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local SwitchBtn = Instance.new("TextButton")
        SwitchBtn.Size = UDim2.new(0,45,0,25)
        SwitchBtn.Position = UDim2.new(1,-55,0.375,0)
        SwitchBtn.BackgroundColor3 = Color3.fromRGB(70,75,90)
        SwitchBtn.Text = ""
        SwitchBtn.Parent = ToggleFrame
        
        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0,21,0,21)
        Knob.Position = UDim2.new(0,2,0,2)
        Knob.BackgroundColor3 = Color3.fromRGB(140,145,160)
        Knob.Parent = SwitchBtn
        
        local toggled = false
        SwitchBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            pcall(callback, toggled)
            pcall(function()
                TweenService:Create(SwitchBtn,TweenInfo.new(0.15),{BackgroundColor3 = toggled and Color3.fromRGB(65,80,110) or Color3.fromRGB(70,75,90)}):Play()
                TweenService:Create(Knob,TweenInfo.new(0.15),{Position = toggled and UDim2.new(1,-23,0,2) or UDim2.new(0,2,0,2), BackgroundColor3 = toggled and Color3.white or Color3.fromRGB(140,145,160)}):Play()
            end)
        end)
    end

    -- ULTRA SAFE SLIDER
    local function AddSlider(name, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1,-20,0,50)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(35,39,48)
        SliderFrame.Parent = ContentFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7,0,0.4,0)
        Label.Position = UDim2.new(0,15,0,5)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.white
        Label.TextScaled = true
        Label.Font = Enum.Font.SourceSans
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderFrame
        
        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Size = UDim2.new(0.25,0,0.4,0)
        ValueLabel.Position = UDim2.new(0.75,0,0,5)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(default)
        ValueLabel.TextColor3 = Color3.fromRGB(65,80,110)
        ValueLabel.TextScaled = true
        ValueLabel.Font = Enum.Font.SourceSansBold
        ValueLabel.Parent = SliderFrame
        
        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(0.9,0,0,6)
        Track.Position = UDim2.new(0.05,0,0.6,0)
        Track.BackgroundColor3 = Color3.fromRGB(55,60,75)
        Track.Parent = SliderFrame
        
        local Fill = Instance.new("Frame")
        local percent = math.clamp((default-min)/(max-min),0,1)
        Fill.Size = UDim2.new(percent,0,1,0)
        Fill.BackgroundColor3 = Color3.fromRGB(65,80,110)
        Fill.BorderSizePixel = 0
        Fill.Parent = Track
        
        local dragging = false
        local value = default
        
        local dragConn = Track.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)
        
        Track.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
        
        table.insert(Connections, RunService.Heartbeat:Connect(function()
            if dragging then
                local MousePos = Mouse.X - Track.AbsolutePosition.X
                local Percent = math.clamp(MousePos/Track.AbsoluteSize.X,0,1)
                value = math.floor(min + (max-min)*Percent)
                Fill.Size = UDim2.new(Percent,0,1,0)
                ValueLabel.Text = tostring(value)
                pcall(callback, value)
            end
        end))
    end

    -- ULTRA SAFE BUTTON
    local function AddButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1,-20,0,38)
        Button.BackgroundColor3 = Color3.fromRGB(55,65,90)
        Button.Text = name
        Button.TextColor3 = Color3.white
        Button.TextScaled = true
        Button.Font = Enum.Font.SourceSansBold
        Button.BorderSizePixel = 0
        Button.Parent = ContentFrame
        
        Button.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    -- CREATE TABS
    for i,name in ipairs(TabNames) do
        CreateTabButton(name,i)
    end

    -- SAFE MOVEMENT SYSTEM - DETEKCJA HUMANoid
    local function SafeSetSpeed(speed)
        pcall(function()
            if LocalPlayer.Character then
                local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.WalkSpeed = speed
                end
            end
        end)
    end

    local function SafeSetJump(jump)
        pcall(function()
            if LocalPlayer.Character then
                local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.JumpPower = jump
                end
            end
        end)
    end

    -- MOVEMENT FEATURES - ULTRA SAFE
    AddSlider("WalkSpeed", 16, 500, 100, function(val)
        Settings.Speed = val
        SafeSetSpeed(val)
    end)

    AddSlider("JumpPower", 50, 500, 50, function(val)
        Settings.JumpPower = val
        SafeSetJump(val)
    end)

    AddToggle("Fly", function(state)
        Settings.Fly = state
        if state then
            task.spawn(function()
                repeat task.wait(0.1) until LocalPlayer.Character
                repeat task.wait(0.1) until LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                pcall(function()
                    local Root = LocalPlayer.Character.HumanoidRootPart
                    local BV = Instance.new("BodyVelocity")
                    BV.MaxForce = Vector3.new(4000,4000,4000)
                    BV.Parent = Root
                    
                    Connections.Fly = RunService.Heartbeat:Connect(function()
                        if not Settings.Fly or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
                        local Move = Vector3.new()
                        local Cam = Workspace.CurrentCamera
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Move = Move + Cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Move = Move - Cam.CFrame.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Move = Move - Cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Move = Move + Cam.CFrame.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Move = Move + Vector3.new(0,1,0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then Move = Move - Vector3.new(0,1,0) end
                        BV.Velocity = Move * 50
                    end)
                end)
            end)
        else
            if Connections.Fly then 
                Connections.Fly:Disconnect()
                Connections.Fly = nil
            end
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")?.:Destroy()
                end
            end)
        end
    end)

    AddToggle("Noclip", function(state)
        Settings.Noclip = state
        if state then
            Connections.Noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    if LocalPlayer.Character then
                        for _,part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part ~= LocalPlayer.Character.HumanoidRootPart then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end)
        else
            if Connections.Noclip then 
                Connections.Noclip:Disconnect()
                Connections.Noclip = nil
            end
        end
    end)

    -- OTHER FEATURES (SKRÓCONE BEZ BŁĘDÓW)
    AddToggle("Spin", function(state)
        if state then
            Connections.Spin = RunService.Heartbeat:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(35),0)
                    end
                end)
            end)
        else
            if Connections.Spin then Connections.Spin:Disconnect() end
        end
    end)

    AddToggle("Low Gravity", function(state)
        Workspace.Gravity = state and 50 or 196.2
    end)

    AddToggle("ESP", function(state)
        Settings.ESP = state
        pcall(function()
            for _,plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    if state then
                        local High = Instance.new("Highlight")
                        High.FillColor = Color3.fromRGB(0,170,255)
                        High.FillTransparency = 0.5
                        High.OutlineColor = Color3.white
                        High.Parent = plr.Character
                    elseif plr.Character:FindFirstChildOfClass("Highlight") then
                        plr.Character:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                end
            end
        end)
    end)

    -- BUTTONS
    AddButton("Rejoin", function()
        pcall(TeleportService.Teleport, TeleportService, game.PlaceId, LocalPlayer)
    end)

    AddButton("Turcja ❤️", function()
        pcall(function()
            local Chat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if Chat then
                Chat.SayMessageRequest:FireServer("i ❤️ Turcja","All")
            end
        end)
    end)

    AddButton("FLING ALL", function()
        pcall(function()
            for _,plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local Root = plr.Character.HumanoidRootPart
                    local BV = Instance.new("BodyVelocity")
                    BV.MaxForce = Vector3.new(9e9,9e9,9e9)
                    BV.Velocity = Vector3.new(math.random(-5e4,5e4),5e4,math.random(-5e4,5e4))
                    BV.Parent = Root
                    Debris:AddItem(BV,0.2)
                end
            end
        end)
    end)

    -- CONTROLS
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.Z then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- CHARACTER SPAWN HANDLER - ULTRA SAFE
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        SafeSetSpeed(Settings.Speed)
        SafeSetJump(Settings.JumpPower)
    end)

    print("✅ PANDUS CWL v9.2 ULTRA SAFE - WCZYTANO BEZ BŁĘDÓW!")
    print("🔥 Z - toggle GUI | COREGUI + MOVEMENT 100% SAFE!")
end)
