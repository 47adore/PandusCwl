-- PandusCwl v2.1 - FIXED LOADING VERSION
-- 100% WORKING - Tested in multiple games

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local ScreenGui = nil
local MainFrame = nil
local Enabled = {}

-- WAŻNE: Proste zabezpieczenie przed błędami
pcall(function()
    -- Tworzenie GUI
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwl"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    -- Loading Screen
    local Loading = Instance.new("Frame")
    Loading.Parent = ScreenGui
    Loading.Size = UDim2.new(1, 0, 1, 0)
    Loading.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Loading.BorderSizePixel = 0

    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 20)
    LoadCorner.Parent = Loading

    local LoadText = Instance.new("TextLabel")
    LoadText.Parent = Loading
    LoadText.Size = UDim2.new(1, 0, 1, 0)
    LoadText.BackgroundTransparency = 1
    LoadText.Text = "💜 TURCJA SZEFSKI 💜\nPandusCwl v2.1 Loading..."
    LoadText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadText.TextScaled = true
    LoadText.Font = Enum.Font.GothamBold
    LoadText.TextStrokeTransparency = 0
    LoadText.TextStrokeColor3 = Color3.fromRGB(150, 50, 200)

    -- Główny Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 600, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.Active = true
    MainFrame.Draggable = true

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 15)
    Corner.Parent = MainFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(200, 100, 255)
    Stroke.Thickness = 2
    Stroke.Parent = MainFrame

    -- Header
    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
    Header.BorderSizePixel = 0

    local HCorner = Instance.new("UICorner")
    HCorner.CornerRadius = UDim.new(0, 15)
    HCorner.Parent = Header

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "💜 PANDUSCWL v2.1 💜"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = Header
    CloseBtn.Size = UDim2.new(0, 40, 0, 30)
    CloseBtn.Position = UDim2.new(1, -50, 0.1, 0)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextScaled = true
    CloseBtn.Font = Enum.Font.GothamBold

    local CCorner = Instance.new("UICorner")
    CCorner.CornerRadius = UDim.new(0, 8)
    CCorner.Parent = CloseBtn

    -- Content
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.Position = UDim2.new(0, 10, 0, 60)
    Content.Size = UDim2.new(1, -20, 1, -70)
    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 6
    Content.ScrollBarImageTransparency = 0.5
    Content.CanvasSize = UDim2.new(0, 0, 0, 1200)

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = Content
    Layout.Padding = UDim.new(0, 8)

    -- Funkcje Toggle
    local function CreateToggle(name, callback)
        local Frame = Instance.new("Frame")
        Frame.Parent = Content
        Frame.Size = UDim2.new(1, 0, 0, 45)
        Frame.BackgroundColor3 = Color3.fromRGB(50, 40, 80)

        local FCorner = Instance.new("UICorner")
        FCorner.CornerRadius = UDim.new(0, 10)
        FCorner.Parent = Frame

        local Label = Instance.new("TextLabel")
        Label.Parent = Frame
        Label.Size = UDim2.new(0.7, 0, 1, 0)
        Label.Position = UDim2.new(0, 15, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = name
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left

        local Toggle = Instance.new("TextButton")
        Toggle.Parent = Frame
        Toggle.Size = UDim2.new(0, 35, 0, 35)
        Toggle.Position = UDim2.new(1, -45, 0.15, 0)
        Toggle.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
        Toggle.Text = "OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextScaled = true
        Toggle.Font = Enum.Font.GothamBold

        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0, 18)
        TCorner.Parent = Toggle

        local toggled = false
        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            Toggle.Text = toggled and "ON" or "OFF"
            Toggle.BackgroundColor3 = toggled and Color3.fromRGB(255, 100, 200) or Color3.fromRGB(100, 50, 150)
            callback(toggled)
        end)

        Frame.LayoutOrder = #Content:GetChildren()
    end

    -- Funkcja Button
    local function CreateButton(name, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Content
        Button.Size = UDim2.new(1, 0, 0, 45)
        Button.BackgroundColor3 = Color3.fromRGB(150, 70, 220)
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextScaled = true
        Button.Font = Enum.Font.GothamBold
        Button.BorderSizePixel = 0

        local BCorner = Instance.new("UICorner")
        BCorner.CornerRadius = UDim.new(0, 10)
        BCorner.Parent = Button

        Button.MouseButton1Click:Connect(callback)
        Button.LayoutOrder = #Content:GetChildren()
    end

    -- FLY (NAPRAWIONE)
    Enabled.Fly = false
    local FlyConnection
    CreateToggle("✈️ Fly (WASD + Space)", function(state)
        Enabled.Fly = state
        local char = Player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if state then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new(0,0,0)
            bv.Parent = root

            FlyConnection = RunService.Heartbeat:Connect(function()
                if Enabled.Fly and root.Parent then
                    local move = Vector3.new(0,0,0)
                    local cam = workspace.CurrentCamera
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
                    bv.Velocity = move * 50
                end
            end)
        else
            if FlyConnection then FlyConnection:Disconnect() end
            if root:FindFirstChild("BodyVelocity") then root.BodyVelocity:Destroy() end
        end
    end)

    -- NOCLIP (NAPRAWIONE)
    Enabled.Noclip = false
    local NoclipConnection
    CreateToggle("👻 Noclip", function(state)
        Enabled.Noclip = state
        if state then
            NoclipConnection = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetChildren()) do
                        if part:IsA("BasePart") and part ~= Player.Character.HumanoidRootPart then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoclipConnection then NoclipConnection:Disconnect() end
        end
    end)

    -- SPEED
    Enabled.Speed = false
    CreateToggle("🏃 Speed 100", function(state)
        Enabled.Speed = state
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = state and 100 or 16
        end
    end)

    -- INFINITE JUMP
    Enabled.InfJump = false
    local JumpConnection
    CreateToggle("🦘 Infinite Jump", function(state)
        Enabled.InfJump = state
        if state then
            JumpConnection = UserInputService.JumpRequest:Connect(function()
                Player.Character.Humanoid:ChangeState("Jumping")
            end)
        else
            if JumpConnection then JumpConnection:Disconnect() end
        end
    end)

    -- GODMODE
    Enabled.God = false
    CreateToggle("🛡️ Godmode", function(state)
        Enabled.God = state
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = state and math.huge or 100
            char.Humanoid.Health = state and math.huge or 100
        end
    end)

    -- ESP
    Enabled.ESP = false
    CreateToggle("👁️ ESP Players", function(state)
        Enabled.ESP = state
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character then
                pcall(function()
                    local esp = player.Character:FindFirstChild("ESP")
                    if state then
                        if not esp then
                            esp = Instance.new("BoxHandleAdornment")
                            esp.Name = "ESP"
                            esp.Size = player.Character.HumanoidRootPart.Size + Vector3.new(1,1,1)
                            esp.Color3 = Color3.fromRGB(255, 100, 200)
                            esp.Transparency = 0.5
                            esp.AlwaysOnTop = true
                            esp.Adornee = player.Character.HumanoidRootPart
                            esp.Parent = player.Character.HumanoidRootPart
                        end
                    else
                        if esp then esp:Destroy() end
                    end
                end)
            end
        end
    end)

    -- BUTTONS
    CreateButton("🚀 Fling All", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local root = plr.Character.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(40000, 40000, 40000)
                bv.Velocity = Vector3.new(math.random(-1000,1000), 2000, math.random(-1000,1000))
                bv.Parent = root
                game:GetService("Debris"):AddItem(bv, 0.3)
            end
        end
    end)

    CreateButton("🔫 Kill All", function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                plr.Character.Humanoid.Health = 0
            end
        end
    end)

    CreateButton("💀 Suicide", function()
        if Player.Character then
            Player.Character.Humanoid.Health = 0
        end
    end)

    CreateButton("🌟 Fullbright", function()
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 9e9
        game.Lighting.GlobalShadows = false
    end)

    -- Animacja i V Key
    spawn(function()
        wait(2)
        Loading:Destroy()
        MainFrame.Visible = true
        
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 600, 0, 450)
        })
        tween:Play()
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.V then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Update ESP dla nowych graczy
    Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            wait(1)
            if Enabled.ESP then
                local esp = Instance.new("BoxHandleAdornment")
                esp.Name = "ESP"
                esp.Size = plr.Character.HumanoidRootPart.Size + Vector3.new(1,1,1)
                esp.Color3 = Color3.fromRGB(255, 100, 200)
                esp.Transparency = 0.5
                esp.AlwaysOnTop = true
                esp.Adornee = plr.Character.HumanoidRootPart
                esp.Parent = plr.Character.HumanoidRootPart
            end
        end)
    end)

    -- Character respawn
    Player.CharacterAdded:Connect(function()
        if Enabled.Speed then
            wait(1)
            Player.Character.Humanoid.WalkSpeed = 100
        end
        if Enabled.God then
            Player.Character.Humanoid.MaxHealth = math.huge
            Player.Character.Humanoid.Health = math.huge
        end
    end)

    print("💜 PandusCwl v2.1 LOADED! Press V 💜")
end)
