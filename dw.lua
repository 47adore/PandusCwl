-- Case Paradise SUSANO V2 by HackerAI
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

getgenv().CP_V2 = {
    AutoQuests = false,
    AutoCases = false,
    SmartSell = false,
    InfiniteCases = false,
    WalkSpeed = 16,
    JumpPower = 50
}

-- ADVANCED GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SusanoCP"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.ClipsDescendants = true

-- Glass Effect
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 150, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.5
UIStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 60)

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "CASE PARADISE | SUSANO V2"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextScaled = true

-- TOGGLE BUTTONS (CS2 Style)
local function createModernToggle(name, posY, callback, color)
    local Container = Instance.new("Frame")
    Container.Parent = MainFrame
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Container.BackgroundTransparency = 0.2
    Container.Position = UDim2.new(0.05, 0, 0, posY)
    Container.Size = UDim2.new(0.9, 0, 0, 55)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = Container
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ToggleBtn.Position = UDim2.new(0.75, 0, 0.15, 0)
    ToggleBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ToggleBtn.TextScaled = true
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = ToggleBtn
    
    ToggleBtn.MouseButton1Click:Connect(function()
        local state = not getgenv().CP_V2[name:gsub(" ", "")]
        getgenv().CP_V2[name:gsub(" ", "")] = state
        callback(state)
        
        ToggleBtn.Text = state and "ON" or "OFF"
        ToggleBtn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and color or Color3.fromRGB(60, 60, 80)}):Play()
    end)
end

-- SLIDER (Modern)
local function createSlider(name, posY, min, max, default)
    local Container = Instance.new("Frame")
    Container.Parent = MainFrame
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Container.BackgroundTransparency = 0.2
    Container.Position = UDim2.new(0.05, 0, 0, posY)
    Container.Size = UDim2.new(0.9, 0, 0, 55)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextScaled = true
    
    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Container
    ValueBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    ValueBox.Position = UDim2.new(0.55, 0, 0.15, 0)
    ValueBox.Size = UDim2.new(0.38, 0, 0.7, 0)
    ValueBox.Font = Enum.Font.Gotham
    ValueBox.Text = tostring(default)
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueBox.TextScaled = true
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 8)
    BoxCorner.Parent = ValueBox
    
    ValueBox.FocusLost:Connect(function()
        local val = math.clamp(tonumber(ValueBox.Text) or default, min, max)
        getgenv().CP_V2[name:gsub(" ", "")] = val
        ValueBox.Text = tostring(val)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid[name == "Walk Speed" and "WalkSpeed" or "JumpPower"] = val
        end
    end)
end

-- CREATE TOGGLES
createModernToggle("Auto Quests", 85, function(state)
    if state then spawn(autoQuestsLoop) end
end, Color3.fromRGB(100, 200, 255))

createModernToggle("Auto Cases", 150, function(state)
    if state then spawn(autoCaseLoop) end
end, Color3.fromRGB(255, 200, 100))

createModernToggle("Smart Sell", 215, function(state)
    if state then spawn(smartSellLoop) end
end, Color3.fromRGB(200, 100, 255))

createModernToggle("Infinite Cases", 280, function(state)
    if state then spawn(infiniteCases) end
end, Color3.fromRGB(100, 255, 150))

-- SLIDERS
createSlider("Walk Speed", 345, 16, 200, 50)
createSlider("Jump Power", 410, 50, 300, 100)

-- ADVANCED LOOPS
function autoQuestsLoop()
    while getgenv().CP_V2.AutoQuests do
        pcall(function()
            -- Divine Quest Handler (Open 40 Hardened etc.)
            local quests = ReplicatedStorage.Quests:GetChildren()
            for _, quest in pairs(quests) do
                if quest.Name:find("Open") and quest.Name:find("cases") then
                    local caseType = quest.Name:match("%d+ (%w+) cases") or "hardened"
                    ReplicatedStorage.Remotes.OpenCase:FireServer(caseType:lower())
                else
                    -- Normal quests
                    fireclickdetector(quest:FindFirstChild("ClickDetector"))
                end
            end
        end)
        wait(0.5)
    end
end

function autoCaseLoop()
    while getgenv().CP_V2.AutoCases do
        pcall(function()
            ReplicatedStorage.Remotes.OpenCase:FireServer("hardened") -- Najlepsze cases
        end)
        wait(1)
    end
end

function smartSellLoop()
    while getgenv().CP_V2.SmartSell do
        pcall(function()
            -- Sprzedaj tylko trash (wartość < 100 coins)
            local inventory = ReplicatedStorage.Inventory:GetChildren()
            for _, item in pairs(inventory) do
                if item.Value < 100 then
                    ReplicatedStorage.Remotes.SellItem:FireServer(item.Name)
                end
            end
        end)
        wait(3)
    end
end

function infiniteCases()
    while getgenv().CP_V2.InfiniteCases do
        pcall(function()
            -- Duplikuj klucze + auto open
            ReplicatedStorage.Remotes.DuplicateKey:FireServer()
            ReplicatedStorage.Remotes.OpenCase:FireServer("dragon")
        end)
        wait(0.1)
    end
end

-- Character Handler
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = getgenv().CP_V2.WalkSpeed
    hum.JumpPower = getgenv().CP_V2.JumpPower
end)

-- Draggable + Keybind
local dragging = false
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.Heartbeat:Connect(function()
    if dragging then
        local mouse = player:GetMouse()
        MainFrame.Position = UDim2.new(0, mouse.X - 225, 0, mouse.Y - 175)
    end
end)

-- X KEY TOGGLE (Invisible start)
ScreenGui.Enabled = false
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = ScreenGui.Enabled and UDim2.new(0, 450, 0, 350) or UDim2.new(0, 0, 0, 0)
        }):Play()
    end
end)

print("🌀 Susano Case Paradise V2 LOADED | Press X")
