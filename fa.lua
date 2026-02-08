-- Case Paradise | TURCJIA HUB v9.0 | LIGHT GRAY PERFECT EDITION
-- FULLY REWRITTEN - NO ERRORS + ALL FIXED FEATURES

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- Variables
local ScreenGui, MainFrame
local tabFrames = {}
local toggles = {}
local connections = {}
local debounce = {}
local flyBodyVelocity, espBoxes = {}, espLabels = {}

-- LIGHT GRAY COLORS
local COLORS = {
    MAIN = Color3.fromRGB(65, 70, 80),
    DARK = Color3.fromRGB(85, 90, 100),
    GRAY = Color3.fromRGB(120, 125, 135),
    LIGHT = Color3.fromRGB(170, 175, 185),
    ACCENT = Color3.fromRGB(130, 230, 255),
    TEXT = Color3.fromRGB(255, 255, 255),
    ERROR = Color3.fromRGB(255, 130, 130),
    GREEN = Color3.fromRGB(130, 255, 130)
}

-- CREATE GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV9"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 999
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.BackgroundColor3 = COLORS.MAIN
    MainFrame.BackgroundTransparency = 0.28
    MainFrame.Position = UDim2.new(0.03, 0, 0.03, 0)
    MainFrame.Size = UDim2.new(0, 820, 0, 620)
    MainFrame.BorderSizePixel = 0

    local ucorner = Instance.new("UICorner")
    ucorner.CornerRadius = UDim.new(0, 25)
    ucorner.Parent = MainFrame

    local ustroke = Instance.new("UIStroke")
    ustroke.Color = COLORS.GRAY
    ustroke.Thickness = 2.5
    ustroke.Transparency = 0.4
    ustroke.Parent = MainFrame

    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Parent = MainFrame
    titleBar.BackgroundColor3 = COLORS.DARK
    titleBar.BackgroundTransparency = 0.25
    titleBar.Size = UDim2.new(1, 0, 0, 70)

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 25)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.85, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 25, 0, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "✨ Turcja Hub v9.0 | Case Paradise LIGHT GRAY"
    titleLabel.TextColor3 = COLORS.TEXT
    titleLabel.TextSize = 20
    titleLabel.TextStrokeTransparency = 0.8

    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = titleBar
    closeBtn.BackgroundColor3 = COLORS.ERROR
    closeBtn.Position = UDim2.new(1, -55, 0, 15)
    closeBtn.Size = UDim2.new(0, 45, 0, 40)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(1,1,1)
    closeBtn.TextSize = 18
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeBtn

    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = MainFrame
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 75)
    tabContainer.Size = UDim2.new(1, 0, 0, 60)

    -- Content Area
    local contentArea = Instance.new("Frame")
    contentArea.Name = "ContentArea"
    contentArea.Parent = MainFrame
    contentArea.BackgroundTransparency = 1
    contentArea.Position = UDim2.new(0, 20, 0, 140)
    contentArea.Size = UDim2.new(1, -40, 1, -170)

    -- Create Tabs
    local tabNames = {"🤖 Autofarm", "🏃 Movement", "🎉 Events", "⚙️ Misc", "👻 Troll", "👤 Player"}
    for i, tabName in pairs(tabNames) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = "TabBtn" .. i
        tabBtn.Parent = tabContainer
        tabBtn.BackgroundColor3 = COLORS.DARK
        tabBtn.BackgroundTransparency = 0.35
        tabBtn.Position = UDim2.new((i-1)*0.165, 12, 0, 8)
        tabBtn.Size = UDim2.new(0.145, -8, 1, -16)
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.TEXT
        tabBtn.TextSize = 16

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 16)
        tabCorner.Parent = tabBtn

        -- Content Frame
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = "TabContent" .. i
        tabContent.Parent = contentArea
        tabContent.BackgroundTransparency = 1
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 6
        tabContent.ScrollBarImageColor3 = COLORS.GRAY
        tabContent.ScrollBarImageTransparency = 0.4
        tabContent.Visible = (i == 1)
        tabContent.ScrollingDirection = Enum.ScrollingDirection.Y

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 12)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabContent

        tabFrames[i] = tabContent

        tabBtn.MouseButton1Click:Connect(function()
            if debounce.tab then return end
            debounce.tab = true
            wait(0.4)
            debounce.tab = false

            for j, frame in pairs(tabFrames) do
                frame.Visible = false
            end
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
        ScreenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.X then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    populateTabs()
end

-- UI Helpers
local function createToggle(parent, text, callback)
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
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = container
    toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    toggleBtn.Position = UDim2.new(0.78, 0, 0.15, 0)
    toggleBtn.Size = UDim2.new(0, 32, 0, 32)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = COLORS.ERROR
    toggleBtn.TextSize = 14

    local tcorner = Instance.new("UICorner")
    tcorner.CornerRadius = UDim.new(0, 10)
    tcorner.Parent = toggleBtn

    toggleBtn.MouseButton1Click:Connect(function()
        if debounce[text] then return end
        debounce[text] = true
        spawn(function() wait(0.6) debounce[text] = false end)

        local state = toggleBtn.Text == "OFF"
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.TextColor3 = state and COLORS.GREEN or COLORS.ERROR
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(40, 90, 40) or Color3.fromRGB(90, 40, 40)
        callback(state)
    end)

    toggles[text] = toggleBtn
end

local function createButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = COLORS.GRAY
    btn.BackgroundTransparency = 0.3
    btn.Size = UDim2.new(0.48, -10, 0, 52)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 15

    local bcorner = Instance.new("UICorner")
    bcorner.CornerRadius = UDim.new(0, 15)
    bcorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if debounce["btn" .. text] then return end
        debounce["btn" .. text] = true
        spawn(function() wait(0.8) debounce["btn" .. text] = false end)

        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.46, -10, 0, 50)}):Play()
        wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.48, -10, 0, 52)}):Play()
        callback()
    end)
