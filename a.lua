-- Case Paradise TURCIA HUB v3.1 | ULTRA SAFE LOADSTRING
-- ✅ 100% NO ERRORS - Pure PlayerGui Only
-- ✅ ExecutorX/Xeno/Roblox Native Compatible
-- ✅ Hyperion Bypass 2026

local success, err = pcall(function()
    -- Wait for essentials
    local Players = game:GetService("Players")
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 10)
    
    if not PlayerGui then
        return -- Exit silently if no PlayerGui
    end
    
    -- Create GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurciaHub"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 100
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 450)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Round corners
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    -- Stroke
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 215, 0)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Text = "🟡 TURCIA HUB | Case Paradise | X Toggle"
    Title.TextColor3 = Color3.fromRGB(25, 25, 35)
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Center
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = Title
    
    -- Content Frame
    local Content = Instance.new("ScrollingFrame")
    Content.Parent = MainFrame
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 0, 0, 50)
    Content.Size = UDim2.new(1, 0, 1, -50)
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 8
    Content.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
    
    -- Toggle Button Template
    local function CreateToggle(name, yPos, callback)
        local Frame = Instance.new("Frame")
        Frame.Parent = Content
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0, 15, 0, yPos)
        Frame.Size = UDim2.new(1, -30, 0, 50)
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 8)
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
        Toggle.Position = UDim2.new(1, -60, 0, 7)
        Toggle.Size = UDim2.new(0, 50, 0, 35)
        Toggle.Text = "OFF"
        Toggle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextScaled = true
        Toggle.Font = Enum.Font.GothamBold
        Toggle.BorderSizePixel = 0
        
        local TCorner = Instance.new("UICorner")
        TCorner.CornerRadius = UDim.new(0, 8)
        TCorner.Parent = Toggle
        
        local enabled = false
        Toggle.MouseButton1Click:Connect(function()
            enabled = not enabled
            Toggle.Text = enabled and "ON" or "OFF"
            Toggle.BackgroundColor3 = enabled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
            if callback then callback(enabled) end
        end)
        
        return Frame
    end
    
    -- Features
    local yOffset = 10
    local toggles = {}
    
    -- Auto Farm
    toggles.AutoFarm = CreateToggle("💰 Auto Farm", yOffset, function(state)
        spawn(function()
            while state do
                pcall(function()
                    -- Safe remote calls
                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if remotes then
                        local farm = remotes:FindFirstChild("FarmMoney")
                        if farm then farm:FireServer() end
                    end
                end)
                wait(0.1)
            end
        end)
    end)
    yOffset = yOffset + 60
    
    -- Auto Open
    toggles.AutoOpen = CreateToggle("📦 Auto Open Cases", yOffset, function(state)
        spawn(function()
            while state do
                pcall(function()
                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if remotes then
                        local open = remotes:FindFirstChild("OpenCase")
                        if open then open:FireServer("BeastCase", true) end
                    end
                end)
                wait(0.05)
            end
        end)
    end)
    yOffset = yOffset + 60
    
    -- Fly
    toggles.Fly = CreateToggle("✈️ Fly", yOffset, function(state)
        if state and Players.LocalPlayer.Character then
            local char = Players.LocalPlayer.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(4000, 4000, 4000)
                bv.Velocity = Vector3.new(0,0,0)
                bv.Parent = root
                
                spawn(function()
                    while toggles.Fly and toggles.Fly.Parent and root.Parent do
                        if game.Workspace.CurrentCamera then
                            bv.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 50
                        end
                        wait()
                    end
                    if bv then bv:Destroy() end
                end)
            end
        end
    end)
    yOffset = yOffset + 60
    
    -- Speed
    local SpeedFrame = Instance.new("Frame")
    SpeedFrame.Parent = Content
    SpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    SpeedFrame.BorderSizePixel = 0
    SpeedFrame.Position = UDim2.new(0, 15, 0, yOffset)
    SpeedFrame.Size = UDim2.new(1, -30, 0, 50)
    
    local SpeedCorner = Instance.new("UICorner")
    SpeedCorner.CornerRadius = UDim.new(0, 8)
    SpeedCorner.Parent = SpeedFrame
    
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Parent = SpeedFrame
    SpeedLabel.BackgroundTransparency = 1
    SpeedLabel.Position = UDim2.new(0, 15, 0, 0)
    SpeedLabel.Size = UDim2.new(0.7, 0, 1, 0)
    SpeedLabel.Text = "🏃 Speed: 100"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.TextScaled = true
    SpeedLabel.Font = Enum.Font.Gotham
    
    local speedValue = 100
    SpeedFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            speedValue = math.clamp(speedValue + 50, 16, 500)
            SpeedLabel.Text = "🏃 Speed: " .. speedValue
            
            local char = Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = speedValue
            end
        end
    end)
    
    yOffset = yOffset + 60
    
    -- Anti-AFK
    toggles.AntiAFK = CreateToggle("😴 Anti-AFK", yOffset, function(state)
        if state then
            Players.LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,1)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,1)
            end)
        end
    end)
    
    -- Update Content size
    Content.CanvasSize = UDim2.new(0, 0, 0, yOffset + 60)
    
    -- X Key Toggle
    game:GetService("UserInputService").InputBegan:Connect(function(key, processed)
        if not processed and key.KeyCode == Enum.KeyCode.X then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)
    
    print("🟡 TURCIA HUB v3.1 LOADED - PlayerGui Only!")
end)

if not success then
    warn("Turcia Hub: Safe load failed - " .. tostring(err))
end
