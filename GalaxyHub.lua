-- GalaxyHub • Blox Fruits | Red Key UI
-- Giao diện mô phỏng theo ảnh người dùng:
-- - Không còn đồng hồ "KEY: xx ngày" ở góc phải
-- - Màu đỏ/đen
-- - Logo là chữ "GalaxyHub"
-- - Bỏ "How To Get Key", YouTube và Discord
-- - Support Us = t.me/onaxscript
-- - XÁC NHẬN vẫn kiểm tra key qua máy chủ ONAX

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
if not player then return end

local GET_KEY_URL = "https://galaxy743.github.io/roblox/"
local SUPPORT_URL = "https://t.me/onaxscript"
local VERIFY_URL = "https://onax.onrender.com/api/check_key?key="

-- Nếu bạn upload ảnh GalaxyHub_anime_logo.png lên Roblox,
-- thay chuỗi dưới đây bằng rbxassetid://ID_CUA_ANH.
local ANIME_IMAGE = ""

local Gui = Instance.new("ScreenGui")
Gui.Name = "GalaxyHub_KeySystem"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true

pcall(function()
    Gui.Parent = game:GetService("CoreGui")
end)
if not Gui.Parent then
    Gui.Parent = player:WaitForChild("PlayerGui")
end

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function outline(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 2
    s.Parent = obj
end

-- Main panel
local Main = Instance.new("Frame")
Main.Parent = Gui
Main.Size = UDim2.new(0, 500, 0, 455)
Main.Position = UDim2.new(0.5, -250, 0.5, -228)
Main.BackgroundColor3 = Color3.fromRGB(28, 24, 28)
Main.BorderSizePixel = 0
corner(Main, 24)
outline(Main, Color3.fromRGB(190, 0, 35), 2)

-- Very subtle background pattern
local Pattern = Instance.new("Frame")
Pattern.Parent = Main
Pattern.Size = UDim2.new(1, 0, 1, 0)
Pattern.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Pattern.BackgroundTransparency = 0.35
Pattern.BorderSizePixel = 0
Pattern.ZIndex = 0
corner(Pattern, 24)

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, -40, 0, 62)
Title.Position = UDim2.new(0, 20, 0, 18)
Title.BackgroundTransparency = 1
Title.Text = "GalaxyHub"
Title.TextColor3 = Color3.fromRGB(245, 245, 245)
Title.TextSize = 34
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 2

-- Small red accent under title
local Accent = Instance.new("Frame")
Accent.Parent = Main
Accent.Size = UDim2.new(0, 90, 0, 3)
Accent.Position = UDim2.new(0.5, -45, 0, 78)
Accent.BackgroundColor3 = Color3.fromRGB(220, 0, 45)
Accent.BorderSizePixel = 0
corner(Accent, 2)
Accent.ZIndex = 2

-- Key box
local KeyBox = Instance.new("TextBox")
KeyBox.Parent = Main
KeyBox.Size = UDim2.new(1, -70, 0, 50)
KeyBox.Position = UDim2.new(0, 35, 0, 100)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 18, 21)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "ENTER KEY HERE"
KeyBox.PlaceholderColor3 = Color3.fromRGB(155, 155, 160)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(245, 245, 245)
KeyBox.TextSize = 15
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.ZIndex = 2
corner(KeyBox, 14)
outline(KeyBox, Color3.fromRGB(130, 0, 25), 2)

-- GET KEY
local GetKey = Instance.new("TextButton")
GetKey.Parent = Main
GetKey.Size = UDim2.new(0.5, -40, 0, 48)
GetKey.Position = UDim2.new(0, 35, 0, 165)
GetKey.BackgroundColor3 = Color3.fromRGB(205, 0, 38)
GetKey.BorderSizePixel = 0
GetKey.Text = "GET KEY"
GetKey.TextColor3 = Color3.new(1,1,1)
GetKey.TextSize = 16
GetKey.Font = Enum.Font.GothamBold
GetKey.ZIndex = 2
corner(GetKey, 12)

