-- PandusCwl v1.0 - Professional Roblox Exploit GUI
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/YOURUSERNAME/PandusCwl/main/loader.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Variables
local ScreenGui, MainFrame, ToggleKey = "V", true
local Connections = {}
local FlyConnection, NoclipConnection, ESPConnections = nil, nil, {}

-- Anti-Detection
getgenv().PandusCwl = true

-- Create GUI
local function CreateGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PandusCwl"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Loading Screen
    local LoadingLabel = Instance.new("TextLabel")
    LoadingLabel.Name = "Loading"
    LoadingLabel.Parent = ScreenGui
    LoadingLabel.BackgroundTransparency = 1
    LoadingLabel.Size = UDim2.new(1, 0, 1, 0)
    LoadingLabel.Position = UDim2.new(0, 0, 0, 0)
    LoadingLabel.Text = "Turcja Szef"
    LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingLabel.TextScaled = true
    LoadingLabel.Font = Enum.Font.GothamBold
    LoadingLabel.TextStrokeTransparency = 0
    LoadingLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    -- Main Frame
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Visible = false
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Stroke
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 60, 80)
    UIStroke.Thickness = 1
    UIStroke.Parent = MainFrame

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Size = UDim2.new(0.6, 0, 0, 35)
    Title.Text = "PandusCwl"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Minimize Button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "Minimize"
    MinimizeBtn.Parent = MainFrame
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Position = UDim2.new(1, -40, 0, 10)
    MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextScaled = true
    MinimizeBtn.Font = Enum.Font.GothamBold

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    -- Scroll Frame
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Parent = MainFrame
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.Position = UDim2.new(0, 10, 0, 55)
    ScrollFrame.Size = UDim2.new(1, -20, 1, -65)
    ScrollFrame.ScrollBarThickness = 6
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = ScrollFrame
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Create Tabs
    local function CreateTab(name, layoutOrder)
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name
        TabFrame.Parent = ScrollFrame
        TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        TabFrame.Size = UDim2.new(1, -20, 0, 200)
        TabFrame.LayoutOrder = layoutOrder

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabFrame

        local TabTitle = Instance.new("TextLabel")
        TabTitle.Name = "Title"
        TabTitle.Parent = TabFrame
        TabTitle.BackgroundTransparency = 1
        TabTitle.Position = UDim2.new(0, 15, 0, 10)
        TabTitle.Size = UDim2.new(1, -30, 0, 30)
        TabTitle.Text = name
        TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.TextScaled = true
        TabTitle.Font = Enum.Font.GothamSemibold

        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabFrame
        TabList.Padding = UDim.new(0, 5)
        TabList.SortOrder = Enum.SortOrder.LayoutOrder
        TabList.Padding = UDim.new(0, 8)

        return TabFrame
    end

    -- Main Tab
    local MainTab = CreateTab("🏠 Main", 1)
    local MovementTab = CreateTab("✈️ Movement", 2)
    local VisualsTab = CreateTab("👁️ Visuals", 3)
    local PlayersTab = CreateTab("👥 Players", 4)
    local MiscTab = CreateTab("⚙️ Misc", 5)

    -- Toggle Button Function
    local function CreateToggle(parent, name, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Parent = parent
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        ToggleFrame.Size = UDim2.new(1, -20, 0, 40)

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleFrame

        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Parent = ToggleFrame
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
        ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleLabel.TextScaled = true
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Parent = ToggleFrame
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.Position = UDim2.new(1, -45, 0.5, -15)
        ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
        ToggleBtn.Text = "OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.TextScaled = true
        ToggleBtn.Font = Enum.Font.GothamBold

        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 15)
        BtnCorner.Parent = ToggleBtn

        local toggleState = false
        ToggleBtn.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            ToggleBtn.Text = toggleState and "ON" or "OFF"
            ToggleBtn.BackgroundColor3 = toggleState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(60, 60, 80)
            callback(toggleState)
        end)

        return ToggleFrame
    end

    -- Slider Function (simplified)
    local function CreateSlider(parent, name, min, max, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Parent = parent
        SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        SliderFrame.Size = UDim2.new(1, -20, 0, 50)

        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 6)
        SliderCorner.Parent = SliderFrame

        local SliderLabel = Instance.new("TextLabel")
        SliderLabel.Parent = SliderFrame
        SliderLabel.BackgroundTransparency = 1
        SliderLabel.Position = UDim2.new(0, 15, 0, 5)
        SliderLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
        SliderLabel.Text = name
        SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderLabel.TextScaled = true
        SliderLabel.Font = Enum.Font.Gotham
        SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

        local SliderBar = Instance.new("Frame")
        SliderBar.Parent = SliderFrame
        SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        SliderBar.Position = UDim2.new(0, 15, 0.6, 0)
        SliderBar.Size = UDim2.new(0.7, 0, 0, 6)

        local SliderFill = Instance.new("Frame")
        SliderFill.Parent = SliderBar
        SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
        SliderFill.BorderSizePixel = 0

        local SliderCornerFill = Instance.new("UICorner")
        SliderCornerFill.CornerRadius = UDim.new(0, 3)
        SliderCornerFill.Parent = SliderFill

        local SliderCornerBar = Instance.new("UICorner")
        SliderCornerBar.CornerRadius = UDim.new(0, 3)
        SliderCornerBar.Parent = SliderBar

        local dragging = false
        local value = 50

        SliderFill.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        SliderFill.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local mouse = Player:GetMouse()
                local relativeX = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                relativeX = math.clamp(relativeX, 0, 1)
                value = math.floor(min + (max - min) * relativeX)
                SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
                SliderLabel.Text = name .. ": " .. value
                callback(value)
            end
        end)
    end

    -- Features
    local FlyEnabled, NoclipEnabled = false, false
    local FlySpeed = 16

    -- Fly
    CreateToggle(MovementTab, "Fly", function(state)
        FlyEnabled = state
        if state then
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.Parent = Player.Character.HumanoidRootPart

            local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
            BodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
            BodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            BodyAngularVelocity.Parent = Player.Character.HumanoidRootPart

            FlyConnection = RunService.Heartbeat:Connect(function()
                if Player.Character and Player.Character.HumanoidRootPart then
                    local Camera = workspace.CurrentCamera
                    local vel = Camera.CFrame.LookVector * (UserInputService:IsKeyDown(Enum.KeyCode.W) and FlySpeed or 0)
                    vel = vel + Camera.CFrame.RightVector * (UserInputService:IsKeyDown(Enum.KeyCode.D) and FlySpeed or 0)
                    vel = vel + Camera.CFrame.RightVector * (UserInputService:IsKeyDown(Enum.KeyCode.A) and -FlySpeed or 0)
                    vel = vel + Camera.CFrame.LookVector * (UserInputService:IsKeyDown(Enum.KeyCode.S) and -FlySpeed or 0)
                    vel = vel + Vector3.new(0, UserInputService:IsKeyDown(Enum.KeyCode.Space) and FlySpeed or 0, 0)
                    vel = vel + Vector3.new(0, UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and -FlySpeed or 0, 0)
                    Player.Character.HumanoidRootPart.BodyVelocity.Velocity = vel
                end
            end)
        else
            if FlyConnection then FlyConnection:Disconnect() end
            if Player.Character and Player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                Player.Character.HumanoidRootPart.BodyVelocity:Destroy()
            end
            if Player.Character and Player.Character.HumanoidRootPart:FindFirstChild("BodyAngularVelocity") then
                Player.Character.HumanoidRootPart.BodyAngularVelocity:Destroy()
            end
        end
    end)

    CreateSlider(MovementTab, "Fly Speed", 1, 100, function(value)
        FlySpeed = value
    end)

    -- Noclip
    CreateToggle(MovementTab, "Noclip", function(state)
        NoclipEnabled = state
        if state then
            NoclipConnection = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if NoclipConnection then NoclipConnection:Disconnect() end
        end
    end)

    -- ESP
    CreateToggle(VisualsTab, "ESP", function(state)
        if state then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local ESP = Instance.new("BoxHandleAdornment")
                    ESP.Name = "PandusESP"
                    ESP.Parent = player.Character.HumanoidRootPart
                    ESP.Adornee = player.Character.HumanoidRootPart
                    ESP.Size = player.Character.HumanoidRootPart.Size + Vector3.new(0.5, 0.5, 0.5)
                    ESP.Color3 = Color3.fromRGB(0, 255, 100)
                    ESP.Transparency = 0.5
                    ESP.AlwaysOnTop = true
                    ESP.ZIndex = 10
                    ESP.Visible = true

                    local NameTag = Instance.new("BillboardGui")
                    NameTag.Name = "NameTag"
                    NameTag.Parent = player.Character.Head
                    NameTag.Size = UDim2.new(0, 100, 0, 50)
                    NameTag.StudsOffset = Vector3.new(0, 2, 0)

                    local NameLabel = Instance.new("TextLabel")
                    NameLabel.Parent = NameTag
                    NameLabel.BackgroundTransparency = 1
                    NameLabel.Size = UDim2.new(1, 0, 1, 0)
                    NameLabel.Text = player.Name
                    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    NameLabel.TextScaled = true
                    NameLabel.Font = Enum.Font.GothamBold
                    NameLabel.TextStrokeTransparency = 0

                    ESPConnections[player] = ESP
                end
            end
        else
            for _, esp in pairs(ESPConnections) do
                if esp then esp:Destroy() end
            end
            ESPConnections = {}
        end
    end)

    -- Fling All
    local FlingBtn = Instance.new("TextButton")
    FlingBtn.Parent = PlayersTab
    FlingBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    FlingBtn.BorderSizePixel = 0
    FlingBtn.Size = UDim2.new(1, -20, 0, 45)
    FlingBtn.Text = "🚀 Fling All Players"
    FlingBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlingBtn.TextScaled = true
    FlingBtn.Font = Enum.Font.GothamBold

    local FlingCorner = Instance.new("UICorner")
    FlingCorner.CornerRadius = UDim.new(0, 6)
    FlingCorner.Parent = FlingBtn

    FlingBtn.MouseButton1Click:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local velocity = Instance.new("BodyVelocity")
                velocity.MaxForce = Vector3.new(4000, 4000, 4000)
                velocity.Velocity = Vector3.new(math.random(-100,100), math.random(50,200), math.random(-100,100))
                velocity.Parent = player.Character.HumanoidRootPart
                
                game:GetService("Debris"):AddItem(velocity, 0.5)
            end
        end
    end)

    -- Crosshair
    CreateToggle(VisualsTab, "Custom Crosshair", function(state)
        if state then
            local Crosshair = Drawing.new("Square")
            Crosshair.Size = Vector2.new(20, 2)
            Crosshair.Color = Color3.fromRGB(0, 255, 100)
            Crosshair.Thickness = 2
            Crosshair.Transparency = 1
            Crosshair.Filled = false
            Crosshair.Visible = true

            -- More crosshair parts...
        else
            -- Remove crosshair
        end
    end)

    -- Show GUI
    wait(2)
    LoadingLabel:Destroy()
    MainFrame.Visible = true

    -- Animate in
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 500, 0, 400)
    })
    tween:Play()
end

-- Keybind V
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Initialize
CreateGUI()

-- Update ESP for new players
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if MainFrame:FindFirstChild("ScrollFrame"):FindFirstChild("Visuals"):FindFirstChild("ESP").ToggleBtn.Text == "ON" then
            -- Recreate ESP
        end
    end)
end)

print("PandusCwl loaded successfully! Press V to toggle GUI")