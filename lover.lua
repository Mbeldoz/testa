local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function findBestServer(gameId)
    -- Use Roblox's API to find servers with open slots
    local success, serverList = pcall(function()
        return TeleportService:GetGameInstancesAsync(gameId)
    end)

    if success and serverList and #serverList > 0 then
        -- Filter servers with open slots
        local availableServers = {}
        for _, server in ipairs(serverList) do
            if server.playing < server.maxPlayers then
                table.insert(availableServers, server)
            end
        end

        -- Pick a random server
        if #availableServers > 0 then
            local randomServer = availableServers[math.random(1, #availableServers)]
            return randomServer.jobId
        end
    end
    return nil
end

local function hopServer()
    local gameId = game.PlaceId
    local bestServer = findBestServer(gameId)

    if bestServer then
        TeleportService:TeleportToPlaceInstance(gameId, bestServer, Players.LocalPlayer)
    else
        warn("No available servers found!")
    end
end

hopServer()
