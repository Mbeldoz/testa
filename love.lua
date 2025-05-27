local function ForceHop()
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    local attempts = 0
    local maxAttempts = 10
    
    print("🔥 Starting force hop - Finding ANY other server...")
    
    while attempts < maxAttempts do
        attempts += 1
        print(`Attempt {attempts}`)
        
        -- Bypass-style HTTP request (works in most executors)
        local servers = {}
        local success, err = pcall(function()
            servers = game:GetService("HttpService"):JSONDecode(
                game:HttpGet(`https://games.roblox.com/v1/games/{placeId}/servers/Public?sortOrder=Asc&limit=100`, true)
            )
        end)
        
        if not success then
            warn("⚠️ API Error:", err)
            task.wait(0.5)
            continue
        end
        
        -- Find ANY server that isn't current
        for _, server in ipairs(servers.data) do
            if server.id ~= currentJobId then
                print(`🚀 Found server: {server.id} ({server.playing or "?"} players)`)
                
                -- Force teleport (no safety checks)
                local t = game:GetService("TeleportService")
                pcall(function()
                    t:TeleportToPlaceInstance(placeId, server.id)
                end)
                
                -- Emergency teleport if normal fails
                task.wait(1)
                pcall(function()
                    t:Teleport(placeId)
                end)
                
                return true
            end
        end
        
        warn("No different servers found, retrying...")
        task.wait(1)
    end
    
    warn("❌ Failed after", maxAttempts, "attempts")
    return false
end

-- Execute immediately
ForceHop()
