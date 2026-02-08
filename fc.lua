-- 🔥 ULTRA SAFE LOADSTRING VERSION 🔥
-- Works on Solar, Xeno, KRNL, Synapse, ALL executors
-- Case Paradise PERFECT

if getexecutorname and (getexecutorname() == "Solar" or getexecutorname() == "Xeno") then
    task.wait(3)
else
    task.wait(1.5)
end

-- SAFE CLEANUP
local success1, _ = pcall(function()
    for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "TurciaHub" then v:Destroy() end
    end
end)

local success2, _ = pcall(function()
    for _, v in pairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
        if v.Name == "TurciaHub" then v:Destroy() end
    end
end)

-- SERVICES
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function fireRemote(name, ...)
    pcall(function()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj.Name == name and obj:IsA("RemoteEvent") then
                obj:FireServer(...)
                return
            end
        end
    end)
end

-- CREATE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.IgnoreGuiInset = true

-- TRY CORE GUI FIRST
local guiSuccess = pcall(function()
    ScreenGui.Parent = CoreGui
end)

if not guiSuccess then
    -- FALLBACK PLAYER GUI
    ScreenGui.Parent = PlayerGui
end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 215, 0)
UIStroke.Thickness = 2.5
UIStroke.Parent = MainFrame

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 TURCIA HUB | CASE PARADISE"
TitleLabel.TextColor3 = Color3.new(1,1,1)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- TABS
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 45)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -95)
ContentFrame.Position = UDim2.new(0, 0, 0, 95)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 5
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentFrame

-- TOGGLE/SLIDER STATE
local toggles = {}
local sliders = {}

local function createToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 40)
    toggleBtn.Position = UDim2.new(1, -70, 0.15, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.new(1,1,1)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = toggleBtn
    
    toggles[text] = false
    
    toggleBtn.MouseButton1Click:Connect(function()
        toggles[text] = not toggles[text]
        toggleBtn.Text = toggles[text] and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = toggles[text] and Color3.fromRGB(60, 255, 60) or Color3.fromRGB(200, 60, 60)
        if callback then callback(toggles[text]) end
    end)
end

local function createSlider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 75)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    frame.BorderSizePixel = 0
    frame.Parent = ContentFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0.4, 0)
    label.Position = UDim2.new(0, 15, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.38, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.6, 0, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    valueLabel.TextScaled = true
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.Parent = frame
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -30, 0, 20)
    sliderBar.Position = UDim2.new(0, 15, 0.5, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = frame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 10)
    barCorner.Parent = sliderBar
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 10)
    fillCorner.Parent = fill
    
    local dragging = false
    local value = default
    sliders[text] = default
    
    local function updateSlider()
        local percent = math.clamp((value - min) / (max - min), 0, 1)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        valueLabel.Text = math.floor(value)
        sliders[text] = value
        if callback then callback(value) end
    end
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    RunService.RenderStepped:Connect(function()
        if dragging and sliderBar.AbsoluteSize.X > 0 then
            local mouse = UserInputService:GetMouseLocation()
            local percent = math.clamp((mouse.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percent
            updateSlider()
        end
    end)
end

-- FEATURES
createToggle("Auto Farm Money", function(state)
    spawn(function()
        while toggles["Auto Farm Money"] do
            fireRemote("FarmMoney")
            task.wait(sliders["Farm Delay"] or 0.1)
        end
    end)
end)

createToggle("Auto Open Cases", function(state)
    spawn(function()
        while toggles["Auto Open Cases"] do
            fireRemote("OpenCase")
            task.wait(0.15)
        end
    end)
end)

createSlider("Farm Delay", 0.01, 2, 0.1)

createSlider("WalkSpeed", 16, 500, 100, function(value)
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end)
end)

local flyVelocity = nil
createToggle("Fly (WASD+Space)", function(state)
    if flyVelocity then
        flyVelocity:Destroy()
        flyVelocity = nil
    end
    
    if state then
        spawn(function()
            repeat task.wait() until LocalPlayer.Character
            local root = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            flyVelocity.Parent = root
            
            local conn
            conn = RunService.Heartbeat:Connect(function()
                if not toggles["Fly (WASD+Space)"] then
                    conn:Disconnect()
                    if flyVelocity then flyVelocity:Destroy() end
                    return
                end
                
                local cam = workspace.CurrentCamera
                local vel = Vector3.new()
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cam.CFrame.RightVector end
                if UserInputService:IsKeyCode.D then vel = vel + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0,1,0) end
                
                flyVelocity.Velocity = vel * 50
            end)
        end)
    end
end)

createToggle("Noclip", function(state)
    spawn(function()
        while toggles["Noclip"] do
            pcall(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            task.wait()
        end
    end)
end)

createToggle("Fullbright", function(state)
    Lighting.Brightness = state and 2 or 1
    Lighting.GlobalShadows = not state
end)

createToggle("FPS Boost", function(state)
    settings().Rendering.QualityLevel = state and Enum.SavedQualitySetting.Performance or Enum.SavedQualitySetting.Automatic
end)

-- REJOIN BUTTON
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(1, 0, 0, 50)
rejoinBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 120)
rejoinBtn.Text = "🔄 REJOIN SERVER"
rejoinBtn.TextColor3 = Color3.new(1,1,1)
rejoinBtn.TextScaled = true
rejoinBtn.Font = Enum.Font.GothamBold
rejoinBtn.Parent = ContentFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = rejoinBtn

rejoinBtn.MouseButton1Click:Connect(function()
    TeleportService:Teleport(game.PlaceId)
end)

-- TOGGLE GUI
UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- AUTO APPLY ON SPAWN
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if sliders["WalkSpeed"] then
        pcall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = sliders["WalkSpeed"]
        end)
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Turcia Hub";
    Text = "Loaded! Press INSERT to toggle";
    Duration = 3;
})

print("🎉 TURCIA HUB LOADED - PRESS INSERT TO TOGGLE!")
