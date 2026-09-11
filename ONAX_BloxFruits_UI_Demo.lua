-- ONAX • Blox Fruits | UI ONLY DEMO
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end

local GET_KEY_URL = "https://galaxy743.github.io/roblox/"

local function makeGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "ONAX_BloxFruits"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true

    local ok = pcall(function()
        gui.Parent = game:GetService("CoreGui")
    end)

    if not ok or not gui.Parent then
        gui.Parent = player:WaitForChild("PlayerGui")
    end
    return gui
end

local Gui = makeGui()

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 430, 0, 235)
Main.Position = UDim2.new(0.5, -215, 0.5, -118)
Main.BackgroundColor3 = Color3.fromRGB(8, 20, 38)
Main.BorderSizePixel = 0
Main.Parent = Gui

local c = Instance.new("UICorner", Main)
c.CornerRadius = UDim.new(0, 16)

local s = Instance.new("UIStroke", Main)
s.Color = Color3.fromRGB(0, 170, 255)
s.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -60, 0, 42)
Title.Position = UDim2.new(0, 20, 0, 12)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ONAX • Blox Fruits"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -42, 0, 12)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(220,235,250)
Close.TextSize = 28
Close.Font = Enum.Font.GothamBold

local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(1, -40, 0, 45)
KeyBox.Position = UDim2.new(0, 20, 0, 62)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 34, 57)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "🔑  Nhập key của bạn..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(135,155,175)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.TextSize = 15
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false

local kc = Instance.new("UICorner", KeyBox)
kc.CornerRadius = UDim.new(0, 10)

local ks = Instance.new("UIStroke", KeyBox)
ks.Color = Color3.fromRGB(0,145,255)

local GetKey = Instance.new("TextButton", Main)
GetKey.Size = UDim2.new(0.47, -5, 0, 45)
GetKey.Position = UDim2.new(0, 20, 0, 119)
GetKey.BackgroundColor3 = Color3.fromRGB(25,90,155)
GetKey.BorderSizePixel = 0
GetKey.Text = "🔑  GET KEY"
GetKey.TextColor3 = Color3.new(1,1,1)
GetKey.TextSize = 15
GetKey.Font = Enum.Font.GothamBold

local gc = Instance.new("UICorner", GetKey)
gc.CornerRadius = UDim.new(0, 10)

local Verify = Instance.new("TextButton", Main)
Verify.Size = UDim2.new(0.47, -5, 0, 45)
Verify.Position = UDim2.new(0.53, 0, 0, 119)
Verify.BackgroundColor3 = Color3.fromRGB(20,125,245)
Verify.BorderSizePixel = 0
Verify.Text = "✓  XÁC NHẬN"
Verify.TextColor3 = Color3.new(1,1,1)
Verify.TextSize = 15
Verify.Font = Enum.Font.GothamBold

local vc = Instance.new("UICorner", Verify)
vc.CornerRadius = UDim.new(0, 10)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, -40, 0, 28)
Status.Position = UDim2.new(0, 20, 0, 181)
Status.BackgroundTransparency = 1
Status.Text = "● Sẵn sàng"
Status.TextColor3 = Color3.fromRGB(120,210,255)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.TextXAlignment = Enum.TextXAlignment.Left

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

GetKey.MouseButton1Click:Connect(function()
    if setclipboard then
        pcall(setclipboard, GET_KEY_URL)
        Status.Text = "● Link Get Key đã được copy!"
    elseif toclipboard then
        pcall(toclipboard, GET_KEY_URL)
        Status.Text = "● Link Get Key đã được copy!"
    else
        Status.Text = "● Get Key: " .. GET_KEY_URL
    end
end)

Verify.MouseButton1Click:Connect(function()
    if KeyBox.Text == "" then
        Status.Text = "● Vui lòng nhập key trước."
        return
    end
    Verify.Text = "ĐANG KIỂM TRA..."
    Status.Text = "● Đang kiểm tra..."
    task.wait(1)
    Verify.Text = "✓  XÁC NHẬN"
    Status.Text = "● Demo UI: API Verify chưa kết nối."
end)

local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
