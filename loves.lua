local function ForceHop()
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    local maxAttempts = 10
    local attemptDelay = 0.5

    print("🚀 Starting ForceHop...")

    for attempt = 1, maxAttempts do
        print(`Attempt {attempt}/{maxAttempts}`)

        -- Fetch server list with better error handling
        local servers = {}
        local success, response = pcall(function()
            return game:HttpGet(
                `https://games.roblox.com/v1/games/{placeId}/servers/Public?sortOrder=Asc&limit=100`,
                true  -- Bypass executor restrictions if possible
            )
        end)

        if not success then
            warn("new❌ HTTP Request Failed:", response)
            task.wait(attemptDelay)
            continue
        end

        -- Safely parse JSON
        local decoded
        success, decoded = pcall(function()
            return game:GetService("HttpService"):JSONDecode(response)
        end)

        if not success or not decoded.data then
            warn("⚠️ Invalid JSON or API response changed:", decoded)
            print("Raw Response:", response:sub(1, 100) .. "...") -- Debug first 100 chars
            task.wait(attemptDelay)
            continue
        end

        -- Find ANY server that isn't current
        for _, server in ipairs(decoded.data) do
            if server.id and server.id ~= currentJobId then
                print(`🎯 Found server: {server.id}`)

                -- Force teleport (no player count checks)
                local ts = game:GetService("TeleportService")
                pcall(function()
                    ts:TeleportToPlaceInstance(placeId, server.id)
                end)

                -- Fallback to normal teleport if instance fails
                task.wait(0.5)
                pcall(function()
                    ts:Teleport(placeId)
                end)

                return true
            end
        end

        warn("No different servers found, retrying...")
        task.wait(attemptDelay)
    end

    warn("new❌ Failed after max attempts")
    return false
end
print("Execute")
ForceHop()
