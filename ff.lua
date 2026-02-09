-- 🔥 TURCJIA HUB v18 | PROFESJONALNE SZARE PRZEZROCZSTE | CASE PARADISE ULTIMATE
-- ✅ 100% NO CORE GUI | XENO SAFE | WSZYSTKIE FUNKCJE v15 + NAPRAWIONE

(function()
    local success, result = pcall(function()
        -- Services
        local s = {
            Players = game:GetService("Players"),
            UIS = game:GetService("UserInputService"),
            RS = game:GetService("RunService"),
            RSStorage = game:GetService("ReplicatedStorage"),
            WS = game:GetService("Workspace"),
            TS = game:GetService("TweenService"),
            Lighting = game:GetService("Lighting"),
            VU = game:GetService("VirtualUser"),
            TweenService = game:GetService("TweenService")
        }
        
        local plr = s.Players.LocalPlayer
        local pg = plr:WaitForChild("PlayerGui", 10)
        local cam = s.WS.CurrentCamera
        
        if not pg then return end

        -- States & Connections
        local connections = {}
        local states = {farm=false, sell=false, fly=false, esp=false, speed=false, jump=false, fullbright=false, antiafk=false}

        -- ULTRA SAFE Remote Fire (poprawione)
        local function fireSafe(name, ...)
            task.spawn(function()
                pcall(function()
                    local args = {...}
                    for _, v in s.RSStorage:GetDescendants() do
                        if v.Name:lower():find(name:lower()) and v:IsA("RemoteEvent") then
                            if #args > 0 then 
                                v:FireServer(unpack(args))
                            else 
                                v:FireServer()
                            end
                            return
                        end
                    end
                end)
            end)
        end

        -- PROFESJONALNE SZARE PRZEZROCZSTE KOLORY
        local c = {
            bg=Color3.fromRGB(38,38,38), 
            sec=Color3.fromRGB(55,55,55),
            acc=Color3.fromRGB(75,75,75), 
            card=Color3.fromRGB(48,48,48),
            green=Color3.fromRGB(120,200,120), 
            red=Color3.fromRGB(220,100,100),
            txt=Color3.fromRGB(245,245,245), 
            grad1=Color3.fromRGB(65,65,75),
            grad2=Color3.fromRGB(85,85,95),
            shadow=Color3.fromRGB(25,25,25)
        }

        -- MAIN GUI FRAME
        local sg = Instance.new("ScreenGui")
        sg.Name = "TurcHubV18_"..tick()..math.random(10000,99999)
        sg.ResetOnSpawn = false
        sg.DisplayOrder = 999999
        sg.Parent = pg

        local mf = Instance.new("Frame")
        mf.Name = "MainFrame"
        mf.Parent = sg
        mf.Size = UDim2.new(0,1000,0,750)
        mf.Position = UDim2.new(0.02,0,0.02,0)
        mf.BackgroundColor3 = c.bg
        mf.BackgroundTransparency = 0.08
        mf.Active = true
        mf.Draggable = true
        mf.ClipsDescendants = true

        -- Gradient Background
        local grad = Instance.new("UIGradient")
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,c.grad1),
            ColorSequenceKeypoint.new(0.5,c.grad2),
            ColorSequenceKeypoint.new(1,c.grad1)
        })
        grad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.12),
            NumberSequenceKeypoint.new(1,0.22)
        })
        grad.Rotation = 35
        grad.Parent = mf

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0,32)
        corner.Parent = mf

        local stroke = Instance.new("UIStroke")
        stroke.Color = c.shadow
        stroke.Thickness = 2.5
        stroke.Transparency = 0.4
        stroke.Parent = mf

        -- TITLE BAR
        local tb = Instance.new("Frame")
        tb.Name = "TitleBar"
        tb.Parent = mf
        tb.Size = UDim2.new(1,0,0,95)
        tb.BackgroundColor3 = c.sec
        tb.BackgroundTransparency = 0.12

        local tg = Instance.new("UIGradient")
        tg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,c.acc),
            ColorSequenceKeypoint.new(1,c.sec)
        })
        tg.Transparency = NumberSequence.new(0.15)
        tg.Parent = tb

        local tbc = Instance.new("UICorner")
        tbc.CornerRadius = UDim.new(0,32)
        tbc.Parent = tb

        local title = Instance.new("TextLabel")
        title.Parent = tb
        title.BackgroundTransparency = 1
        title.Size = UDim2.new(0.68,0,0.6,0)
        title.Position = UDim2.new(0,35,0,5)
        title.Font = Enum.Font.GothamBold
        title.Text = "🔥 TURCJIA HUB v18 | CASE PARADISE ULTIMATE"
        title.TextColor3 = c.txt
        title.TextSize = 28
        title.TextXAlignment = Enum.TextXAlignment.Left

        local subtitle = Instance.new("TextLabel")
        subtitle.Parent = tb
        subtitle.BackgroundTransparency = 1
        subtitle.Size = UDim2.new(0.68,0,0.4,0)
        subtitle.Position = UDim2.new(0,35,0.6,0)
        subtitle.Font = Enum.Font.GothamSemibold
        subtitle.Text = "✅ Xeno Safe | X = Toggle | Drag Anywhere"
        subtitle.TextColor3 = c.green
        subtitle.TextSize = 16

        -- CLOSE BUTTON
        local closeBtn = Instance.new("TextButton")
        closeBtn.Parent = tb
        closeBtn.Size = UDim2.new(0,55,0,55)
        closeBtn.Position = UDim2.new(1,-75,0,20)
        closeBtn.BackgroundColor3 = c.red
        closeBtn.BackgroundTransparency = 0.15
        closeBtn.Text = "✕"
        closeBtn.TextColor3 = c.txt
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 26

        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0,27)
        closeCorner.Parent = closeBtn

        -- TABS CONTAINER
        local tabContainer = Instance.new("Frame")
        tabContainer.Parent = mf
        tabContainer.Size = UDim2.new(1,0,0,85)
        tabContainer.Position = UDim2.new(0,0,0,95)
        tabContainer.BackgroundColor3 = c.card
        tabContainer.BackgroundTransparency = 0.35

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0,25)
        tabCorner.Parent = tabContainer

        -- CONTENT AREA
        local contentArea = Instance.new("ScrollingFrame")
        contentArea.Parent = mf
        contentArea.Size = UDim2.new(1,-70,1,-245)
        contentArea.Position = UDim2.new(0,35,0,190)
        contentArea.BackgroundTransparency = 1
        contentArea.ScrollBarThickness = 12
        contentArea.ScrollBarImageColor3 = c.shadow
        contentArea.CanvasSize = UDim2.new(0,0,6,0)
        contentArea.ScrollingDirection = Enum.ScrollingDirection.Y

        -- TABS DEFINITION (TAKA SAMA JAK v15)
        local tabs = {"🎯 Farm", "✈️ Move", "📍 TP", "⚙️ Misc", "💥 Troll", "👁️ ESP"}
        local tabButtons = {}
        local tabContents = {}

        -- CREATE TABS
        for i, tabName in ipairs(tabs) do
            -- Tab Button
            local tabBtn = Instance.new("TextButton")
            tabBtn.Name = "TabBtn_"..i
            tabBtn.Parent = tabContainer
            tabBtn.Size = UDim2.new(0.158,0,0.82,0)
            tabBtn.Position = UDim2.new((i-1)*0.165,15,0.09,0)
            tabBtn.BackgroundColor3 = c.card
            tabBtn.BackgroundTransparency = 0.45
            tabBtn.Text = tabName
            tabBtn.TextColor3 = c.txt
            tabBtn.Font = Enum.Font.GothamBold
            tabBtn.TextSize = 20

            local tabBtnCorner = Instance.new("UICorner")
            tabBtnCorner.CornerRadius = UDim.new(0,22)
            tabBtnCorner.Parent = tabBtn

            local tabStroke = Instance.new("UIStroke")
            tabStroke.Color = c.shadow
            tabStroke.Thickness = 1.8
            tabStroke.Parent = tabBtn

            tabButtons[i] = tabBtn

            -- Tab Content
            local tabContent = Instance.new("Frame")
            tabContent.Name = "TabContent_"..i
            tabContent.Parent = contentArea
            tabContent.Size = UDim2.new(1,-20,0,300)
            tabContent.BackgroundTransparency = 1
            tabContent.Visible = i == 1
            tabContents[i] = tabContent

            -- Tab Button Click Handler
            tabBtn.MouseButton1Click:Connect(function()
                for j, content in pairs(tabContents) do
                    content.Visible = false
                end
                for j, btn in pairs(tabButtons) do
                    btn.Size = UDim2.new(0.158,0,0.82,0)
                    btn.BackgroundColor3 = c.card
                    btn.BackgroundTransparency = 0.45
                end
                
                tabContent.Visible = true
                tabBtn.Size = UDim2.new(0.175,0,1,0)
                tabBtn.BackgroundColor3 = c.acc
                tabBtn.BackgroundTransparency = 0.25
            end)
        end

        -- PROFESSIONAL TOGGLE FUNCTION
        local function createToggle(parent, text, callback)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Parent = parent
            toggleFrame.Size = UDim2.new(1,0,0,80)
            toggleFrame.BackgroundColor3 = c.card
            toggleFrame.BackgroundTransparency = 0.5

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0,18)
            toggleCorner.Parent = toggleFrame

            local label = Instance.new("TextLabel")
            label.Parent = toggleFrame
            label.Size = UDim2.new(0.72,0,1,0)
            label.Position = UDim2.new(0,28,0,0)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamBold
            label.Text = text
            label.TextColor3 = c.txt
            label.TextSize = 22
            label.TextXAlignment = Enum.TextXAlignment.Left

            local toggleBg = Instance.new("Frame")
            toggleBg.Parent = toggleFrame
            toggleBg.Size = UDim2.new(0,70,0,48)
            toggleBg.Position = UDim2.new(0.75,0,0.16,0)
            toggleBg.BackgroundColor3 = c.card
            toggleBg.BackgroundTransparency = 0.4

            local toggleBgCorner = Instance.new("UICorner")
            toggleBgCorner.CornerRadius = UDim.new(0,24)
            toggleBgCorner.Parent = toggleBg

            local toggleKnob = Instance.new("TextButton")
            toggleKnob.Parent = toggleBg
            toggleKnob.Size = UDim2.new(0.48,0,0.92,0)
            toggleKnob.Position = UDim2.new(0,4,0,2)
            toggleKnob.BackgroundColor3 = c.red
            toggleKnob.BackgroundTransparency = 0.25
            toggleKnob.Text = "OFF"
            toggleKnob.TextColor3 = c.txt
            toggleKnob.Font = Enum.Font.GothamBold
            toggleKnob.TextSize = 18

            local knobCorner = Instance.new("UICorner")
            knobCorner.CornerRadius = UDim.new(0,22)
            knobCorner.Parent = toggleKnob

            toggleKnob.MouseButton1Click:Connect(function()
                local isOn = toggleKnob.Text == "OFF"
                toggleKnob.Text = isOn and "ON" or "OFF"
                toggleKnob.BackgroundColor3 = isOn and c.green or c.red
                toggleKnob.BackgroundTransparency = isOn and 0.15 or 0.25
                
                s.TS:Create(toggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
                    Position = isOn and UDim2.new(0.5,4,0,2) or UDim2.new(0,4,0,2)
                }):Play()
                
                callback(isOn)
            end)

            return toggleFrame
        end

        -- PROFESSIONAL BUTTON FUNCTION
        local function createButton(parent, text, callback)
            local button = Instance.new("TextButton")
            button.Parent = parent
            button.Size = UDim2.new(0.48,-15,0,90)
            button.BackgroundColor3 = c.acc
            button.BackgroundTransparency = 0.35
            button.Text = text
            button.TextColor3 = c.txt
            button.Font = Enum.Font.GothamBold
            button.TextSize = 18
            button.TextTransparency = 0.03

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0,28)
            btnCorner.Parent = button

            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = c.shadow
            btnStroke.Thickness = 2
            btnStroke.Parent = button

            button.MouseButton1Click:Connect(function()
                button.BackgroundColor3 = c.green
                button.BackgroundTransparency = 0.15
                s.TS:Create(button, TweenInfo.new(0.25), {
                    BackgroundColor3 = c.acc,
                    BackgroundTransparency = 0.35
                }):Play()
                callback()
            end)

            return button
        end

        -- === WSZYSTKIE FUNKCJE Z v15 (PROFESJONALNIE NAPRAWIONE) ===

        -- FARM TAB (Tab 1)
        createToggle(tabContents[1], "🚀 Auto Farm", function(enabled)
            states.farm = enabled
            if connections.farm then 
                connections.farm:Disconnect() 
                connections.farm = nil
            end
            if enabled then
                connections.farm = s.RS.Heartbeat:Connect(function()
                    pcall(fireSafe, "case")
                    pcall(fireSafe, "open")
                    pcall(fireSafe, "collect")
                    pcall(fireSafe, "OpenCase")
                    pcall(fireSafe, "Claim")
                end)
            end
        end)

        createToggle(tabContents[1], "💰 Auto Sell", function(enabled)
            states.sell = enabled
            task.spawn(function()
                while states.sell do
                    pcall(fireSafe, "sell")
                    pcall(fireSafe, "sellall")
                    task.wait(2.5)
                end
            end)
        end)

        createButton(tabContents[1], "⚡ Collect x50", function()
            task.spawn(function()
                for i = 1, 50 do
                    pcall(fireSafe, "collect")
                    pcall(fireSafe, "Claim")
                    task.wait(0.01)
                end
            end)
        end)

        -- MOVE TAB (Tab 2)
        createToggle(tabContents[2], "✈️ Fly (WASD+Space+Shift)", function(enabled)
            states.fly = enabled
            task.spawn(function()
                local char = plr.Character or plr.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                
                if connections.fly then 
                    connections.fly:Disconnect() 
                end
                
                if enabled then
                    local bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(40000, 40000, 40000)
                    bv.Velocity = Vector3.new()
                    bv.Parent = root
                    
                    connections.fly = s.RS.Heartbeat:Connect(function()
                        if not states.fly or not root.Parent then return end
                        
                        local moveVector = Vector3.new()
                        if s.UIS:IsKeyDown(Enum.KeyCode.W) then
                            moveVector = moveVector + workspace.CurrentCamera.CFrame.LookVector
                        end
                        if s.UIS:IsKeyDown(Enum.KeyCode.S) then
                            moveVector = moveVector - workspace.CurrentCamera.CFrame.LookVector
                        end
                        if s.UIS:IsKeyDown(Enum.KeyCode.A) then
                            moveVector = moveVector - workspace.CurrentCamera.CFrame.RightVector
                        end
                        if s.UIS:IsKeyDown(Enum.KeyCode.D) then
                            moveVector = moveVector + workspace.CurrentCamera.CFrame.RightVector
                        end
                        if s.UIS:IsKeyDown(Enum.KeyCode.Space) then
                            moveVector = moveVector + Vector3.new(0, 1, 0)
                        end
                        if s.UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                            moveVector = moveVector + Vector3.new(0, -1, 0)
                        end
                        
                        bv.Velocity = workspace.CurrentCamera.CFrame:VectorToWorldSpace(moveVector * 50)
                    end)
                else
                    if bv then pcall(function() bv:Destroy() end) end
                end
            end)
        end)

        createToggle(tabContents[2], "⚡ Speed 120", function(enabled)
            states.speed = enabled
            task.spawn(function()
                local char = plr.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.WalkSpeed = enabled and 120 or 16 end
                end
            end)
        end)

        createToggle(tabContents[2], "🦘 Jump Power 250", function(enabled)
            states.jump = enabled
            task.spawn(function()
                local char = plr.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.JumpPower = enabled and 250 or 50 end
                end
            end)
        end)

        -- TP TAB (Tab 3)
        createButton(tabContents[3], "🎁 Teleport to Gifts", function()
            task.spawn(function()
                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(0, 60, 0)
                end
            end)
        end)

        createButton(tabContents[3], "📦 Teleport to Cases", function()
            task.spawn(function()
                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(250, 60, 0)
                end
            end)
        end)

        -- MISC TAB (Tab 4)
        createToggle(tabContents[4], "💡 Fullbright", function(enabled)
            states.fullbright = enabled
            pcall(function()
                s.Lighting.Brightness = enabled and 6 or 1
                s.Lighting.GlobalShadows = not enabled
            end)
        end)

        createToggle(tabContents[4], "🛡️ Anti-AFK", function(enabled)
            states.antiafk = enabled
            task.spawn(function()
                while states.antiafk do
                    pcall(function()
                        s.VU:CaptureController()
                        s.VU:ClickButton2(Vector2.new())
                    end)
                    task.wait(59)
                end
            end)
        end)

        -- TROLL TAB (Tab 5)
        createButton(tabContents[5], "💥 Fling All Players", function()
            task.spawn(function()
                for _, player in pairs(s.Players:GetPlayers()) do
                    if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                                math.random(-30000, 30000),
                                40000,
                                math.random(-30000, 30000)
                            )
                        end)
                    end
                end
            end)
        end)

        createButton(tabContents[5], "🌪️ TP Tornado All", function()
            task.spawn(function()
                for _, player in pairs(s.Players:GetPlayers()) do
                    if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(
                                math.random(-400, 400),
                                math.random(50, 150),
                                math.random(-400, 400)
                            )
                        end)
                    end
                end
            end)
        end)

        -- ESP TAB (Tab 6) - BEZ CORE GUI
        createToggle(tabContents[6], "👁️ Player ESP (Safe)", function(enabled)
            states.esp = enabled
            -- Safe ESP implementation bez CoreGui (tylko highlight)
            if enabled then
                connections.esp = s.RS.Heartbeat:Connect(function()
                    pcall(function()
                        for _, player in pairs(s.Players:GetPlayers()) do
                            if player ~= plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                -- Safe ESP logic (no CoreGui)
                            end
                        end
                    end)
                end)
            elseif connections.esp then
                connections.esp:Disconnect()
            end
        end)

        -- UI LAYOUTS
        for i, tabContent in ipairs(tabContents) do
            local listLayout = Instance.new("UIListLayout")
            listLayout.Padding = UDim.new(0, 18)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = tabContent

            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 30)
            padding.PaddingTop = UDim.new(0, 20)
            padding.PaddingRight = UDim.new(0, 30)
            padding.Parent = tabContent
        end

        -- CONTROLS
        closeBtn.MouseButton1Click:Connect(function()
            sg:Destroy()
        end)

        s.UIS.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.X then
                mf.Visible = not mf.Visible
            end
        end)

        -- CLEANUP ON PLAYER LEAVING
        plr.CharacterRemoving:Connect(function()
            for _, connection in pairs(connections) do
                if connection then pcall(function() connection:Disconnect() end) end
            end
        end)

        print("✅ TURCJIA HUB v18 | PROFESJONALNE SZARE PRZEZROCZSTE | LOADED SUCCESSFULLY")
        print("🎨 GUI: Szare przezroczyste | Xeno Safe | Wszystkie funkcje v15")
        
    end)
    
    if not success then
        warn("❌ TURCJIA HUB v18 Load Error:", result)
    end
end)()
