-- GalaxyHub standalone UI test #1
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_1"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then gui.Parent = player:WaitForChild("PlayerGui") end

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(330, 150)
frame.Position = UDim2.new(0.5, -165, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 18, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 35)
title.Position = UDim2.fromOffset(10, 8)
title.BackgroundTransparency = 1
title.Text = "GalaxyHub • TEST #1"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_AutoFarm"
status.TextColor3 = Color3.fromRGB(235, 235, 235)
status.TextSize = 15
status.Font = Enum.Font.Gotham
status.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(90, 30)
close.Position = UDim2.new(0.5, -45, 1, -38)
close.BackgroundColor3 = Color3.fromRGB(90, 45, 120)
close.Text = "Đóng"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 14
close.Font = Enum.Font.GothamBold
close.Parent = frame
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 3: Auto Farm (Banana logic) ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

local AutoFarm = {}
AutoFarm.Enabled = false
AutoFarm.AutoHaki = false
AutoFarm.BringMob = false

local function getRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid(char)
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getQuest()
    local plr = LocalPlayer
    local quests = plr.PlayerGui and plr.PlayerGui:FindFirstChild("Main") and plr.PlayerGui.Main:FindFirstChild("Quest")
    if quests then
        local title = quests:FindFirstChild("Title")
        if title and title.Text and title.Text ~= "" then
            return title.Text
        end
    end
    return nil
end

local function getNearestMob()
    local char = LocalPlayer.Character
    local root = getRoot(char)
    if not root then return nil end
    local nearest, nearestDist = nil, math.huge
    for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v:IsA("Model") and v ~= char then
            local hum = v:FindFirstChildOfClass("Humanoid")
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = v
                end
            end
        end
    end
    return nearest
end

local function equipBestWeapon()
    local char = LocalPlayer.Character
    if not char then return end
    local backpack = LocalPlayer.Backpack
    local best, bestDmg = nil, 0
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local dmg = 0
            local cfg = tool:FindFirstChild("Config") or tool:FindFirstChild("Damage")
            if cfg and cfg.Value then dmg = tonumber(cfg.Value) or 0 end
            if dmg > bestDmg then bestDmg = dmg; best = tool end
        end
    end
    if best then
        local hum = getHumanoid(char)
        if hum then hum:EquipTool(best) end
    end
end

local function attack(target)
    local char = LocalPlayer.Character
    local hum = getHumanoid(char)
    if not hum or not target then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Remote") then
        tool:Activate()
    else
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

local function teleportTo(target)
    local char = LocalPlayer.Character
    local root = getRoot(char)
    local tRoot = getRoot(target)
    if root and tRoot then
        root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
    end
end

local function bringMob(target)
    local char = LocalPlayer.Character
    local root = getRoot(char)
    local tRoot = getRoot(target)
    if root and tRoot then
        tRoot.CFrame = root.CFrame * CFrame.new(0, 0, 3)
    end
end

local function enableHaki()
    local char = LocalPlayer.Character
    if not char then return end
    local haki = char:FindFirstChild("Haki") or char:FindFirstChild("Buso")
    if haki then
        local remote = haki:FindFirstChild("Remote") or haki:FindFirstChild("Activate")
        if remote then remote:FireServer() end
    end
end

local function respawn()
    local char = LocalPlayer.Character
    local hum = getHumanoid(char)
    if hum and hum.Health <= 0 then
        task.wait(2)
        local btn = LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("Respawn")
        if btn then
            for _, b in pairs(btn:GetDescendants()) do
                if b:IsA("TextButton") then b:Fire() end
            end
        end
    end
end

function AutoFarm.start()
    AutoFarm.Enabled = true
    task.spawn(function()
        while AutoFarm.Enabled do
            pcall(function()
                local char = LocalPlayer.Character
                if not char then
                    task.wait(1)
                    return
                end
                local hum = getHumanoid(char)
                if hum and hum.Health <= 0 then
                    respawn()
                    task.wait(1)
                    return
                end
                if AutoFarm.AutoHaki then enableHaki() end
                equipBestWeapon()
                local target = getNearestMob()
                if target then
                    if AutoFarm.BringMob then bringMob(target) end
                    teleportTo(target)
                    attack(target)
                end
            end)
            task.wait(0.15)
        end
    end)
end

function AutoFarm.stop()
    AutoFarm.Enabled = false
end

return AutoFarm
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_AutoFarm"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #1] GalaxyHub_AutoFarm:", err)
end
