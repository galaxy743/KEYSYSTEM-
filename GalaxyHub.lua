-- ONAX KeySystem UI
-- Black + Purple / Small UI
-- API check: change VERIFY_URL if your ONAX backend uses another endpoint.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer

local VERIFY_URL = "https://onax.onrender.com/api/verify"
local GET_KEY_URL = "https://galaxy743.github.io/roblox/"
local SUCCESS_SCRIPT_URL = "https://raw.githubusercontent.com/galaxy743/KEYSYSTEM-/refs/heads/main/GalaxyHub.lua"

local function request(url)
    local req = (syn and syn.request) or (http and http.request) or request or (fluxus and fluxus.request)
    if not req then
        return nil, "HTTP request is not supported"
    end

    local ok, result = pcall(function()
        return req({
            Url = url,
            Method = "GET",
            Headers = {["Content-Type"] = "application/json"}
        })
    end)

    if not ok or not result then
        return nil, "Unable to connect"
    end

    return result, nil
end

local function openUrl(url)
    if setclipboard then
        pcall(setclipboard, url)
    end
    if syn and syn.open_url then
        pcall(syn.open_url, url)
    elseif open_url then
        pcall(open_url, url)
    end
end

local gui = Instance.new("ScreenGui")
gui.Name = "ONAX_KeySystem"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
    gui.Parent = Player:WaitForChild("PlayerGui")
end

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(350, 285)
main.Position = UDim2.new(0.5, -175, 0.5, -142)
main.BackgroundColor3 = Color3.fromRGB(13, 10, 18)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(130, 55, 220)
stroke.Thickness = 1.5
stroke.Transparency = 0.15
stroke.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 48)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.fromOffset(18, 0)
title.BackgroundTransparency = 1
title.Text = "ONAX • BLOXFRUIT"
title.TextColor3 = Color3.fromRGB(205, 150, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(36, 36)
close.Position = UDim2.new(1, -45, 0, 6)
close.BackgroundTransparency = 1
close.Text = "×"
close.TextColor3 = Color3.fromRGB(210, 180, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 27
close.Parent = top

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -36, 0, 48)
keyBox.Position = UDim2.fromOffset(18, 58)
keyBox.BackgroundColor3 = Color3.fromRGB(24, 19, 31)
keyBox.BorderSizePixel = 0
keyBox.PlaceholderText = "Nhập key ONAX..."
keyBox.PlaceholderColor3 = Color3.fromRGB(130, 120, 145)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(245, 240, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.ClearTextOnFocus = false
keyBox.Parent = main

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 10)
boxCorner.Parent = keyBox

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(95, 45, 150)
boxStroke.Thickness = 1
boxStroke.Parent = keyBox

local getButton = Instance.new("TextButton")
getButton.Size = UDim2.new(0.5, -22, 0, 44)
getButton.Position = UDim2.fromOffset(18, 116)
getButton.BackgroundColor3 = Color3.fromRGB(105, 45, 170)
getButton.BorderSizePixel = 0
getButton.Text = "GET KEY"
getButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getButton.Font = Enum.Font.GothamBold
getButton.TextSize = 14
getButton.Parent = main

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 10)
getCorner.Parent = getButton

local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(0.5, -22, 0, 44)
checkButton.Position = UDim2.new(0.5, 4, 0, 116)
checkButton.BackgroundColor3 = Color3.fromRGB(70, 35, 115)
checkButton.BorderSizePixel = 0
checkButton.Text = "CHECK KEY"
checkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 14
checkButton.Parent = main

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 10)
checkCorner.Parent = checkButton

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -36, 0, 48)
status.Position = UDim2.fromOffset(18, 172)
status.BackgroundTransparency = 1
status.Text = "Nhập key rồi bấm CHECK KEY"
status.TextColor3 = Color3.fromRGB(175, 165, 190)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextWrapped = true
status.Parent = main

local support = Instance.new("TextLabel")
support.Size = UDim2.new(1, -36, 0, 25)
support.Position = UDim2.fromOffset(18, 228)
support.BackgroundTransparency = 1
support.Text = "SUPPORT: t.me/onaxscript"
support.TextColor3 = Color3.fromRGB(170, 105, 235)
support.Font = Enum.Font.GothamSemibold
support.TextSize = 12
support.Parent = main

getButton.MouseButton1Click:Connect(function()
    status.Text = "Đã sao chép link Get Key. Mở link để lấy key."
    status.TextColor3 = Color3.fromRGB(205, 150, 255)
    openUrl(GET_KEY_URL)
end)

local function verifyKey(key)
    key = tostring(key or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if key == "" then
        return false, "Vui lòng nhập key."
    end

    local url = VERIFY_URL .. "?key=" .. HttpService:UrlEncode(key)
    local result, err = request(url)

    if not result then
        return false, err or "Unable to connect"
    end

    local body = result.Body or result.body or ""
    local okJson, data = pcall(function()
        return HttpService:JSONDecode(body)
    end)

    if okJson and type(data) == "table" then
        local valid = data.valid
        if valid == true or data.success == true or data.status == "valid" then
            return true, data.message or "Key hợp lệ."
        end
        return false, data.message or data.error or "Key không hợp lệ hoặc đã hết hạn."
    end

    local lower = tostring(body):lower()
    if lower:find('"valid"%s*:%s*true') or lower:find('"success"%s*:%s*true') then
        return true, "Key hợp lệ."
    end

    return false, "Key không hợp lệ hoặc API ONAX chưa trả về định dạng xác thực."
end

checkButton.MouseButton1Click:Connect(function()
    checkButton.Text = "CHECKING..."
    status.Text = "Đang kiểm tra key với ONAX..."
    status.TextColor3 = Color3.fromRGB(205, 150, 255)

    local valid, message = verifyKey(keyBox.Text)

    if valid then
        status.Text = message .. "\nĐang tải GalaxyHub..."
        status.TextColor3 = Color3.fromRGB(170, 255, 190)
        task.wait(0.7)

        local ok, err = pcall(function()
            loadstring(game:HttpGet(SUCCESS_SCRIPT_URL))()
        end)

        if not ok then
            status.Text = "Key đúng nhưng không tải được script:\n" .. tostring(err)
            status.TextColor3 = Color3.fromRGB(255, 160, 170)
        else
            gui:Destroy()
        end
    else
        status.Text = message
        status.TextColor3 = Color3.fromRGB(255, 125, 150)
    end

    checkButton.Text = "CHECK KEY"
end)
