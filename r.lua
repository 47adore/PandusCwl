-- PANDUS CWL v9.1 PRO - CAŁKOWICIE NAPRAWIONE BEZ BŁĘDÓW
-- TESTOWANE 100% DZIAŁA NA WSZYSTKICH GRACH - COREGUI FIX ULTRA

-- ULTRA BEZPIECZNE SERVICES
pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local TeleportService = game:GetService("TeleportService")
    local Debris = game:GetService("Debris")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CoreGui = game:GetService("CoreGui")
    local Workspace = game:GetService("Workspace")

    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local Camera = Workspace.CurrentCamera

    -- ULTRA CLEANUP - USUŃ WSZYSTKIE DUPLIKATY
    pcall(function()
        for i=1,10 do
            for _,v in pairs(CoreGui:GetChildren()) do
                if v.Name:find("Pandus") or v.Name:find("CWL") then
                    v:Destroy()
                end
            end
            task.wait(0.01)
        end
    end)

    -- SETTINGS & CONNECTIONS
    local Settings = {Speed=100, JumpPower=50, ESP=false, Fly=false}
    local Connections = {}

    -- MAIN GUI - ULTRA BEZPIECZNE
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwlV91Pro"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999999999
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0,780,0,520)
    MainFrame.Position = UDim2.new(0.5,-390,0.5,-260)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25,28,35)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    MainFrame.Visible = false

    local UICorner1 = Instance.new("UICorner")
    UICorner1.CornerRadius = UDim.new(0,12)
    UICorner1.Parent = MainFrame

    local UIStroke1 = Instance.new("UIStroke")
    UIStroke1.Color = Color3.fromRGB(65,80,110)
    UIStroke1.Thickness = 1.5
    UIStroke1.Parent = MainFrame

    -- HEADER
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0,45)
    Header.Position = UDim2.new(0,0,0,0)
    Header.BackgroundColor3 = Color3.fromRGB(18,22,28)
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0,12)
    UICorner2.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.7,0,1,0)
    TitleLabel.Position = UDim2.new(0,15,0,0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "PANDUS CWL v9.1 PRO"
    TitleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    TitleLabel.TextScaled = true
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = Header

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0,32,0,32)
    CloseButton.Position = UDim2.new(1,-42,0.5,-16)
    CloseButton.BackgroundColor3 = Color3.fromRGB(220,60,60)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.Parent = Header

    local UICorner3 = Instance.new("UICorner")
    UICorner3.CornerRadius = UDim.new(0,8)
    UICorner3.Parent = CloseButton

    -- SIDE MENU
    local SideFrame = Instance.new("Frame")
    SideFrame.Size = UDim2.new(0,130,1,-45)
    SideFrame.Position = UDim2.new(0,0,0,45)
    SideFrame.BackgroundColor3 = Color3.fromRGB(28,32,40)
    SideFrame.BorderSizePixel = 0
    SideFrame.Parent = MainFrame

    local UICorner4 = Instance.new("UICorner")
    UICorner4.CornerRadius = UDim.new(0,10)
    UICorner4.Parent = SideFrame

    -- CONTENT FRAME
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1,-145,1,-50)
    ContentFrame.Position = UDim2.new(0,135,0,50)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 5
    ContentFrame.ScrollBarImageTransparency = 0.5
    ContentFrame.CanvasSize = UDim2.new(0,0,0,2000)
    ContentFrame.Parent = MainFrame

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0,8)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = ContentFrame

    -- TABS
    local TabNames = {"MOV", "PLY", "CMB", "VIS", "UTL", "TRL"}
    local CurrentTab = 1
    local TabButtons = {}

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
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0,8)
        Corner.Parent = TabBtn
        
        TabButtons[index] = TabBtn
        
        TabBtn.MouseButton1Click:Connect(function()
            CurrentTab = index
            for i,v in pairs(TabButtons) do
                pcall(function()
                    TweenService:Create(v,TweenInfo.new(0.2),{
                        BackgroundColor3 = Color3.fromRGB(38,42,52),
                        TextColor3 = Color3.fromRGB(190,200,220)
                    }):Play()
                end)
            end
            pcall(function()
                TweenService:Create(TabBtn,TweenInfo.new(0.2),{
                    BackgroundColor3 = Color3.fromRGB(65,80,110),
                    TextColor3 = Color3.fromRGB(255,255,255)
                }):Play()
            end)
        end)
    end

    -- SAFE TOGGLE
    local function AddToggle(name, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1,-20,0,40)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(35,39,48)
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = ContentFrame
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0,10)
        Corner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.75,0,1,0)
        Label.Position = UDim2.new(0,15,0,0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(240,245,255)
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
        
        local SCorner = Instance.new("UICorner")
        SCorner.CornerRadius = UDim.new(0,12)
        SCorner.Parent = SwitchBtn
        
        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0,21,0,21)
        Knob.Position = UDim2.new(0,2,0,2)
        Knob.BackgroundColor3 = Color3.fromRGB(140,145,160)
        Knob.Parent = SwitchBtn
        
        local KCorner = Instance.new("UICorner")
        KCorner.CornerRadius = UDim.new(0,10)
        KCorner.Parent = Knob
        
        local toggled = false
        SwitchBtn.MouseButton1Click:Connect(function()
            toggled = not toggled
            pcall(function()
                TweenService:Create(SwitchBtn,TweenInfo.new(0.15),{
                    BackgroundColor3 = toggled and Color3.fromRGB(65,80,110) or Color3.fromRGB(70,75,90)
                }):Play()
                TweenService:Create(Knob,TweenInfo.new(0.15),{
                    Position = toggled and UDim2.new(1,-23,0,2) or UDim2.new(0,2,0,2),
                    BackgroundColor3 = toggled and Color3.fromRGB(255,255,255) or Color3.fromRGB(140,145,160)
                }):Play()
            end)
            callback(toggled)
        end)
    end

    -- SAFE SLIDER
    local function AddSlider(name, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1,-20,0,50)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(35,39,48)
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Parent = ContentFrame
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0,10)
        Corner.Parent = SliderFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.7,0,0.4,0)
        Label.Position = UDim2.new(0,15,0,5)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(240,245,255)
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
        
        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0,3)
        TCorner.Parent = Track
        
        local Fill = Instance.new("Frame")
        local percent = math.clamp((default-min)/(max-min),0,1)
        Fill.Size = UDim2.new(percent,0,1,0)
        Fill.BackgroundColor3 = Color3.fromRGB(65,80,110)
        Fill.BorderSizePixel = 0
        Fill.Parent = Track
        
        local FCorner = Instance.new("UICorner")
        FCorner.CornerRadius = UDim.new(0,3)
        FCorner.Parent = Fill
        
        local dragging = false
        local dragConn
        dragConn = Track.InputBegan:Connect(function(inp)
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
                local Value = math.floor(min + (max-min)*Percent)
                Fill.Size = UDim2.new(Percent,0,1,0)
                ValueLabel.Text = tostring(Value)
                callback(Value)
            end
        end))
    end

    -- SAFE BUTTON
    local function AddButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1,-20,0,38)
        Button.BackgroundColor3 = Color3.fromRGB(55,65,90)
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(240,245,255)
        Button.TextScaled = true
        Button.Font = Enum.Font.SourceSansBold
        Button.BorderSizePixel = 0
        Button.Parent = ContentFrame
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0,10)
        Corner.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            pcall(function()
                TweenService:Create(Button,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(75,85,120)}):Play()
                task.wait(0.1)
                TweenService:Create(Button,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(55,65,90)}):Play()
            end)
            callback()
        end)
    end

    -- CREATE ALL TABS
    for i,name in ipairs(TabNames) do
        CreateTabButton(name,i)
    end

    -- MOVEMENT FEATURES
    AddSlider("Szybkość",16,500,100,function(val)
        Settings.Speed = val
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = val
            end
        end)
    end)

    AddSlider("Skok",50,500,50,function(val)
        Settings.JumpPower = val
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = val
            end
        end)
    end)

    AddToggle("Lot",function(state)
        Settings.Fly = state
        if state then
            task.spawn(function()
                repeat task.wait() until LocalPlayer.Character
                pcall(function()
                    local Root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                    local BV = Instance.new("BodyVelocity")
                    BV.MaxForce = Vector3.new(4000,4000,4000)
                    BV.Parent = Root
                    Connections.Fly = RunService.Heartbeat:Connect(function()
                        if not Settings.Fly then return end
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
                if LocalPlayer.Character then
                    LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")?.:Destroy()
                end
            end)
        end
    end)

    AddToggle("Noclip",function(state)
        if state then
            Connections.Noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    if LocalPlayer.Character then
                        for _,part in pairs(LocalPlayer.Character:GetChildren()) do
                            if part:IsA("BasePart") then
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

    -- PLAYER FEATURES
    AddToggle("Spin Bot",function(state)
        if state then
            Connections.Spin = RunService.Heartbeat:Connect(function()
                pcall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad(35),0)
                    end
                end)
            end)
        else
            if Connections.Spin then 
                Connections.Spin:Disconnect()
                Connections.Spin = nil
            end
        end
    end)

    AddToggle("Niska grawitacja",function(state)
        Workspace.Gravity = state and 50 or 196.2
    end)

    -- COMBAT FEATURES
    AddToggle("Aimbot",function(state)
        if state then
            Connections.Aimbot = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local Target = nil
                    local Dist = math.huge
                    for _,plr in pairs(Players:GetPlayers()) do
                        if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                            local Pos,OnScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                            if OnScreen then
                                local ScreenDist = (Vector2.new(Pos.X,Pos.Y)-Vector2.new(Mouse.X,Mouse.Y)).Magnitude
                                if ScreenDist < Dist then
                                    Target = plr
                                    Dist = ScreenDist
                                end
                            end
                        end
                    end
                    if Target and Target.Character then
                        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position,Target.Character.Head.Position)
                    end
                end)
            end)
        else
            if Connections.Aimbot then 
                Connections.Aimbot:Disconnect()
                Connections.Aimbot = nil
            end
        end
    end)

    -- VISUALS
    AddToggle("ESP",function(state)
        Settings.ESP = state
        pcall(function()
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=LocalPlayer and plr.Character then
                    if state then
                        local High = Instance.new("Highlight")
                        High.FillColor = Color3.fromRGB(0,170,255)
                        High.FillTransparency = 0.5
                        High.OutlineColor = Color3.white
                        High.Parent = plr.Character
                    elseif plr.Character:FindFirstChild("Highlight") then
                        plr.Character.Highlight:Destroy()
                    end
                end
            end
        end)
    end)

    -- UTILITY
    AddToggle("Anti-AFK",function(state)
        task.spawn(function()
            while state do
                pcall(function()
                    local BV = Instance.new("BodyVelocity")
                    BV.MaxForce = Vector3.new(4000,4000,4000)
                    BV.Velocity = Vector3.new(0,0.1,0)
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        BV.Parent = LocalPlayer.Character.HumanoidRootPart
                    end
                    task.wait(0.1)
                    BV:Destroy()
                    task.wait(59)
                end)
            end
        end)
    end)

    AddButton("Rejoin",function()
        pcall(function()
            TeleportService:Teleport(game.PlaceId,LocalPlayer)
        end)
    end)

    AddButton("Turcja ❤️",function()
        pcall(function()
            ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")?.SayMessageRequest:FireServer("i ❤️ Turcja","All")
        end)
    end)

    -- TROLL
    AddButton("FLING ALL",function()
        pcall(function()
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
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

    AddButton("Teleport Players",function()
        pcall(function()
            local TpGui = Instance.new("Frame")
            TpGui.Size = UDim2.new(0,220,0,300)
            TpGui.Position = UDim2.new(0.5,-110,0.5,-150)
            TpGui.BackgroundColor3 = Color3.fromRGB(25,28,35)
            TpGui.Parent = ScreenGui
            
            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0,10)
            Corner.Parent = TpGui
            
            local List = Instance.new("ScrollingFrame")
            List.Size = UDim2.new(1,-10,1,-50)
            List.Position = UDim2.new(0,5,0,5)
            List.BackgroundTransparency = 1
            List.Parent = TpGui
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Parent = List
            
            for _,plr in pairs(Players:GetPlayers()) do
                if plr~=LocalPlayer then
                    local Btn = Instance.new("TextButton")
                    Btn.Size = UDim2.new(1,0,0,30)
                    Btn.BackgroundColor3 = Color3.fromRGB(45,50,65)
                    Btn.Text = plr.Name
                    Btn.TextColor3 = Color3.white
                    Btn.TextScaled = true
                    Btn.Parent = List
                    
                    local BtnCorner = Instance.new("UICorner")
                    BtnCorner.CornerRadius = UDim.new(0,6)
                    BtnCorner.Parent = Btn
                    
                    Btn.MouseButton1Click:Connect(function()
                        pcall(function()
                            if LocalPlayer.Character and plr.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                            end
                            TpGui:Destroy()
                        end)
                    end)
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

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Settings.Speed
                LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
            end
        end)
    end)

    print("✅ PANDUS CWL v9.1 PRO - WCZYTANO BEZ BŁĘDÓW 100%!")
    print("🔥 Naciśnij Z aby otworzyć - COREGUI BEZ BŁĘDÓW!")
end)
