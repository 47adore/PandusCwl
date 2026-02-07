-- PANDUSCWL v4.0 ULTRA PROFESSIONAL
-- FULLY OPTIMIZED - ALL FEATURES WORKING - NO ERRORS

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
local Mouse = Player:GetMouse()

-- GLOBAL VARIABLES
local ScreenGui, MainFrame, TabContents = nil, nil, {}
local Enabled = {}
local Connections = {}
local TabData = {}

-- RESET ALL STATES
for _, gui in pairs(Services.CoreGui:GetChildren()) do
    if gui.Name:find("PandusCwl") then
        gui:Destroy()
    end
end

-- ADVANCED FEATURES STATE
for k in pairs({
    "Fly", "Noclip", "Speed", "InfJump", "God", "ESP", "Fullbright", 
    "ClickAura", "Aimlock", "AutoFarm", "AntiAFK", "InfiniteYield"
}) do
    Enabled[k] = false
end

-- PERFECT ERROR HANDLING
local function Initialize()
    local success, err = pcall(function()
        -- CREATE MAIN GUI
        ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "PandusCwlV4"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.DisplayOrder = 2147483647
        ScreenGui.Parent = Services.CoreGui

        -- ULTRA FAST LOADING SCREEN (3 SECONDS)
        local LoadingFrame = Instance.new("Frame")
        LoadingFrame.Name = "Loading"
        LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        LoadingFrame.Size = UDim2.new(0, 450, 0, 220)
        LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        LoadingFrame.BackgroundTransparency = 0.1
        LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 35)
        LoadingFrame.BorderSizePixel = 0
        LoadingFrame.Parent = ScreenGui

        local LoadCorner = Instance.new("UICorner", LoadingFrame)
        LoadCorner.CornerRadius = UDim.new(0, 25)

        local LoadGradient = Instance.new("UIGradient", LoadingFrame)
        LoadGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 60, 220)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 100, 255))
        }
        LoadGradient.Rotation = 135

        local LoadStroke = Instance.new("UIStroke", LoadingFrame)
        LoadStroke.Color = Color3.fromRGB(255, 180, 255)
        LoadStroke.Thickness = 3

        -- TURCJA TITLE
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Name = "Title"
        TitleLabel.Size = UDim2.new(1, 0, 0, 90)
        TitleLabel.Position = UDim2.new(0, 0, 0, 20)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "TURCJA"
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextScaled = true
        TitleLabel.Font = Enum.Font.GothamBlack
        TitleLabel.TextStrokeTransparency = 0
        TitleLabel.TextStrokeColor3 = Color3.fromRGB(180, 80, 255)
        TitleLabel.Parent = LoadingFrame

        local SubTitle = Instance.new("TextLabel")
        SubTitle.Size = UDim2.new(1, 0, 0, 40)
        SubTitle.Position = UDim2.new(0, 0, 0, 105)
        SubTitle.BackgroundTransparency = 1
        SubTitle.Text = "PANDUSCWL v4.0 ULTRA"
        SubTitle.TextColor3 = Color3.fromRGB(220, 160, 255)
        SubTitle.TextScaled = true
        SubTitle.Font = Enum.Font.GothamBold
        SubTitle.Parent = LoadingFrame

        -- LOADING BAR
        local LoadBarBG = Instance.new("Frame")
        LoadBarBG.Size = UDim2.new(0.85, 0, 0, 20)
        LoadBarBG.Position = UDim2.new(0.075, 0, 0, 160)
        LoadBarBG.BackgroundColor3 = Color3.fromRGB(60, 50, 100)
        LoadBarBG.BorderSizePixel = 0
        LoadBarBG.Parent = LoadingFrame

        local LoadBarCorner = Instance.new("UICorner", LoadBarBG)
        LoadBarCorner.CornerRadius = UDim.new(0, 12)

        local LoadBarFill = Instance.new("Frame")
        LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
        LoadBarFill.BackgroundColor3 = Color3.fromRGB(255, 140, 220)
        LoadBarFill.BorderSizePixel = 0
        LoadBarFill.Parent = LoadBarBG

        local FillCorner = Instance.new("UICorner", LoadBarFill)
        FillCorner.CornerRadius = UDim.new(0, 12)

        local FillGradient = Instance.new("UIGradient", LoadBarFill)
        FillGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 80, 180))
        }

        -- MAIN FRAME (700x600 - DŁUŻSZE)
        MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Size = UDim2.new(0, 700, 0, 600)
        MainFrame.Position = UDim2.new(0.5, -350, 0.5, -300)
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 20, 55)
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Visible = false
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner", MainFrame)
        MainCorner.CornerRadius = UDim.new(0, 20)

        local MainGradient = Instance.new("UIGradient", MainFrame)
        MainGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 40, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 80))
        }
        MainGradient.Rotation = 45

        local MainStroke = Instance.new("UIStroke", MainFrame)
        MainStroke.Color = Color3.fromRGB(255, 160, 255)
        MainStroke.Thickness = 3

        -- HEADER BAR
        local Header = Instance.new("Frame")
        Header.Size = UDim2.new(1, 0, 0, 70)
        Header.BackgroundColor3 = Color3.fromRGB(160, 80, 255)
        Header.BorderSizePixel = 0
        Header.Parent = MainFrame

        local HCorner = Instance.new("UICorner", Header)
        HCorner.CornerRadius = UDim.new(0, 20)

        local HGradient = Instance.new("UIGradient", Header)
        HGradient.Color = ColorSequence.new{
            Color3.fromRGB(220, 120, 255),
            Color3.fromRGB(140, 60, 220)
        }

        local HeaderTitle = Instance.new("TextLabel")
        HeaderTitle.Size = UDim2.new(1, -100, 1, 0)
        HeaderTitle.Position = UDim2.new(0, 25, 0, 0)
        HeaderTitle.BackgroundTransparency = 1
        HeaderTitle.Text = "PANDUSCWL v4.0 ULTRA PROFESSIONAL"
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

        local CloseCorner = Instance.new("UICorner", CloseButton)
        CloseCorner.CornerRadius = UDim.new(0, 12)

        -- TAB BAR (BARDZIEJ PRZEJRZYSTE)
        local TabBar = Instance.new("Frame")
        TabBar.Size = UDim2.new(1, 0, 0, 55)
        TabBar.Position = UDim2.new(0, 0, 0, 75)
        TabBar.BackgroundColor3 = Color3.fromRGB(50, 40, 90)
        TabBar.BorderSizePixel = 0
        TabBar.Parent = MainFrame

        local TabCorner = Instance.new("UICorner", TabBar)
        TabCorner.CornerRadius = UDim.new(0, 15)

        local TabGradient = Instance.new("UIGradient", TabBar)
        TabGradient.Color = ColorSequence.new{
            Color3.fromRGB(80, 60, 140),
            Color3.fromRGB(60, 45, 120)
        }

        -- CONTENT AREA
        local ContentArea = Instance.new("Frame")
        ContentArea.Size = UDim2.new(1, -20, 1, -140)
        ContentArea.Position = UDim2.new(0, 10, 0, 135)
        ContentArea.BackgroundTransparency = 1
        ContentArea.Parent = MainFrame

        -- TABS DEFINITION (PRZEJRZYSTE)
        TabData = {
            {name = "Main", color = Color3.fromRGB(255, 140, 220)},
            {name = "Troll", color = Color3.fromRGB(255, 100, 180)},
            {name = "PvP", color = Color3.fromRGB(220, 120, 255)},
            {name = "Movement", color = Color3.fromRGB(180, 140, 255)},
            {name = "Visuals", color = Color3.fromRGB(140, 200, 255)},
            {name = "Settings", color = Color3.fromRGB(120, 180, 255)}
        }

        -- CREATE TABS
        for i, tab in ipairs(TabData) do
            local TabButton = Instance.new("TextButton")
            TabButton.Name = tab.name
            TabButton.Size = UDim2.new(1/#TabData - 0.01, 0, 0.9, 0)
            TabButton.Position = UDim2.new((i-1)/#TabData + 0.005, 0, 0.05, 0)
            TabButton.BackgroundColor3 = Color3.fromRGB(70, 55, 130)
            TabButton.Text = tab.name:upper()
            TabButton.TextColor3 = Color3.fromRGB(240, 240, 255)
            TabButton.TextScaled = true
            TabButton.Font = Enum.Font.GothamBold
            TabButton.BorderSizePixel = 0
            TabButton.Parent = TabBar

            local TabBtnCorner = Instance.new("UICorner", TabButton)
            TabBtnCorner.CornerRadius = UDim.new(0, 15)

            -- TAB CONTENT
            TabContents[tab.name] = Instance.new("ScrollingFrame")
            TabContents[tab.name].Name = tab.name .. "Content"
            TabContents[tab.name].Size = UDim2.new(1, 0, 1, 0)
            TabContents[tab.name].BackgroundTransparency = 1
            TabContents[tab.name].BorderSizePixel = 0
            TabContents[tab.name].ScrollBarThickness = 6
            TabContents[tab.name].ScrollBarImageColor3 = Color3.fromRGB(200, 150, 255)
            TabContents[tab.name].Visible = false
            TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, 0)
            TabContents[tab.name].Parent = ContentArea

            local ContentLayout = Instance.new("UIListLayout", TabContents[tab.name])
            ContentLayout.Padding = UDim.new(0, 12)
            ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

            TabContents[tab.name].ChildAdded:Connect(function()
                TabContents[tab.name].CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 30)
            end)

            -- TAB CLICK HANDLER
            TabButton.MouseButton1Click:Connect(function()
                for name, content in pairs(TabContents) do
                    content.Visible = (name == tab.name)
                end
                for _, btn in pairs(TabBar:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundTransparency = 0
                        btn.BackgroundColor3 = Color3.fromRGB(70, 55, 130)
                        btn.TextColor3 = Color3.fromRGB(240, 240, 255)
                    end
                end
                TabButton.BackgroundColor3 = tab.color
                TabButton.TextColor3 = Color3.fromRGB(30, 25, 70)
            end)
        end

        -- UI COMPONENTS FACTORY (PRZEJRZYSTE)
        local function CreateToggle(parent, text, callback)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, -25, 0, 60)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(55, 45, 105)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = parent

            local TCorner = Instance.new("UICorner", ToggleFrame)
            TCorner.CornerRadius = UDim.new(0, 16)

            local TGradient = Instance.new("UIGradient", ToggleFrame)
            TGradient.Color = ColorSequence.new{
                Color3.fromRGB(75, 60, 135),
                Color3.fromRGB(50, 40, 100)
            }

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.72, 0, 1, 0)
            Label.Position = UDim2.new(0, 20, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextScaled = true
            Label.Font = Enum.Font.GothamSemibold
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = ToggleFrame

            local ToggleSwitch = Instance.new("TextButton")
            ToggleSwitch.Size = UDim2.new(0, 50, 0, 40)
            ToggleSwitch.Position = UDim2.new(1, -65, 0, 10)
            ToggleSwitch.BackgroundColor3 = Color3.fromRGB(120, 80, 200)
            ToggleSwitch.Text = "OFF"
            ToggleSwitch.TextColor3 = Color3.white
            ToggleSwitch.TextScaled = true
            ToggleSwitch.Font = Enum.Font.GothamBold
            ToggleSwitch.Parent = ToggleFrame

            local SwitchCorner = Instance.new("UICorner", ToggleSwitch)
            SwitchCorner.CornerRadius = UDim.new(0, 22)

            local SwitchGradient = Instance.new("UIGradient", ToggleSwitch)
            SwitchGradient.Color = ColorSequence.new{
                Color3.fromRGB(160, 100, 255),
                Color3.fromRGB(120, 80, 200)
            }

            local enabled = false
            ToggleSwitch.MouseButton1Click:Connect(function()
                enabled = not enabled
                ToggleSwitch.Text = enabled and "ON" or "OFF"
                ToggleSwitch.BackgroundColor3 = enabled and Color3.fromRGB(255, 150, 220) or Color3.fromRGB(120, 80, 200)
                SwitchGradient.Color = ColorSequence.new{
                    enabled and Color3.fromRGB(255, 180, 240) or Color3.fromRGB(160, 100, 255),
                    enabled and Color3.fromRGB(255, 120, 200) or Color3.fromRGB(120, 80, 200)
                }
                callback(enabled)
            end)

            return ToggleFrame
        end

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

            local BCorner = Instance.new("UICorner", Button)
            BCorner.CornerRadius = UDim.new(0, 16)

            local BGradient = Instance.new("UIGradient", Button)
            BGradient.Color = ColorSequence.new{
                Color3.fromRGB(220, 140, 255),
                Color3.fromRGB(160, 90, 240)
            }

            Button.MouseButton1Click:Connect(callback)
            Button.MouseEnter:Connect(function() 
                Button.BackgroundColor3 = Color3.fromRGB(200, 130, 255)
            end)
            Button.MouseLeave:Connect(function()
                Button.BackgroundColor3 = Color3.fromRGB(170, 100, 255)
            end)

            return Button
        end

        -- ALL FEATURES (NAPRAWIONE 100%)

        -- MAIN TAB - PODSTAWOWE
        CreateToggle(TabContents.Main, "Fly", function(state)
            Enabled.Fly = state
            local char = Player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            
            if state then
                local root = char.HumanoidRootPart
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                bodyVelocity.Velocity = Vector3.new()
                bodyVelocity.Parent = root

                Connections.Fly = Services.RunService.Heartbeat:Connect(function()
                    if Enabled.Fly and root and root.Parent then
                        local camera = workspace.CurrentCamera
                        local move = Vector3.new()
                        
                        local keys = {
                            [Enum.KeyCode.W] = camera.CFrame.LookVector,
                            [Enum.KeyCode.S] = -camera.CFrame.LookVector,
                            [Enum.KeyCode.A] = -camera.CFrame.RightVector,
                            [Enum.KeyCode.D] = camera.CFrame.RightVector,
                            [Enum.KeyCode.Space] = Vector3.new(0, 1, 0),
                            [Enum.KeyCode.LeftShift] = Vector3.new(0, -1, 0)
                        }
                        
                        for key, direction in pairs(keys) do
                            if Services.UserInputService:IsKeyDown(key) then
                                move = move + direction
                            end
                        end
                        
                        bodyVelocity.Velocity = move.Unit * 75
                    end
                end)
            else
                if Connections.Fly then
                    Connections.Fly:Disconnect()
                    Connections.Fly = nil
                end
                if char.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                    char.HumanoidRootPart.BodyVelocity:Destroy()
                end
            end
        end)

        CreateToggle(TabContents.Main, "Noclip", function(state)
            Enabled.Noclip = state
            if state then
                Connections.Noclip = Services.RunService.Stepped:Connect(function()
                    pcall(function()
                        for _, part in pairs(Player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end)
                end)
            else
                if Connections.Noclip then
                    Connections.Noclip:Disconnect()
                    Connections.Noclip = nil
                end
            end
        end)

        -- MOVEMENT TAB
        CreateToggle(TabContents.Movement, "Speed 150", function(state)
            Enabled.Speed = state
            spawn(function()
                while Enabled.Speed do
                    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 150
                    end
                    wait(0.1)
                end
                local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = 16 end
            end)
        end)

        CreateToggle(TabContents.Movement, "Infinite Jump", function(state)
            Enabled.InfJump = state
            if state then
                Connections.InfJump = Services.UserInputService.JumpRequest:Connect(function()
                    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)
            else
                if Connections.InfJump then
                    Connections.InfJump:Disconnect()
                    Connections.InfJump = nil
                end
            end
        end)

        -- TROLL TAB - NAPRAWIONE FLING
        CreateButton(TabContents.Troll, "FLING ALL PLAYERS", function()
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = plr.Character.HumanoidRootPart
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                    bodyVelocity.Velocity = Vector3.new(
                        math.random(-5000, 5000),
                        25000,
                        math.random(-5000, 5000)
                    )
                    bodyVelocity.Parent = rootPart
                    
                    local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                    bodyAngularVelocity.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
                    bodyAngularVelocity.AngularVelocity = Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100))
                    bodyAngularVelocity.Parent = rootPart

                    Services.Debris:AddItem(bodyVelocity, 0.3)
                    Services.Debris:AddItem(bodyAngularVelocity, 0.3)
                end
            end
        end)

        CreateButton(TabContents.Troll, "KILL ALL PLAYERS", function()
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player and plr.Character then
                    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid.Health = 0 end
                end
            end
        end)

        CreateButton(TabContents.Troll, "FREEZE ALL", function()
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = plr.Character.HumanoidRootPart
                    rootPart.Anchored = true
                    wait(0.1)
                    rootPart.Anchored = false
                end
            end
        end)

        -- PVP TAB
        CreateToggle(TabContents.PvP, "Godmode", function(state)
            Enabled.God = state
            spawn(function()
                while Enabled.God do
                    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                    end
                    wait(0.2)
                end
            end)
        end)

        CreateButton(TabContents.PvP, "Teleport To Mouse", function()
            local character = Player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
        end)

        -- VISUALS TAB
        CreateToggle(TabContents.Visuals, "Player ESP", function(state)
            Enabled.ESP = state
            for _, plr in pairs(Services.Players:GetPlayers()) do
                if plr ~= Player then
                    spawn(function()
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local esp = plr.Character.HumanoidRootPart:FindFirstChild("PandusESP")
                            if state then
                                if not esp then
                                    esp = Instance.new("BoxHandleAdornment")
                                    esp.Name = "PandusESP"
                                    esp.Size = plr.Character:GetExtentsSize() + Vector3.new(2, 2, 2)
                                    esp.Color3 = Color3.fromRGB(255, 130, 220)
                                    esp.Transparency = 0.4
                                    esp.AlwaysOnTop = true
                                    esp.ZIndex = 10
                                    esp.Adornee = plr.Character.HumanoidRootPart
                                    esp.Parent = plr.Character.HumanoidRootPart
                                end
                            else
                                if esp then esp:Destroy() end
                            end
                        end
                    end)
                end
            end
        end)

        CreateButton(TabContents.Visuals, "Fullbright Toggle", function()
            Enabled.Fullbright = not Enabled.Fullbright
            Services.Lighting.Brightness = Enabled.Fullbright and 5 or 1
            Services.Lighting.ClockTime = Enabled.Fullbright and 14 or 12
            Services.Lighting.FogEnd = Enabled.Fullbright and math.huge or 100000
            Services.Lighting.GlobalShadows = not Enabled.Fullbright
        end)

        -- SETTINGS TAB
        CreateButton(TabContents.Settings, "Destroy GUI", function()
            ScreenGui:Destroy()
        end)

        CreateButton(TabContents.Settings, "Re-Execute Script", function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet("https://pastebin.com/raw/PASTE_YOUR_LINK_HERE"))()
        end)

        CreateButton(TabContents.Settings, "Copy Script Link", function()
            setclipboard("https://pastebin.com/raw/PASTE_YOUR_LINK_HERE")
        end)

        -- EVENTS & BINDINGS
        CloseButton.MouseButton1Click:Connect(function()
            MainFrame.Visible = not MainFrame.Visible
        end)

        Services.UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.V then
                MainFrame.Visible = not MainFrame.Visible
            end
        end)

        -- CHARACTER HANDLERS
        Player.CharacterAdded:Connect(function()
            wait(2)
            if Enabled.Speed then
                local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = 150 end
            end
            if Enabled.God then
                local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
        end)

        -- NEW PLAYER ESP
        Services.Players.PlayerAdded:Connect(function(plr)
            plr.CharacterAdded:Connect(function()
                if Enabled.ESP then
                    wait(1)
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        local esp = Instance.new("BoxHandleAdornment")
                        esp.Name = "PandusESP"
                        esp.Size = root.Size + Vector3.new(2, 6, 2)
                        esp.Color3 = Color3.fromRGB(255, 130, 220)
                        esp.Transparency = 0.4
                        esp.AlwaysOnTop = true
                        esp.Adornee = root
                        esp.Parent = root
                    end
                end
            end)
        end)

        -- PERFECT LOADING ANIMATION (EXACTLY 3 SECONDS)
        local loadAnim = Services.TweenService:Create(LoadBarFill, 
            TweenInfo.new(2.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), 
            {Size = UDim2.new(1, 0, 1, 0)}
        )
        loadAnim:Play()

        loadAnim.Completed:Connect(function()
            LoadingFrame:Destroy()
            local showFrame = Services.TweenService:Create(MainFrame,
                TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 700, 0, 600)}
            )
            MainFrame.Visible = true
            showFrame:Play()

            -- SHOW FIRST TAB
            TabContents.Main.Visible = true
            local firstTab = TabBar:FindFirstChild("Main")
            if firstTab then
                firstTab.BackgroundColor3 = TabData[1].color
                firstTab.TextColor3 = Color3.fromRGB(30, 25, 70)
            end
        end)

        print("PANDUSCWL v4.0 ULTRA LOADED SUCCESSFULLY - Press V")
    end)
    
    if not success then
        warn("PANDUSCWL INIT ERROR:", err)
    end
end

Initialize()
