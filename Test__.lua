local WebhookURL = "https://discord.com/api/webhooks/1429331168125386832/oGuy-2rm7Nl9SnVNEecMBB1jHZDyHmkRhH0fBCQS5WEWjDIEEfLnW0_TIj1jHtS4sB1I"
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local placeId = game.PlaceId
local mapName = "Unknown"

local success, info = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)

if success then
    mapName = info.Name
end

local embed = {
    ["title"] = "📍 Roblox Map Info",
    ["color"] = 65280, 
    ["fields"] = {
        {
            ["name"] = "🗺 Map Name",
            ["value"] = mapName,
            ["inline"] = false
        },
        {
            ["name"] = "🆔 Place ID",
            ["value"] = tostring(placeId),
            ["inline"] = true
        }
    },
    ["footer"] = {
        ["text"] = "Map Info Logger"
    },
    ["timestamp"] = DateTime.now():ToIsoDate()
}

local data = {
    ["username"] = "Map Logger",
    ["embeds"] = {embed}
}

local jsonData = HttpService:JSONEncode(data)
local function SendWebhook(url, body)
    local requestFunc = (syn and syn.request) or (http and http.request) or request or http_request
    if requestFunc then
        requestFunc({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
        })
    else
        warn("><")
    end
end

SendWebhook(WebhookURL, jsonData)
