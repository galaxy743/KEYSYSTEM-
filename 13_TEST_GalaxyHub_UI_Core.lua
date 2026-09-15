-- GalaxyHub standalone UI test #13
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_13"
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
title.Text = "GalaxyHub • TEST #13"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_UI_Core"
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

local source = [===[--[[ GalaxyHub | BloxFruit | FILE 2: UI Core (Black + Purple + Pink) ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local UI = {}
UI.__index = UI

local function create(cls, props)
    local i = Instance.new(cls)
    for k, v in pairs(props or {}) do i[k] = v end
    return i
end

local function corner(parent, r)
    create("UICorner", { Parent = parent, CornerRadius = UDim.new(0, r or 8) })
end

function UI.makeDraggable(gui, dragPart)
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

function UI.notify(parent, text, color)
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
    TweenService:Create(n, TweenInfo.new(0.4), { Position = UDim2.new(1, -270, 0, 10) }):Play()
    task.wait(3)
    TweenService:Create(n, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
    task.wait(0.4)
    n:Destroy()
end

function UI.createWindow(title)
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

    UI.makeDraggable(Main, TitleBar)

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
        return { set = function(v) state = v; btn.BackgroundColor3 = v and Color3.fromRGB(140, 60, 255) or Color3.fromRGB(50, 50, 70); btn.Text = v and "ON" or "OFF" end, get = function() return state end }
    end

    local function addButton(page, text, callback)
        local btn = create("TextButton", {
            Parent = page, Size = UDim2.new(1, -16, 0, 34), Position = UDim2.new(0, 8, 0, 0),
            BackgroundColor3 = Color3.fromRGB(28, 28, 44), Text = text,
            TextColor3 = Color3.fromRGB(220, 200, 255), Font = Enum.Font.GothamBold, TextSize = 13, BorderSizePixel = 0
        })
        corner(btn, 6)
        btn.MouseButton1Click:Connect(callback or function() end)
        return btn
    end

    local function addLabel(page, text)
        create("TextLabel", {
            Parent = page, Size = UDim2.new(1, -16, 0, 24), Position = UDim2.new(0, 8, 0, 0),
            BackgroundTransparency = 1, Text = text, TextColor3 = Color3.fromRGB(180, 180, 200),
            TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 12
        })
    end

    return {
        ScreenGui = ScreenGui,
        Main = Main,
        addTab = addTab,
        addToggle = addToggle,
        addButton = addButton,
        addLabel = addLabel,
        notify = function(text, color) UI.notify(ScreenGui, text, color) end
    }
end

return UI
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_UI_Core"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #13] GalaxyHub_UI_Core:", err)
end
