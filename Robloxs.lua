repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local Request = (syn and syn.request) or request or (http and http.request) or http_request
local username = game.Players.LocalPlayer.Name
local HandleBlacklist = { [772] = true }
local IsGetKick = false

game.StarterGui:SetCore("SendNotification", {
    Title = 'API SERVICES',
    Text = 'User : ' .. username,
    Duration = 25,
    Icon = 'rbxassetid://18976336309'
})

local function checkForError()
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
            if not HandleBlacklist[game:GetService("GuiService"):GetErrorCode().Value] then
                IsGetKick = true
            end
        end
    end)
    return IsGetKick
end

local function updateStatus()
    local url = "http://103.216.158.53:1471/"
    local username = game.Players.LocalPlayer.Name
    local data = "username=" .. username

    local requestData = {
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/x-www-form-urlencoded"
        },
        Body = data
    }

    local success, response = pcall(function()
        return Request(requestData)
    end)

    if success and response.StatusCode == 200 then
        print("Status Updated API : " .. username)
    else
        warn("Failed Update API " .. (response and response.StatusCode or "Request failed"))
    end
end

local Round = 0
loadstring(game:HttpGet("https://raw.githubusercontent.com/NopNopA/Loader/refs/heads/main/Fix"))()
while true do
    globalFunc = checkForError()
    print("Disconnected : ", globalFunc)
    print("API runs at : ", Round)
    if not globalFunc then
        updateStatus()
    end
    Round = Round + 1
    print("----------------------------------------")
    wait(15)
end
