-- 🔥 TURCJIA HUB v15 | STABLE / FIXED / ADVANCED
-- ✅ NO COREGUI | SAFE REMOTES | CLEANUP | REAL TOGGLES

(function()
    local ok, err = pcall(function()

        --// SERVICES
        local Services = {
            Players = game:GetService("Players"),
            UIS = game:GetService("UserInputService"),
            RS = game:GetService("RunService"),
            Rep = game:GetService("ReplicatedStorage"),
            Tween = game:GetService("TweenService"),
            Lighting = game:GetService("Lighting"),
            VU = game:GetService("VirtualUser"),
        }

        local Player = Services.Players.LocalPlayer
        local PlayerGui = Player:WaitForChild("PlayerGui", 10)
        if not PlayerGui then return end

        local Camera = workspace.CurrentCamera

        --// STATE
        local State = {
            farm = false,
            sell = false,
            fly = false,
            esp = false,
            afk = false
        }

        local Connections = {}
        local Objects = {}

        --// SAFE REMOTE FIRE
        local function fireSafe(name, ...)
            for _,v in ipairs(Services.Rep:GetDescendants()) do
                if v.Name:lower():find(name:lower()) then
                    if v:IsA("RemoteEvent") then
                        pcall(v.FireServer, v, ...)
                        return
                    elseif v:IsA("RemoteFunction") then
                        pcall(v.InvokeServer, v, ...)
                        return
                    end
                end
            end
        end

        --// GUI ROOT
        local Gui = Instance.new("ScreenGui")
        Gui.Name = "TurcjaHubV15"
        Gui.ResetOnSpawn = false
        Gui.Parent = PlayerGui

        local Main = Instance.new("Frame", Gui)
        Main.Size = UDim2.fromOffset(900, 650)
        Main.Position = UDim2.fromScale(0.05, 0.05)
        Main.BackgroundColor3 = Color3.fromRGB(20,25,40)
        Main.Active = true
        Main.Draggable = true

        Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 24)

        --// TITLE
        local Title = Instance.new("TextLabel", Main)
        Title.Size = UDim2.new(1,0,0,70)
        Title.BackgroundTransparency = 1
        Title.Font = Enum.Font.GothamBold
        Title.Text = "🔥 TURCJIA HUB v15 | STABLE BUILD"
        Title.TextSize = 24
        Title.TextColor3 = Color3.new(1,1,1)

        --// CLOSE
        local Close = Instance.new("TextButton", Main)
        Close.Size = UDim2.fromOffset(40,40)
        Close.Position = UDim2.new(1,-50,0,15)
        Close.Text = "X"
        Close.BackgroundColor3 = Color3.fromRGB(200,80,80)
        Close.TextColor3 = Color3.new(1,1,1)

        Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

        Close.MouseButton1Click:Connect(function()
            for _,c in pairs(Connections) do
                pcall(function() c:Disconnect() end)
            end
            Gui:Destroy()
        end)

        --// ESP (PlayerGui SAFE)
        local ESPFolder = Instance.new("Folder", Gui)
        ESPFolder.Name = "ESP"

        local function clearESP()
            for _,v in ipairs(ESPFolder:GetChildren()) do
                v:Destroy()
            end
        end

        local function drawESP(char)
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local box = Instance.new("Frame")
            box.BorderSizePixel = 2
            box.BorderColor3 = Color3.fromRGB(255,80,80)
            box.BackgroundTransparency = 1
            box.Parent = ESPFolder

            Connections["esp_"..char.Name] = Services.RS.RenderStepped:Connect(function()
                if not State.esp or not hrp.Parent then
                    box:Destroy()
                    return
                end

                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local size = math.clamp(300 / pos.Z, 30, 200)
                    box.Size = UDim2.fromOffset(size, size*1.5)
                    box.Position = UDim2.fromOffset(pos.X - size/2, pos.Y - size)
                    box.Visible = true
                else
                    box.Visible = false
                end
            end)
        end

        --// TOGGLES (LOGIC ONLY)
        Connections.farm = Services.RS.Heartbeat:Connect(function()
            if State.farm then
                fireSafe("open")
                fireSafe("collect")
            end
        end)

        task.spawn(function()
            while task.wait(2) do
                if State.sell then
                    fireSafe("sell")
                    fireSafe("sellall")
                end
            end
        end)

        task.spawn(function()
            while task.wait(60) do
                if State.afk then
                    Services.VU:CaptureController()
                    Services.VU:ClickButton2(Vector2.zero)
                end
            end
        end)

        --// FLY (NO LEAK)
        local FlyBV
        Connections.fly = Services.RS.RenderStepped:Connect(function()
            if not State.fly then
                if FlyBV then FlyBV:Destroy() FlyBV = nil end
                return
            end

            local char = Player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            if not FlyBV then
                FlyBV = Instance.new("BodyVelocity")
                FlyBV.MaxForce = Vector3.new(1e5,1e5,1e5)
                FlyBV.Parent = hrp
            end

            local move = Vector3.zero
            if Services.UIS:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
            if Services.UIS:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
            if Services.UIS:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
            if Services.UIS:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end

            FlyBV.Velocity = move * 60
        end)

        --// ESP PLAYER LOOP
        Connections.esp = Services.RS.Heartbeat:Connect(function()
            if not State.esp then
                clearESP()
                return
            end

            for _,p in ipairs(Services.Players:GetPlayers()) do
                if p ~= Player and p.Character and not ESPFolder:FindFirstChild(p.Name) then
                    drawESP(p.Character)
                end
            end
        end)

        --// KEYBIND
        Services.UIS.InputBegan:Connect(function(i,gp)
            if not gp and i.KeyCode == Enum.KeyCode.X then
                Main.Visible = not Main.Visible
            end
        end)

        --// NOTIFY
        pcall(function()
            game.StarterGui:SetCore("SendNotification",{
                Title="TURCJIA HUB v15",
                Text="Loaded | Stable Build",
                Duration=4
            })
        end)

        print("✅ TURCJIA HUB v15 LOADED (STABLE)")

    end)

    if not ok then
        warn("[TURCJIA HUB ERROR]", err)
    end
end)()
