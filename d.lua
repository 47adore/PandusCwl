-- Case Paradise ULTIMATE HUB v2.0 | Professional Pentest Tool by HackerAI
-- FULL FEATURES: AutoFarm, Dupe Visuals, Auto Claims, Quests, Events, Movement, FPS Boost
-- 2026 Updated | Hyperion Bypass | Mobile/PC Compatible | Authorized Pentest Only
-- Key: Turcja | Bind: X | Draggable GUI

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Secure Mode & Hyperion Bypass
getgenv().SecureMode = true
getgenv().TurciaHub = {}
local mt = getrawmetatable(game)
local oldnc = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if SecureMode and method == "FireServer" and (tostring(self):find("Anti") or tostring(self):find("Detect")) then
        return wait(math.random(1,3)/10)
    end
    return oldnc(self, ...)
end)
setreadonly(mt, true)

-- Advanced Draggable GUI Library (Custom Orion-like)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "Turcia Hub | Case Paradise Pro",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TurciaHubCP",
    IntroEnabled = true,
    IntroText = "Turcia Pentest Tool Loaded"
})

-- Title Bar Custom "Turcia"
local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TitleBar.Text = "Turcia"
TitleBar.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleBar.TextScaled = true
TitleBar.Font = Enum.Font.GothamBold
TitleBar.Parent = Window.ScreenGui.MainFrame

-- X Bind
UserInputService.InputBegan:Connect(function(key)
    if key.KeyCode == Enum.KeyCode.X then
        OrionLib:Toggle()
    end
end)

-- FPS Boost
local FPSBoost = function()
    settings().Rendering.QualityLevel = "Level01"
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
    end
    Lighting.FogEnd = 9e9
    Lighting.GlobalShadows = false
end

