--// ONAX KEY SYSTEM - DEMO
--// Blox Fruits style

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer

local GET_KEY_URL = "https://galaxy743.github.io/roblox/"
local VERIFY_URL = "https://onax.onrender.com/"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ONAX_KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 380, 0, 245)
Main.Position = UDim2.new(0.5, -190, 0.5, -122)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 14)
Corner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(70, 70, 85)
Stroke.Thickness = 1.5
Stroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 45)
Title.Position = UDim2.new(0, 15, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⚔ ONAX KEY SYSTEM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -30, 0, 25)
SubTitle.Position = UDim2.new(0, 15, 0, 48)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Blox Fruits"
SubTitle.TextColor3 = Color3.fromRGB(160, 160, 170)
SubTitle.TextSize = 14
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Main

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 42)
KeyBox.Position = UDim2.new(0, 20, 0, 82)
KeyBox.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Nhập key của bạn..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 9)
BoxCorner.Parent = KeyBox

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.new(0.46, -5, 0, 42)
GetKey.Position = UDim2.new(0, 20, 0, 137)
GetKey.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
GetKey.BorderSizePixel = 0
GetKey.Text = "🔑 GET KEY"
GetKey.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKey.TextSize = 14
GetKey.Font = Enum.Font.GothamBold
GetKey.Parent = Main

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 9)
GetCorner.Parent = GetKey

local Verify = Instance.new("TextButton")
Verify.Size = UDim2.new(0.46, -5, 0, 42)
Verify.Position = UDim2.new(0.54, 0, 0, 137)
Verify.BackgroundColor3 = Color3.fromRGB(45, 120, 255)
Verify.BorderSizePixel = 0
Verify.Text = "✓ XÁC NHẬN"
Verify.TextColor3 = Color3.fromRGB(255, 255, 255)
Verify.TextSize = 14
Verify.Font = Enum.Font.GothamBold
Verify.Parent = Main

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 9)
VerifyCorner.Parent = Verify

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -40, 0, 30)
Status.Position = UDim2.new(0, 20, 0, 190)
Status.BackgroundTransparency = 1
Status.Text = "Trạng thái: Chưa xác nhận"
Status.TextColor3 = Color3.fromRGB(170, 170, 180)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.Parent = Main

GetKey.MouseButton1Click:Connect(function()
    Status.Text = "Đang mở trang Get Key..."
    pcall(function()
        GuiService:OpenBrowserWindow(GET_KEY_URL)
    end)
    task.wait(0.5)
    Status.Text = "Hãy lấy key rồi nhập vào ô bên trên."
end)

Verify.MouseButton1Click:Connect(function()
    local Key = KeyBox.Text

    if Key == "" then
        Status.Text = "❌ Vui lòng nhập key."
        return
    end

    Status.Text = "⏳ Đang xác nhận key..."
    Verify.Text = "ĐANG KIỂM TRA..."

    task.wait(1)

    -- DEMO ONLY: chưa kết nối API Verify thật.
    Status.Text = "⚠ Demo: API Verify chưa được kết nối."
    Verify.Text = "✓ XÁC NHẬN"
end)
