repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local Request = (syn and syn.request) or request or (http and http.request) or http_request
local username = game.Players.LocalPlayer.Name
local globalFunc = false

game.StarterGui:SetCore("SendNotification", {
    Title = 'API SERVICES',
    Text = 'User : ' .. username,
    Duration = 25,
    Icon = 'rbxassetid://18976336309'
})

local function checkForError()
    game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v)
        if v.Name == "ErrorPrompt" then
            pcall(function()
                repeat wait(0.5) until game.CoreGui.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame:FindFirstChild("ErrorMessage")
                
                local errorMessage = game.CoreGui.RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text
                local errorCode = tonumber(errorMessage:split("\n")[2]:match("%d+"))

                if errorCode ~= 772 and errorCode ~= 773 then
                    globalFunc = true
                end
            end)
        end
    end)
    return globalFunc
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
