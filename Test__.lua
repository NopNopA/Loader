local WebhookURL = "https://discord.com/api/webhooks/1217657919462707343/xho5HWzagEt201ggZS-Z_aPdCROTyL-vkxKY664-MhtPR4N_MsVa_V2Sb0jvyReLHd7H"
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
