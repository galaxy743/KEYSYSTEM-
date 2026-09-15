-- GalaxyHub standalone UI test #3
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_3"
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
title.Text = "GalaxyHub • TEST #3"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_Fruit"
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

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 6: Fruit ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local Fruit = {}
Fruit.Enabled = false
Fruit.Store = false

local function getRoot(char)
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function findFruit()
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("fruit") then
            return v
        end
        if v:IsA("Model") then
            local handle = v:FindFirstChild("Handle")
            if handle and v.Name:lower():find("fruit") then
                return v
            end
        end
    end
    return nil
end

local function collectFruit(fruit)
    local char = LocalPlayer.Character
    local root = getRoot(char)
    if not root or not fruit then return end
    local handle = fruit:IsA("Tool") and fruit.Handle or fruit:FindFirstChild("Handle")
    if handle then
        root.CFrame = handle.CFrame
        task.wait(0.3)
        if fruit:IsA("Tool") then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:EquipTool(fruit) end
        end
    end
end

local function storeFruit()
    local char = LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if tool and tool.Name:lower():find("fruit") then
        local remotes = game:GetService("ReplicatedStorage"):GetDescendants()
        for _, r in pairs(remotes) do
            if r:IsA("RemoteEvent") and r.Name:lower():find("store") then
                pcall(function() r:FireServer() end)
            end
        end
    end
end

function Fruit.start()
    Fruit.Enabled = true
    task.spawn(function()
        while Fruit.Enabled do
            pcall(function()
                local f = findFruit()
                if f then
                    collectFruit(f)
                    if Fruit.Store then storeFruit() end
                end
            end)
            task.wait(1)
        end
    end)
end

function Fruit.stop()
    Fruit.Enabled = false
end

return Fruit
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_Fruit"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #3] GalaxyHub_Fruit:", err)
end
