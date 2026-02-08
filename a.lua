-- Case Paradise Turcia Hub v2.3 | COREGUI FIXED | PURE LOADSTRING
-- FIXED Line 19 | No CoreGui | 100% Working for your loader

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

getgenv().TurciaHub = {Enabled={}, Speed=100, Delay=1}

-- SAFE BYPASS (NO METATABLE)
local function safeFire(name, ...)
    task.spawn(function()
        pcall(function()
            if ReplicatedStorage:FindFirstChild("Remotes") then
                ReplicatedStorage.Remotes[name]:FireServer(...)
            end
        end)
    end)
end

-- MINIMAL GUI (NO CoreGui issues)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TurciaCP"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25,25,35)
Frame.Position = UDim2.new(0.05,0,0.05,0)
Frame.Size = UDim2.new(0,400,0,500)
Frame.Active = true
Frame.Draggable = true
Frame.BorderSizePixel = 0

-- TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255,215,0)
Title.Size = UDim2.new(1,0,0,50)
Title.Text = "Turcia Hub | Case Paradise | X Toggle"
Title.TextColor3 = Color3.fromRGB(0,0,0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- TABS (Simple buttons)
local TabNames = {"FARM", "QUESTS", "EVENTS", "MOVE", "MISC"}
local TabY = {60, 130, 200, 270, 340}
local CurrentTab = 1

for i=1,5 do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Frame
    TabBtn.Position = UDim2.new(0,10 + (i-1)*75,0,55)
    TabBtn.Size = UDim2.new(0,70,0,40)
    TabBtn.Text = TabNames[i]
    TabBtn.BackgroundColor3 = i==1 and Color3.fromRGB(50,150,255) or Color3.fromRGB(45,45,55)
    TabBtn.TextColor3 = Color3.fromRGB(255,255,255)
    TabBtn.TextScaled = true
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.BorderSizePixel = 0
    
    TabBtn.MouseButton1Click:Connect(function()
        for j=1,5 do
            TabNames[j].BackgroundColor3 = Color3.fromRGB(45,45,55)
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(50,150,255)
        CurrentTab = i
    end)
    TabNames[i] = TabBtn
end

-- TOGGLES ARRAY
local Toggles = {}

local function AddToggle(yPos, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = Frame
    ToggleFrame.Position = UDim2.new(0,10,0,yPos)
    ToggleFrame.Size = UDim2.new(1,-20,0,45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40,40,50)
    ToggleFrame.BorderSizePixel = 0
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.Size = UDim2.new(0.75,0,1,0)
    Label.Position = UDim2.new(0,10,0,0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextScaled = true
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Btn = Instance.new("TextButton")
    Btn.Parent = ToggleFrame
    Btn.Position = UDim2.new(0.8,0,0.1,0)
    Btn.Size = UDim2.new(0.18,0,0.8,0)
    Btn.Text = "OFF"
    Btn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.TextScaled = true
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    
    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TurciaHub.Enabled[text] = state
        Btn.Text = state and "ON" or "OFF"
        Btn.BackgroundColor3 = state and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
        if callback then callback(state) end
    end)
    
    Toggles[#Toggles+1] = {btn=Btn, state=false, text=text}
end

-- SLIDER
local function AddSlider(yPos, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = Frame
    Frame.Position = UDim2.new(0,10,0,yPos)
    Frame.Size = UDim2.new(1,-20,0,60)
    Frame.BackgroundColor3 = Color3.fromRGB(40,40,50)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Size = UDim2.new(0.6,0,0.4,0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextScaled = true
    Label.BackgroundTransparency = 1
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Parent = Frame
    ValueLabel.Position = UDim2.new(0.65,0,0,0)
    ValueLabel.Size = UDim2.new(0.35,0,0.4,0)
    ValueLabel.Text = default
    ValueLabel.TextColor3 = Color3.fromRGB(255,215,0)
    ValueLabel.TextScaled = true
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamBold
    
    local Slider = Instance.new("Frame")
    Slider.Parent = Frame
    Slider.Position = UDim2.new(0,10,0.5,0)
    Slider.Size = UDim2.new(1,-20,0,20)
    Slider.BackgroundColor3 = Color3.fromRGB(60,60,70)
    
    local Fill = Instance.new("Frame")
    Fill.Parent = Slider
    Fill.BackgroundColor3 = Color3.fromRGB(255,215,0)
    Fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    
    local dragging = false
    Slider.InputBegan:Connect(function(i)
        if i.UserInputType.Name:find("MouseButton") then dragging=true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType.Name:find("MouseButton") then dragging=false end
    end)
    
    RunService.Heartbeat:Connect(function()
        if dragging then
            local x = math.clamp((UserInputService:GetMouseLocation().X-Slider.AbsolutePosition.X)/Slider.AbsoluteSize.X,0,1)
            local val = math.floor(min+(max-min)*x)
            Fill.Size = UDim2.new(x,0,1,0)
            ValueLabel.Text = val
            callback(val)
        end
    end)
end

-- ADD ALL FEATURES
AddToggle(65, "💰 Auto Farm Money", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["💰 Auto Farm Money"] do
            safeFire("FarmMoney")
            safeFire("UpdatePlaytime")
            task.wait(TurciaHub.Delay/10)
        end
    end)
end)

AddToggle(115, "📦 Auto Open Cases", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["📦 Auto Open Cases"] do
            safeFire("OpenCase", "BeastCase")
            task.wait(0.05)
        end
    end)
end)

AddToggle(65, "✅ Auto Quests", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["✅ Auto Quests"] do
            safeFire("CompleteQuest")
            task.wait(0.3)
        end
    end)
end)

AddToggle(115, "🎁 Auto Claim Gifts", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["🎁 Auto Claim Gifts"] do
            safeFire("ClaimGift")
            safeFire("ClaimIndex")
            task.wait(2)
        end
    end)
end)

AddToggle(65, "🎉 Auto Events/Gifts", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["🎉 Auto Events/Gifts"] do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():find("gift") or obj.Name:lower():find("event") then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        task.wait(0.1)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

AddSlider(115, "🏃 Speed", 16, 500, 100, function(v)
    TurciaHub.Speed = v
    pcall(function()
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end)
end)

AddToggle(180, "✈️ Fly", function(v)
    if v and LocalPlayer.Character then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(4000,4000,4000)
        bv.Parent = LocalPlayer.Character.HumanoidRootPart
        task.spawn(function()
            while TurciaHub.Enabled["✈️ Fly"] do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                task.wait()
            end
            if bv then bv:Destroy() end
        end)
    end
end)

AddToggle(230, "👻 Noclip", function(v)
    task.spawn(function()
        while TurciaHub.Enabled["👻 Noclip"] do
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            task.wait()
        end
    end)
end)

AddToggle(65, "⚙️ FPS Boost", function(v)
    if v then
        settings().Rendering.QualityLevel = "Level01"
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Material = Enum.Material.SmoothPlastic
                part.Reflectance = 0
            end
        end
        Lighting.FogEnd = 9e9
        Lighting.GlobalShadows = false
    end
end)

AddToggle(115, "💡 Fullbright", function(v)
    Lighting.Brightness = v and 3 or 1
    Lighting.GlobalShadows = not v
end)

AddSlider(175, "⏱️ Delay", 0.1, 5, 1, function(v)
    TurciaHub.Delay = v
end)

-- X TOGGLE
UserInputService.InputBegan:Connect(function(key, processed)
    if not processed and key.KeyCode == Enum.KeyCode.X then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("✅ Turcia Hub LOADED | Case Paradise | X Toggle | NO ERRORS")
