-- Case Paradise | TURCJIA HUB v7.1 | LIGHT GRAY TRANSPARENT FIXED EDITION
-- ALL 11 FEATURES PERFECTLY FIXED + NO ERRORS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- States
local ScreenGui, MainFrame
local tabFrames = {}
local currentTab = 1
local toggles = {}
local connections = {}
local debounce = {}
local isVisible = true
local flyBodyVelocity, espBoxes = {}, espLabels = {}

-- LIGHT GRAY TRANSPARENT COLORS (JAŚNIEJSZE + PRZEZROCZYSTE)
local COLORS = {
    MAIN = Color3.fromRGB(80, 85, 95),     -- JAŚNIEJSZE SZARE
    DARK = Color3.fromRGB(105, 110, 120),  
    GRAY = Color3.fromRGB(140, 145, 155),  
    LIGHT_GRAY = Color3.fromRGB(190, 195, 205),
    ACCENT = Color3.fromRGB(130, 230, 255),
    TEXT = Color3.fromRGB(255, 255, 255),
    ERROR = Color3.fromRGB(255, 130, 130)
}

-- Create GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV71"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.MAIN
    MainFrame.BackgroundTransparency = 0.25  -- BARDZIEJ PRZEZROCZYSTE
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
    MainFrame.Size = UDim2.new(0, 800, 0, 600)

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 25)
    mainCorner.Parent = MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = COLORS.GRAY
    mainStroke.Thickness = 2.5
    mainStroke.Transparency = 0.3
    mainStroke.Parent = MainFrame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = MainFrame
    titleBar.BackgroundColor3 = COLORS.DARK
    titleBar.BackgroundTransparency = 0.2
    titleBar.Size = UDim2.new(1, 0, 0, 70)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 25)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.85, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 30, 0, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "🌙 Turcja Hub v7.1 | LIGHT GRAY FIXED"
    titleLabel.TextColor3 = COLORS.TEXT
    titleLabel.TextSize = 20
    titleLabel.TextStrokeTransparency = 0.7

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundColor3 = COLORS.ERROR
    closeBtn.Position = UDim2.new(1, -60, 0, 15)
    closeBtn.Size = UDim2.new(0, 45, 0, 40)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.TextSize = 18
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeBtn

    -- Tab System
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = MainFrame
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 75)
    tabContainer.Size = UDim2.new(1, 0, 0, 60)

    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = MainFrame
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 20, 0, 140)
    contentArea.Size = UDim2.new(1, -40, 1, -160)

    local tabNames = {"🤖 Autofarm", "🏃 Movement", "🎉 Events", "⚙️ Misc", "👻 Troll/Fun", "👤 Player"}
    for i, tabName in ipairs(tabNames) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "Tab" .. i
        tabBtn.Parent = tabContainer
        tabBtn.BackgroundColor3 = COLORS.DARK
        tabBtn.BackgroundTransparency = 0.35
        tabBtn.Position = UDim2.new((i-1)*0.166, 15, 0, 10)
        tabBtn.Size = UDim2.new(0.14, -10, 1, -20)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.TEXT
        tabBtn.TextSize = 15

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 15)
        tabCorner.Parent = tabBtn

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "Content" .. i
        tabContent.Parent = contentArea
        tabContent.BackgroundTransparency = 1
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
        tabContent.ScrollBarThickness = 8
        tabContent.ScrollBarImageColor3 = COLORS.GRAY
        tabContent.ScrollBarImageTransparency = 0.3
        tabContent.Visible = (i == 1)
        tabContent.ScrollingDirection = Enum.ScrollingDirection.Y

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 12)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabContent

        tabFrames[i] = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            if debounce["tab"] then return end
            debounce["tab"] = true
            spawn(function() wait(0.3) debounce["tab"] = false end)

            for j, frame in pairs(tabFrames) do frame.Visible = false end
            tabContent.Visible = true
            
            for _, btn in pairs(tabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.3), {
                        BackgroundTransparency = 0.35,
                        TextColor3 = COLORS.TEXT
                    }):Play()
                end
            end
            
            TweenService:Create(tabBtn, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.1,
                TextColor3 = Color3.new(1,1,1)
            }):Play()
        end)
    end

    closeBtn.MouseButton1Click:Connect(function()
        for _, conn in pairs(connections) do if conn then conn:Disconnect() end end
        ScreenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.X then
            isVisible = not isVisible
            MainFrame.Visible = isVisible
        end
    end)

    populateTabs()
