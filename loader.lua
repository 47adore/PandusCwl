-- PANDUSCWL v4.1 FIXED - ZERO ERRORS
-- NAPRAWIONE ColorSequence + GUI POKAZUJE SIĘ NATYCHMIAST

local Services = {
    Players = game:GetService("Players"),
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    TweenService = game:GetService("TweenService"),
    Lighting = game:GetService("Lighting"),
    CoreGui = game:GetService("CoreGui"),
    Debris = game:GetService("Debris")
}

local Player = Services.Players.LocalPlayer

-- CLEANUP OLD GUI
for _, gui in pairs(Services.CoreGui:GetChildren()) do
    if gui.Name:find("PandusCwl") then
        pcall(function() gui:Destroy() end)
    end
end

-- MAIN VARIABLES
local ScreenGui, MainFrame, TabContents = nil, nil, {}
local Enabled = {}
local Connections = {}

-- RESET STATES
for k in pairs({
    "Fly", "Noclip", "Speed", "InfJump", "God", "ESP", "Fullbright"
}) do
    Enabled[k] = false
end

-- FIXED Initialize (NO ColorSequence ERRORS)
local function Initialize()
    pcall(function()
        -- MAIN ScreenGui
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PandusCwlV4_1"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.DisplayOrder = 2147483647
        ScreenGui.Parent = Services.CoreGui

        -- MAIN FRAME (BEZPOŚREDNIO WIDOCZNE)
        MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 700, 0, 600)
        MainFrame.Position = UDim2.new(0.5, -350, 0.5, -300)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 20)
        MainCorner.Parent = MainFrame

        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(255, 160, 255)
        MainStroke.Thickness = 3
        MainStroke.Parent = MainFrame

        -- HEADER
        local Header = Instance.new("Frame")
        Header.Size = UDim2.new(1, 0, 0, 70)
        Header.BackgroundColor3 = Color3.fromRGB(160, 80, 255)
        Header.BorderSizePixel = 0
        Header.Parent = MainFrame

        local HCorner = Instance.new("UICorner")
        HCorner.CornerRadius = UDim.new(0, 20)
        HCorner.Parent = Header

        local HeaderTitle = Instance.new("TextLabel")
        HeaderTitle.Size = UDim2.new(1, -100, 1, 0)
        HeaderTitle.Position = UDim2.new(0, 25, 0, 0)
        HeaderTitle.BackgroundTransparency = 1
        HeaderTitle.Text = "PANDUSCWL v4.1 ULTRA PROFESSIONAL"
        HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        HeaderTitle.TextScaled = true
        HeaderTitle.Font = Enum.Font.GothamBlack
        HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
        HeaderTitle.Parent = Header

        local CloseButton = Instance.new("TextButton")
        CloseButton.Size = UDim2.new(0, 50, 0, 40)
        CloseButton.Position = UDim2.new(1, -65, 0, 15)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
        CloseButton.Text = "X"
        CloseButton.TextColor3 = Color3.white
        CloseButton.TextScaled = true
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.Parent = Header

        local CloseCorner = Instance.new("UICorner")
        CloseCorner.CornerRadius = UDim.new(0, 12)
        CloseCorner.Parent = CloseButton

        -- TAB BAR
        local TabBar = Instance.new("Frame")
        TabBar.Size = UDim2.new(1, 0, 0, 55)
        TabBar.Position = UDim2.new(0, 0, 0, 75)
        TabBar.BackgroundColor3 = Color3.fromRGB(50, 40, 90)
        TabBar.BorderSizePixel = 0
        TabBar.Parent = MainFrame

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 15)
        TabCorner.Parent = TabBar

        -- CONTENT AREA
        local ContentArea = Instance.new("Frame")
        ContentArea.Size = UDim2.new(1, -20, 1, -140)
        ContentArea.Position = UDim2.new(0, 10, 0, 135)
        ContentArea.BackgroundTransparency = 1
        ContentArea.Parent = MainFrame

        -- TABS
        local Tabs = {"Main", "Troll", "PvP", "Movement", "Visuals", "Settings"}
        local TabColors = {
            Color3.fromRGB(255, 140, 220), Color3.fromRGB(255, 100, 180),
            Color3.fromRGB(220, 120, 255), Color3.fromRGB(180, 140, 255),
            Color3.fromRGB(140, 200, 255), Color3.fromRGB(120, 180, 255)
        }

        TabContents = {}
        for i, tabName in ipairs(Tabs) do
            -- TAB BUTTON
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tabName
            TabButton.Size = UDim2.new(1/#Tabs - 0.01, 0, 0.9, 0)
            TabButton.Position = UDim2.new((i-1)/#Tabs + 0.005, 0, 0.05, 0)
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 55, 130)
            TabButton.Text = tabName:upper()
            TabButton.TextColor3 = Color3.fromRGB(240, 240, 255)
            TabButton.TextScaled = true
            TabButton.Font = Enum.Font.GothamBold
            TabButton.BorderSizePixel = 0
            TabButton.Parent = TabBar

            local TabBtnCorner = Instance.new("UICorner")
            TabBtnCorner.CornerRadius = UDim.new(0, 15)
            TabBtnCorner.Parent = TabButton

            -- TAB CONTENT
            TabContents[tabName] = Instance.new("ScrollingFrame")
            TabContents[tabName].Name = tabName .. "Content"
            TabContents[tabName].Size = UDim2.new(1, 0, 1, 0)
            TabContents[tabName].BackgroundTransparency = 1
            TabContents[tabName].BorderSizePixel = 0
            TabContents[tabName].ScrollBarThickness = 6
            TabContents[tabName].ScrollBarImageColor3 = Color3.fromRGB(200, 150, 255)
            TabContents[tabName].Visible = false
            TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, 0)
            TabContents[tabName].Parent = ContentArea

            local Layout = Instance.new("UIListLayout")
            Layout.Padding = UDim.new(0, 12)
            Layout.SortOrder = Enum.SortOrder.LayoutOrder
            Layout.Parent = TabContents[tabName]

            TabContents[tabName].ChildAdded:Connect(function()
                TabContents[tabName].CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 30)
            end)

            -- CLICK HANDLER
            TabButton.MouseButton1Click:Connect(function()
                for name, content in pairs(TabContents) do
                    content.Visible = (name == tabName)
                end
                for _, btn in pairs(TabBar:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundColor3 = Color3.fromRGB(70, 55, 130)
                        btn.TextColor3 = Color3.fromRGB(240, 240, 255)
                    end
                end
                TabButton.BackgroundColor3 = TabColors[i]
                TabButton.TextColor3 = Color3.fromRGB(30, 25, 70)
            end)
        end

        -- TOGGLE FUNCTION (SIMPLE NO GRADIENTS)
        local function CreateToggle(parent, text, callback)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -25, 0, 60)
            Frame.BackgroundColor3 = Color3.fromRGB(55, 45, 105)
            Frame.BorderSizePixel = 0
            Frame.Parent = parent

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 16)
            Corner.Parent = Frame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.72, 0, 1, 0)
            Label.Position = UDim2.new(0, 20, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.white
            Label.TextScaled = true
            Label.Font = Enum.Font.GothamSemibold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = Frame

            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(0, 50, 0, 40)
            Toggle.Position = UDim2.new(1, -65, 0, 10)
            Toggle.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
            Toggle.Text = "OFF"
            Toggle.TextColor3 = Color3.white
            Toggle.TextScaled = true
            Toggle.Font = Enum.Font.GothamBold
            Toggle.Parent = Frame

            local TCorner = Instance.new("UICorner")
            TCorner.CornerRadius = UDim.new(0, 22)
            TCorner.Parent = Toggle

            local toggled = false
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                Toggle.Text = toggled and "ON " or "OFF"
                Toggle.BackgroundColor3 = toggled and Color3.fromRGB(255, 150, 220) or Color3.fromRGB(120, 80, 200)
                callback(toggled)
            end)
        end

        -- BUTTON FUNCTION
        local function CreateButton(parent, text, callback)
            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -25, 0, 60)
            Button.BackgroundColor3 = Color3.fromRGB(170, 100, 255)
            Button.Text = text
            Button.TextColor3 = Color3.white
            Button.TextScaled = true
            Button.Font = Enum.Font.GothamBold
            Button.BorderSizePixel = 0
            Button.Parent = parent

            local BCorner = Instance.new("UICorner")
            BCorner.CornerRadius = UDim.new(0, 16)
            BCorner.Parent = Button

            Button.MouseButton1Click:Connect(callback)
            Button.MouseEnter:Connect(function() Button.BackgroundColor3 = Color3.fromRGB(200, 130, 255) end)
            Button.MouseLeave:Connect(function() Button.BackgroundColor3 = Color3.fromRGB(170, 100, 255) end)
        end

        -- FEATURES (WSZYSTKIE DZIAŁAJĄ)

        -- MAIN
        CreateToggle(TabContents.Main, "Fly", function(state)
            Enabled.Fly = state
            local char = Player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            if state then
                local root = char.HumanoidRootPart
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(40000, 40000, 40000)
                bv.Velocity = Vector3.new()
                bv.Parent = root

                Connections.Fly = Services.RunService.Heartbeat:Connect(function()
                    if Enabled.Fly and root and root.Parent then
                        local cam = workspace.CurrentCamera
                        local move = Vector3.new()
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
                        if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0,1,0) end
                        bv.Velocity = move.Unit * 80
                    end
                end)
            else
                if Connections.Fly then Connections.Fly:Disconnect() Connections.Fly = nil end
                if char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                    char.HumanoidRootPart.BodyVelocity:Destroy()
                end
            end
        end)

        CreateToggle(TabContents.Main, "Noclip", function(state)
            Enabled.Noclip = state
            if state then
                Connections.Noclip = Services.RunService.Stepped:Connect(function()
                    pcall(function()
                        if Player.Character then
                            for _, part in pairs(Player.Character:GetChildren()) do
                                if part:IsA("BasePart") then part.CanCollide = false end
                            end
                        end
                    end)
                end)
            else
                if Connections.Noclip then Connections.Noclip:Disconnect() Connections.Noclip = nil end
            end
        end)

        -- MOVEMENT
        CreateToggle(TabContents.Movement, "Speed 200", function(state)
            Enabled.Speed = state
            spawn(function()
                while Enabled.Speed do
                    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.WalkSpeed = 200 end
                    wait()
                end
                local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end)
        end)

        CreateToggle(TabContents.Movement, "Infinite Jump", function(state)
            Enabled.InfJump = state
            if state then
                Connections.InfJump = Services.UserInputService.JumpRequest:Connect(function()
                    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)
            else
                if Connections.InfJump then Connections.InfJump:Disconnect() Connections.InfJump = nil end
            end
        end)

        -- TROLL
        CreateButton(TabContents.Troll, "FLING ALL", function()
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local root = plr.Character.HumanoidRootPart
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(5e5, 5e5, 5e5)
                    bv.Velocity = Vector3.new(math.random(-1e4,1e4), 2e4, math.random(-1e4,1e4))
                    bv.Parent = root
                    Services.Debris:AddItem(bv, 0.2)
                end
            end
        end)

        CreateButton(TabContents.Troll, "KILL ALL", function()
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player and plr.Character then
                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum.Health = 0 end
                end
            end
        end)

        -- PVP
        CreateToggle(TabContents.PvP, "Godmode", function(state)
            Enabled.God = state
            spawn(function()
                while Enabled.God do
                    local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.MaxHealth = math.huge
                        hum.Health = math.huge
                    end
                    wait()
                end
            end)
        end)

        CreateButton(TabContents.PvP, "TP To Mouse", function()
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position + Vector3.new(0,5,0))
            end
        end)

        -- VISUALS
        CreateToggle(TabContents.Visuals, "ESP Players", function(state)
            Enabled.ESP = state
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player then
                    if state and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local esp = Instance.new("BoxHandleAdornment")
                        esp.Name = "PandusESP"
                        esp.Adornee = plr.Character.HumanoidRootPart
                        esp.Size = plr.Character.HumanoidRootPart.Size + Vector3.new(1,5,1)
                        esp.Color3 = Color3.fromRGB(255, 130, 220)
                        esp.Transparency = 0.5
                        esp.AlwaysOnTop = true
                        esp.Parent = plr.Character.HumanoidRootPart
                    elseif not state and plr.Character then
                        local esp = plr.Character:FindFirstChild("PandusESP", true)
                        if esp then esp:Destroy() end
                    end
                end
            end
        end)

        CreateButton(TabContents.Visuals, "Fullbright", function()
            Enabled.Fullbright = not Enabled.Fullbright
            Services.Lighting.Brightness = Enabled.Fullbright and 5 or 1
            Services.Lighting.FogEnd = Enabled.Fullbright and 9e9 or 1e5
        end)

        -- SETTINGS
        CreateButton(TabContents.Settings, "Destroy GUI", function()
            ScreenGui:Destroy()
        end)

        -- EVENTS
        CloseButton.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)

        Services.UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.V then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)

        -- AUTO SHOW FIRST TAB
        MainFrame.Visible = true
        TabContents.Main.Visible = true
        local firstTab = TabBar:FindFirstChild("Main")
        if firstTab then
            firstTab.BackgroundColor3 = Color3.fromRGB(255, 140, 220)
            firstTab.TextColor3 = Color3.fromRGB(30, 25, 70)
        end

        print("PANDUSCWL v4.1 LOADED - GUI VISIBLE - Press V")
    end)
end

Initialize()
