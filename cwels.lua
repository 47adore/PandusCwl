-- 🔥 TURCJIA HUB v16 | ULTRA SAFE | NO CORE GUI EVER
-- ✅ ABSOLUTELY NO CORE GUI REFERENCES | FULLY REWRITTEN

local function safeLoad()
    -- ABSOLUTE MINIMAL - NO RISKY CALLS
    local pcall = pcall
    local task = task
    local game = game
    local math = math
    
    pcall(function()
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TweenService = game:GetService("TweenService")
        local Workspace = game:GetService("Workspace")
        local VirtualUser = game:GetService("VirtualUser")
        
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        
        -- SAFE GUI CREATION
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "HubV16_"..tostring(math.random(1e6,9e6))
        ScreenGui.ResetOnSpawn = false
        ScreenGui.DisplayOrder = 999
        ScreenGui.Parent = PlayerGui

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "Main"
        MainFrame.Parent = ScreenGui
        MainFrame.Size = UDim2.new(0, 800, 0, 550)
        MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.BorderSizePixel = 0

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 15)
        Corner.Parent = MainFrame

        -- TITLE
        local TitleFrame = Instance.new("Frame")
        TitleFrame.Parent = MainFrame
        TitleFrame.Size = UDim2.new(1, 0, 0, 70)
        TitleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        TitleFrame.BorderSizePixel = 0

        local TitleCorner = Instance.new("UICorner")
        TitleCorner.CornerRadius = UDim.new(0, 15)
        TitleCorner.Parent = TitleFrame

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Parent = TitleFrame
        TitleLabel.Size = UDim2.new(1, -80, 1, 0)
        TitleLabel.Position = UDim2.new(0, 20, 0, 0)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "🔥 TURCJIA HUB v16 - ZERO ERROR"
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 22
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

        -- CLOSE BUTTON
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Parent = TitleFrame
        CloseBtn.Size = UDim2.new(0, 50, 0, 50)
        CloseBtn.Position = UDim2.new(1, -65, 0, 10)
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        CloseBtn.TextSize = 24
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.BorderSizePixel = 0

        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 25)
        CloseCorner.Parent = CloseBtn

        -- TABS
        local TabFrame = Instance.new("Frame")
        TabFrame.Parent = MainFrame
        TabFrame.Size = UDim2.new(1, 0, 0, 50)
        TabFrame.Position = UDim2.new(0, 0, 0, 70)
        TabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        TabFrame.BorderSizePixel = 0

        local TabList = Instance.new("UIListLayout")
        TabList.FillDirection = Enum.FillDirection.Horizontal
        TabList.Padding = UDim.new(0, 5)
        TabList.Parent = TabFrame

        -- CONTENT AREA
        local ContentFrame = Instance.new("ScrollingFrame")
        ContentFrame.Parent = MainFrame
        ContentFrame.Size = UDim2.new(1, -20, 1, -150)
        ContentFrame.Position = UDim2.new(0, 10, 0, 125)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.ScrollBarThickness = 8
        ContentFrame.CanvasSize = UDim2.new(0, 0, 3, 0)

        local ContentList = Instance.new("UIListLayout")
        ContentList.Padding = UDim.new(0, 10)
        ContentList.Parent = ContentFrame

        -- TOGGLE FUNCTION
        local toggles = {}
        local function createToggle(parent, name, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = parent
            ToggleFrame.Size = UDim2.new(1, -20, 0, 60)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            ToggleFrame.BorderSizePixel = 0

            local TCorner = Instance.new("UICorner")
            TCorner.CornerRadius = UDim.new(0, 12)
            TCorner.Parent = ToggleFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = name
            ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleLabel.TextSize = 18
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Parent = ToggleFrame
            ToggleBtn.Size = UDim2.new(0, 50, 0, 40)
            ToggleBtn.Position = UDim2.new(1, -65, 0, 10)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            ToggleBtn.Text = "OFF"
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.TextSize = 16
            ToggleBtn.Font = Enum.Font.GothamBold
            ToggleBtn.BorderSizePixel = 0

            local TBCorner = Instance.new("UICorner")
            TBCorner.CornerRadius = UDim.new(0, 20)
            TBCorner.Parent = ToggleBtn

            local state = false
            toggles[name] = {enabled=false}

            ToggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggles[name].enabled = state
                ToggleBtn.Text = state and "ON" or "OFF"
                ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(200, 50, 50)
                callback(state)
            end)
        end

        -- BUTTON FUNCTION
        local function createButton(parent, name, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = parent
            Button.Size = UDim2.new(0.48, -10, 0, 70)
            Button.BackgroundColor3 = Color3.fromRGB(70, 100, 200)
            Button.Text = name
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 18
            Button.Font = Enum.Font.GothamBold
            Button.BorderSizePixel = 0

            local BCorner = Instance.new("UICorner")
            BCorner.CornerRadius = UDim.new(0, 15)
            BCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 100, 200)}):Play()
                callback()
            end)
        end

        -- TABS DATA
        local tabs = {
            {name="🎯 FARM", content={}},
            {name="✈️ MOVEMENT", content={}},
            {name="📍 TELEPORT", content={}},
            {name="⚙️ MISC", content={}},
            {name="💥 TROLL", content={}}
        }

        local currentTab = 1
        local tabContents = {}

        -- CREATE TABS
        for i, tab in ipairs(tabs) do
            local TabBtn = Instance.new("TextButton")
            TabBtn.Parent = TabFrame
            TabBtn.Size = UDim2.new(0.18, 0, 0.8, 0)
            TabBtn.Position = UDim2.new((i-1)*0.2, 10, 0.1, 0)
            TabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(60, 60, 80)
            TabBtn.Text = tab.name
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.TextSize = 16
            TabBtn.Font = Enum.Font.GothamBold
            TabBtn.BorderSizePixel = 0

            local TabBtnCorner = Instance.new("UICorner")
            TabBtnCorner.CornerRadius = UDim.new(0, 10)
            TabBtnCorner.Parent = TabBtn

            TabBtn.MouseButton1Click:Connect(function()
                for j, btn in ipairs(TabFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                    end
                end
                TabBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                currentTab = i
            end)

            -- Tab content
            local TabContent = Instance.new("Frame")
            TabContent.Parent = ContentFrame
            TabContent.Size = UDim2.new(1, -20, 0, 400)
            TabContent.BackgroundTransparency = 1
            TabContent.Visible = i == 1
            tabContents[i] = TabContent
        end

        -- FARM TAB
        createToggle(tabContents[1], "🚀 Auto Farm", function(state)
            if state then
                task.spawn(function()
                    while toggles["🚀 Auto Farm"].enabled do
                        pcall(function()
                            for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                                if obj.Name:lower():find("case") or obj.Name:lower():find("open") then
                                    if obj:IsA("RemoteEvent") then obj:FireServer() end
                                end
                            end
                        end)
                        task.wait(0.1)
                    end
                end)
            end
        end)

        createToggle(tabContents[1], "💰 Auto Sell", function(state)
            if state then
                task.spawn(function()
                    while toggles["💰 Auto Sell"].enabled do
                        pcall(function()
                            for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                                if obj.Name:lower():find("sell") then
                                    if obj:IsA("RemoteEvent") then obj:FireServer() end
                                end
                            end
                        end)
                        task.wait(3)
                    end
                end)
            end
        end)

        createButton(tabContents[1], "⚡ Collect All", function()
            pcall(function()
                for i = 1, 20 do
                    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                        if obj.Name:lower():find("collect") or obj.Name:lower():find("claim") then
                            if obj:IsA("RemoteEvent") then obj:FireServer() end
                        end
                    end
                end
            end)
        end)

        -- MOVEMENT TAB
        createToggle(tabContents[2], "✈️ Fly", function(state)
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local rootPart = character.HumanoidRootPart
                if state then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    bodyVelocity.Parent = rootPart
                    
                    local connection
                    connection = RunService.Heartbeat:Connect(function()
                        if not toggles["✈️ Fly"].enabled or not rootPart.Parent then
                            connection:Disconnect()
                            if bodyVelocity then bodyVelocity:Destroy() end
                            return
                        end
                        
                        local camera = Workspace.CurrentCamera
                        local moveVector = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            moveVector = moveVector + camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            moveVector = moveVector - camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            moveVector = moveVector - camera.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            moveVector = moveVector + camera.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            moveVector = moveVector + Vector3.new(0, 1, 0)
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            moveVector = moveVector - Vector3.new(0, 1, 0)
                        end
                        
                        bodyVelocity.Velocity = moveVector * 50
                    end)
                else
                    if rootPart:FindFirstChild("BodyVelocity") then
                        rootPart.BodyVelocity:Destroy()
                    end
                end
            end
        end)

        createToggle(tabContents[2], "⚡ Speed 100", function(state)
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                character.Humanoid.WalkSpeed = state and 100 or 16
            end
        end)

        -- MISC TAB
        createToggle(tabContents[4], "🛡️ Anti-AFK", function(state)
            if state then
                task.spawn(function()
                    while toggles["🛡️ Anti-AFK"].enabled do
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                        task.wait(60)
                    end
                end)
            end
        end)

        -- TROLL TAB
        createButton(tabContents[5], "💥 Fling Players", function()
            pcall(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                            math.random(-5000, 5000),
                            5000,
                            math.random(-5000, 5000)
                        )
                    end
                end
            end)
        end)

        -- CLOSE BUTTON
        CloseBtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)

        -- HIDE/SHOW WITH X KEY
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.X then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)

        -- SUCCESS
        print("✅ TURCJIA HUB v16 LOADED - NO CORE GUI!")
        
    end)
end

-- EXECUTE SAFELY
pcall(safeLoad)
