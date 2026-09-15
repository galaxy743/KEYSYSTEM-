-- GalaxyHub standalone UI test #14
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_14"
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
title.Text = "GalaxyHub • TEST #14"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_Visual"
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

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 11: Visual (ESP) ]]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera

local Visual = {}
Visual.PlayerESP = false
Visual.FruitESP = false
Visual.MobESP = false
Visual._espObjects = {}

local function createESP(target, color, name)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "GalaxyESP"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.Adornee = target
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name or target.Name
    label.TextColor3 = color or Color3.fromRGB(140, 60, 255)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = billboard
    billboard.Parent = target
    table.insert(Visual._espObjects, billboard)
    return billboard
end

local function clearESP()
    for _, b in pairs(Visual._espObjects) do
        pcall(function() b:Destroy() end)
    end
    Visual._espObjects = {}
end

local function loopESP()
    while Visual.PlayerESP or Visual.FruitESP or Visual.MobESP do
        pcall(function()
            clearESP()
            if Visual.PlayerESP then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then createESP(hrp, Color3.fromRGB(255, 80, 80), plr.Name) end
                    end
                end
            end
            if Visual.MobESP then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        if hrp then createESP(hrp, Color3.fromRGB(255, 200, 80), v.Name) end
                    end
                end
            end
            if Visual.FruitESP then
                for _, v in pairs(Workspace:GetChildren()) do
                    if v.Name:lower():find("fruit") then
                        local handle = v:IsA("Tool") and v.Handle or v:FindFirstChild("Handle")
                        if handle then createESP(handle, Color3.fromRGB(140, 60, 255), v.Name) end
                    end
                end
            end
        end)
        task.wait(1)
    end
    clearESP()
end

function Visual.start()
    task.spawn(loopESP)
end

function Visual.stop()
    Visual.PlayerESP = false
    Visual.FruitESP = false
    Visual.MobESP = false
    clearESP()
end

return Visual
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_Visual"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #14] GalaxyHub_Visual:", err)
end
