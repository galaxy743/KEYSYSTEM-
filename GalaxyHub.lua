-- ONAX • BLOXFRUIT
-- Small Black/Purple KeySystem + feature panel
-- Key check is synchronized with the ONAX backend.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer

local VERIFY_URL = "https://onax.onrender.com/api/check_key"
local GET_KEY_URL = "https://galaxy743.github.io/roblox/"

local requestFn = (syn and syn.request) or (http and http.request) or request or (fluxus and fluxus.request)

local function httpGet(url)
    if not requestFn then return nil, "HTTP request is not supported" end
    local ok, res = pcall(function()
        return requestFn({
            Url = url,
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
        })
    end)
    if not ok or not res then return nil, "Unable to connect" end
    return res.Body or res.body or "", nil
end

local function openUrl(url)
    if setclipboard then pcall(setclipboard, url) end
    if syn and syn.open_url then pcall(syn.open_url, url)
    elseif open_url then pcall(open_url, url) end
end

local function checkKey(key)
    key = tostring(key or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if key == "" then return false, "Vui lòng nhập key." end

    local body, err = httpGet(VERIFY_URL .. "?key=" .. HttpService:UrlEncode(key))
    if not body then return false, err end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if ok and type(data) == "table" then
        if data.valid == true and data.success == true then
            local remain = data.remaining
            if remain then
                return true, "Key hợp lệ • Còn " .. math.floor(remain / 3600) .. " giờ"
            end
            return true, "Key hợp lệ."
        end
        return false, data.error or data.message or "Key không hợp lệ."
    end

    return false, "API ONAX trả về dữ liệu không hợp lệ."
end

local gui = Instance.new("ScreenGui")
gui.Name = "ONAX_BloxFruit"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function stroke(obj)
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(135, 65, 220)
    s.Thickness = 1.3
    s.Transparency = 0.15
    s.Parent = obj
end

local function makeButton(parent, text, pos, size)
    local b = Instance.new("TextButton")
    b.Size = size
    b.Position = pos
    b.BackgroundColor3 = Color3.fromRGB(45, 25, 65)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = Color3.fromRGB(240, 225, 255)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    b.AutoButtonColor = true
    b.Parent = parent
    corner(b, 9)
    stroke(b)
    return b
end

-- KEY PANEL
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.fromOffset(360, 275)
keyFrame.Position = UDim2.new(.5, -180, .5, -138)
keyFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 18)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = gui
corner(keyFrame, 14)
stroke(keyFrame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 42)
title.Position = UDim2.fromOffset(17, 7)
title.BackgroundTransparency = 1
title.Text = "ONAX • BLOXFRUIT"
title.TextColor3 = Color3.fromRGB(205, 150, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = keyFrame

local closeKey = makeButton(keyFrame, "×", UDim2.new(1, -45, 0, 8), UDim2.fromOffset(32, 32))
closeKey.TextSize = 20

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -34, 0, 45)
keyBox.Position = UDim2.fromOffset(17, 55)
keyBox.BackgroundColor3 = Color3.fromRGB(24, 19, 31)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Nhập key ONAX..."
keyBox.PlaceholderColor3 = Color3.fromRGB(130, 120, 145)
keyBox.TextColor3 = Color3.fromRGB(245, 240, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame
corner(keyBox, 9)
stroke(keyBox)

local get = makeButton(keyFrame, "GET KEY", UDim2.fromOffset(17, 112), UDim2.fromOffset(155, 43))
local submit = makeButton(keyFrame, "CHECK KEY", UDim2.fromOffset(188, 112), UDim2.fromOffset(155, 43))

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -34, 0, 52)
status.Position = UDim2.fromOffset(17, 166)
status.BackgroundTransparency = 1
status.Text = "Nhập key rồi bấm CHECK KEY"
status.TextColor3 = Color3.fromRGB(170, 160, 185)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextWrapped = true
status.Parent = keyFrame

local support = Instance.new("TextLabel")
support.Size = UDim2.new(1, -34, 0, 25)
support.Position = UDim2.fromOffset(17, 230)
support.BackgroundTransparency = 1
support.Text = "SUPPORT • t.me/onaxscript"
support.TextColor3 = Color3.fromRGB(175, 110, 235)
support.Font = Enum.Font.GothamSemibold
support.TextSize = 12
support.Parent = keyFrame