-- Submit
local Submit = Instance.new("TextButton")
Submit.Parent = Main
Submit.Size = UDim2.new(1, -70, 0, 48)
Submit.Position = UDim2.new(0, 35, 0, 225)
Submit.BackgroundColor3 = Color3.fromRGB(205, 0, 38)
Submit.BorderSizePixel = 0
Submit.Text = "SUBMIT KEY"
Submit.TextColor3 = Color3.new(1,1,1)
Submit.TextSize = 16
Submit.Font = Enum.Font.GothamBold
Submit.ZIndex = 2
corner(Submit, 12)

-- Optional anime image
local Anime = Instance.new("ImageLabel")
Anime.Parent = Main
Anime.Size = UDim2.new(0, 105, 0, 105)
Anime.Position = UDim2.new(0, 35, 0, 292)
Anime.BackgroundColor3 = Color3.fromRGB(20,18,21)
Anime.BorderSizePixel = 0
Anime.Image = ANIME_IMAGE
Anime.ScaleType = Enum.ScaleType.Crop
Anime.ZIndex = 2
corner(Anime, 14)
outline(Anime, Color3.fromRGB(130, 0, 25), 2)

-- Support us
local Support = Instance.new("TextButton")
Support.Parent = Main
Support.Size = UDim2.new(1, -170, 0, 44)
Support.Position = UDim2.new(0, 155, 0, 300)
Support.BackgroundColor3 = Color3.fromRGB(20, 18, 21)
Support.BorderSizePixel = 0
Support.Text = "SUPPORT US"
Support.TextColor3 = Color3.fromRGB(235, 235, 235)
Support.TextSize = 15
Support.Font = Enum.Font.GothamBold
Support.ZIndex = 2
corner(Support, 12)
outline(Support, Color3.fromRGB(130, 0, 25), 2)

-- Status
local Status = Instance.new("TextLabel")
Status.Parent = Main
Status.Size = UDim2.new(1, -170, 0, 48)
Status.Position = UDim2.new(0, 155, 0, 352)
Status.BackgroundTransparency = 1
Status.Text = "Ready"
Status.TextColor3 = Color3.fromRGB(190, 190, 195)
Status.TextSize = 13
Status.Font = Enum.Font.Gotham
Status.TextWrapped = true
Status.ZIndex = 2

-- Close
local Close = Instance.new("TextButton")
Close.Parent = Main
Close.Size = UDim2.new(0, 36, 0, 36)
Close.Position = UDim2.new(1, -50, 0, 18)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(235, 235, 235)
Close.TextSize = 30
Close.Font = Enum.Font.GothamBold
Close.ZIndex = 3

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

local function copyText(text)
    if setclipboard then
        return pcall(setclipboard, text)
    elseif toclipboard then
        return pcall(toclipboard, text)
    end
    return false
end

GetKey.MouseButton1Click:Connect(function()
    if copyText(GET_KEY_URL) then
        Status.Text = "Get Key link copied!"
    else
        Status.Text = GET_KEY_URL
    end
end)

Support.MouseButton1Click:Connect(function()
    if copyText(SUPPORT_URL) then
        Status.Text = "Telegram link copied!"
    else
        Status.Text = SUPPORT_URL
    end
end)

local function formatRemaining(seconds)
    seconds = math.max(0, math.floor(seconds))
    local days = math.floor(seconds / 86400)
    seconds = seconds % 86400
    local hours = math.floor(seconds / 3600)
    seconds = seconds % 3600
    local minutes = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%d ngày %02d:%02d:%02d", days, hours, minutes, secs)
end

