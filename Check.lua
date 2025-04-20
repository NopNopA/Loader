local Request = (syn and syn.request) or request or (http and http.request) or http_request
local username = game.Players.LocalPlayer.Name
local url = "http://103.216.158.53:12345/online"

while true do
    Request({
        Url = url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            username = username
        })
    })
    wait(50)
end