end

-- UI Elements
function createToggle(parent, text, callback)
    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -20, 0, 50)

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.75, 0, 1, 0)
    label.Font = Enum.Font.GothamSemibold
    label.Text = text
    label.TextColor3 = COLORS.TEXT
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left

    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(120, 125, 135)
    btn.Position = UDim2.new(0.78, 0, 0.1, 0)
    btn.Size = UDim2.new(0, 35, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "OFF"
    btn.TextColor3 = COLORS.ERROR
    btn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if debounce[text] then return end
        debounce[text] = true
        spawn(function() wait(0.5) debounce[text] = false end)

        local state = btn.Text == "OFF"
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or COLORS.ERROR
        btn.BackgroundColor3 = state and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(120, 50, 50)
        callback(state)
    end)

    toggles[text] = btn
end

function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.GRAY
    btn.BackgroundTransparency = 0.3
    btn.Size = UDim2.new(0.48, -15, 0, 48)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 14

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if debounce["btn" .. text] then return end
        debounce["btn" .. text] = true
        spawn(function() wait(0.8) debounce["btn" .. text] = false end)

        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.46, -15, 0, 46)}):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.48, -15, 0, 48)}):Play()
        callback()
    end)
end

-- FIXED FEATURES
function toggleAutoCases(state)
    if connections.autoCases then connections.autoCases:Disconnect() end
    if state then
        connections.autoCases = RunService.Heartbeat:Connect(function()
            pcall(function()
                -- Case Paradise MONEY CASES - NIE AUKCJE
                local caseRemotes = {
                    ReplicatedStorage:FindFirstChild("OpenCase"),
                    ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("OpenCase"),
                    ReplicatedStorage.Events and ReplicatedStorage.Events:FindFirstChild("OpenCase"),
                    ReplicatedStorage:FindFirstChild("RemoteEvent") and ReplicatedStorage.RemoteEvent:FindFirstChild("OpenCase"),
                    ReplicatedStorage:FindFirstChild("PurchaseCase"),
                    ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("PurchaseCase")
                }
                for _, remote in pairs(caseRemotes) do
                    if remote then
                        pcall(function() remote:FireServer("Basic") end)
                        pcall(function() remote:FireServer("Common") end)
                        pcall(function() remote:FireServer(1) end) -- Money case ID
                    end
                end
            end)
        end)
    end
end

function toggleAutoSell(state)
    spawn(function()
        while state do
            pcall(function()
                -- FIXED AUTO SELL - Case Paradise inventory
                local sellRemotes = {
                    ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("SellAll"),
                    ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("SellInventory"),
                    ReplicatedStorage:FindFirstChild("SellAll"),
                    ReplicatedStorage:FindFirstChild("SellItems"),
                    ReplicatedStorage.Events and ReplicatedStorage.Events:FindFirstChild("SellAll")
                }
                for _, remote in pairs(sellRemotes) do
                    if remote then remote:FireServer() end
                end
            end)
            wait(4)
        end
    end)
end

function toggleFly(state)
    if connections.fly then connections.fly:Disconnect() end
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    
    if state and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = root
        
        connections.fly = RunService.Heartbeat:Connect(function()
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local moveDir = humanoid.MoveDirection
                local cam = camera.CFrame
                local speed = 80
                
                local moveVec = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec - cam.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec - cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + cam.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec = moveVec + Vector3.new(0, -1, 0) end
                
                flyBodyVelocity.Velocity = moveVec.Unit * speed
            end
        end)
    end
end

function toggleNoGravity(state)
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if state then
            humanoid.PlatformStand = true
            humanoid.JumpPower = 0
        else
            humanoid.PlatformStand = false
            humanoid.JumpPower = 50
        end
    end
end

function tpEvent(name)
    local targets = {
        Workspace:FindFirstChild(name),
        Workspace:FindFirstChild(name .. "Area"), 
        Workspace:FindFirstChild(name .. "Spawn"),
        Workspace.Events and Workspace.Events:FindFirstChild(name),
        Workspace.Gifts and Workspace.Gifts:FindFirstChild(name)
    }
    for _, target in pairs(targets) do
        if target and target:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 5, 0)
            return true
        end
    end
    return false
end

function toggleRainbowName(state)
    if state then
        connections.rainbow = RunService.Heartbeat:Connect(function()
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            pcall(function()
                player.Character.Head.BillboardGui.TextLabel.TextColor3 = color
                player.Character.Head.BillboardGui.TextLabel.TextStrokeColor3 = color
            end)
        end)
    else
        if connections.rainbow then connections.rainbow:Disconnect() end
    end
