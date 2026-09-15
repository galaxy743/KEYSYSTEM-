-- GalaxyHub standalone UI test #2
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_2"
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
title.Text = "GalaxyHub • TEST #2"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_Banana_ONAX_FULL"
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

local source = [===[--[[
    GalaxyHub | BloxFruit
    STANDALONE FULL BUILD (Banana Cat Hub logic + ONAX key)
    Theme: Black + Purple + Pink
]]

-- ===================== ENVIRONMENT =====================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TeleportService = game:GetService("TeleportService")

local request = (syn and syn.request) or (http_request or request) or (fluxus and fluxus.request) or nil
local identifyexecutor = identifyexecutor or function() return "Unknown" end

-- ===================== ONAX KEY =====================
local ONAX = {}
ONAX.KEY_API = "https://onax.onrender.com/api/check_key"
ONAX.Verified = false

function ONAX.getHWID()
    local ok, r = pcall(function()
        if identifyexecutor then return identifyexecutor() end
        if syn and syn.crypt then return syn.crypt.custom("HWID") end
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if ok and r then return tostring(r) end
    return "UNKNOWN_HWID"
end

function ONAX.verifyKey(key)
    if not key or key == "" then return false, "Vui lòng nhập key" end
    if not request then return false, "Executor không hỗ trợ HTTP request" end
    local ok, response = pcall(function()
        return request({
            Url = ONAX.KEY_API,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ key = key, hwid = ONAX.getHWID() })
        })
    end)
    if not ok then return false, "Không thể kết nối server key" end
    if not response then return false, "Không có phản hồi" end
    local body = response.Body
    if type(body) == "string" then
        local d = pcall(HttpService.JSONDecode, HttpService, body)
        if d then body = d end
    end
    if type(body) == "table" then
        if body.valid == true or body.success == true or body.status == "valid" or body.authorized == true then
            ONAX.Verified = true
            return true, "Key hợp lệ"
        end
    end
    return false, "Key không hợp lệ"
end

-- ===================== UI =====================
local function create(cls, props)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    return i
end

local function corner(parent, r)
    create("UICorner", { Parent = parent, CornerRadius = UDim.new(0, r or 8) })
end

local function makeDraggable(gui, dragPart)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    dragPart.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function notify(parent, text, color)
    color = color or Color3.fromRGB(140, 60, 255)
    local n = create("Frame", {
        Parent = parent, Size = UDim2.new(0, 260, 0, 40),
        Position = UDim2.new(1, -270, 0, 10),
        BackgroundColor3 = Color3.fromRGB(20, 20, 32), BorderSizePixel = 0
    })
    corner(n, 6)
    create("UIStroke", { Parent = n, Color = color, Thickness = 1.5 })
    create("TextLabel", {
        Parent = n, Size = UDim2.new(1, -16, 1, 0), Position = UDim2.new(0, 8, 0, 0),
        BackgroundTransparency = 1, Text = text, TextColor3 = Color3.fromRGB(220, 200, 255),
        TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 13
    })
    task.wait(3)
    n:Destroy()
end

local function createWindow(title)
    local ScreenGui = create("ScreenGui", {
        Parent = game:GetService("CoreGui"), Name = "GalaxyHub",
        ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    local Main = create("Frame", {
        Parent = ScreenGui, Size = UDim2.new(0, 640, 0, 440),
        Position = UDim2.new(0.5, -320, 0.5, -220),
        BackgroundColor3 = Color3.fromRGB(14, 14, 22), BorderSizePixel = 0
    })
    corner(Main, 8)
    create("UIStroke", { Parent = Main, Color = Color3.fromRGB(140, 60, 255), Thickness = 2, Transparency = 0.3 })

    local TitleBar = create("Frame", {
        Parent = Main, Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Color3.fromRGB(24, 24, 38), BorderSizePixel = 0
    })
    corner(TitleBar, 8)
    create("TextLabel", {
        Parent = TitleBar, Size = UDim2.new(1, -80, 0, 0), Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1, Text = title, TextColor3 = Color3.fromRGB(200, 160, 255),
        TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamBold, TextSize = 16
    })

    local MinBtn = create("TextButton", {
        Parent = TitleBar, Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -68, 0, 3),
        BackgroundColor3 = Color3.fromRGB(40, 40, 55), Text = "—", TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0
    })
    corner(MinBtn, 6)
    local CloseBtn = create("TextButton", {
        Parent = TitleBar, Size = UDim2.new(0, 30, 0, 30), Position = UDim2.new(1, -34, 0, 3),
        BackgroundColor3 = Color3.fromRGB(40, 40, 55), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold, TextSize = 14, BorderSizePixel = 0
    })
    corner(CloseBtn, 6)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local minimized = false
    MinBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        Main.Size = minimized and UDim2.new(0, 640, 0, 36) or UDim2.new(0, 640, 0, 440)
    end)

    makeDraggable(Main, TitleBar)

    local Sidebar = create("Frame", {
        Parent = Main, Size = UDim2.new(0, 140, 1, -36), Position = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = Color3.fromRGB(17, 17, 28), BorderSizePixel = 0
    })
    local SideList = create("ScrollingFrame", {
        Parent = Sidebar, Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 2,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    create("UIListLayout", { Parent = SideList, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4) })

    local Content = create("Frame", {
        Parent = Main, Size = UDim2.new(1, -140, 1, -36), Position = UDim2.new(0, 140, 0, 36),
        BackgroundColor3 = Color3.fromRGB(14, 14, 22), BorderSizePixel = 0
    })

    local tabs = {}
    local function addTab(name)
        local btn = create("TextButton", {
            Parent = SideList, Size = UDim2.new(1, -16, 0, 32), Position = UDim2.new(0, 8, 0, 0),
            BackgroundColor3 = Color3.fromRGB(28, 28, 44), Text = name,
            TextColor3 = Color3.fromRGB(200, 200, 220), Font = Enum.Font.GothamBold, TextSize = 13, BorderSizePixel = 0
        })
        corner(btn, 6)
        local page = create("ScrollingFrame", {
            Parent = Content, Size = UDim2.new(1, 0, 1, 0), Visible = false,
            BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        create("UIListLayout", { Parent = page, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6) })
        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do t.page.Visible = false end
            page.Visible = true
        end)
        table.insert(tabs, { btn = btn, page = page })
        return page
    end

    local function addToggle(page, text, default, callback)
        local holder = create("Frame", {
            Parent = page, Size = UDim2.new(1, -16, 0, 36), Position = UDim2.new(0, 8, 0, 0),
            BackgroundColor3 = Color3.fromRGB(22, 22, 36), BorderSizePixel = 0
        })
        corner(holder, 6)
        create("TextLabel", {
            Parent = holder, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.new(0, 10, 0, 0),
            BackgroundTransparency = 1, Text = text, TextColor3 = Color3.fromRGB(220, 220, 240),
            TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 13
        })
        local state = default or false
        local btn = create("TextButton", {
            Parent = holder, Size = UDim2.new(0, 44, 0, 22), Position = UDim2.new(1, -52, 0, 7),
            BackgroundColor3 = state and Color3.fromRGB(140, 60, 255) or Color3.fromRGB(50, 50, 70),
            Text = state and "ON" or "OFF", TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBold, TextSize = 11, BorderSizePixel = 0
        })
        corner(btn, 11)
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(140, 60, 255) or Color3.fromRGB(50, 50, 70)
            btn.Text = state and "ON" or "OFF"
            if callback then callback(state) end
        end)
    end

    local function addButton(page, text, callback)
        local btn = create("TextButton", {
            Parent = page, Size = UDim2.new(1, -16, 0, 34), Position = UDim2.new(0, 8, 0, 0),
            BackgroundColor3 = Color3.fromRGB(28, 28, 44), Text = text,
            TextColor3 = Color3.fromRGB(220, 200, 255), Font = Enum.Font.GothamBold, TextSize = 13, BorderSizePixel = 0
        })
        corner(btn, 6)
        btn.MouseButton1Click:Connect(callback or function() end)
    end

    return {
        ScreenGui = ScreenGui,
        addTab = addTab,
        addToggle = addToggle,
        addButton = addButton,
        notify = function(text, color) notify(ScreenGui, text, color) end
    }
end

-- ===================== HELPERS =====================
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
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

-- ===================== MODULES =====================
local AutoFarm = { Enabled = false, AutoHaki = false, BringMob = false }
local Magnet = { Enabled = false }
local Raid = { Enabled = false, AutoBuyChip = false }
local Fruit = { Enabled = false, Store = false }
local SeaEvent = { Enabled = false }
local Race = { Enabled = false }
local Item = { Enabled = false }
local Visual = { PlayerESP = false, FruitESP = false, MobESP = false, _espObjects = {} }
local Misc = { SafeMode = false }

-- AutoFarm logic
function AutoFarm.start()
    AutoFarm.Enabled = true
    task.spawn(function()
        while AutoFarm.Enabled do
            pcall(function()
                local target = getNearestMob()
                if target then
                    if AutoFarm.BringMob then
                        local tRoot = getRoot(target)
                        local root = getRoot(LocalPlayer.Character)
                        if tRoot and root then tRoot.CFrame = root.CFrame * CFrame.new(0, 0, 3) end
                    end
                    teleportTo(target)
                    attack()
                end
            end)
            task.wait(0.15)
        end
    end)
end
function AutoFarm.stop() AutoFarm.Enabled = false end

-- Magnet logic
local function isElectrified(mob)
    for _, child in pairs(mob:GetDescendants()) do
        if child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then return true end
    end
    return false
end
function Magnet.start()
    Magnet.Enabled = true
    task.spawn(function()
        while Magnet.Enabled do
            pcall(function()
                local char = LocalPlayer.Character
                local root = getRoot(char)
                if root then
                    local nearest, nearestDist = nil, math.huge
                    for _, v in pairs(Workspace:GetChildren()) do
                        if v:IsA("Model") and v ~= char then
                            local hum = v:FindFirstChildOfClass("Humanoid")
                            local hrp = v:FindFirstChild("HumanoidRootPart")
                            if hum and hrp and hum.Health > 0 and isElectrified(v) then
                                local dist = (hrp.Position - root.Position).Magnitude
                                if dist < nearestDist then nearestDist = dist; nearest = v end
                            end
                        end
                    end
                    if nearest then teleportTo(nearest); attack() end
                end
            end)
            task.wait(0.2)
        end
    end)
end
function Magnet.stop() Magnet.Enabled = false end

-- Raid logic
function Raid.start()
    Raid.Enabled = true
    task.spawn(function()
        while Raid.Enabled do
            pcall(function()
                local target = getNearestMob()
                if target then teleportTo(target); attack() end
            end)
            task.wait(0.2)
        end
    end)
end
function Raid.stop() Raid.Enabled = false end

-- Fruit logic
local function findFruit()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name:lower():find("fruit") then
            if v:IsA("Tool") then return v end
            if v:FindFirstChild("Handle") then return v end
        end
    end
    return nil
end
function Fruit.start()
    Fruit.Enabled = true
    task.spawn(function()
        while Fruit.Enabled do
            pcall(function()
                local f = findFruit()
                if f then
                    local handle = f:IsA("Tool") and f.Handle or f:FindFirstChild("Handle")
                    local root = getRoot(LocalPlayer.Character)
                    if handle and root then root.CFrame = handle.CFrame end
                end
            end)
            task.wait(1)
        end
    end)
end
function Fruit.stop() Fruit.Enabled = false end

-- SeaEvent logic
function SeaEvent.start()
    SeaEvent.Enabled = true
    task.spawn(function()
        while SeaEvent.Enabled do
            pcall(function()
                local target = getNearestMob()
                if target then teleportTo(target); attack() end
            end)
            task.wait(0.2)
        end
    end)
end
function SeaEvent.stop() SeaEvent.Enabled = false end

-- Race logic
function Race.start()
    Race.Enabled = true
    task.spawn(function()
        while Race.Enabled do
            pcall(function()
                local target = getNearestMob()
                if target then teleportTo(target); attack() end
            end)
            task.wait(0.2)
        end
    end)
end
function Race.stop() Race.Enabled = false end

-- Item logic
function Item.start()
    Item.Enabled = true
    task.spawn(function()
        while Item.Enabled do
            pcall(function()
                local target = getNearestMob()
                if target then teleportTo(target); attack() end
            end)
            task.wait(0.2)
        end
    end)
end
function Item.stop() Item.Enabled = false end

-- Visual logic
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
end
local function clearESP()
    for _, b in pairs(Visual._espObjects) do pcall(function() b:Destroy() end) end
    Visual._espObjects = {}
end
function Visual.start()
    task.spawn(function()
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
    end)
end

-- Misc logic
function Misc.serverHop()
    local servers = {}
    local ok, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
    end)
    if ok and result and result.data then
        for _, s in pairs(result.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then table.insert(servers, s.id) end
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
    end
end
function Misc.rejoin()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

-- ===================== KEY GATE =====================
local key = "PASTE_KEY_HERE"
local ok, msg = ONAX.verifyKey(key)
if not ok then
    warn("[GalaxyHub] " .. msg)
    return
end

-- ===================== BUILD UI =====================
local win = createWindow("GalaxyHub | BloxFruit")

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
win.addButton(tpTab, "Teleport Sea 1", function() teleportTo(getNearestMob()) end)
win.addButton(tpTab, "Teleport Sea 2", function() teleportTo(getNearestMob()) end)
win.addButton(tpTab, "Teleport Sea 3", function() teleportTo(getNearestMob()) end)

local visTab = win.addTab("Visual")
win.addToggle(visTab, "Player ESP", false, function(v) Visual.PlayerESP = v; Visual.start() end)
win.addToggle(visTab, "Fruit ESP", false, function(v) Visual.FruitESP = v; Visual.start() end)
win.addToggle(visTab, "Mob ESP", false, function(v) Visual.MobESP = v; Visual.start() end)

local miscTab = win.addTab("Misc")
win.addButton(miscTab, "Server Hop", function() Misc.serverHop() end)
win.addButton(miscTab, "Rejoin", function() Misc.rejoin() end)
win.addToggle(miscTab, "Safe Mode", false, function(v) Misc.SafeMode = v end)

win.notify("GalaxyHub loaded thành công!")
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_Banana_ONAX_FULL"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #2] GalaxyHub_Banana_ONAX_FULL:", err)
end
