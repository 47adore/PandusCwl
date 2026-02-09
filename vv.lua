-- Case Paradise FULL GUI SCRIPT by HackerAI
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Anti-Detection
getgenv().AutoFarmEnabled = false
getgenv().AutoOpenCases = false
getgenv().AutoSellTrash = false
getgenv().SpeedHack = false
getgenv().WalkSpeed = 16
getgenv().JumpPower = 50

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleAutoFarm = Instance.new("TextButton")
local ToggleCases = Instance.new("TextButton")
local ToggleSell = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")
local JumpSlider = Instance.new("TextBox")
local KeybindLabel = Instance.new("TextLabel")

ScreenGui.Name = "CaseParadiseGUI"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

-- Corner Radius
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "Case Paradise HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- Toggle Buttons
local function createToggle(name, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Font = Enum.Font.Gotham
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        callback()
        btn.Text = name .. ": " .. (getgenv()[name:gsub(" ", ""):gsub(":", "")] and "ON" or "OFF")
    end)
    return btn
end

-- Auto Functions
local function autoQuests()
    spawn(function()
        while getgenv().AutoFarmEnabled do
            pcall(function()
                -- Znajdź i wykonaj questy
                for _, quest in pairs(workspace.Quests:GetChildren()) do
                    if quest:FindFirstChild("ClickDetector") then
                        fireclickdetector(quest.ClickDetector)
                    end
                end
            end)
            wait(0.1)
        end
    end)
end

local function autoOpenCases()
    spawn(function()
        while getgenv().AutoOpenCases do
            pcall(function()
                -- Auto otwieranie skrzynek
                local remote = ReplicatedStorage.Remotes.OpenCase
                if remote then
                    remote:FireServer("common") -- lub "rare" itp.
                end
            end)
            wait(1)
        end
    end)
end

local function autoSellTrash()
    spawn(function()
        while getgenv().AutoSellTrash do
            pcall(function()
                local remote = ReplicatedStorage.Remotes.SellItem
                if remote then
                    remote:FireServer("trash_item_name")
                end
            end)
            wait(2)
        end
    end)
end

-- Toggles
ToggleAutoFarm = createToggle("Auto Quests", 70, function()
    getgenv().AutoFarmEnabled = not getgenv().AutoFarmEnabled
    if getgenv().AutoFarmEnabled then autoQuests() end
end)

ToggleCases = createToggle("Auto Cases", 130, function()
    getgenv().AutoOpenCases = not getgenv().AutoOpenCases
    if getgenv().AutoOpenCases then autoOpenCases() end
end)

ToggleSell = createToggle("Auto Sell Trash", 190, function()
    getgenv().AutoSellTrash = not getgenv().AutoSellTrash
    if getgenv().AutoSellTrash then autoSellTrash() end
end)

-- Sliders
SpeedSlider.Parent = MainFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
SpeedSlider.Position = UDim2.new(0.05, 0, 0, 260)
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 40)
SpeedSlider.PlaceholderText = "Speed: 16"
SpeedSlider.Text = "16"
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = SpeedSlider

JumpSlider.Parent = MainFrame
JumpSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
JumpSlider.Position = UDim2.new(0.05, 0, 0, 310)
JumpSlider.Size = UDim2.new(0.9, 0, 0, 40)
JumpSlider.PlaceholderText = "Jump: 50"
JumpSlider.Text = "50"
local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = JumpSlider

-- Keybind
KeybindLabel.Parent = MainFrame
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.Position = UDim2.new(0.05, 0, 0, 360)
KeybindLabel.Size = UDim2.new(0.9, 0, 0, 30)
KeybindLabel.Font = Enum.Font.Gotham
KeybindLabel.Text = "Toggle GUI: X"
KeybindLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
KeybindLabel.TextScaled = true

-- Events
SpeedSlider.FocusLost:Connect(function()
    getgenv().WalkSpeed = tonumber(SpeedSlider.Text) or 16
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = getgenv().WalkSpeed
    end
end)

JumpSlider.FocusLost:Connect(function()
    getgenv().JumpPower = tonumber(JumpSlider.Text) or 50
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = getgenv().JumpPower
    end
end)

-- Character Speed/Jump
player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = getgenv().WalkSpeed
    humanoid.JumpPower = getgenv().JumpPower
end)

-- Toggle GUI Keybind (X)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Minimize on start
ScreenGui.Enabled = false
print("Case Paradise GUI loaded! Press X to toggle")
