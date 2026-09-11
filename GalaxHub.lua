-- ONAX • Blox Fruits | API Verify + Success Panel

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then return end

local GET_KEY_URL = "https://galaxy743.github.io/roblox/"
local VERIFY_URL = "https://onax.onrender.com/api/check_key?key="

local Gui = Instance.new("ScreenGui")
Gui.Name = "ONAX_BloxFruits"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true

local ok = pcall(function()
    Gui.Parent = game:GetService("CoreGui")
end)
if not ok or not Gui.Parent then
    Gui.Parent = player:WaitForChild("PlayerGui")
end

local function corner(obj, n)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, n)
    c.Parent = obj
end

local function stroke(obj, color)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = 2
    s.Parent = obj
end

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,430,0,235)
Main.Position = UDim2.new(.5,-215,.5,-118)
Main.BackgroundColor3 = Color3.fromRGB(8,20,38)
Main.BorderSizePixel = 0
corner(Main,16)
stroke(Main,Color3.fromRGB(0,170,255))

local Title = Instance.new("TextLabel",Main)
Title.Size = UDim2.new(1,-60,0,42)
Title.Position = UDim2.new(0,20,0,12)
Title.BackgroundTransparency = 1
Title.Text = "⚡ ONAX • Blox Fruits"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton",Main)
Close.Size = UDim2.new(0,32,0,32)
Close.Position = UDim2.new(1,-42,0,12)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(220,235,250)
Close.TextSize = 28
Close.Font = Enum.Font.GothamBold

local KeyBox = Instance.new("TextBox",Main)
KeyBox.Size = UDim2.new(1,-40,0,45)
KeyBox.Position = UDim2.new(0,20,0,62)
KeyBox.BackgroundColor3 = Color3.fromRGB(15,34,57)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "🔑  Nhập key của bạn..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(135,155,175)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.TextSize = 15
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
corner(KeyBox,10)

local GetKey = Instance.new("TextButton",Main)
GetKey.Size = UDim2.new(.47,-5,0,45)
GetKey.Position = UDim2.new(0,20,0,119)
GetKey.BackgroundColor3 = Color3.fromRGB(25,90,155)
GetKey.BorderSizePixel = 0
GetKey.Text = "🔑  GET KEY"
GetKey.TextColor3 = Color3.new(1,1,1)
GetKey.TextSize = 15
GetKey.Font = Enum.Font.GothamBold
corner(GetKey,10)

local Verify = Instance.new("TextButton",Main)
Verify.Size = UDim2.new(.47,-5,0,45)
Verify.Position = UDim2.new(.53,0,0,119)
Verify.BackgroundColor3 = Color3.fromRGB(20,125,245)
Verify.BorderSizePixel = 0
Verify.Text = "✓  XÁC NHẬN"
Verify.TextColor3 = Color3.new(1,1,1)
Verify.TextSize = 15
Verify.Font = Enum.Font.GothamBold
corner(Verify,10)

local Status = Instance.new("TextLabel",Main)
Status.Size = UDim2.new(1,-40,0,28)
Status.Position = UDim2.new(0,20,0,181)
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
        pcall(setclipboard,GET_KEY_URL)
        Status.Text = "● Link Get Key đã được copy!"
    elseif toclipboard then
        pcall(toclipboard,GET_KEY_URL)
        Status.Text = "● Link Get Key đã được copy!"
    else
        Status.Text = "● Get Key: "..GET_KEY_URL
    end
end)

local function ShowSuccess(data)
    Main.Visible = false

    local Success = Instance.new("Frame",Gui)
    Success.Name = "SuccessPanel"
    Success.Size = UDim2.new(0,430,0,235)
    Success.Position = UDim2.new(.5,-215,.5,-118)
    Success.BackgroundColor3 = Color3.fromRGB(8,20,38)
    Success.BorderSizePixel = 0
    corner(Success,16)
    stroke(Success,Color3.fromRGB(0,200,120))

    local T = Instance.new("TextLabel",Success)
    T.Size = UDim2.new(1,-60,0,42)
    T.Position = UDim2.new(0,20,0,12)
    T.BackgroundTransparency = 1
    T.Text = "⚡ ONAX • Blox Fruits"
    T.TextColor3 = Color3.new(1,1,1)
    T.TextSize = 22
    T.Font = Enum.Font.GothamBold
    T.TextXAlignment = Enum.TextXAlignment.Left

    local C = Instance.new("TextButton",Success)
    C.Size = UDim2.new(0,32,0,32)
    C.Position = UDim2.new(1,-42,0,12)
    C.BackgroundTransparency = 1
    C.Text = "×"
    C.TextColor3 = Color3.fromRGB(220,235,250)
    C.TextSize = 28
    C.Font = Enum.Font.GothamBold
    C.MouseButton1Click:Connect(function() Gui:Destroy() end)

    local S = Instance.new("TextLabel",Success)
    S.Size = UDim2.new(1,-40,0,45)
    S.Position = UDim2.new(0,20,0,62)
    S.BackgroundTransparency = 1
    S.Text = "✓  KEY HỢP LỆ"
    S.TextColor3 = Color3.fromRGB(80,255,140)
    S.TextSize = 20
    S.Font = Enum.Font.GothamBold

    local I = Instance.new("TextLabel",Success)
    I.Size = UDim2.new(1,-40,0,40)
    I.Position = UDim2.new(0,20,0,105)
    I.BackgroundTransparency = 1
    I.Text = "Thời hạn: "..tostring(data.days or "?").." ngày  •  Trạng thái: Active"
    I.TextColor3 = Color3.fromRGB(210,225,240)
    I.TextSize = 15
    I.Font = Enum.Font.Gotham

    local Continue = Instance.new("TextButton",Success)
    Continue.Size = UDim2.new(1,-40,0,45)
    Continue.Position = UDim2.new(0,20,0,160)
    Continue.BackgroundColor3 = Color3.fromRGB(20,125,245)
    Continue.BorderSizePixel = 0
    Continue.Text = "TIẾP TỤC"
    Continue.TextColor3 = Color3.new(1,1,1)
    Continue.TextSize = 15
    Continue.Font = Enum.Font.GothamBold
    corner(Continue,10)

    Continue.MouseButton1Click:Connect(function()
        -- Đặt loadstring của script chính tại đây khi bạn có URL.
        -- loadstring(game:HttpGet("URL_SCRIPT_CHINH"))()
        S.Text = "✓  KEY HỢP LỆ"
    end)
end

Verify.MouseButton1Click:Connect(function()
    local key = KeyBox.Text:gsub("^%s*(.-)%s*$","%1")
    if key == "" then
        Status.Text = "● Vui lòng nhập key trước."
        return
    end

    Verify.Text = "ĐANG KIỂM TRA..."
    Status.Text = "● Đang kiểm tra API..."

    local ok2, response = pcall(function()
        return game:HttpGet(VERIFY_URL..HttpService:UrlEncode(key))
    end)

    if not ok2 then
        Verify.Text = "✓  XÁC NHẬN"
        Status.Text = "● Không thể kết nối API."
        return
    end

    local decoded, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not decoded or type(data) ~= "table" then
        Verify.Text = "✓  XÁC NHẬN"
        Status.Text = "● API trả dữ liệu không hợp lệ."
        return
    end

    Verify.Text = "✓  XÁC NHẬN"

    if data.valid == true then
        ShowSuccess(data)
    else
        Status.Text = "● "..tostring(data.error or "Key không hợp lệ!")
    end
end)

-- Kéo bảng
local dragging, dragStart, startPos = false,nil,nil

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
    end
end)
