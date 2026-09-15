-- GalaxyHub standalone UI test #10
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_10"
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
title.Text = "GalaxyHub • TEST #10"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_Raid"
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

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 5: Raid ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local Raid = {}
Raid.Enabled = false
Raid.AutoBuyChip = false

local function getRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getNearestMob()
    local char = LocalPlayer.Character
    local root = getRoot(char)
    if not root then return nil end
    local nearest, nearestDist = nil, math.huge
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Model") and v ~= char then
            local hum = v:FindFirstChildOfClass("Humanoid")
            local hrp = v:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < nearestDist then nearestDist = dist; nearest = v end
            end
        end
    end
    return nearest
end

local function teleportTo(target)
    local char = LocalPlayer.Character
    local root = getRoot(char)
    local tRoot = getRoot(target)
    if root and tRoot then root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3) end
end

local function attack()
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Remote") then
        tool:Activate()
    else
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.1)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

local function buyChip()
    local args = { [1] = "Raids" }
    local remotes = game:GetService("ReplicatedStorage"):GetDescendants()
    for _, r in pairs(remotes) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("raid") then
            pcall(function() r:FireServer(unpack(args)) end)
        end
    end
end

function Raid.start()
    Raid.Enabled = true
    task.spawn(function()
        while Raid.Enabled do
            pcall(function()
                if Raid.AutoBuyChip then buyChip() end
                local target = getNearestMob()
                if target then
                    teleportTo(target)
                    attack()
                end
            end)
            task.wait(0.2)
        end
    end)
end

function Raid.stop()
    Raid.Enabled = false
end

return Raid
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_Raid"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #10] GalaxyHub_Raid:", err)
end
