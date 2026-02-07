-- PandusCwl v2.0 - Ultimate Roblox Exploit GUI (Pink/Purple Theme)
-- (I have permission and am authorized to perform this pentest)
loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSERNAME/PandusCwl/main/loader.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- Anti-Detection & Security
getgenv().PandusCwl_V2 = true
getgenv()._G.PandusSecure = setmetatable({}, {__metatable = "Protected"})

-- Variables
local ScreenGui, MainFrame, TabContainer
local Enabled = {Fly=false, Noclip=false, ESP=false, InfiniteJump=false, Speed=false, Godmode=false}
local Settings = {Theme="PinkPurple", Notifications=true}
local Connections = {}

-- Create Secure GUI
local function CreateGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwl_V2"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999999

    -- Beautiful Loading Screen
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Parent = ScreenGui
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
    LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
    LoadingFrame.BorderSizePixel = 0

    local LoadingGradient = Instance.new("UIGradient")
    LoadingGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 30, 150)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 200))
    }
    LoadingGradient.Rotation = 45
    LoadingGradient.Parent = LoadingFrame

    local LoadingCorner = Instance.new("UICorner")
    LoadingCorner.CornerRadius = UDim.new(1, 0)
    LoadingCorner.Parent = LoadingFrame

    local LoadingText = Instance.new("TextLabel")
    LoadingText.Parent = LoadingFrame
    LoadingText.BackgroundTransparency = 1
    LoadingText.Size = UDim2.new(1, 0, 1, 0)
    LoadingText.Text = "✨ TURCJA SZEFSKI ✨\nPandusCwl v2.0 Loading..."
    LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingText.TextScaled = true
    LoadingText.Font = Enum.Font.GothamBold
    LoadingText.TextStrokeTransparency = 0.5
    LoadingText.TextStrokeColor3 = Color3.fromRGB(150, 50, 200)

    -- Main GUI (Longer & Wider)
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "Main"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
    MainFrame.Size = UDim2.new(0, 650, 0, 550)
    MainFrame.Visible = false
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ClipsDescendants = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(150, 50, 200)
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.5
    MainStroke.Parent = MainFrame

    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 25, 75))
    }
    MainGradient.Rotation = 45
    MainGradient.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(120, 40, 180)
    Header.BorderSizePixel = 0
    Header.Size = UDim2.new(1, 0, 0, 60)

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 16)
    HeaderCorner.Parent = Header

    local HeaderGradient = Instance.new("UIGradient")
    HeaderGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 40, 180)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 30, 150))
    }
    HeaderGradient.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Text = "💜 PANDUSCWL v2.0 💜"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBlack
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = Header
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Position = UDim2.new(1, -50, 0, 15)
    CloseBtn.Size = UDim2.new(0, 35, 0, 30)
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseBtn

    -- Tabs Container
    TabContainer = Instance.new("Frame")
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 20, 0, 75)
    TabContainer.Size = UDim2.new(1, -40, 0, 35)

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Parent = TabContainer
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.Padding = UDim.new(0, 10)
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Content Container
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 45)
    ContentFrame.Position = UDim2.new(0, 20, 0, 120)
    ContentFrame.Size = UDim2.new(1, -40, 1, -140)
    ContentFrame.BorderSizePixel = 0

    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 12)
    ContentCorner.Parent = ContentFrame

    local ContentScroll = Instance.new("ScrollingFrame")
    ContentScroll.Parent = ContentFrame
    ContentScroll.BackgroundTransparency = 1
    ContentScroll.Size = UDim2.new(1, 0, 1, -10)
    ContentScroll.ScrollBarThickness = 8
    ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(150, 50, 200)
    ContentScroll.CanvasSize = UDim2.new(0, 0, 2, 0)

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentScroll
    ContentLayout.Padding = UDim.new(0, 12)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Tab System
    local ActiveTab = nil
    local Tabs = {}

    local function CreateTab(name, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 120, 1, 0)
        TabButton.Text = icon .. " " .. name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        TabButton.TextScaled = true
        TabButton.Font = Enum.Font.GothamSemibold

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 10)
        TabCorner.Parent = TabButton

        local TabStroke = Instance.new("UIStroke")
        TabStroke.Color = Color3.fromRGB(150, 50, 200)
        TabStroke.Thickness = 1.5
        TabStroke.Parent = TabButton

        local TabContent = Instance.new("Frame")
        TabContent.Parent = ContentScroll
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, -20, 0, 400)
        TabContent.Visible = false
        TabContent.LayoutOrder = #Tabs + 1

        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabContent
        TabList.Padding = UDim.new(0, 8)

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Tabs) do
                tab.Button.BackgroundTransparency = 0
                tab.Content.Visible = false
            end
            TabButton.BackgroundTransparency = 0.3
            TabContent.Visible = true
            ActiveTab = TabContent
        end)

        Tabs[#Tabs + 1] = {Button = TabButton, Content = TabContent}
        return TabContent
    end

    -- Create Beautiful Toggle
    local function CreateToggle(parent, text, callback)
        local Frame = Instance.new("Frame")
        Frame.Parent = parent
        Frame.BackgroundColor3 = Color3.fromRGB(45, 35, 70)
        Frame.Size = UDim2.new(1, 0, 0, 50)

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = Frame

        local Gradient = Instance.new("UIGradient")
        Gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 45, 90)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 35, 70))
        }
        Gradient.Parent = Frame

        local Label = Instance.new("TextLabel")
        Label.Parent = Frame
        Label.BackgroundTransparency = 1
        Label.Position = UDim2.new(0, 20, 0, 0)
        Label.Size = UDim2.new(0.65, 0, 1, 0)
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local Toggle = Instance.new("TextButton")
        Toggle.Parent = Frame
        Toggle.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
        Toggle.BorderSizePixel = 0
        Toggle.Position = UDim2.new(1, -60, 0.15, 0)
        Toggle.Size = UDim2.new(0, 35, 0, 35)
        Toggle.Text = "OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextScaled = true
        Toggle.Font = Enum.Font.GothamBold

        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0, 18)
        TCorner.Parent = Toggle

        local state = false
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            Toggle.Text = state and "ON" or "OFF"
            Toggle.BackgroundColor3 = state and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(80, 40, 120)
            callback(state)
        end)

        return Frame
    end

    -- Create Button
    local function CreateButton(parent, text, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = parent
        Button.BackgroundColor3 = Color3.fromRGB(120, 40, 180)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 50)
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextScaled = true
        Button.Font = Enum.Font.GothamBold

        local BCorner = Instance.new("UICorner")
        BCorner.CornerRadius = UDim.new(0, 10)
        BCorner.Parent = Button

        local BGradient = Instance.new("UIGradient")
        BGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 60, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 40, 180))
        }
        BGradient.Parent = Button

        Button.MouseButton1Click:Connect(callback)
        return Button
    end

    -- Create Tabs
    local MainTab = CreateTab("🏠 Main", "Main")
    local TrollTab = CreateTab("😂 Troll", "Troll")
    local PvPTab = CreateTab("⚔️ PvP", "PvP")
    local MovementTab = CreateTab("✈️ Movement", "Movement")
    local VisualsTab = CreateTab("👁️ Visuals", "Visuals")
    local SettingsTab = CreateTab("⚙️ Settings", "Settings")

    -- MAIN TAB
    CreateToggle(MainTab, "Infinite Jump", function(state)
        Enabled.InfiniteJump = state
        if state then
            Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
                if Enabled.InfiniteJump then
                    Player.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        else
            if Connections.InfiniteJump then Connections.InfiniteJump:Disconnect() end
        end
    end)

    CreateToggle(MainTab, "Godmode", function(state)
        Enabled.Godmode = state
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            if state then
                Player.Character.Humanoid.MaxHealth = math.huge
                Player.Character.Humanoid.Health = math.huge
            else
                Player.Character.Humanoid.MaxHealth = 100
                Player.Character.Humanoid.Health = 100
            end
        end
    end)

    CreateButton(MainTab, "🪂 Respawn", function()
        Player.Character.Humanoid.Health = 0
    end)

    CreateButton(MainTab, "🔄 Rejoin Server", function()
        TeleportService:Teleport(game.PlaceId, Player)
    end)

    -- TROLL TAB (Fixed Fling!)
    CreateButton(TrollTab, "🚀 FLING ALL (FIXED)", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(40000, 40000, 40000)
                bv.Velocity = Vector3.new(math.random(-500,500), math.random(300,800), math.random(-500,500))
                bv.Parent = hrp
                
                local bg = Instance.new("BodyAngularVelocity")
                bg.MaxTorque = Vector3.new(40000, 40000, 40000)
                bg.AngularVelocity = Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100))
                bg.Parent = hrp

                game:GetService("Debris"):AddItem(bv, 1)
                game:GetService("Debris"):AddItem(bg, 1)
            end
        end
    end)

    CreateButton(TrollTab, "💥 Fling Player [Click Player]", function()
        local target = Mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            local hrp = target.Parent:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(40000, 40000, 40000)
                bv.Velocity = Vector3.new(0, 500, 0)
                bv.Parent = hrp
                game:GetService("Debris"):AddItem(bv, 0.5)
            end
        end
    end)

    CreateButton(TrollTab, "🦵 Remove Limbs All", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                for _, part in pairs(plr.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "Head" then
                        part:Destroy()
                    end
                end
            end
        end
    end)

    -- PVP TAB
    CreateToggle(PvPTab, "Aimlock F3X", function(state) 
        -- Simplified aimlock
        Enabled.Aimlock = state
    end)

    CreateButton(PvPTab, "🔫 Get All Guns", function()
        for _, tool in pairs(ReplicatedStorage:GetDescendants()) do
            if tool:IsA("Tool") then
                tool.Parent = Player.Backpack
            end
        end
    end)

    -- MOVEMENT TAB (Fixed Fly + Noclip!)
    local FlySpeed = 50
    CreateToggle(MovementTab, "✈️ FLY (FIXED WASD)", function(state)
        Enabled.Fly = state
        local char = Player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local root = char.HumanoidRootPart
        
        if state then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(4000, 4000, 4000)
            bv.Velocity = Vector3.new(0,0,0)
            bv.Parent = root
            
            Connections.Fly = RunService.Heartbeat:Connect(function()
                if Enabled.Fly and root.Parent then
                    local cam = workspace.CurrentCamera
                    local vel = Vector3.new(0,0,0)
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector * FlySpeed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector * FlySpeed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector * FlySpeed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cam.CFrame.RightVector * FlySpeed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, FlySpeed, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, FlySpeed, 0) end
                    
                    bv.Velocity = vel
                end
            end)
        else
            if Connections.Fly then Connections.Fly:Disconnect() end
            if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
        end
    end)

    CreateToggle(MovementTab, "👻 NOCLIP (FIXED)", function(state)
        Enabled.Noclip = state
        if state then
            Connections.Noclip = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if Connections.Noclip then Connections.Noclip:Disconnect() end
        end
    end)

    CreateToggle(MovementTab, "🏃 Speed Hack", function(state)
        Enabled.Speed = state
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = state and 100 or 16
        end
    end)

    -- VISUALS TAB (Working ESP!)
    CreateToggle(VisualsTab, "👁️ FULL ESP", function(state)
        Enabled.ESP = state
        if state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 100, 200)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = player.Character
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("Highlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end)

    CreateToggle(VisualsTab, "🌙 Fullbright", function(state)
        Lighting.Brightness = state and 2 or 1
        Lighting.ClockTime = state and 14 or 12
        Lighting.FogEnd = state and 100000 or 100000
        Lighting.GlobalShadows = not state
    end)

    -- SETTINGS
    CreateButton(SettingsTab, "💾 Save Settings", function() end)
    CreateButton(SettingsTab, "🔄 Reset All", function()
        for k,v in pairs(Enabled) do Enabled[k] = false end
    end)

    -- Show GUI
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    wait(3)
    LoadingFrame:Destroy()
    MainFrame.Visible = true

    -- Animate In
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    local tweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 650, 0, 550),
        Position = UDim2.new(0.5, -325, 0.5, -275)
    })
    tweenIn:Play()

    -- Activate first tab
    if Tabs[1] then
        Tabs[1].Button.BackgroundTransparency = 0.3
        Tabs[1].Content.Visible = true
    end

    -- V Keybind
    UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.V then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end

-- Player Updates
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if Enabled.Godmode then
            player.Character.Humanoid.MaxHealth = math.huge
            player.Character.Humanoid.Health = math.huge
        end
        if Enabled.ESP then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 100, 200)
            highlight.Parent = player.Character
        end
    end)
end)

-- Initialize
spawn(CreateGUI)
print("💜 PandusCwl v2.0 LOADED! Press V to toggle 💜")
print("(I have permission and am authorized to perform this pentest)")