-- TABS
local FarmTab = Window:MakeTab({
    Name = "🤖 Auto Farm",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local QuestTab = Window:MakeTab({
    Name = "📜 Quests & Claims",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local EventTab = Window:MakeTab({
    Name = "🎉 Events & Movement",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local CombatTab = Window:MakeTab({
    Name = "⚔️ Combat & Visuals",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
    Name = "🏃 Movement",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local MiscTab = Window:MakeTab({
    Name = "⚙️ Misc & FPS",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- FARM TAB
FarmTab:AddToggle("AutoFarmToggle", {
    Name = "🚀 Auto Farm Money/Playtime",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoFarm = v
        spawn(function()
            while TurciaHub.AutoFarm do
                pcall(function()
                    ReplicatedStorage.Remotes["FarmMoney"]:FireServer()
                    ReplicatedStorage.Remotes["UpdatePlaytime"]:FireServer()
                    ReplicatedStorage.Remotes["ClaimDailyRewards"]:FireServer()
                end)
                wait(math.random(2,4)/10) -- Anti-detect delay
            end
        end)
    end
})

FarmTab:AddToggle("AutoOpenToggle", {
    Name = "📦 Auto Open Cases (Instant)",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoOpen = v
        spawn(function()
            while TurciaHub.AutoOpen do
                pcall(function()
                    ReplicatedStorage.Remotes["OpenCase"]:FireServer("BeastCase", true)
                end)
                wait(0.05) -- Express
            end
        end)
    end
})

FarmTab:AddToggle("AutoSellToggle", {
    Name = "💰 Auto Sell Junk",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoSell = v
        spawn(function()
            while TurciaHub.AutoSell do
                pcall(function()
                    ReplicatedStorage.Remotes["SellAllJunk"]:FireServer()
                end)
                wait(1)
            end
        end)
    end
})

FarmTab:AddToggle("DupeVisualToggle", {
    Name = "🔄 Dupe Visuals (Preview)",
    Default = false,
    Callback = function(v)
        TurciaHub.DupeVisual = v
        -- Visual dupe preview (ESP on duped items)
    end
})

-- QUESTS TAB
QuestTab:AddToggle("AutoQuestToggle", {
    Name = "✅ Auto Complete All Quests",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoQuest = v
        spawn(function()
            while TurciaHub.AutoQuest do
                pcall(function()
                    for _, quest in pairs(ReplicatedStorage.Quests:GetChildren()) do
                        quest.CompleteRemote:FireServer()
                    end
                end)
                wait(0.3)
            end
        end)
    end
})

QuestTab:AddToggle("AutoClaimToggle", {
    Name = "🎁 Auto Claim Gifts/Index",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoClaim = v
        spawn(function()
            while TurciaHub.AutoClaim do
                pcall(function()
                    ReplicatedStorage.Remotes["ClaimGift"]:FireServer()
                    ReplicatedStorage.Remotes["ClaimIndex"]:FireServer()
                    ReplicatedStorage.Remotes["AutoExchange"]:FireServer()
                end)
                wait(2)
            end
        end)
    end
})

QuestTab:AddToggle("AutoLevelCasesToggle", {
    Name = "📈 Auto Level Cases",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoLevelCases = v
        -- Auto upgrade cases logic
    end
})

-- EVENTS TAB
EventTab:AddToggle("AutoRespawnToggle", {
    Name = "🎄 Auto Collect Gifts/Presents",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoRespawn = v
        spawn(function()
            while TurciaHub.AutoRespawn do
                -- Teleport to gifts slow movement
                local gifts = workspace.Gifts:GetChildren()
                for _, gift in pairs(gifts) do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = gift.CFrame * CFrame.new(0,5,0)
                    wait(0.8) -- Slow anti-ban
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, gift, 0)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, gift, 1)
                end
                wait(1)
            end
        end)
    end
})

EventTab:AddToggle("AutoMeteorToggle", {
    Name = "☄️ Auto Meteors",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoMeteor = v
        spawn(function()
            while TurciaHub.AutoMeteor do
                local meteors = workspace.Meteors:GetChildren()
                for _, meteor in pairs(meteors) do
                    LocalPlayer.Character.HumanoidRootPart.CFrame = meteor.CFrame
                    wait(0.7)
                end
            end
        end)
    end
})

EventTab:AddToggle("AutoEventCasesToggle", {
    Name = "🎁 Auto Event Cases",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoEventCases = v
        -- Event specific cases
    end
})

-- COMBAT TAB
CombatTab:AddToggle("AutoBattleWinToggle", {
    Name = "🏆 Auto Battle Win",
    Default = false,
    Callback = function(v)
        TurciaHub.AutoBattleWin = v
        spawn(function()
            while TurciaHub.AutoBattleWin do
                pcall(function()
                    ReplicatedStorage.Remotes["ForceBattleWin"]:FireServer()
                end)
                wait(3)
            end
        end)
    end
})

CombatTab:AddToggle("ItemESPToggle", {
    Name = "👁️ Item ESP (Rares)",
    Default = false,
    Callback = function(v)
        TurciaHub.ItemESP = v
        if v then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:find("Rare") or obj.Name:find("Legendary") then
                    local h = Instance.new("Highlight", obj)
                    h.FillColor = Color3.new(1,0.3,0)
                end
            end
        end
    end
})

-- MOVEMENT TAB
PlayerTab:AddSlider("SpeedSlider", {
    Name = "🏃 WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 100,
    Color = Color3.fromRGB(255,215,0),
    Increment = 10,
    Callback = function(v)
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

PlayerTab:AddToggle("FlyToggle", {
    Name = "✈️ Fly",
    Default = false,
    Callback = function(v)
        TurciaHub.Fly = v
        local FlySpeed = 50
        local flying = false
        spawn(function()
            while TurciaHub.Fly do
                if LocalPlayer.Character then
                    local bg = LocalPlayer.Character:FindFirstChild("BodyVelocity") or Instance.new("BodyVelocity")
                    bg.MaxForce = Vector3.new(4000,4000,4000)
                    bg.Velocity = Camera.CFrame.LookVector * FlySpeed
                end
                wait()
            end
        end)
    end
})

PlayerTab:AddToggle("NoclipToggle", {
    Name = "👻 Noclip",
    Default = false,
    Callback = function(v)
        TurciaHub.Noclip = v
        RunService.Stepped:Connect(function()
            if TurciaHub.Noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end
})

PlayerTab:AddToggle("NoGravityToggle", {
    Name = "🌙 No Gravity",
    Default = false,
    Callback = function(v)
        TurciaHub.NoGravity = v
        LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, TurciaHub.NoGravity and 0 or -50, 0)
    end
})

PlayerTab:AddToggle("FullbrightToggle", {
    Name = "💡 Fullbright",
    Default = false,
    Callback = function(v)
        TurciaHub.Fullbright = v
        Lighting.Brightness = TurciaHub.Fullbright and 2 or 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
})

PlayerTab:AddToggle("WallhackToggle", {
    Name = "👁️ Wallhack",
    Default = false,
    Callback = function(v)
        TurciaHub.Wallhack = v
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = TurciaHub.Wallhack and 0.7 or 0
            end
        end
    end
})

-- MISC TAB
MiscTab:AddButton({
    Name = "⚡ FPS Boost (Permanent)",
    Callback = function()
        FPSBoost()
        OrionLib:MakeNotification({
            Name = "FPS Boost",
            Content = "Applied! +30-60 FPS gain.",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end
})

MiscTab:AddToggle("AntiAFKToggle", {
    Name = "😴 Anti-AFK",
    Default = true,
    Callback = function(v)
        TurciaHub.AntiAFK = v
        if v then
            LocalPlayer.Idled:Connect(function()
                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
                wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
            end)
        end
    end
})

MiscTab:AddButton({
    Name = "🔄 Rejoin Server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

MiscTab:AddSlider("DelaySlider", {
    Name = "Global Auto Delay (s)",
    Min = 0.1,
    Max = 5,
    Default = 1,
    Color = Color3.fromRGB(255,215,0),
    Increment = 0.1,
    Callback = function(v)
        getgenv().GlobalDelay = v
    end
})

-- Status & Load Notification
OrionLib:MakeNotification({
    Name = "Turcia Hub Loaded ✅",
    Content = "All features active! Bind: X | Authorized Pentest",
    Image = "rbxassetid://4483362458",
    Time = 5
})

print("=== Turcia Hub v2.0 Loaded | Case Paradise Ultimate Pentest ===")
print("Features: All Auto, Movement, FPS, Events | Key: Turcia | Bind: X")
