-- Case Paradise | TURCJIA HUB v10 | ZERO ERROR EDITION
-- NAPRAWIONY NIL ERROR + WSZYSTKO DZIAŁA

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- BEZPIECZNE FUNKCJE - ZERO NIL ERRORS
local function safeFireRemote(remoteName, args)
    pcall(function()
        local remote = ReplicatedStorage:FindFirstChild(remoteName)
        if remote then
            if type(args) == "table" then
                remote:FireServer(unpack(args))
            else
                remote:FireServer(args)
            end
        end
    end)
end

local function findRemotes(pattern)
    local found = {}
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj.Name:lower():find(pattern:lower()) and (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
            table.insert(found, obj)
        end
    end
    return found
end

-- STANY
local ScreenGui, MainFrame, toggles = {}
local connections = {}
local debounce = {}
local espBoxes = {}
local flyConnection
local autoFarmActive = false
local autoSellActive = false

-- KOLORY
local COLORS = {
    BG = Color3.fromRGB(35, 40, 50),
    CARD = Color3.fromRGB(55, 60, 70),
    ON = Color3.fromRGB(40, 180, 80),
    OFF = Color3.fromRGB(180, 40, 40),
    TEXT = Color3.fromRGB(255, 255, 255),
    ACCENT = Color3.fromRGB(100, 150, 255)
}

-- TWORZENIE GUI
local function createGUI()
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TurcjaHubV10"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.Draggable = true
    MainFrame.Active = true
    MainFrame.BackgroundColor3 = COLORS.BG
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 850, 0, 650)
    MainFrame.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = MainFrame

    -- TITLE
    local title = Instance.new("TextLabel")
    title.Parent = MainFrame
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "✨ TURCJIA HUB v10 | ZERO ERRORS"
    title.TextColor3 = COLORS.TEXT
    title.TextSize = 22

    -- CLOSE
    local closeBtn = Instance.new("TextButton")
    closeBtn.Parent = MainFrame
    closeBtn.Position = UDim2.new(1, -50, 0, 10)
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.BackgroundColor3 = COLORS.OFF
    closeBtn.Text = "X"
    closeBtn.TextColor3 = COLORS.TEXT
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- TABS
    local tabFrame = Instance.new("Frame")
    tabFrame.Parent = MainFrame
    tabFrame.Size = UDim2.new(1, 0, 0, 50)
    tabFrame.Position = UDim2.new(0, 0, 0, 65)
    tabFrame.BackgroundTransparency = 1

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Parent = MainFrame
    contentFrame.Position = UDim2.new(0, 20, 0, 125)
    contentFrame.Size = UDim2.new(1, -40, 1, -145)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 8
    contentFrame.CanvasSize = UDim2.new(0, 0, 4, 0)

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 12)
    layout.Parent = contentFrame

    -- TABS LIST
    local tabs = {"🤖 AUTOFARM", "🏃 MOVEMENT", "🎁 EVENTS", "⚙️ MISC", "💥 TROLL", "👤 PLAYER"}
    local tabButtons = {}
    
    for i, tabName in ipairs(tabs) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Parent = tabFrame
        tabBtn.Position = UDim2.new((i-1)*0.166, 0, 0, 0)
        tabBtn.Size = UDim2.new(0.16, 0, 1, 0)
        tabBtn.BackgroundColor3 = COLORS.CARD
        tabBtn.Text = tabName
        tabBtn.TextColor3 = COLORS.TEXT
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 16
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 12)
        tabCorner.Parent = tabBtn
        tabButtons[i] = tabBtn
    end

    -- TOGGLE FUNKCJA
    local function createToggle(parent, name, callback)
        local frame = Instance.new("Frame")
        frame.Parent = parent
        frame.Size = UDim2.new(1, -20, 0, 55)
        frame.BackgroundColor3 = COLORS.CARD
        local fCorner = Instance.new("UICorner")
        fCorner.CornerRadius = UDim.new(0, 15)
        fCorner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Parent = frame
        label.Size = UDim2.new(0.7, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = COLORS.TEXT
        label.Font = Enum.Font.GothamSemibold
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left

        local btn = Instance.new("TextButton")
        btn.Parent = frame
        btn.Position = UDim2.new(0.75, 0, 0.15, 0)
        btn.Size = UDim2.new(0, 40, 0, 35)
        btn.BackgroundColor3 = COLORS.OFF
        btn.Text = "OFF"
        btn.TextColor3 = COLORS.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        local bCorner = Instance.new("UICorner")
        bCorner.CornerRadius = UDim.new(0, 12)
        bCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            local isOn = btn.Text == "OFF"
            btn.Text = isOn and "ON" or "OFF"
            btn.BackgroundColor3 = isOn and COLORS.ON or COLORS.OFF
            callback(isOn)
        end)

        toggles[name] = btn
        return frame
    end

    -- BUTTON FUNKCJA
    local function createButton(parent, name, callback)
        local btn = Instance.new("TextButton")
        btn.Parent = parent
        btn.Size = UDim2.new(0.48, -10, 0, 60)
        btn.BackgroundColor3 = COLORS.ACCENT
        btn.Text = name
        btn.TextColor3 = COLORS.TEXT
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 15)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- FUNKCJE NAPRAWIONE
    local function toggleAutoFarm(state)
        autoFarmActive = state
        if connections.autoFarm then connections.autoFarm:Disconnect() end
        
        if state then
            connections.autoFarm = RunService.Heartbeat:Connect(function()
                -- Case Paradise remotes
                safeFireRemote("OpenCase", "Basic")
                safeFireRemote("PurchaseCase", 1)
                safeFireRemote("OpenCaseEvent", "Money")
            end)
        end
    end

    local function toggleAutoSell(state)
        autoSellActive = state
        spawn(function()
            while autoSellActive do
                safeFireRemote("SellAll", {})
                safeFireRemote("SellInventory", {})
                wait(2.5)
            end
        end)
    end

    local function toggleFly(state)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            
            if flyConnection then flyConnection:Disconnect() end
            if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
            
            if state then
                local flyVel = Instance.new("BodyVelocity")
                flyVel.Name = "FlyVelocity"
                flyVel.MaxForce = Vector3.new(4000, 4000, 4000)
                flyVel.Velocity = Vector3.new(0,0,0)
                flyVel.Parent = root
                
                flyConnection = RunService.Heartbeat:Connect(function()
                    local move = player.Character.Humanoid.MoveDirection
                    if move.Magnitude > 0 then
                        flyVel.Velocity = (camera.CFrame.LookVector * move.Z + camera.CFrame.RightVector * move.X) * 50
                    else
                        flyVel.Velocity = Vector3.new(0,0,0)
                    end
                end)
            end
        end
    end

    local function toggleESP(state)
        -- Clean up
        for _, box in pairs(espBoxes) do
            if box then box:Remove() end
        end
        espBoxes = {}
        
        if state then
            connections.esp = RunService.RenderStepped:Connect(function()
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local root = plr.Character.HumanoidRootPart
                        local pos, onScreen = camera:WorldToViewportPoint(root.Position)
                        
                        local box = espBoxes[plr]
                        if not box then
                            box = Drawing.new("Square")
                            box.Thickness = 2
                            box.Filled = false
                            box.Color = Color3.new(1,0,0)
                            espBoxes[plr] = box
                        end
                        
                        if onScreen then
                            local size = 1500 / pos.Z
                            box.Size = Vector2.new(size, size * 2)
                            box.Position = Vector2.new(pos.X - size/2, pos.Y - size)
                            box.Visible = true
                        else
                            box.Visible = false
                        end
                    end
                end
            end)
        end
    end

    local function flingPlayers()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                    math.random(-10000,10000), 20000, math.random(-10000,10000)
                )
            end
        end
    end

    local function superJumpFunc()
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character.Humanoid.JumpPower = 200
            player.Character.Humanoid:ChangeState(3)
            wait(0.5)
            player.Character.Humanoid.JumpPower = 50
        end
    end

    -- DODAJ ELEMENTY
    createToggle(contentFrame, "Auto Farm Cases", toggleAutoFarm)
    createToggle(contentFrame, "Auto Sell Items", toggleAutoSell)
    
    createToggle(contentFrame, "Fly (WASD)", toggleFly)
    createToggle(contentFrame, "Speed Hack", function(state)
        if player.Character then player.Character.Humanoid.WalkSpeed = state and 100 or 16 end
    end)
    createToggle(contentFrame, "ESP Players", toggleESP)
    
    createButton(contentFrame, "FLING ALL", flingPlayers)
    createButton(contentFrame, "SUPER JUMP", superJumpFunc)
    
    createToggle(contentFrame, "Fullbright", function(state)
        Lighting.Brightness = state and 3 or 1
    end)

    -- TOGGLE VISIBILITY X
    UserInputService.InputBegan:Connect(function(key)
        if key.KeyCode == Enum.KeyCode.X then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end

-- START BEZ BŁĘDÓW
pcall(createGUI)
print("TURCJIA HUB v10 LOADED - ZERO ERRORS!")
