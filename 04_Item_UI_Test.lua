-- GalaxyHub UI TEST | Item
-- Chỉ kiểm tra UI, chưa chạy chức năng gốc.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local function getParent()
    local ok, h = pcall(function()
        if gethui then return gethui() end
    end)
    if ok and h then return h end
    return CoreGui
end

local parent = getParent()
local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_UI_TEST_Item"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = parent

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 220)
main.Position = UDim2.new(0.5, -180, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(20,16,28)
main.BorderSizePixel = 0
main.Parent = gui

local c = Instance.new("UICorner", main)
c.CornerRadius = UDim.new(0,14)

local s = Instance.new("UIStroke", main)
s.Color = Color3.fromRGB(150,70,220)
s.Thickness = 2

local t = Instance.new("TextLabel", main)
t.Size = UDim2.new(1,-30,0,42)
t.Position = UDim2.new(0,15,0,12)
t.BackgroundTransparency = 1
t.Text = "GalaxyHub | Item"
t.TextColor3 = Color3.fromRGB(235,210,255)
t.TextSize = 21
t.Font = Enum.Font.GothamBold
t.TextXAlignment = Enum.TextXAlignment.Left

local st = Instance.new("TextLabel", main)
st.Size = UDim2.new(1,-30,0,35)
st.Position = UDim2.new(0,15,0,58)
st.BackgroundTransparency = 1
st.Text = "UI TEST: ĐÃ HIỆN"
st.TextColor3 = Color3.fromRGB(120,255,160)
st.TextSize = 17
st.Font = Enum.Font.GothamMedium
st.TextXAlignment = Enum.TextXAlignment.Left

local inf = Instance.new("TextLabel", main)
inf.Size = UDim2.new(1,-30,0,50)
inf.Position = UDim2.new(0,15,0,94)
inf.BackgroundTransparency = 1
inf.Text = "Chỉ test giao diện.\nChưa chạy chức năng gốc."
inf.TextColor3 = Color3.fromRGB(190,180,200)
inf.TextSize = 15
inf.Font = Enum.Font.Gotham
inf.TextXAlignment = Enum.TextXAlignment.Left

local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0,150,0,38)
btn.Position = UDim2.new(0,15,1,-50)
btn.BackgroundColor3 = Color3.fromRGB(115,55,180)
btn.Text = "TEST UI"
btn.TextColor3 = Color3.new(1,1,1)
btn.TextSize = 16
btn.Font = Enum.Font.GothamBold
Instance.new("UICorner",btn).CornerRadius = UDim.new(0,9)

btn.MouseButton1Click:Connect(function()
    st.Text = "UI OK: Item"
end)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0,80,0,38)
close.Position = UDim2.new(1,-95,1,-50)
close.BackgroundColor3 = Color3.fromRGB(55,45,65)
close.Text = "Đóng"
close.TextColor3 = Color3.new(1,1,1)
close.TextSize = 15
close.Font = Enum.Font.GothamBold
Instance.new("UICorner",close).CornerRadius = UDim.new(0,9)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