-- FEATURE PANEL
local featureFrame

local function createFeaturePanel()
    featureFrame = Instance.new("Frame")
    featureFrame.Size = UDim2.fromOffset(365, 335)
    featureFrame.Position = UDim2.new(.5, -182, .5, -168)
    featureFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 18)
    featureFrame.BorderSizePixel = 0
    featureFrame.Parent = gui
    corner(featureFrame, 14)
    stroke(featureFrame)

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -25, 0, 43)
    t.Position = UDim2.fromOffset(17, 5)
    t.BackgroundTransparency = 1
    t.Text = "ONAX • BLOXFRUIT"
    t.TextColor3 = Color3.fromRGB(205, 150, 255)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 17
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.Parent = featureFrame

    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -34, 0, 28)
    info.Position = UDim2.fromOffset(17, 43)
    info.BackgroundTransparency = 1
    info.Text = "KEY VERIFIED • FEATURES"
    info.TextColor3 = Color3.fromRGB(155, 125, 185)
    info.Font = Enum.Font.Gotham
    info.TextSize = 11
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Parent = featureFrame

    local fixLag = makeButton(featureFrame, "FIX LAG", UDim2.fromOffset(17, 78), UDim2.new(1, -34, 0, 43))
    local autoFarm = makeButton(featureFrame, "AUTO FARM", UDim2.fromOffset(17, 130), UDim2.new(1, -34, 0, 43))
    local mobFarm = makeButton(featureFrame, "AUTO QUEST + MOB", UDim2.fromOffset(17, 182), UDim2.new(1, -34, 0, 43))
    local close = makeButton(featureFrame, "CLOSE", UDim2.fromOffset(17, 244), UDim2.new(1, -34, 0, 38))

    local featureStatus = Instance.new("TextLabel")
    featureStatus.Size = UDim2.new(1, -34, 0, 35)
    featureStatus.Position = UDim2.fromOffset(17, 286)
    featureStatus.BackgroundTransparency = 1
    featureStatus.Text = "Sẵn sàng."
    featureStatus.TextColor3 = Color3.fromRGB(170, 160, 185)
    featureStatus.Font = Enum.Font.Gotham
    featureStatus.TextSize = 11
    featureStatus.Parent = featureFrame

    -- Safe client-side optimization. Does not alter server data.
    fixLag.MouseButton1Click:Connect(function()
        featureStatus.Text = "Đã bật tối ưu client."
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                    obj.Enabled = false
                end
            end
        end)
    end)

    -- These buttons intentionally expose the feature state.
    -- Game-specific NPC/quest/remote names must be connected to the target game's
    -- current API before implementing automatic quest and combat actions.
    autoFarm.MouseButton1Click:Connect(function()
        featureStatus.Text = "AUTO FARM: bật • cần cấu hình NPC/quest của game."
        autoFarm.Text = "AUTO FARM • ON"
    end)

    mobFarm.MouseButton1Click:Connect(function()
        featureStatus.Text = "AUTO QUEST + MOB: bật • cần cấu hình NPC/quest."
        mobFarm.Text = "AUTO QUEST + MOB • ON"
    end)

    close.MouseButton1Click:Connect(function()
        featureFrame.Visible = false
    end)
end

createFeaturePanel()
featureFrame.Visible = false

closeKey.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

get.MouseButton1Click:Connect(function()
    status.Text = "Đã sao chép link Get Key."
    status.TextColor3 = Color3.fromRGB(205, 150, 255)
    openUrl(GET_KEY_URL)
end)

submit.MouseButton1Click:Connect(function()
    submit.Text = "CHECKING..."
    status.Text = "Đang kiểm tra key với ONAX..."
    status.TextColor3 = Color3.fromRGB(205, 150, 255)

    local valid, message = checkKey(keyBox.Text)

    if valid then
        status.Text = message
        status.TextColor3 = Color3.fromRGB(170, 255, 190)
        task.wait(.5)
        keyFrame.Visible = false
        featureFrame.Visible = true
    else
        status.Text = message
        status.TextColor3 = Color3.fromRGB(255, 125, 150)
    end

    submit.Text = "CHECK KEY"
end)