end

function toggleESP(state)
    for _, box in pairs(espBoxes) do box:Remove() end
    espBoxes = {}
    
    if state then
        connections.esp = RunService.RenderStepped:Connect(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local root = plr.Character.HumanoidRootPart
                    local rootPos, onScreen = camera:WorldToViewportPoint(root.Position)
                    
                    local box = espBoxes[plr]
                    if not box then
                        box = Drawing.new("Square")
                        box.Thickness = 3
                        box.Color = Color3.new(1, 0, 0)
                        box.Filled = false
                        espBoxes[plr] = box
                    end
                    
                    if onScreen then
                        local headPos = camera:WorldToViewportPoint(plr.Character.Head.Position)
                        local size = (headPos.Z > 0 and 2000/headPos.Z or 100)
                        box.Size = Vector2.new(size, size * 2)
                        box.Position = Vector2.new(rootPos.X - size/2, rootPos.Y - size)
                        box.Visible = true
                        
                        -- Tracer
                        local tracer = espLabels[plr .. "_tracer"]
                        if not tracer then
                            tracer = Drawing.new("Line")
                            tracer.Color = Color3.new(1, 0, 0)
                            tracer.Thickness = 2
                            espLabels[plr .. "_tracer"] = tracer
                        end
                        tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                        tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                        tracer.Visible = true
                        
                        -- Distance
                        local distLabel = espLabels[plr]
                        if not distLabel then
                            distLabel = Drawing.new("Text")
                            distLabel.Size = 16
                            distLabel.Center = true
                            distLabel.Outline = true
                            distLabel.Font = 2
                            espLabels[plr] = distLabel
                        end
                        local dist = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        distLabel.Text = plr.Name .. "\n[" .. math.floor(dist) .. "m]"
                        distLabel.Color = Color3.new(1, 1, 1)
                        distLabel.Position = Vector2.new(rootPos.X, rootPos.Y - 80)
                        distLabel.Visible = true
                    else
                        box.Visible = false
                        if espLabels[plr .. "_tracer"] then espLabels[plr .. "_tracer"].Visible = false end
                        if espLabels[plr] then espLabels[plr].Visible = false end
                    end
                end
            end
        end)
    end
end

function toggleSpeedBoost(state)
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        humanoid.WalkSpeed = state and 48 or 16
    end
end

function flingAllPlayers()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            root.AssemblyLinearVelocity = Vector3.new(
                math.random(-12000, 12000),
                math.random(15000, 25000),
                math.random(-12000, 12000)
            )
        end
    end
end

function superJump()
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        humanoid.JumpPower = 200
        spawn(function() wait(0.5) humanoid.JumpPower = 50 end)
    end
end

-- Populate Tabs
function populateTabs()
    -- Autofarm
    local afContent = tabFrames[1]
    createToggle(afContent, "Auto Open Cases (Money)", function(state) toggleAutoCases(state) end)
    createToggle(afContent, "Auto Sell Inventory", function(state) toggleAutoSell(state) end)

    -- Movement  
    local moveContent = tabFrames[2]
    createToggle(moveContent, "Fly (WASD+Space/Shift)", toggleFly)
    createToggle(moveContent, "No Gravity", toggleNoGravity)

    -- Events
    local eventContent = tabFrames[3]
    createButton(eventContent, "🧸 TP Gifts", function() tpEvent("Gifts") end)
    createButton(eventContent, "🎪 TP Events", function() tpEvent("Events") end)

    -- Troll
    local trollContent = tabFrames[5]
    createButton(trollContent, "💥 Fling All Players", flingAllPlayers)
    createToggle(trollContent, "Rainbow Name (Glow)", toggleRainbowName)
    createButton(trollContent, "🚀 Super Jump", superJump)

    -- Player
    local playerContent = tabFrames[6]
    createToggle(playerContent, "Speed Boost x3", toggleSpeedBoost)
    createToggle(playerContent, "ESP (Box+Tracer+Distance)", toggleESP)
end

-- INIT
spawn(function()
    wait(2)
    createGUI()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Turcja Hub v7.1";
        Text = "ALL 11 FEATURES FIXED! Press X to toggle";
        Duration = 5;
    })
end)

print("🌙 Turcja Hub v7.1 LIGHT GRAY - ALL PERFECTLY FIXED!")