local function showSuccess(data)
    Main.Visible = false

    local Success = Instance.new("Frame")
    Success.Parent = Gui
    Success.Size = UDim2.new(0, 500, 0, 310)
    Success.Position = UDim2.new(0.5, -250, 0.5, -155)
    Success.BackgroundColor3 = Color3.fromRGB(28, 24, 28)
    Success.BorderSizePixel = 0
    corner(Success, 24)
    outline(Success, Color3.fromRGB(0, 210, 100), 2)

    local T = Instance.new("TextLabel", Success)
    T.Size = UDim2.new(1, -70, 0, 55)
    T.Position = UDim2.new(0, 35, 0, 18)
    T.BackgroundTransparency = 1
    T.Text = "GalaxyHub"
    T.TextColor3 = Color3.fromRGB(245,245,245)
    T.TextSize = 30
    T.Font = Enum.Font.GothamBold

    local X = Instance.new("TextButton", Success)
    X.Size = UDim2.new(0,36,0,36)
    X.Position = UDim2.new(1,-50,0,18)
    X.BackgroundTransparency = 1
    X.Text = "×"
    X.TextColor3 = Color3.fromRGB(235,235,235)
    X.TextSize = 30
    X.Font = Enum.Font.GothamBold
    X.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)

    local Valid = Instance.new("TextLabel", Success)
    Valid.Size = UDim2.new(1,-70,0,50)
    Valid.Position = UDim2.new(0,35,0,82)
    Valid.BackgroundTransparency = 1
    Valid.Text = "✓  KEY HỢP LỆ"
    Valid.TextColor3 = Color3.fromRGB(70,255,130)
    Valid.TextSize = 21
    Valid.Font = Enum.Font.GothamBold

    local Info = Instance.new("TextLabel", Success)
    Info.Size = UDim2.new(1,-70,0,50)
    Info.Position = UDim2.new(0,35,0,130)
    Info.BackgroundTransparency = 1
    Info.Text = "Thời hạn: "..tostring(data.days or "?").." ngày"
    Info.TextColor3 = Color3.fromRGB(215,215,220)
    Info.TextSize = 15
    Info.Font = Enum.Font.Gotham

    local Continue = Instance.new("TextButton", Success)
    Continue.Size = UDim2.new(1,-70,0,50)
    Continue.Position = UDim2.new(0,35,0,205)
    Continue.BackgroundColor3 = Color3.fromRGB(205,0,38)
    Continue.BorderSizePixel = 0
    Continue.Text = "TIẾP TỤC"
    Continue.TextColor3 = Color3.new(1,1,1)
    Continue.TextSize = 16
    Continue.Font = Enum.Font.GothamBold
    corner(Continue,12)

    -- Server expiry countdown is shown INSIDE the success panel,
    -- not in the top-right corner.
    local expires = tonumber(data.expires)
    if not expires and data.activated_at and data.days then
        expires = tonumber(data.activated_at) + tonumber(data.days) * 86400
    end

    if expires then
        task.spawn(function()
            while Gui.Parent and Success.Parent do
                local left = expires - os.time()
                if left <= 0 then
                    Info.Text = "KEY ĐÃ HẾT HẠN"
                    Info.TextColor3 = Color3.fromRGB(255,80,80)
                    Continue.Active = false
                    Continue.AutoButtonColor = false
                    break
                end
                Info.Text = "Còn lại: "..formatRemaining(left)
                task.wait(1)
            end
        end)
    end

    Continue.MouseButton1Click:Connect(function()
        -- Đặt raw URL SCRIPT CHÍNH ở đây nếu bạn muốn chạy script sau khi xác nhận.
        -- Ví dụ:
        -- loadstring(game:HttpGet("https://raw.githubusercontent.com/USER/REPO/main/main.lua"))()
        Info.Text = "Key hợp lệ — sẵn sàng!"
    end)
end

Submit.MouseButton1Click:Connect(function()
    local key = KeyBox.Text:gsub("^%s*(.-)%s*$","%1")
    if key == "" then
        Status.Text = "Please enter your key."
        return
    end

    Submit.Text = "CHECKING..."
    Status.Text = "Checking key..."

    local ok, response = pcall(function()
        return game:HttpGet(VERIFY_URL..HttpService:UrlEncode(key))
    end)

    if not ok then
        Submit.Text = "SUBMIT KEY"
        Status.Text = "Unable to connect."
        return
    end

    local decoded, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    Submit.Text = "SUBMIT KEY"

    if not decoded or type(data) ~= "table" then
        Status.Text = "Invalid response."
        return
    end

    if data.valid == true then
        showSuccess(data)
    else
        Status.Text = tostring(data.error or "Key không hợp lệ!")
    end
end)

-- Drag UI
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

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
