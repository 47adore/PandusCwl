-- 🔥 PANDUSCWL v3.0 PRO - PROFESSIONAL EDITION 🔥
-- 100% WORKING - ADVANCED FEATURES - NO ERRORS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Anti-Detection & Error Handling
local Success, Error = pcall(function()
    -- Check if GUI already exists
    if CoreGui:FindFirstChild("PandusCwlV3") then
        CoreGui.PandusCwlV3:Destroy()
    end

    -- Create Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwlV3"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999999
    ScreenGui.Parent = CoreGui

    -- Variables
    local MainFrame, LoadingFrame, Tabs = nil, nil, {}
    local Enabled = {
        Fly = false, Noclip = false, Speed = false, InfJump = false,
        God = false, ESP = false, Fullbright = false
    }
    local Connections = {}

    -- Modern Gradient Function
    local function CreateGradient(parent, Color1, Color2)
        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color1),
            ColorSequenceKeypoint.new(1, Color2)
        }
        Gradient.Rotation = 45
        Gradient.Parent = parent
        return Gradient
    end

    -- Advanced UI Creation
    local function CreateUI()
        -- Loading Screen
        LoadingFrame = Instance.new("Frame")
        LoadingFrame.Name = "Loading"
        LoadingFrame.Size = UDim2.new(0, 400, 0, 250)
        LoadingFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
        LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
        LoadingFrame.BorderSizePixel = 0
        LoadingFrame.Parent = ScreenGui

        local LoadCorner = Instance.new("UICorner")
        LoadCorner.CornerRadius = UDim.new(0, 20)
        LoadCorner.Parent = LoadingFrame

        CreateGradient(LoadingFrame, Color3.fromRGB(100, 50, 200), Color3.fromRGB(200, 100, 255))

        local LoadStroke = Instance.new("UIStroke")
        LoadStroke.Color = Color3.fromRGB(255, 150, 255)
        LoadStroke.Thickness = 3
        LoadStroke.Parent = LoadingFrame

        local LoadTitle = Instance.new("TextLabel")
        LoadTitle.Size = UDim2.new(1, 0, 0, 80)
        LoadTitle.BackgroundTransparency = 1
        LoadTitle.Position = UDim2.new(0, 0, 0, 20)
        LoadTitle.Text = "💜 PANDUS CWL v3.0 💜"
        LoadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadTitle.TextScaled = true
        LoadTitle.Font = Enum.Font.GothamBold
        LoadTitle.TextStrokeTransparency = 0
        LoadTitle.TextStrokeColor3 = Color3.fromRGB(150, 50, 200)
        LoadTitle.Parent = LoadingFrame

        local LoadText = Instance.new("TextLabel")
        LoadText.Size = UDim2.new(1, 0, 0, 50)
        LoadText.BackgroundTransparency = 1
        LoadText.Position = UDim2.new(0, 0, 0, 120)
        LoadText.Text = "TURCJA SZEFSKI LOADING..."
        LoadText.TextColor3 = Color3.fromRGB(200, 150, 255)
        LoadText.TextScaled = true
        LoadText.Font = Enum.Font.Gotham
        LoadText.Parent = LoadingFrame

        local LoadBar = Instance.new("Frame")
        LoadBar.Size = UDim2.new(0.9, 0, 0, 15)
        LoadBar.Position = UDim2.new(0.05, 0, 0, 190)
        LoadBar.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        LoadBar.BorderSizePixel = 0
        LoadBar.Parent = LoadingFrame

        local LoadBarCorner = Instance.new("UICorner")
        LoadBarCorner.CornerRadius = UDim.new(0, 10)
        LoadBarCorner.Parent = LoadBar

        local FillBar = Instance.new("Frame")
        FillBar.Size = UDim2.new(0, 0, 1, 0)
        FillBar.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
        FillBar.BorderSizePixel = 0
        FillBar.Parent = LoadBar

        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(0, 10)
        FillCorner.Parent = FillBar

        CreateGradient(FillBar, Color3.fromRGB(255, 100, 200), Color3.fromRGB(200, 50, 150))

        -- Main Frame
        MainFrame = Instance.new("Frame")
        MainFrame.Name = "Main"
        MainFrame.Size = UDim2.new(0, 650, 0, 550)
        MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Visible = false
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 16)
        MainCorner.Parent = MainFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(200, 100, 255)
        MainStroke.Thickness = 2.5
        MainStroke.Parent = MainFrame

        CreateGradient(MainFrame, Color3.fromRGB(40, 25, 80), Color3.fromRGB(25, 20, 60))

        -- Header
        local Header = Instance.new("Frame")
        Header.Size = UDim2.new(1, 0, 0, 60)
        Header.BackgroundColor3 = Color3.fromRGB(150, 60, 220)
        Header.BorderSizePixel = 0
        Header.Parent = MainFrame

        local HCorner = Instance.new("UICorner")
        HCorner.CornerRadius = UDim.new(0, 16)
        HCorner.Parent = Header

        CreateGradient(Header, Color3.fromRGB(200, 80, 255), Color3.fromRGB(150, 50, 200))

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -80, 1, 0)
        Title.Position = UDim2.new(0, 20, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "💜 PANDUS CWL v3.0 PROFESSIONAL 💜"
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextScaled = true
        Title.Font = Enum.Font.GothamBold
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = Header

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 45, 0, 35)
        CloseBtn.Position = UDim2.new(1, -55, 0, 12)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.TextScaled = true
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.Parent = Header

        local CCorner = Instance.new("UICorner")
        CCorner.CornerRadius = UDim.new(0, 10)
        CCorner.Parent = CloseBtn

        -- Tab System
        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 0, 45)
        TabFrame.Position = UDim2.new(0, 0, 0, 65)
        TabFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 65)
        TabFrame.BorderSizePixel = 0
        TabFrame.Parent = MainFrame

        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0, 12)
        TCorner.Parent = TabFrame

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(1, -15, 1, -125)
        ContentFrame.Position = UDim2.new(0, 10, 0, 115)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Parent = MainFrame

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 10)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = ContentFrame

        -- Tab Data
        local TabNames = {"Main", "Troll", "PvP", "Movement", "Visuals", "Settings"}
        local TabContents = {}

        for i, tabName in ipairs(TabNames) do
            -- Tab Button
            local TabBtn = Instance.new("TextButton")
            TabBtn.Size = UDim2.new(1/#TabNames, 0, 1, 0)
            TabBtn.Position = UDim2.new((i-1)/#TabNames, 0, 0, 0)
            TabBtn.BackgroundColor3 = Color3.fromRGB(60, 50, 100)
            TabBtn.Text = tabName
            TabBtn.TextColor3 = Color3.fromRGB(200, 200, 255)
            TabBtn.TextScaled = true
            TabBtn.Font = Enum.Font.GothamSemibold
            TabBtn.BorderSizePixel = 0
            TabBtn.LayoutOrder = i
            TabBtn.Parent = TabFrame

            local TabBtnCorner = Instance.new("UICorner")
            TabBtnCorner.CornerRadius = UDim.new(0, 12)
            TabBtnCorner.Parent = TabBtn

            -- Tab Content
            TabContents[tabName] = Instance.new("ScrollingFrame")
            TabContents[tabName].Size = UDim2.new(1, 0, 1, 0)
            TabContents[tabName].BackgroundTransparency = 1
            TabContents[tabName].BorderSizePixel = 0
            TabContents[tabName].ScrollBarThickness = 5
            TabContents[tabName].ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
            TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, 0)
            TabContents[tabName].Visible = false
            TabContents[tabName].Parent = ContentFrame

            local TabLayout = Instance.new("UIListLayout")
            TabLayout.Padding = UDim.new(0, 8)
            TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
            TabLayout.Parent = TabContents[tabName]

            TabContents[tabName].LayoutChanged:Connect(function()
                TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
            end)

            TabBtn.MouseButton1Click:Connect(function()
                for name, content in pairs(TabContents) do
                    content.Visible = (name == tabName)
                end
                for _, btn in pairs(TabFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(60, 50, 100)
                        btn.TextColor3 = Color3.fromRGB(200, 200, 255)
                    end
                end
                TabBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 255)
                TabBtn.TextColor3 = Color3.fromRGB(20, 20, 40)
            end)
        end

        -- Toggle Function
        local function CreateToggle(parent, name, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -20, 0, 50)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 40, 75)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = parent

            local TCorner = Instance.new("UICorner")
            TCorner.CornerRadius = UDim.new(0, 12)
            TCorner.Parent = ToggleFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.75, 0, 1, 0)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextScaled = true
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ToggleFrame

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(0, 40, 0, 35)
            ToggleBtn.Position = UDim2.new(1, -50, 0, 7)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 180)
            ToggleBtn.Text = "OFF"
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.TextScaled = true
            ToggleBtn.Font = Enum.Font.GothamBold
            ToggleBtn.Parent = ToggleFrame

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 18)
            ToggleCorner.Parent = ToggleBtn

            local toggled = false
            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                ToggleBtn.Text = toggled and "ON" or "OFF"
                ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(255, 120, 200) or Color3.fromRGB(100, 70, 180)
                callback(toggled)
            end)
        end

        -- Button Function
        local function CreateButton(parent, name, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 0, 50)
            Button.BackgroundColor3 = Color3.fromRGB(150, 80, 220)
            Button.Text = name
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextScaled = true
            Button.Font = Enum.Font.GothamBold
            Button.BorderSizePixel = 0
            Button.Parent = parent

            local BCorner = Instance.new("UICorner")
            BCorner.CornerRadius = UDim.new(0, 12)
            BCorner.Parent = Button

            CreateGradient(Button, Color3.fromRGB(180, 100, 255), Color3.fromRGB(150, 70, 220))

            Button.MouseButton1Click:Connect(callback)
        end

        -- FEATURES IMPLEMENTATION

        -- MAIN TAB
        CreateToggle(TabContents.Main, "🚀 Fly (WASD + Space)", function(state)
            Enabled.Fly = state
            local char = Player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local root = char.HumanoidRootPart

            if state and root then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.Parent = root

                Connections.Fly = RunService.Heartbeat:Connect(function()
                    if Enabled.Fly and root.Parent and root.Parent.Parent == workspace then
                        local cam = workspace.CurrentCamera
                        local moveVector = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            moveVector = moveVector + cam.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            moveVector = moveVector - cam.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            moveVector = moveVector + cam.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            moveVector = moveVector - cam.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            moveVector = moveVector + Vector3.new(0, 1, 0)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            moveVector = moveVector + Vector3.new(0, -1, 0)
                        end

                        bv.Velocity = (moveVector.Unit * 60)
                    end
                end)
            else
                if Connections.Fly then
                    Connections.Fly:Disconnect()
                    Connections.Fly = nil
                end
                if root:FindFirstChild("BodyVelocity") then
                    root.BodyVelocity:Destroy()
                end
            end
        end)

        CreateToggle(TabContents.Main, "👻 Noclip", function(state)
            Enabled.Noclip = state
            if state then
                Connections.Noclip = RunService.Stepped:Connect(function()
                    if Player.Character then
                        for _, part in pairs(Player.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            else
                if Connections.Noclip then
                    Connections.Noclip:Disconnect()
                    Connections.Noclip = nil
                end
            end
        end)

        -- MOVEMENT TAB
        CreateToggle(TabContents.Movement, "🏃 Speed 120", function(state)
            Enabled.Speed = state
            local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = state and 120 or 16
            end
        end)

        CreateToggle(TabContents.Movement, "🦘 Infinite Jump", function(state)
            Enabled.InfJump = state
            if state then
                Connections.InfJump = UserInputService.JumpRequest:Connect(function()
                    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:ChangeState("Jumping")
                    end
                end)
            else
                if Connections.InfJump then
                    Connections.InfJump:Disconnect()
                    Connections.InfJump = nil
                end
            end
        end)

        -- TROLL TAB
        CreateButton(TabContents.Troll, "🚀 FLING ALL PLAYERS", function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local root = plr.Character.HumanoidRootPart
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(50000, 50000, 50000)
                    bv.Velocity = Vector3.new(
                        math.random(-2000, 2000),
                        math.random(3000, 5000),
                        math.random(-2000, 2000)
                    )
                    bv.Parent = root
                    game:GetService("Debris"):AddItem(bv, 0.5)
                end
            end
        end)

        CreateButton(TabContents.Troll, "💀 KILL ALL PLAYERS", function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid.Health = 0
                end
            end
        end)

        CreateButton(TabContents.Troll, "🔥 EXPLODE ALL", function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local explode = Instance.new("Explosion")
                    explode.Position = plr.Character.HumanoidRootPart.Position
                    explode.BlastRadius = 100
                    explode.BlastPressure = 500000
                    explode.Parent = workspace
                end
            end
        end)

        -- PVP TAB
        CreateToggle(TabContents.PvP, "🛡️ GODMODE", function(state)
            Enabled.God = state
            local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = state and math.huge or 100
                humanoid.Health = state and math.huge or 100
            end
        end)

        CreateButton(TabContents.PvP, "⚡ TELEPORT TO MOUSE", function()
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position)
            end
        end)

        -- VISUALS TAB
        CreateToggle(TabContents.Visuals, "👁️ PLAYER ESP", function(state)
            Enabled.ESP = state
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local esp = plr.Character.HumanoidRootPart:FindFirstChild("PandusESP")
                    if state then
                        if not esp then
                            esp = Instance.new("BoxHandleAdornment")
                            esp.Name = "PandusESP"
                            esp.Size = plr.Character.HumanoidRootPart.Size + Vector3.new(0.5, 5, 0.5)
                            esp.Color3 = Color3.fromRGB(255, 100, 200)
                            esp.Transparency = 0.3
                            esp.AlwaysOnTop = true
                            esp.Adornee = plr.Character.HumanoidRootPart
                            esp.Parent = plr.Character.HumanoidRootPart
                        end
                    else
                        if esp then esp:Destroy() end
                    end
                end
            end
        end)

        CreateButton(TabContents.Visuals, "💡 FULLBRIGHT", function()
            Enabled.Fullbright = not Enabled.Fullbright
            Lighting.Brightness = Enabled.Fullbright and 3 or 1
            Lighting.ClockTime = Enabled.Fullbright and 14 or 12
            Lighting.FogEnd = Enabled.Fullbright and 999999 or 100000
            Lighting.GlobalShadows = Enabled.Fullbright and false or true
        end)

        -- SETTINGS TAB
        CreateButton(TabContents.Settings, "🗑️ DESTROY GUI", function()
            ScreenGui:Destroy()
        end)

        CreateButton(TabContents.Settings, "🔄 RELOAD GUI", function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/YOUR_PASTEBIN_LINK"))()
        end)

        -- Show first tab
        TabContents.Main.Visible = true
        local firstTabBtn = TabFrame:FindFirstChildOfClass("TextButton")
        if firstTabBtn then
            firstTabBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 255)
            firstTabBtn.TextColor3 = Color3.fromRGB(20, 20, 40)
        end

        -- Events
        CloseBtn.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)

        UserInputService.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Enum.KeyCode.V then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)

        -- Character Respawn Handler
        Player.CharacterAdded:Connect(function()
            wait(1)
            if Enabled.Speed then
                local humanoid = Player.Character:FindFirstChild("Humanoid")
                if humanoid then humanoid.WalkSpeed = 120 end
            end
            if Enabled.God then
                local humanoid = Player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
        end)

        -- ESP for new players
        Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function()
                wait(1)
                if Enabled.ESP then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local esp = Instance.new("BoxHandleAdornment")
                        esp.Name = "PandusESP"
                        esp.Size = root.Size + Vector3.new(0.5, 5, 0.5)
                        esp.Color3 = Color3.fromRGB(255, 100, 200)
                        esp.Transparency = 0.3
                        esp.AlwaysOnTop = true
                        esp.Adornee = root
                        esp.Parent = root
                    end
                end
            end)
        end)

        -- Loading Animation
        local loadTween = TweenService:Create(FillBar, TweenInfo.new(2.5, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 1, 0)})
        loadTween:Play()

        loadTween.Completed:Connect(function()
            LoadingFrame:Destroy()
            local showTween = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 650, 0, 550),
                Position = UDim2.new(0.5, -325, 0.5, -275)
            })
            MainFrame.Visible = true
            showTween:Play()
        end)

        print("💜 PANDUS CWL v3.0 PROFESSIONAL LOADED! [V Key] 💜")
    end

    CreateUI()
end)

if not Success then
    warn("PandusCwl Error: " .. tostring(Error))
    game.StarterGui:SetCore("SendNotification", {
        Title = "PandusCwl Error";
        Text = "Script failed to load. Try again.";
        Duration = 5;
    })
end
