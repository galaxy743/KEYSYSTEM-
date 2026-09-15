-- GalaxyHub standalone UI test #6
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_6"
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
title.Text = "GalaxyHub • TEST #6"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_Main"
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

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 13: Main (load modules + UI + ONAX) ]]
local ONAX = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_ONAX_Core.lua"))()
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_UI_Core.lua"))()
local AutoFarm = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_AutoFarm.lua"))()
local Magnet = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_MagnetToken.lua"))()
local Raid = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Raid.lua"))()
local Fruit = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Fruit.lua"))()
local SeaEvent = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_SeaEvent.lua"))()
local Race = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Race.lua"))()
local Item = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Item.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Teleport.lua"))()
local Visual = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Visual.lua"))()
local Misc = loadstring(game:HttpGet("https://raw.githubusercontent.com/yourrepo/GalaxyHub_Misc.lua"))()

-- Key gate
local key = game:HttpGet("https://raw.githubusercontent.com/yourrepo/key.txt") or ""
local ok, msg = ONAX.verifyKey(key)
if not ok then
    warn("[GalaxyHub] " .. msg)
    return
end

local win = UI.createWindow("GalaxyHub | BloxFruit")

local farmTab = win.addTab("Auto Farm")
win.addToggle(farmTab, "Auto Farm Level", false, function(v) if v then AutoFarm.start() else AutoFarm.stop() end end)
win.addToggle(farmTab, "Auto Haki", false, function(v) AutoFarm.AutoHaki = v end)
win.addToggle(farmTab, "Bring Mob", false, function(v) AutoFarm.BringMob = v end)

local magnetTab = win.addTab("Magnet Token")
win.addToggle(magnetTab, "Auto Farm Magnet Token", false, function(v) if v then Magnet.start() else Magnet.stop() end end)

local raidTab = win.addTab("Raid")
win.addToggle(raidTab, "Auto Raid", false, function(v) if v then Raid.start() else Raid.stop() end end)
win.addToggle(raidTab, "Auto Buy Chip", false, function(v) Raid.AutoBuyChip = v end)

local fruitTab = win.addTab("Fruit")
win.addToggle(fruitTab, "Auto Collect Fruit", false, function(v) if v then Fruit.start() else Fruit.stop() end end)
win.addToggle(fruitTab, "Store Fruit", false, function(v) Fruit.Store = v end)

local seaTab = win.addTab("Sea Event")
win.addToggle(seaTab, "Auto Sea Event", false, function(v) if v then SeaEvent.start() else SeaEvent.stop() end end)

local raceTab = win.addTab("Race")
win.addToggle(raceTab, "Auto Race", false, function(v) if v then Race.start() else Race.stop() end end)

local itemTab = win.addTab("Item")
win.addToggle(itemTab, "Auto Item", false, function(v) if v then Item.start() else Item.stop() end end)

local tpTab = win.addTab("Teleport")
win.addButton(tpTab, "Teleport Sea 1", function() Teleport.toPosition(Vector3.new(0, 0, 0)) end)
win.addButton(tpTab, "Teleport Sea 2", function() Teleport.toPosition(Vector3.new(0, 0, 0)) end)
win.addButton(tpTab, "Teleport Sea 3", function() Teleport.toPosition(Vector3.new(0, 0, 0)) end)

local visTab = win.addTab("Visual")
win.addToggle(visTab, "Player ESP", false, function(v) Visual.PlayerESP = v; Visual.start() end)
win.addToggle(visTab, "Fruit ESP", false, function(v) Visual.FruitESP = v; Visual.start() end)
win.addToggle(visTab, "Mob ESP", false, function(v) Visual.MobESP = v; Visual.start() end)

local miscTab = win.addTab("Misc")
win.addButton(miscTab, "Server Hop", function() Misc.serverHop() end)
win.addButton(miscTab, "Rejoin", function() Misc.rejoin() end)
win.addToggle(miscTab, "Safe Mode", false, function(v) Misc.toggleSafeMode(v) end)

win.notify("GalaxyHub loaded thành công!")
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_Main"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #6] GalaxyHub_Main:", err)
end
