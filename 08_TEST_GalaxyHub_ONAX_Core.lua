-- GalaxyHub standalone UI test #8
-- Mục đích: file này LUÔN hiện UI test trước, sau đó chạy code gốc và báo OK/ERROR.

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "GalaxyHub_Test_8"
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
title.Text = "GalaxyHub • TEST #8"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 55)
status.Position = UDim2.fromOffset(10, 48)
status.BackgroundTransparency = 1
status.Text = "UI OK\nĐang test: GalaxyHub_ONAX_Core"
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
    FILE 1: ONAX Key System Core
    POST /api/check_key | key + HWID | verify | lock/unlock | error handling
]]

local HttpService = game:GetService("HttpService")

local request = (syn and syn.request)
    or (http_request or request)
    or (fluxus and fluxus.request)
    or nil

local identifyexecutor = identifyexecutor or function() return "Unknown" end

local ONAX = {}
ONAX.__index = ONAX

ONAX.KEY_API = "https://onax.onrender.com/api/check_key"
ONAX.Verified = false
ONAX.CurrentKey = ""

-- ============================================================
-- HWID
-- ============================================================
function ONAX.getHWID()
    local success, result = pcall(function()
        if identifyexecutor then
            return identifyexecutor()
        end
        if syn and syn.crypt then
            return syn.crypt.custom("HWID")
        end
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end)
    if success and result then
        return tostring(result)
    end
    return "UNKNOWN_HWID"
end

-- ============================================================
-- VERIFY KEY
-- ============================================================
function ONAX.verifyKey(key)
    if not key or key == "" then
        return false, "Vui lòng nhập key"
    end
    if not request then
        return false, "Executor không hỗ trợ HTTP request"
    end

    local success, response = pcall(function()
        return request({
            Url = ONAX.KEY_API,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                key = key,
                hwid = ONAX.getHWID()
            })
        })
    end)

    if not success then
        return false, "Không thể kết nối server key (503/offline)"
    end
    if not response then
        return false, "Không có phản hồi từ server"
    end

    local body = response.Body
    if type(body) == "string" then
        local ok, decoded = pcall(HttpService.JSONDecode, HttpService, body)
        if ok then
            body = decoded
        end
    end

    if type(body) == "table" then
        if body.valid == true
            or body.success == true
            or body.status == "valid"
            or body.authorized == true
            or body.valid_key == true then
            ONAX.Verified = true
            ONAX.CurrentKey = key
            return true, "Key hợp lệ"
        end
    end

    ONAX.Verified = false
    return false, "Key không hợp lệ"
end

-- ============================================================
-- LOCK / UNLOCK
-- ============================================================
function ONAX.lock()
    ONAX.Verified = false
    ONAX.CurrentKey = ""
end

function ONAX.unlock(key)
    local ok, msg = ONAX.verifyKey(key)
    return ok, msg
end

function ONAX.isVerified()
    return ONAX.Verified
end

return ONAX
]=]==]
local ok, err = pcall(function()
    local fn, loadErr = loadstring(source)
    if not fn then error(loadErr) end
    return fn()
end)

if ok then
    status.Text = "UI OK\nCODE OK • GalaxyHub_ONAX_Core"
    status.TextColor3 = Color3.fromRGB(120, 255, 160)
else
    status.Text = "UI OK\nCODE ERROR\n" .. tostring(err):sub(1, 120)
    status.TextColor3 = Color3.fromRGB(255, 120, 120)
    warn("[GalaxyHub TEST #8] GalaxyHub_ONAX_Core:", err)
end