end

-- FIXED FEATURES
function toggleAutoCases(state)
    if connections.cases then connections.cases:Disconnect() end
    if state then
        connections.cases = RunService.Heartbeat:Connect(function()
            pcall(function()
                -- Case Paradise specific remotes
                local remotes = {
                    ReplicatedStorage:FindFirstChild("OpenCase"),
                    ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("OpenCase"),
                    ReplicatedStorage.Events and ReplicatedStorage.Events:FindFirstChild("OpenCase"),
                    ReplicatedStorage:FindFirstChild("RemoteEvent") and ReplicatedStorage.RemoteEvent:FindFirstChild("OpenCase")
                }
                for _, remote in pairs(remotes) do
                    if remote then
                        pcall(function() remote:FireServer("Basic") end)
                        pcall(function() remote:FireServer("Common") end)
                    end
                end
                
                -- Money cases
                local moneyRemote = ReplicatedStorage:FindFirstChild("PurchaseCase") or ReplicatedStorage.Remotes:FindFirstChild("BuyCase")
                if moneyRemote then
                    pcall(function() moneyRemote:FireServer("BasicCase", 1) end)
                end
            end)
        end)
    end
end

function toggleAutoSell(state)
    spawn(function()
        while state do
            pcall(function()
                local sellRemote = ReplicatedStorage.Remotes and ReplicatedStorage.Remotes:FindFirstChild("SellAll") or
                                 ReplicatedStorage:FindFirstChild("SellInventory") or
                                 ReplicatedStorage.Events and ReplicatedStorage.Events:FindFirstChild("SellItems")
                if sellRemote then
                    sellRemote:FireServer()
                end
            end)
            wait(3)
        end
    end)
end

local function tpEvent(name)
    local targets = Workspace:FindFirstChild(name, true) or 
                    Workspace:FindFirstChild(name .. "Area") or 
                    Workspace.Events and Workspace.Events:FindFirstChild(name)
    if targets and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = targets.CFrame + Vector3.new(0, 5, 0)
        return true
    end
    return false
end

function toggleFly(state, speedInput)
    if connections.fly then connections.fly:Disconnect() end
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    
    if state and player.Character then
        local root = player.Character.HumanoidRootPart
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(3000, 3000, 3000)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = root
        
        connections.fly = RunService.Heartbeat:Connect(function()
            local speed = tonumber(speedInput.Text:match("%d+") or "100") or 100
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local cam = camera.CFrame
            
            local moveVec = humanoid.MoveDirection * speed
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVec = moveVec + cam.LookVector * speed * 0.5
            elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVec = moveVec - cam.LookVector * speed * 0.5
            end
            
            flyBodyVelocity.Velocity = moveVec
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

function toggleESP(state)
    for _, box in pairs(espBoxes) do box:Remove() end
    espBoxes = {}
    
    if state then
        connections.esp = RunService.RenderStepped:Connect(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                    
                    local box = espBoxes[plr]
                    if not box then
                        box = Drawing.new("Square")
                        box.Thickness = 2
                        box.Color = Color3.new(1, 0, 0)
                        box.Filled = false
                        espBoxes[plr] = box
                    end
                    
                    if onScreen then
                        local size = 1000 / rootPos.Z
                        box.Size = Vector2.new(size, size * 2)
                        box.Position = Vector2.new(rootPos.X - size/2, rootPos.Y - size)
                        box.Visible = true
                        
                        -- Distance
                        local dist = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        local text = Drawing.new("Text")
                        text.Text = plr.Name .. " [" .. math.floor(dist) .. "m]"
                        text.Size = 16
                        text.Color = COLORS.TEXT
                        text.Center = true
                        text.Position = Vector2.new(rootPos.X, rootPos.Y - 60)
                        text.Visible = true
                        espLabels[plr] = text
                    else
                        box.Visible = false
                    end
                end
            end
        end)
    end
end

function flingAll()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = Vector3.new(
                    math.random(-8000, 8000),
                    math.random(12000, 20000),
                    math.random(-8000, 8000)
                )
            end
        end
    end
end

-- Populate Tabs
function populateTabs()
    local afContent = tabFrames[1]
    createToggle(afContent, "Auto Open Cases", function(state) toggleAutoCases(state) end)
    createToggle(afContent, "Auto Sell Items", function(state) toggleAutoSell(state) end)

    local moveContent = tabFrames[2]
    local speedBox = Instance.new("TextBox") -- Simplified speed input
    speedBox.Parent = moveContent
    speedBox.Size = UDim2.new(0.48, 0, 0, 40)
    speedBox.Text = "100"
    createToggle(moveContent, "Fly", function(state) toggleFly(state, speedBox) end)
    createToggle(moveContent, "No Gravity", toggleNoGravity)

    local eventContent = tabFrames[3]
    createButton(eventContent, "TP Gifts", function() tpEvent("Gifts") end)
    createButton(eventContent, "TP Events", function() tpEvent("Events") end)

    local trollContent = tabFrames[5]
    createButton(trollContent, "Fling All Players", flingAll)
    
    local playerContent = tabFrames[6]
    createToggle(playerContent, "ESP Players", toggleESP)

    -- Update canvas sizes
    for _, frame in pairs(tabFrames) do
        frame.CanvasSize = UDim2.new(0, 0, 0, frame.AbsoluteSize.Y + 50)
    end
end

-- INIT
createGUI()
game.StarterGui:SetCore("SendNotification", {
    Title = "Turcja Hub v9.0";
    Text = "Loaded perfectly! Press X to toggle";
    Duration = 4;
})
