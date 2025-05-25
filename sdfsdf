if _G.NoLag then return end
_G.NoLag = true
_G.highUNC = false

local version = "5.7"
local name_game = "Grow A Garden"
local Fluent = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/UI_ROBLOX/refs/heads/main/UI_FLUENT.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoLag-id/UI_ROBLOX/refs/heads/main/Temp_save.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playername = player.Name
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local JumpConnection = nil
local noclipEnabled = false
local noclipConnection = nil
local bodyGyro = Instance.new("BodyGyro")
local bodyVelocity = Instance.new("BodyVelocity")
bodyGyro.Parent = nil
bodyVelocity.Parent = nil
local GameEvents = ReplicatedStorage.GameEvents

local function checkExecutor()
    local trustedExecutors = {
        "awp", "velocity", "swift", "wave", "zenith", "delta", "arceus", "codex", "vegax", "krnl", "volcano", "ronix"
    }

    local success, exec = pcall(function()
        return identifyexecutor():lower()
    end)

    if success and exec then
        for _, trustedName in ipairs(trustedExecutors) do
            if exec:find(trustedName, 1, true) then
                _G.highUNC = true
                return true, exec
            end
        end
    end

    return false, exec or "unknown"
end
task.wait(1)
local isValid, execName = checkExecutor()
print(isValid and "✅ - Good Executor: "..execName
               or "❌ - Unknown/Invalid Executor: "..execName.."(⚠️ Some feature may not working !)")
task.wait(2)

local BaseVar = {
    FLYING = false,
    InfJumpVar = false,
    BadExe = false,
    AntiAfk = true,
    NoClip = false,
    JobId = "",
    FLY_SPEED = 50,
    WalkSpeed = 16,
}

-- [Base Function]
local BaseModule = {} do
    function BaseModule:WaitForCharacter()
        if not player.Character then
            player.CharacterAdded:Wait()
        end
        return player.Character
    end

    function BaseModule:ToggleInfiniteJump()
        if JumpConnection then
            JumpConnection:Disconnect()
            JumpConnection = nil
        end

        if BaseVar.InfJumpVar then
            JumpConnection = UserInputService.JumpRequest:Connect(function()
                if player.Character then
                    local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid and Humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        end

    end

    function BaseModule:enableNoclip()
        if noclipConnection then return end

        noclipEnabled = false
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character and not noclipEnabled then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    function BaseModule:disableNoclip()
        noclipEnabled = true
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end

    function BaseModule:startFlying()
        bodyGyro.Parent = rootPart
        bodyVelocity.Parent = rootPart

        bodyGyro.P = 10000
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end

    function BaseModule:stopFlying()
        bodyGyro.Parent = nil
        bodyVelocity.Parent = nil
        controlValues = {Forward = 0, Backward = 0, Left = 0, Right = 0, Up = 0, Down = 0}
    end


    function BaseModule:hopServer()
        local placeId = game.PlaceId
        local servers = {}
        local success, err = pcall(function()
            servers = game:GetService("HttpService"):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100")
            )
        end)

        if not success or not servers.data then
            warn("Failed to get servers: "..tostring(err))
            return false
        end

        local viableServers = {}
        local currentJobId = game.JobId

        for _, server in ipairs(servers.data) do
            if server.playing and server.playing > 0
               and server.playing < server.maxPlayers
               and server.id ~= currentJobId then
                table.insert(viableServers, server)
            end
        end

        if #viableServers == 0 then return false end

        local targetServer = viableServers[math.random(1, #viableServers)]

        game:GetService("TeleportService"):TeleportToPlaceInstance(
            placeId,
            targetServer.id,
            game.Players.LocalPlayer
        )

        return true
    end



end

-- [Game Variable]
local Config = {
    AutoBuyEvent = false,
    AutoCollect = false,
    AutoSell = false,
    TeleportToTree = false,
    AutoBuy = false,
    AutoPickUp = false,
    AutoBuyEaster = false,
    AutoBuyAll = false,
    StartCollect = false,
    AutoSeedAll = false,
    SpamFarm = false,
    FarmPattern = false,
    PlotPattern = 1,
    SeedGiver = false,
    Unrelease = false,
    AutoBuyGear = false,
    AutoWater = false,
    AutoRemoveTree = false,
    AutoMoveTree = false,
    AutoSeed = false,
    FastSell = false,
    HideGarden = false,
    Busy_TP = false,
    Busy_1 = false,
    Busy_2 = false,
    Busy_Webhook = false,
    SubmitSeed = false,
    AutoSellBP = false,
    PremAuto = false,
    OpPack = false,
    doneWebhook = false,
    AutoFav = false,
    AutoHatch = false,
    AutoBuyEgg = false,
    AutoFeed = false,
    CollectFull = false,
    CollectMode = "Normal",
    FilterBool = false,
    AutoPlaceEgg = false,
    AutoBuyAllEgg = false,
    CollectMoonlit = false,
    Tooclose = true,
    childnotif,
    AutoEsp = false,
    EspList = {fruit = {}, mutation = {}},
    EggPlace = {},
    PetEgg = {},
    WorldPet = {},
    WhitelistSeed = {},
    WhitelistEvent = {},
    WhitelistGear = {},
    SelectedSeed = {},
    Fav = {"Normal"},
    Fav2 = {},
    Fav3 = {},
    PetFeedTable = {},
    PetFood = {},
    SavePos = {},
    Blacklist = {mutation = {}, variant = {}, fruit = {}},
    EquipSeed = "Carrot",
    RemoveTreeTarget = "",
    MoveTreeTarget = "",
    AutoSellDelay = 30,
    PlantSpeed = 0.5,
    WaterDis = 0.1,
    Equiped = 0,
    RemoveSpeed = 0.5,
    WaterSpeed = 0.5,
    TpCollectSpeed = 0.5,
    TaskMulti = 5,
    FeedSpeed = 600,
    CollectSpecific = false,
    SubmitMoonlit = false,
    CollectTreeList = {},
    FilterMode = "",
    SavePos2 = {},
    Sprinkler  ={},
    AutoBuyEaster2 = false,
}
local Table = {
    PetList = {},
    BuySeedList = {},
    BuyGearList = {},
    CollectTreeList = {},
    RemoveTreeList = {},
    LoadStock = {
        seed = {},
        gear = {},
        event = {},
    },
    SavePos = {},
    Venus_Quest = {},
    SeedData = {"All Selection", "Apple", "Avocado", "Bamboo", "Banana", "Beanstalk","Blueberry", "Blood Banana","Cacao", "Cactus", "Candy Blossom", "Candy Sunflower", "Carrot", "Cherry Blossom", "Chocolate Carrot", "Coconut", "Corn", "Cranberry", "Crimson Vine", "Cursed Fruit", "Daffodil", "Dragon Fruit", "Durian", "Easter Egg", "Eggplant", "Glowshroom", "Grape", "Lemon", "Lotus", "Mango", "Mint", "Moon Blossom", "Moonglow", "Moonflower", "Moon Melon", "Mushroom", "Nightshade", "Orange Tulip", "Papaya", "Passionfruit", "Peach", "Pear", "Pepper", "Pineapple", "Pumpkin", "Raspberry", "Red Lollipop", "Soul Fruit", "Starfruit", "Strawberry", "Succulent", "Tomato", "Venus Fly Trap", "Watermelon"},
    Egglist = {"Common Egg", "Uncommon Egg", "Rare Egg", "Epic Egg", "Legendary Egg", "Mythical Egg", "Divine Egg", "Bug Egg", "Exotic Bug Egg", "Night Egg"},
    RareStock = {"Master Sprinkler", "Lightning Rod", "Godly Sprinkler", "Grape", "Mushroom", "Pepper", "Legendary Egg", "Bug Egg"},
    WeatherData = { "RainEvent", "Thunderstorm", "FrostEvent", "SheckleRain", "NightEvent" },
    Mutation = {"Any" ,"Wet", "Shocked", "Choc", "Frozen", "Chilled", "Moonlit", "Bloodlit", "Celestial", "Disco", "Zombified", "Plasma"}
}

-- [Game Function]
local DataLoader = {} do
    function DataLoader:loadPetList()
        for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
            if pet.Name == "PetMover" and pet:GetAttribute("OWNER") == playername then
                for _, petObj in ipairs(pet:GetChildren()) do
                    if petObj:IsA("Model") then
                        table.insert(Table.PetList, tostring(petObj.Name))
                    end
                end
            end
        end
    end

    function DataLoader:loadTreeList()
        local found_trees = {}
        local tree_types = {}

        for _, farm in ipairs(workspace.Farm:GetChildren()) do
            if farm.Important.Data.Owner.Value == player.Name then
                for _, tree in ipairs(farm.Important.Plants_Physical:GetChildren()) do
                    if not table.find(tree_types, tree.Name) then
                        table.insert(tree_types, tree.Name)
                    end
                    found_trees[tree.Name] = (found_trees[tree.Name] or 0) + 1
                end
            end
        end

        for _, tree_name in ipairs(tree_types) do
            table.insert(Table.CollectTreeList, string.format("%s", tree_name))
            table.insert(Table.RemoveTreeList, string.format("%s (x%d)", tree_name, found_trees[tree_name] or 0))
        end
    end

    function DataLoader:Once()
        --Stock
        for _, item in pairs(player.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetChildren()) do
            if item:FindFirstChild("Main_Frame") then
                table.insert(Table.LoadStock.seed , item.Name)
            end
        end
        for _, item in pairs(player.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetChildren()) do
            if item:FindFirstChild("Main_Frame") then
                table.insert(Table.LoadStock.gear, item.Name)
            end
        end
        for _, item in pairs(player.PlayerGui.NightEventShop_UI.Frame.ScrollingFrame:GetChildren()) do
            if item:FindFirstChild("Main_Frame") then
                table.insert(Table.LoadStock.event, item.Name)
            end
        end

        --Quest
        for i, seed in ipairs(Quest_Data) do
            local displayText = string.format("%d. %s", i, seed.PLANT_NAME)
            local hasWeight = seed.WEIGHT ~= nil
            local hasMutation = seed.MUTATION ~= nil

            if hasWeight or hasMutation then
                displayText = displayText .. " ("
                if hasWeight then
                    displayText = displayText .. string.format("%.1fkg", seed.WEIGHT)
                    if hasMutation then
                        displayText = displayText .. ", "
                    end
                end
                if hasMutation then
                    displayText = displayText .. seed.MUTATION
                end
                displayText = displayText .. ")"
            end

            table.insert(Table.Venus_Quest, displayText)
        end

        DataLoader:loadPetList() -- Pet
        DataLoader:loadTreeList() -- Tree

    end
end

local hiddenData = {}
local treeVisibility = {
    hidden = false,
    storedParts = {}
}

local GameModule = {} do
    function GameModule:WeatherLogs()
        weather = "☁️ Normal"
        mention = "N/A"
        if workspace:GetAttribute("Thunderstorm") == true then
            weather = "Thunderstorm ⛈️"
            mention = "<@&1371595714974584912>"
        elseif workspace:GetAttribute("RainEvent") == true then
            weather = "Raining 🌧️"
            mention = "<@&1371595916850495629>"
        elseif workspace:GetAttribute("FrostEvent") == true then
            weather = "Frost 🌨️"
            mention = "<@&1371596071205077054>"
        elseif workspace:GetAttribute("NightEvent") == true then
            weather = "Night 🌑"
            mention = "<@&1371596004863901776>"
        end

        local requestFunction = http_request or request or HttpPost or syn.request
        local response = requestFunction({ Url = "https://nolag-weather-webhook.vercel.app/checkweather", Method = "POST" })

        if response.Success then
            local data = {
                embeds = {
                    {
                    fields = {
                        {
                            id = 827631865,
                            name = "Current Weather",
                            value = weather,
                            inline = false
                        }
                    }
                }
            },
            content = mention
        }


        local headers = { ["Content-Type"] = "application/json" }
        local jsonData = game:GetService("HttpService"):JSONEncode(data)
        requestFunction({ Url = "https://nolag-weather-webhook.vercel.app/getweather", Method = "POST", Headers = headers, Body = jsonData })
        task.wait(5)
        end
    end

    function GameModule:GetStockData(shopFrame)
        local stockData = {}

        for _, item in ipairs(shopFrame:GetChildren()) do
            if item:FindFirstChild("Main_Frame") then
                local stockText = item.Main_Frame.Stock_Text.Text
                local stockCount = stockText:match("X(%d+)")
                local itemName = item.Name

                if stockCount and tonumber(stockCount) > 0 then
                    stockData[itemName] = {
                        count = tonumber(stockCount),
                        price = tonumber(stockText:match("%d+")) or 0
                    }
                end
            end
        end

        return stockData
    end

    function GameModule:GetGarden()
        for _, garden in ipairs(workspace.Farm:GetChildren()) do
            if garden.Important.Data.Owner.Value == player.Name then
                return garden
            end
        end
    end

    function GameModule:hideTrees()
        for _, garden in pairs(workspace.Farm:GetChildren()) do
            for _, part in next, garden.Important.Plants_Physical:GetDescendants() do
                pcall(function()
                    if (part:IsA("BasePart") and not part:FindFirstChild("ProximityPrompt")) then
                        if not treeVisibility.storedParts[part] then
                            treeVisibility.storedParts[part] = {
                                parent = part.Parent,
                                transparency = part.Transparency,
                                canCollide = part.CanCollide,
                                anchored = part.Anchored
                            }
                        end
                    part.Parent = nil
                    end
                end)
            end

        end
        treeVisibility.hidden = true
    end

    function GameModule:showTrees()
        for part, data in pairs(treeVisibility.storedParts) do
            pcall(function()
                if part and data then
                    part.Parent = data.parent
                    part.Transparency = data.transparency
                    part.CanCollide = data.canCollide
                    part.Anchored = data.anchored
                end
            end)
        end
        treeVisibility.storedParts = {}
        treeVisibility.hidden = false
    end

    function GameModule:CheckBackpack()
        local count = 0
        for _, tool in ipairs(player.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                count = count + 1
            end
        end
        return count
    end

    function GameModule:SellInventory()
        local character = BaseModule:WaitForCharacter()
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            return false
        end

        local seller = workspace.NPCS:FindFirstChild("Steven")
        if not seller then return false end
        Config.Busy_TP = true
        local originalPosition = character.HumanoidRootPart.CFrame
        character.HumanoidRootPart.CFrame = seller.HumanoidRootPart.CFrame
        task.wait(0.5)

        local success = pcall(function()
            GameEvents.Sell_Inventory:FireServer()
        end)

        task.wait(0.5)
        character.HumanoidRootPart.CFrame = originalPosition
        Config.Busy_TP = false
        return success
    end

    function GameModule:GetCurrentSeed()
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            if tool:GetAttribute("Seed") then
                local Seed_Name = tool:GetAttribute("Seed")
                return Seed_Name
            end
        end
        return nil
    end

    function GameModule:EquipSeed(seedName)
        if not Config.AutoSeed or not seedName then return end

        local currentSeed = GameModule:GetCurrentSeed()
        if currentSeed == seedName then return true end

        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:GetAttribute("Seed") then
                if item:GetAttribute("Seed") == seedName then
                    character:FindFirstChildOfClass("Humanoid"):EquipTool(item)
                    return true
                end
            end
        end
        return false
    end

    function GameModule:SpamPlant()
        if GameModule:GetCurrentSeed() then
            local pos = character.HumanoidRootPart.Position
            GameEvents.Plant_RE:FireServer(Vector3.new(pos.X, 0.1355, pos.Z), GameModule:GetCurrentSeed())
        end
    end

    function GameModule:savePos(mytable)
        local pos = character.HumanoidRootPart.Position
        table.insert(mytable, {x = pos.X, z = pos.z})
    end

    function GameModule:getPos(mytable)
        local posStrings = {}
        for _, posData in ipairs(mytable) do
            local str = string.format("%.2f %.2f", posData.x, posData.z)
            table.insert(posStrings, str)
        end
        return posStrings
    end

    function GameModule:PosFarm()
        if not Config.PosFarm then return end

        local currentSeed = GameModule:GetCurrentSeed()
        if not currentSeed then
            warn("No seed selected for planting")
            return
        end

        if Config.SavePos then
            for _, posData in ipairs(Config.SavePos) do
                GameEvents.Plant_RE:FireServer(Vector3.new(posData[1], 0.1355, posData[2]), currentSeed)
                task.wait(0.1)
            end
        end


    end

    function GameModule:GetPlantLocation(plantNumber)
        local loopCount = 0
        for _, garden in pairs(workspace.Farm:GetChildren()) do
            if garden.Important.Data.Owner.Value == player.Name then
                for _, plantLocation in pairs(garden.Important.Plant_Locations:GetChildren()) do
                    if plantLocation:IsA("Part") and plantLocation.Name == "Can_Plant" then
                        loopCount = loopCount + 1
                        if loopCount == plantNumber then
                            return plantLocation
                        end
                    end
                end
            end
        end
    end

    function GameModule:fixLag()
        for _, sound in next, workspace:GetChildren() do
            if sound:IsA("Sound") and sound.Name == "Collect" then
                sound:Destroy()
            end
        end
    end

    function GameModule:ItemWhitelist(item)
        for _, mutation in pairs(Config.Fav3) do
            if item:GetAttribute(mutation) then
                return true
            end
        end
        return false
    end

    function GameModule:FruitFilter(fruit)
        if not table.find(Config.Blacklist.fruit, "All Selection") then
            if table.find(Config.Blacklist.fruit ,fruit.Name) then return true end
        end

        for _, mutation in pairs(Config.Blacklist.mutation) do
            if fruit:GetAttribute(mutation) then
                return true
            end
        end

        if fruit:FindFirstChild("Variant") then
            if table.find(Config.Blacklist.variant, fruit.Variant.Value) then
                return true
            end
        end
        return false
    end

    function GameModule:FruitMatch(fruit)
        if not table.find(Config.Blacklist.fruit, "All Selection") then
            if not table.find(Config.Blacklist.fruit ,fruit.Name) then return false end
        end

        if Config.Blacklist.mutation and Config.Blacklist.mutation ~= "Any" then
            for _, mutation in pairs(Config.Blacklist.mutation) do
                if not fruit:GetAttribute(mutation) then
                    return false
                end
            end
        end

        if Config.Blacklist.variant and Config.Blacklist.variant ~= "Any" then
            if fruit:FindFirstChild("Variant") then
                if not table.find(Config.Blacklist.variant, fruit.Variant.Value) then
                    return false
                end
            end
        end
        return true
    end

    function GameModule:CollectFull(mode)
        if Config.Busy_Event then return end
        local garden = GameModule:GetGarden()
        local vim = game:GetService("VirtualInputManager")
        -- Normal/Fast Mode (Proximity Prompt Collection)
        for _, prompt in pairs(garden.Important.Plants_Physical:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("BasePart") then
                local Part = prompt.Parent
                local fruit = Part.Parent
                if Config.FilterBool then
                    list = GameModule:FruitFilter(fruit)
                end

                local function collect(obj)
                    ReplicatedStorage.ByteNetReliable:FireServer(buffer.fromstring("\001\001\000\001"), { obj })
                    if mode == "Normal" then
                        task.wait()
                    end
                end

                if not fruit:GetAttribute("Favorited")and not Config.Busy_Event then
                    if Config.FilterBool and Config.FilterMode == "Blacklist" and not list then
                        collect(fruit)
                    elseif Config.FilterBool and Config.FilterMode == "Whitelist" and list then
                        collect(fruit)
                    elseif not Config.FilterBool then
                        collect(fruit)
                    end
                end
            end
        end

        GameModule:fixLag() -- Optional: Reduce lag after collection
    end

    function GameModule:CollectSpecificFruit(garden)
        if not Config.CollectSpecific then return end

        for _, tree_list in next, garden.Important.Plants_Physical:GetChildren() do
            if table.find(Config.CollectTreeList, tree_list.Name) then
                for _, prompt in next, tree_list:GetDescendants() do
                    if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("Part") then
                        local plantPosition = prompt.Parent.Position
                        local playerPosition = character.HumanoidRootPart.Position
                        local distance = (playerPosition - plantPosition).Magnitude

                        if distance < prompt.MaxActivationDistance then
                            fireproximityprompt(prompt)
                            task.wait()
                        end
                    end
                end
            end
        end
        GameModule:fixLag()
    end

    function GameModule:SearchTool(input)
        for _, v in pairs(character:GetChildren()) do
            if v:isA("Tool") and v.Name:find(input) then
                return v
            end
        end
        return false
    end

    function GameModule:MoveTree(parent)
        local originalPosition = character.HumanoidRootPart.CFrame
        for _, child in ipairs(parent.Important.Plants_Physical:GetChildren()) do
            if child.Name:find(Config.MoveTreeTarget:gsub("%s*%(x%d+%)", "")) then
                local Trowel = GameModule:SearchTool("Trowel")
                BaseModule:enableNoclip()
                task.wait()
                character.HumanoidRootPart.CFrame = CFrame.new(child:FindFirstChild("1").CFrame.Position + Vector3.new(0, 3, 0))

                if not Trowel then
                    for _, item in ipairs(player.Backpack:GetChildren()) do
                        if item:GetAttribute("ITEM_TYPE") == "Trowel" then
                            character:FindFirstChildOfClass("Humanoid"):EquipTool(item)
                            task.wait(1)
                            Trowel = GameModule:SearchTool("Trowel")
                        end
                    end
                end

                game:GetService("ReplicatedStorage").GameEvents.TrowelRemote:InvokeServer("Pickup", Trowel, child)
                task.wait()
                game:GetService("ReplicatedStorage").GameEvents.TrowelRemote:InvokeServer("Place", Trowel, child, originalPosition)
            end
        end
        BaseModule:disableNoclip()
        task.wait(0.5)
        character.HumanoidRootPart.CFrame = GameModule:GetGarden().Spawn_Point.CFrame
    end

    function GameModule:RemoveTree(parent)
        for _, child in ipairs(parent.Important.Plants_Physical:GetChildren()) do
            if child.Name:find(Config.RemoveTreeTarget:gsub("%s*%(x%d+%)", "")) then
                for _, fruit_part in pairs(child:GetChildren()) do
                    if fruit_part:IsA("Part") then
                        if not character:FindFirstChild("Shovel [Destroy Plants]") then
                            local shovel = player.Backpack:FindFirstChild("Shovel [Destroy Plants]")
                            shovel.Parent = character
                            task.wait()
                        end

                        character.HumanoidRootPart.CFrame = CFrame.new(fruit_part.CFrame.Position)
                        task.wait(0.1)
                        GameEvents.Remove_Item:FireServer(fruit_part)
                        return
                    end
                end
            end
        end
        task.wait(0.5)
    end

    function GameModule:TeleportToTree(garden)
        if not Config.TeleportToTree or Config.Busy_Event then return end
        local plants = garden.Important.Plants_Physical
        for _, prompt in ipairs(plants:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Parent:IsA("Part") and prompt.Enabled then
                local Part = prompt.Parent
                local fruit = Part.Parent
                if Config.FilterBool then
                    list = GameModule:FruitFilter(fruit)
                end

                if not fruit:GetAttribute("Favorited") and not Config.Busy_event then
                    if Config.FilterBool and Config.FilterMode == "Blacklist" and not list then
                        character.HumanoidRootPart.CFrame = CFrame.new(prompt.Parent.Position)
                        break
                    elseif Config.FilterBool and Config.FilterMode == "Whitelist" and list then
                        character.HumanoidRootPart.CFrame = CFrame.new(prompt.Parent.Position)
                        break
                    elseif not Config.FilterBool then
                        character.HumanoidRootPart.CFrame = CFrame.new(prompt.Parent.Position)
                        break
                    end
                end
            end
        end
    end

    function GameModule:CreateFruitEsp(fruit, options)
        options = options or {}

        -- Skip if already has ESP
        if fruit:FindFirstChild("FruitESP_Highlight") then return end

        -- Create highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "FruitESP_Highlight"
        highlight.FillColor = options.Color or Color3.fromRGB(255, 215, 0) -- Gold
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.Parent = fruit

        -- Create name label
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "FruitESP_Label"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)

        local textLabel = Instance.new("TextLabel")
        textLabel.Text = fruit.Name
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 18
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboard

        billboard.Parent = fruit
    end

    function GameModule:FruitEsp(enable)
        local garden = GameModule:GetGarden()

        if not enable then
            for _, obj in pairs(garden.Important.Plants_Physical:GetDescendants()) do
                if obj.Name == "FruitESP_Highlight" or obj.Name == "FruitESP_Label" then
                    obj:Destroy()
                end
            end
            return
        end

        for _, prompt in pairs(garden.Important.Plants_Physical:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Parent and prompt.Parent:IsA("BasePart") then
                local Part = prompt.Parent
                local fruit = Part.Parent
                if Config.EspList.fruit and Config.EspList.mutation then
                    if (table.find(Config.EspList.fruit, fruit.Name) or table.find(Config.EspList.fruit, "All Selection")) and not fruit:FindFirstChild("FruitESP_Highlight") then
                        for _, mutation in ipairs(Config.EspList.mutation) do
                            if fruit:GetAttribute(mutation) then
                                GameModule:CreateFruitEsp(fruit, {
                                    Color = Color3.fromRGB(255, 215, 0)
                                })
                            end
                        end
                    end
                end
            end
        end
    end

    function GameModule:Watering()
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local forwardDirection = rootPart.CFrame.LookVector
            local waterPosition = rootPart.Position + (forwardDirection * Config.WaterDis)

            waterPosition = Vector3.new(waterPosition.X, 0.135, waterPosition.Z)

            GameEvents.Water_RE:FireServer(waterPosition)
        end
    end

    function GameModule:DeletePlot()
        for _, garden in pairs(workspace.Farm:GetChildren()) do
            if garden.Important.Data.Owner.Value ~= player.Name then
               Farm:Destroy()
            end
        end
    end

    function GameModule:hideDescendants(parent)
        for _, child in ipairs(parent:GetDescendants()) do
            pcall(function()
                if not hiddenData[child] then
                    hiddenData[child] = {}
                end

                if child:IsA("BasePart") or child:IsA("MeshPart") then
                    hiddenData[child].Transparency = child.Transparency
                    hiddenData[child].CanCollide = child.CanCollide
                    child.Transparency = 1
                    child.CanCollide = false
                elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") or child:IsA("Fire") or child:IsA("Smoke") then
                    hiddenData[child].Enabled = child.Enabled
                    child.Enabled = false
                elseif child:IsA("Model") then
                    hiddenData[child].PrimaryPart = child.PrimaryPart
                    if child.PrimaryPart then
                        if not hiddenData[child.PrimaryPart] then
                            hiddenData[child.PrimaryPart] = {}
                        end
                        hiddenData[child.PrimaryPart].Transparency = child.PrimaryPart.Transparency
                        hiddenData[child.PrimaryPart].CanCollide = child.PrimaryPart.CanCollide
                        child.PrimaryPart.Transparency = 1
                        child.PrimaryPart.CanCollide = false
                    end
                elseif child:IsA("BillboardGui") or child:IsA("SurfaceGui") or child:IsA("Decal") then
                    hiddenData[child].Enabled = child.Enabled
                    child.Enabled = false
                end
            end)
        end
    end

    function GameModule:restoreAll()
        for child, data in pairs(hiddenData) do
            pcall(function()
                if child:IsA("BasePart") or child:IsA("MeshPart") then
                    if data.Transparency ~= nil then
                        child.Transparency = data.Transparency
                    end
                    if data.CanCollide ~= nil then
                        child.CanCollide = data.CanCollide
                    end
                elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") or child:IsA("Fire") or child:IsA("Smoke") then
                    if data.Enabled ~= nil then
                        child.Enabled = data.Enabled
                    end
                elseif child:IsA("Model") then
                    if data.PrimaryPart and hiddenData[data.PrimaryPart] then
                        local primaryData = hiddenData[data.PrimaryPart]
                        if primaryData.Transparency ~= nil then
                            data.PrimaryPart.Transparency = primaryData.Transparency
                        end
                        if primaryData.CanCollide ~= nil then
                            data.PrimaryPart.CanCollide = primaryData.CanCollide
                        end
                    end
                elseif child:IsA("BillboardGui") or child:IsA("SurfaceGui") or child:IsA("Decal") then
                    if data.Enabled ~= nil then
                        child.Enabled = data.Enabled
                    end
                end
            end)
        end
        hiddenData = {}
    end

--[[     function GameModule:sendStockToServer(ping)
    local requestFunction = http_request or request or HttpPost or syn.request
    local response = requestFunction({ Url = "https://nolag-stock-webhook.vercel.app/checkstock", Method = "POST" })

    if response.Success then
        local mention = "No Rare Stock !"
        local eggList = {}
        local gearList = {}
        local seedList = {}

        local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
        local any_GetData_result1 = DataService_upvr:GetData()
        local SeedData = any_GetData_result1.SeedStock.Stocks
        local GearData = any_GetData_result1.GearStock.Stocks

        if SeedData then
            for key, value in pairs(SeedData) do
                table.insert(seedList, string.format("[X%s] %s", value.MaxStock, key))
                if table.find(Table.RareStock ,tostring(key)) then
                    mention = "<@&1368286455977213964>"
                end
            end
        end

        if GearData then
            for key, value in pairs(GearData) do
                table.insert(gearList, string.format("[X%s] %s", value.MaxStock, key))
                if table.find(Table.RareStock ,tostring(key)) then
                    mention = "<@&1368286455977213964>"
                end
            end
        end

        for _, egg in next, workspace.NPCS["Pet Stand"].EggLocations:GetChildren() do
            if egg:isA("Model") and egg.Name:find("Egg") then
                table.insert(eggList, egg.Name)
                if table.find(Table.RareStock, egg.Name) then
                    if ping == "pet" then
                        mention = "<@&1368286510717337670>"
                    end
                end
            end
        end

        local data = {
            embeds = {
                {
                    fields = {
                        {
                            id = 827631865,
                            name = "🥚 Egg List",
                            value = table.concat(eggList, "\n"),
                            inline = false
                        },
                        {
                            id = 50047292,
                            name = "⚙️ Gear List",
                            value = table.concat(gearList, "\n"),
                            inline = false
                        },
                        {
                            id = 632746676,
                            name = "🌱 Seed List",
                            value = table.concat(seedList, "\n"),
                            inline = false
                        }
                    }
                }
            },
            content = mention, playername
        }


        local headers = { ["Content-Type"] = "application/json" }
        local jsonData = game:GetService("HttpService"):JSONEncode(data)
        requestFunction({ Url = "https://nolag-stock-webhook.vercel.app/getstock", Method = "POST", Headers = headers, Body = jsonData })
        task.wait(5)
        end
    end ]]

    function GameModule:PlaceGear()
        if Config.Sprinkler then
            for _, tool in ipairs(Config.Sprinker) do
                for _, item in ipairs(player.Backpack:GetChildren()) do
                    if item:GetAttribute("ItemName") == tool then
                        character:FindFirstChildOfClass("Humanoid"):EquipTool(item)
                        if Config.SavePos2 then
                            local position = CFrame.new(Config.SavePos2[1], 0.135525137, Config.SavePos2[2], 0.064701885, 0.857260585, -0.510801494, -0, 0.51187402, 0.859060585, 0.997904658, -0.05558284, 0.0331192128)
                            GameEvents.SprinklerService:FireServer("Create", position)
                            task.wait(0.2)
                        else
                            break
                        end
                    end
                end
            end
        end
    end
end

local GameLoop = {} do
    function GameLoop:CreateLoop(action, condition, interval)
        task.spawn(function()
            while condition() do
                pcall(action)
                --action()
                task.wait(interval())
            end
        end)
    end

    function GameLoop:SpamFarm()
        self:CreateLoop(
            function() GameModule:SpamPlant() end,
            function() return _G.NoLag and Config.SpamFarm end,
            function() return Config.PlantSpeed end
        )
    end

    function GameLoop:PosFarm()
        self:CreateLoop(
            function() GameModule:PosFarm() end,
            function() return _G.NoLag and Config.PosFarm end,
            function() return Config.PlantSpeed end
        )
    end

    function GameLoop:PatternFarm()
        if Config.FarmPattern then
            task.spawn(GameModule:StartSnakePlanting())
        end
    end

    function GameLoop:CollectFull()
        self:CreateLoop(
            function() GameModule:CollectFull(Config.CollectMode) end,
            function() return _G.NoLag and Config.CollectFull end,
            function() return 0.5 end
        )
    end

    function GameLoop:AutoCollectXeno()
        self:CreateLoop(
            function()
                for _, garden in ipairs(workspace.Farm:GetChildren()) do
                    if garden.Important.Data.Owner.Value == player.Name then
                        for _, child in ipairs(garden.Important.Plants_Physical:GetDescendants()) do
                            if child:IsA("ProximityPrompt") then
                                local vim = game:GetService("VirtualInputManager")
                                vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                                vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                task.wait(0.05)
                            end
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.BadExe end,
            function() return 0.5 end
        )
    end

    function GameLoop:TeleportToTree()
        self:CreateLoop(
            function()
                if not Config.Busy_TP then
                    GameModule:TeleportToTree(GameModule:GetGarden())
                end
            end,
            function() return _G.NoLag and Config.TeleportToTree end,
            function() return Config.TpCollectSpeed end
        )
    end

    function GameLoop:RemoveTree()
        self:CreateLoop(
            function()
                if not Config.Busy_TP then
                    GameModule:RemoveTree(GameModule:GetGarden())
                end
            end,
            function() return _G.NoLag and Config.AutoRemoveTree end,
            function() return Config.RemoveSpeed end
        )
    end

    function GameLoop:AutoBuyEgg()
        self:CreateLoop(
            function()
                local path = workspace.NPCS["Pet Stand"].EggLocations
                local num = 0
                for _, egg in ipairs(path:GetChildren()) do
                    local EGG = egg.Name:lower()
                    if EGG:find("egg") then
                        num = num + 1
                        if not table.find(Config.PetEgg, egg.Name) then
                            GameEvents.BuyPetEgg:FireServer(num)
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoBuyEgg end,
            function() return 30 end
        )
    end

    function GameLoop:AutoBuyAllEgg()
        self:CreateLoop(
            function()
                for i = 1, 3 do
                    GameEvents.BuyPetEgg:FireServer(i)
                end
            end,
            function() return _G.NoLag and Config.AutoBuyAllEgg end,
            function() return 30 end
        )
    end

    function GameLoop:AutoHatch()
        self:CreateLoop(
            function()
                local farmFolder = workspace:FindFirstChild("Farm")
                for _, descendant in ipairs(farmFolder:GetDescendants()) do
                    if descendant:IsA("Model") and descendant.Name == "PetEgg" then
                        if descendant:GetAttribute("OWNER") == playername and descendant:GetAttribute("READY") == true then
                            game:GetService("ReplicatedStorage").GameEvents.PetEggService:FireServer("HatchPet", descendant)
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoHatch end,
            function() return 30 end
        )
    end

    function GameLoop:AutoFeed()
        self:CreateLoop(
            function()
                for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
                    if pet.Name == "PetMover" and pet:GetAttribute("OWNER") == playername then
                        if Config.PetFeedTable and Config.PetFood then
                            for _, petOBJ in ipairs(Config.PetFeedTable) do
                                for _, tool in ipairs(player.Backpack:GetChildren()) do
                                    if tool:IsA("Tool") and tool:GetAttribute("ItemName") and not string.find(tool.Name, "Seed") and not tool:GetAttribute("Favorite") and table.find(Config.PetFood, tool:GetAttribute("ItemName")) then
                                        tool.Parent = character
                                        break
                                    end
                                end
                                if pet:FindFirstChild(petOBJ) then
                                    game:GetService("ReplicatedStorage").GameEvents.ActivePetService:FireServer("Feed", pet:GetAttribute("UUID"))
                                    task.wait(1)
                                end
                            end
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoFeed end,
            function() return Config.FeedSpeed end
        )
    end

    function GameLoop:AutoClaimPremium()
        self:CreateLoop(
            function()
                GameEvents.SeedPackGiverEvent:FireServer("ClaimPremiumPack")
            end,
            function() return _G.NoLag and Config.PremAuto end,
            function() return 10 end
        )
    end

    function GameLoop:SpamSubmit()
        if Config.SubmitSeed then
            for i = 0, Config.TaskMulti do
                task.spawn(function()
                    while _G.NoLag and Config.SubmitSeed and task.wait() do
                        GameEvents.SeedPackGiverEvent:FireServer("SubmitHeldPlant")
                    end
                end)
            end
        end
    end

    function GameLoop:AutoOpenSeedPack()
        self:CreateLoop(
            function()
                local RollUI = player.PlayerGui:FindFirstChild("RollCrate_UI")
                if RollUI then RollUI:Destroy() end

                for _, item in pairs(character:GetChildren()) do
                    if item.Name:find("Basic Seed Pack") then
                        item:Activate()
                        break
                    end
                end
            end,
            function() return _G.NoLag and Config.OpPack end,
            function() return 0.1 end
        )
    end

    function GameLoop:AutoSell()
        self:CreateLoop(
            function() GameModule:SellInventory() end,
            function() return _G.NoLag and Config.AutoSell end,
            function() return Config.AutoSellDelay end
        )
    end

    function GameLoop:AutoSellBP()
        self:CreateLoop(
            function()
                if GameModule:CheckBackpack() > 199 then
                    GameModule:SellInventory()
                end
            end,
            function() return _G.NoLag and Config.AutoSellBP end,
            function() return 1 end
        )
    end

    function GameLoop:AutoWater()
        self:CreateLoop(
            function() GameModule:Watering() end,
            function() return _G.NoLag and Config.AutoWater end,
            function() return Config.WaterSpeed end
        )
    end

    function GameLoop:AutoFavorite()
        self:CreateLoop(
            function()
                for _, v in ipairs(player.Backpack:GetChildren()) do
                    if v:IsA("Tool") and table.find(Config.Fav2, v:GetAttribute("ItemName")) and v:GetAttribute("ITEM_TYPE") == "Holdable" and not v:GetAttribute("Favorite") then
                        if Config.Fav then
                            if table.find(Config.Fav, v.Variant.Value) then
                                local whitelist = true
                                if Config.Fav3 and #Config.Fav3 ~= 0 then
                                    whitelist = GameModule:ItemWhitelist(v)
                                end

                                if whitelist then
                                    GameEvents.Favorite_Item:FireServer(v)
                                end
                            end
                        end
                        task.wait(0.05)
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoFav end,
            function() return 1 end
        )
    end

    function GameLoop:AutoEquipSeed()
        self:CreateLoop(
            function() GameModule:EquipSeed(Config.EquipSeed) end,
            function() return _G.NoLag and Config.AutoSeed end,
            function() return 0.5 end
        )
    end

    function GameLoop:AutoBuyStock()
        self:CreateLoop(
            function()
                local stockData = GameModule:GetStockData(player.PlayerGui.Seed_Shop.Frame.ScrollingFrame)
                local cash = player.leaderstats.Sheckles.Value

                for seedName, data in pairs(stockData) do
                    if table.find(Config.WhitelistSeed, seedName) and cash >= data.price then
                        GameEvents.BuySeedStock:FireServer(seedName)
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoBuy end,
            function() return 0.5 end
        )
    end

    function GameLoop:AutoPlaceEgg()
        self:CreateLoop(
            function()
                for _, item in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if string.find(item.Name, "Egg") and item:FindFirstChild("PetEggToolLocal") then
                        local new_name = item.Name:gsub("%s*x%d+$", "")
                        if table.find(Config.EggPlace, new_name) then
                            character:FindFirstChildOfClass("Humanoid"):EquipTool(item)
                            task.wait(1)
                            local garden = GameModule:GetGarden()
                            local place = garden.Important.Plant_Locations:FindFirstChild("Can_Plant")
                            local vector = Vector3.new(place.CFrame.Position.X , 0.1355254054069519, place.CFrame.Position.Z)
                            GameEvents.PetEggService:FireServer("CreateEgg", vector)
                            task.wait(2)
                            if Config.Tooclose then
                                Config.Tooclose = false
                                local basePos = place.CFrame.Position
                                local adjustments = {
                                    -- X-axis only
                                    {x = 6, z = 0},
                                    {x = -6, z = 0},

                                    -- Z-axis only
                                    {x = 0, z = 6},
                                    {x = 0, z = -6},

                                    -- Diagonal (X and Z)
                                    {x = 6, z = 6},
                                    {x = 6, z = -6},
                                    {x = -6, z = 6},
                                    {x = -6, z = -6},

                                    -- Final fallback (optional)
                                    {x = 0, z = 0}
                                }

                                for _, adj in ipairs(adjustments) do
                                    local vector = Vector3.new(
                                        basePos.X + adj.x,
                                        0.1355254054069519,
                                        basePos.Z + adj.z
                                    )
                                    GameEvents.PetEggService:FireServer("CreateEgg", vector)
                                    task.wait(2)
                                    local childNotifExists = false
                                    pcall(function()
                                        childNotifExists = Config.childnotif and Config.childnotif.Parent ~= nil
                                    end)

                                    if not childNotifExists then
                                        Config.Tooclose = false
                                        break
                                    end
                                end
                            end
                            character:FindFirstChildOfClass("Humanoid"):UnequipTools()
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoPlaceEgg end,
            function() return 10 end
        )
    end

    function GameLoop:SubmitMoonlit()
        self:CreateLoop(
            function()
                GameEvents.NightQuestRemoteEvent:FireServer("SubmitAllPlants")
            end,
            function() return _G.NoLag and Config.SubmitMoonlit end,
            function() return 30 end
        )
    end

    function GameLoop:AutoEsp()
        self:CreateLoop(
            function()
                GameModule:FruitEsp(true)
            end,
            function() return _G.NoLag and Config.AutoEsp end,
            function() return 5 end
        )
    end

    function GameLoop:AutoPickUp()
        self:CreateLoop(
            function()
                if workspace:GetAttribute("Thunderstorm") then
                    for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
                        if pet.Name == "PetMover" and pet:GetAttribute("OWNER") == playername then
                            game:GetService("ReplicatedStorage").GameEvents.PetsService:FireServer("UnequipPet", pet:GetAttribute("UUID"))
                            task.wait(0.1)
                        end
                    end
                end
            end,
            function() return _G.NoLag and Config.AutoPickUp end,
            function() return 5 end
        )
    end

end

-- [Connection]
local flyConnections = {}
local connections = {} do
    -- Anti-AFK
    connections.antiAfk = player.Idled:Connect(function()
        if BaseVar.AntiAfk then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)

    -- Character
    connections.characterAdded = player.CharacterAdded:Connect(function()
        if BaseVar.InfJumpVar then
            if JumpConnection then
                JumpConnection:Disconnect()
            end
            BaseModule:ToggleInfiniteJump()
        end
    end)

    --Heartbeat
    connections.heartbeat = RunService.Heartbeat:Connect(function()
        if Fluent.Unloaded then
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
            if JumpConnection then JumpConnection:Disconnect() end
            for key in pairs(controlValues) do
                controlValues[key] = 0
            end
            for _, connection in pairs(flyConnections) do
                connection:Disconnect()
            end
            print("No-Lag Hub | Exit")
            _G.NoLag = false
        end

        if not BaseVar.FLYING or bodyGyro.Parent == nil then return end

        local direction = (
            (workspace.CurrentCamera.CFrame.LookVector * (controlValues.Forward - controlValues.Backward)) +
            (workspace.CurrentCamera.CFrame.RightVector * (controlValues.Right - controlValues.Left)) +
            (Vector3.new(0, 1, 0) * (controlValues.Up - controlValues.Down)))

        if direction.Magnitude > 0 then
            direction = direction.Unit * BaseVar.FLY_SPEED
        end

        bodyVelocity.Velocity = direction
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end)

end

local function Loop_Shop()
    while _G.NoLag and task.wait(1) do
        if not character or not character.Parent then
            character = BaseModule:WaitForCharacter()
        end

        if Config.AutoBuy and #Config.WhitelistSeed > 0 then

            local stockData = GameModule:GetStockData(player.PlayerGui.Seed_Shop.Frame.ScrollingFrame)
            local cash = player.leaderstats.Sheckles.Value

            for _, seedName in ipairs(Config.WhitelistSeed) do
                local seedData = stockData[seedName]
                if seedData and seedData.count > 0 and cash >= seedData.price then
                    GameEvents.BuySeedStock:FireServer(seedName)
                    task.wait()
                end
            end
        end

        if Config.AutoBuyGear and #Config.WhitelistGear > 0 then
            local stockData = GameModule:GetStockData(player.PlayerGui.Gear_Shop.Frame.ScrollingFrame)
            local cash = player.leaderstats.Sheckles.Value
            for _, seedName in ipairs(Config.WhitelistGear) do
                local seedData = stockData[seedName]
                if seedData and seedData.count > 0 and cash >= seedData.price then
                    GameEvents.BuyGearStock:FireServer(seedName)
                    task.wait()
                end
            end
        end

        if Config.AutoBuyEvent and #Config.WhitelistEvent > 0 and workspace:GetAttribute("BloodMoonEvent") then
            local stockData = GameModule:GetStockData(player.PlayerGui.NightEventShop_UI.Frame.ScrollingFrame)
            local cash = player.leaderstats.Sheckles.Value
            for _, seedName in ipairs(Config.WhitelistEvent) do
                local seedData = stockData[seedName]
                if seedData and seedData.count > 0 and cash >= seedData.price then
                    GameEvents.BuyEventShopStock:FireServer(seedName)
                    task.wait()
                end
            end
        end
    end
end
local function Loop_Shop2()
    while _G.NoLag and task.wait(10) do
        if Config.AutoBuyAll then
            local stockData = GameModule:GetStockData(player.PlayerGui.Seed_Shop.Frame.ScrollingFrame)
            local cash = player.leaderstats.Sheckles.Value

            for seedName, data in pairs(stockData) do
                if cash >= data.price then
                    for i = 1, data.count do
                        if cash >= data.price then
                            GameEvents.BuySeedStock:FireServer(seedName)
                            cash = cash - data.price
                            task.wait()
                        else
                            break
                        end
                    end
                end
            end

            local stockData = GameModule:GetStockData(player.PlayerGui.Gear_Shop.Frame.ScrollingFrame)
            local cash = player.leaderstats.Sheckles.Value

            for seedName, data in pairs(stockData) do
                if cash >= data.price then
                    for i = 1, data.count do
                        if cash >= data.price then
                            GameEvents.BuyGearStock:FireServer(seedName)
                            cash = cash - data.price
                            task.wait()
                        else
                            break
                        end
                    end
                end
            end
        end

        if Config.Unrelease then
            local cash = player.leaderstats.Sheckles.Value
            if cash >= 850000 then
                GameEvents.BuySeedStock:FireServer("Banana")
            end
        end
    end
end
local function Loop_Farm()
    while _G.NoLag and task.wait(1) do
        pcall(function()
            if Config.AutoSeedAll then
                for _, tool in ipairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool:GetAttribute("Seed") then
                        tool.Parent = character
                    end
                end
            end

        end)
    end
end

pcall(function() return DataLoader:Once() end)
task.spawn(Loop_Shop)
task.spawn(Loop_Farm)
task.spawn(Loop_Shop2)
print("[No-Lag] Waiting......")
task.wait(2)
-- [Gui]
do
    local Window = Fluent:CreateWindow({
    Title = "No-Lag HUB",
    SubTitle = name_game.."  ".. "V"..version,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 360),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Automatic = Window:AddTab({ Title = "Farm", Icon = "apple" }),
    Pet = Window:AddTab({ Title = "Pet", Icon = "bone" }),
    Utility = Window:AddTab({ Title = "Utility", Icon = "boxes" }),
    Item = Window:AddTab({ Title = "Item", Icon = "hammer" }),
    UI = Window:AddTab({ Title = "Esp & UI", Icon = "component" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Experimential = Window:AddTab({ Title = "Experimential", Icon = "flask-conical" }),
    Performance = Window:AddTab({ Title = "Performance ", Icon = "cog" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options
local function SendNotification(message, duration)
    Fluent:Notify({
        Title = "NoLag HUB",
        Content = message,
        Duration = duration
    })
end

-- [Setup]
Window:Dialog({
    Title = "Join The Discord Server",
    Content = "Join Discord for Script Updates",
    Buttons = {
        {
            Title = "Copy Link",
            Callback = function()
                setclipboard("https://discord.gg/CHGNhdKNtP")
                SendNotification("Copied: https://discord.gg/CHGNhdKNtP", 1)
            end
        }

    }
})
    -- [Main Tab]
    do
        local Section = Tabs.Main:AddSection("Player")
        local SpeedHack = Tabs.Main:AddInput("SpeedHack", {
            Title = "WalkSpeed",
            Default = "16",
            Numeric = true,
            Callback = function(Value)
                if Value then
                    local speed = tonumber(Value)
                    if speed then
                        BaseVar.WalkSpeed = math.max(16, speed)
                    end
                end
            end
        })

        Tabs.Main:AddButton({
            Title = "Apply Speed",
            Callback = function()
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = BaseVar.WalkSpeed
                end
            end
        })

        local AntiAfk = Tabs.Main:AddToggle("AntiAfk", {Title = "Anti Afk", Default = false })
        AntiAfk:OnChanged(function()
            BaseVar.AntiAfk = Options.AntiAfk.Value
        end)

        local Flyhack = Tabs.Main:AddToggle("Flyhack", {Title = "Fly", Default = false })
        Flyhack:OnChanged(function()
            BaseVar.FLYING = Options.Flyhack.Value
            if BaseVar.FLYING == true then
                humanoid.PlatformStand = true

                -- Create input connections only when flyhack is enabled
                flyConnections.inputBegan = UserInputService.InputBegan:Connect(function(input)
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W then
                        controlValues.Forward = 1
                    elseif key == Enum.KeyCode.S then
                        controlValues.Backward = 1
                    elseif key == Enum.KeyCode.A then
                        controlValues.Left = 1
                    elseif key == Enum.KeyCode.D then
                        controlValues.Right = 1
                    elseif key == Enum.KeyCode.Space then
                        controlValues.Up = 1
                    elseif key == Enum.KeyCode.LeftShift then
                        controlValues.Down = 1
                    end
                end)

                flyConnections.inputEnded = UserInputService.InputEnded:Connect(function(input)
                    local key = input.KeyCode
                    if key == Enum.KeyCode.W then
                        controlValues.Forward = 0
                    elseif key == Enum.KeyCode.S then
                        controlValues.Backward = 0
                    elseif key == Enum.KeyCode.A then
                        controlValues.Left = 0
                    elseif key == Enum.KeyCode.D then
                        controlValues.Right = 0
                    elseif key == Enum.KeyCode.Space then
                        controlValues.Up = 0
                    elseif key == Enum.KeyCode.LeftShift then
                        controlValues.Down = 0
                    end
                end)

                BaseModule:startFlying()
            else
                -- Disconnect all flyhack input connections when disabled
                for _, connection in pairs(flyConnections) do
                    connection:Disconnect()
                end
                flyConnections = {} -- Clear the table

                BaseModule:stopFlying()
                humanoid.PlatformStand = false

                -- Reset all control values to 0
                controlValues.Forward = 0
                controlValues.Backward = 0
                controlValues.Left = 0
                controlValues.Right = 0
                controlValues.Up = 0
                controlValues.Down = 0
            end
        end)

        local InfJump = Tabs.Main:AddToggle("InfJump", {Title = "Inf Jump", Default = false })
        InfJump:OnChanged(function()
            BaseVar.InfJumpVar = Options.InfJump.Value
            BaseModule:ToggleInfiniteJump()
        end)


        local NoClip = Tabs.Main:AddToggle("NoClip", {Title = "No Clip", Default = false })
        NoClip:OnChanged(function()
            BaseVar.NoClip = Options.NoClip.Value
            if BaseVar.NoClip == true then
                BaseModule:enableNoclip()
            else
                BaseModule:disableNoclip()
            end
        end)

        local Section = Tabs.Main:AddSection("Server")
        Tabs.Main:AddParagraph({
            Title = "Server Version",
            Content = game:GetService("CoreGui").RobloxGui.SettingsClippingShield.SettingsShield.VersionContainer.PlaceVersionLabel.Text:match("%d+")
        })

        Tabs.Main:AddButton({
            Title = "Copy JobId",
            Callback = function()
                setclipboard(tostring(game.JobId))
            end
        })

        local InputJobId = Tabs.Main:AddInput("InputJobId", {
            Title = "Input JobId",
            Numeric = false,
            Callback = function(Value)
                if Value then
                    BaseVar.InputJobId = Value
                end
            end
        })

        Tabs.Main:AddButton({
            Title = "Teleport To JobId",
            Callback = function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, BaseVar.InputJobId, game:GetService("Players").LocalPlayer)
            end
        })

        Tabs.Main:AddButton({
            Title = "Hop Server",
            Callback = function()
                BaseModule:hopServer()
            end
        })

        local Section = Tabs.Main:AddSection("Information")
        Tabs.Main:AddButton({
            Title = "Copy Discord Server",
            Callback = function()
                setclipboard("https://discord.gg/MpcajbJBND")
                SendNotification("Copied: https://discord.gg/MpcajbJBND", 1)
            end
        })

        Tabs.Main:AddParagraph({
            Title = "About Us",
            Content = "Script by No-Dev & DeopZa\n\nWe make clean, keyless scripts that just work.\nNo bloat, no nonsense - just exclusive feature."
        })
    end

     -- [Farm Tab]
    do
        local Section = Tabs.Automatic:AddSection("Plant Seed")
        local Farmspd = Tabs.Automatic:AddSlider("Farmspd", {
            Title = "Plant Delay (Seconds)",
            Default = 0.5,
            Min = 0.05,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                if Value == 0 then Value = 0.05 end
                Config.PlantSpeed = Value
            end
        })



        local SpamFarm = Tabs.Automatic:AddToggle("SpamFarm", {Title = "Auto Plant (Spam)", Default = false })
        SpamFarm:OnChanged(function()
            Config.SpamFarm = Options.SpamFarm.Value
            if Config.SpamFarm then GameLoop:SpamFarm() end
        end)

        local PlantPos = Tabs.Automatic:AddDropdown("PlantPos", {
            Title = "Plant Position",
            Values = {},
            Multi = true,
            Default = {},
        })

        PlantPos:OnChanged(function(Value)
            Config.SavePos = {}
            for Value, State in next, Value do
                local x, z = Value:match("([%-%d%.]+)%s+([%-%d%.]+)")
                table.insert(Config.SavePos, {tonumber(x), tonumber(z)})
            end
        end)

        local PosFarm = Tabs.Automatic:AddToggle("PosFarm", {Title = "Auto Plant (Position)",Default = false})
        PosFarm:OnChanged(function()
            Config.PosFarm = Options.PosFarm.Value
            if Config.PosFarm then GameLoop:PosFarm() end
        end)

        Tabs.Automatic:AddButton({
            Title = "Save Plant Position",
            Callback = function()
                GameModule:savePos(Table.SavePos)  -- Save the raw position data
                local formattedPositions = GameModule:getPos(Table.SavePos)  -- Get formatted strings
                PlantPos:SetValues(formattedPositions)  -- Pass the formatted strings
                SendNotification("Position Saved", 1)
            end
        })

        Tabs.Automatic:AddButton({
            Title = "Clear Plant Positions",
            Callback = function()
                Table.SavePos = {}
                Config.SavePos = {}
                PlantPos:SetValue({})
                PlantPos:SetValues({})
                SendNotification("All positions cleared", 1)
            end
        })

        local Section = Tabs.Automatic:AddSection("Collect Fruit")
        local CollectMode = Tabs.Automatic:AddDropdown("CollectMode", {
            Title = "Collect Mode",
            Values = {"Normal", "Fast"},
            Multi = false,
            Default = 1,
        })
        CollectMode:OnChanged(function(Value)
            if Value then
                Config.CollectMode = Value
            end
        end)

        local CollectMode1 = Tabs.Automatic:AddDropdown("CollectMode1", {
            Title = "List Fruit",
            Values = {},
            Multi = true,
            Default = {},
        })
        CollectMode1:OnChanged(function(Value)
            Config.Blacklist.fruit = {}
            for Value, State in next, Value do
                table.insert(Config.Blacklist.fruit, Value)
            end
        end)

        local CollectMode2 = Tabs.Automatic:AddDropdown("CollectMode2", {
            Title = "List Variant",
            Values = {"Any" ,"Gold", "Rainbow"},
            Multi = true,
            Default = {},
        })
        CollectMode2:OnChanged(function(Value)
            Config.Blacklist.variant = {}
            for Value, State in next, Value do
                table.insert(Config.Blacklist.variant, Value)
            end
        end)

        local CollectMode3 = Tabs.Automatic:AddDropdown("CollectMode3", {
            Title = "List Mutation",
            Values = Table.Mutation,
            Multi = true,
            Default = {},
        })
        CollectMode3:OnChanged(function(Value)
            Config.Blacklist.mutation = {}
            for Value, State in next, Value do
                table.insert(Config.Blacklist.mutation, Value)
            end
        end)

        local CollectMode4 = Tabs.Automatic:AddDropdown("CollectMode4", {
            Title = "Filter Mode",
            Values = {"Whitelist", "Blacklist"},
            Multi = false,
            Default = "",
        })
        CollectMode4:OnChanged(function(Value)
            Config.FilterMode = Value
        end)

        local FilterToggle = Tabs.Automatic:AddToggle("FilterToggle", {Title = "Filter",Description = "Will (not collect/teleport or collect/telpeort) fruits with specific mutations or variants", Default = false })
        FilterToggle:OnChanged(function()
            Config.FilterBool = Options.FilterToggle.Value
        end)

        local CollectAll = Tabs.Automatic:AddToggle("CollectAll", {Title = "Auto Collect ", Default = false })
        CollectAll:OnChanged(function()
            Config.CollectFull = Options.CollectAll.Value
            if Config.CollectFull then
                GameLoop:CollectFull()
            end
        end)

        local TpSpeed = Tabs.Automatic:AddSlider("TpSpeed", {
            Title = "Teleport Delay (Seconds)",
            Default = 0.5,
            Min = 0.1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Config.TpCollectSpeed = Value
            end
        })

        local TeleportToTree = Tabs.Automatic:AddToggle("TeleportToTree", {Title = "Teleport To Fruit", Default = false })
        TeleportToTree:OnChanged(function()
            Config.TeleportToTree = Options.TeleportToTree.Value
            if Config.TeleportToTree then
                Options.Flyhack:SetValue(true)
                Options.NoClip:SetValue(true)
                GameLoop:TeleportToTree()
            else
                Options.Flyhack:SetValue(false)
                Options.NoClip:SetValue(false)
            end
        end)


        local Section = Tabs.Automatic:AddSection("Remove Tree" )
        local RemoveTreeDropdown = Tabs.Automatic:AddDropdown("RemoveTreeDropdown", {
            Title = "Tree List",
            Description = "Select tree to remove",
            Values = {},
            Multi = false,
            Default = "",
        })

        Tabs.Automatic:AddButton({
            Title = "Refresh Tree List",
            Description = "Refresh Tree List Dropdown" ,
            Callback = function()
                Table.RemoveTreeList = {}
                DataLoader:loadTreeList()
                RemoveTreeDropdown:SetValues(Table.RemoveTreeList)
            end
        })

        RemoveTreeDropdown:OnChanged(function(Value)
            Config.RemoveTreeTarget = Value
        end)

        local RemSpeed = Tabs.Automatic:AddSlider("RemSpeed", {
            Title = "Remove Delay (Seconds)",
            Default = 0.5,
            Min = 0.1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Config.RemoveSpeed = Value
            end
        })

        local RemoveToggle = Tabs.Automatic:AddToggle("RemoveToggle", {Title = "Remove specific tree", Default = false })
        RemoveToggle:OnChanged(function()
            Config.AutoRemoveTree = Options.RemoveToggle.Value
            if Config.AutoRemoveTree then GameLoop:RemoveTree() end
        end)

        local Section = Tabs.Automatic:AddSection("Move Tree" )
        local MoveTreeDropdown = Tabs.Automatic:AddDropdown("MoveTreeDropdown", {
            Title = "Tree List",
            Description = "Select tree you want to move",
            Values = {},
            Multi = false,
            Default = "",
        })

        Tabs.Automatic:AddButton({
            Title = "Refresh Tree List",
            Description = "Refresh Tree List Dropdown" ,
            Callback = function()
                Table.RemoveTreeList = {}
                DataLoader:loadTreeList()
                MoveTreeDropdown:SetValues(Table.RemoveTreeList)
            end
        })

        MoveTreeDropdown:OnChanged(function(Value)
            Config.MoveTreeTarget = Value
        end)

        Tabs.Automatic:AddButton({
            Title = "Move Tree",
            Description = "Move Selected Tree To Current Position",
            Callback = function()
                GameModule:MoveTree(GameModule:GetGarden())
            end
        })

        task.spawn(function()
            task.wait(2)
            CollectMode1:SetValues(Table.SeedData)
        end)
    end

    -- [Pet Tab]
    do
        Tabs.Pet:AddButton({
            Title = "Teleport Egg Shop",
            Callback = function()
                character.HumanoidRootPart.CFrame = CFrame.new(-258.483734, 2.99999976, -4.85723829, -0.0251665786, -1.80528161e-08, 0.999683261, -1.27722677e-08, 1, 1.77370012e-08, -0.999683261, -1.23218422e-08, -0.0251665786)
            end
        })

        local PetEgg = Tabs.Pet:AddDropdown("PetEgg", {
            Title = "Blacklist Buy Egg",
            Description = "Will not buy egg that selected in this list.",
            Values = Table.Egglist,
            Multi = true,
            Default = {"Common Egg"},
        })

        PetEgg:OnChanged(function(Value)
            Config.PetEgg = {}
            for Value, State in next, Value do
                table.insert(Config.PetEgg, Value)
            end
        end)

        local AutoBuyEgg = Tabs.Pet:AddToggle("AutoBuyEgg", {Title = "Auto Buy Egg", Default = false })
        AutoBuyEgg:OnChanged(function()
            Config.AutoBuyEgg = Options.AutoBuyEgg.Value
            if Config.AutoBuyEgg then GameLoop:AutoBuyEgg() end
        end)

        local AutoBuyAllEgg = Tabs.Pet:AddToggle("AutoBuyAllEgg", {Title = "Auto All Buy Egg", Default = false })
        AutoBuyAllEgg:OnChanged(function()
            Config.AutoBuyAllEgg = Options.AutoBuyAllEgg.Value
            if Config.AutoBuyAllEgg then GameLoop:AutoBuyAllEgg() end
        end)

        local PlaceEggDrop = Tabs.Pet:AddDropdown("PlaceEggDrop", {
            Title = "Place Egg List",
            Values = Table.Egglist,
            Multi = true,
            Default = {"Common Egg"},
        })

        PlaceEggDrop:OnChanged(function(Value)
            Config.EggPlace = {}
            for Value, State in next, Value do
                table.insert(Config.EggPlace, Value)
            end
        end)

        local PlaceEgg = Tabs.Pet:AddToggle("PlaceEgg", {Title = "Auto Place", Default = false })
        PlaceEgg:OnChanged(function()
            Config.AutoPlaceEgg = Options.PlaceEgg.Value
            if Config.AutoPlaceEgg then GameLoop:AutoPlaceEgg() end
        end)

        local AutoHatch = Tabs.Pet:AddToggle("AutoHatch", {Title = "Auto Hatch", Default = false })
        AutoHatch:OnChanged(function()
            Config.AutoHatch = Options.AutoHatch.Value
            if Config.AutoHatch then GameLoop:AutoHatch() end
        end)
        local Section = Tabs.Pet:AddSection("My Pet")
        local PetFeedW = Tabs.Pet:AddDropdown("PetFeedW", {
            Title = "Pet List",
            Values = {},
            Multi = true,
            Default = {},
        })

        PetFeedW:OnChanged(function(Value)
            Config.PetFeedTable = {}
            for Value, State in next, Value do
                table.insert(Config.PetFeedTable, Value)
            end
        end)

        local PetFood = Tabs.Pet:AddDropdown("PetFood", {
            Title = "Pet Food",
            Values = {},
            Multi = true,
            Default = {""},
        })
        PetFood:OnChanged(function(Value)
            Config.PetFood = {}
            for Value, State in next, Value do
                table.insert(Config.PetFood, Value)
            end
        end)

        Tabs.Pet:AddButton({
            Title = "Refresh Pet & Food List",
            Callback = function()
                Table.PetList = {}
                DataLoader:loadPetList()
                PetFood:SetValues(Table.SeedData)
                PetFeedW:SetValues(Table.PetList)
                PetFeedW:SetValue({""})
            end
        })

        local FeedDelay = Tabs.Pet:AddInput("FeedDelay", {
            Title = "Feed Delay (Minute)",
            Default = 10,
            Numeric = true,
            Callback = function(Value)
                if Value then
                    local delay = tonumber(Value) * 60
                    if delay then
                        Config.FeedSpeed = math.max(60, delay)
                    end
                end
            end
        })

        local AutoFeed = Tabs.Pet:AddToggle("AutoFeed", {Title = "Auto Feed Pet", Default = false })
        AutoFeed:OnChanged(function()
            Config.AutoFeed = Options.AutoFeed.Value
            if Config.AutoFeed then GameLoop:AutoFeed() end
        end)

        Tabs.Pet:AddButton({
            Title = "Pick Up Pet",
            Callback = function()
                for _, pet in ipairs(workspace.PetsPhysical:GetChildren()) do
                    if pet.Name == "PetMover" and pet:GetAttribute("OWNER") == playername then
                        if Config.PetFeedTable then
                            for _, petOBJ in ipairs(Config.PetFeedTable) do
                                if pet:FindFirstChild(petOBJ) then
                                    game:GetService("ReplicatedStorage").GameEvents.PetsService:FireServer("UnequipPet", pet:GetAttribute("UUID"))
                                end
                            end
                        end
                    end
                end
            end
        })

        local AutoPickUp = Tabs.Pet:AddToggle("AutoPickUp", {Title = "Auto Pick Up Pet",Description = "Will pick up all pet during thunderstrom", Default = false })
        AutoPickUp:OnChanged(function()
            Config.AutoPickUp = Options.AutoPickUp.Value
            if Config.AutoPickUp then GameLoop:AutoPickUp() end
        end)

    end

    -- [Utility Tab]
    do
        local Section = Tabs.Utility:AddSection("Calculate Price")
        local CheckPrice, CheckPrice2
        local total = 0
        local priceitem = 0
        local ButtonValue = Tabs.Utility:AddButton({
            Title = "Inventory Value: Click to Calculate",
            Description = "Press To Check Inventory Value",
            Callback = function()
                local value = require(game:GetService("ReplicatedStorage").Modules.CalculatePlantValue)
                total = 0

                for _, item in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if item:GetAttribute("ITEM_TYPE") and item:GetAttribute("ITEM_TYPE") == "Holdable" then
                        local price = value(item) or 0
                        total = total + price
                    end
                end
                CheckPrice = true
            end
        })
        local ButtonValue2 = Tabs.Utility:AddButton({
            Title = "Hold Item Value: Click to Calculate",
            Description = "Press To Check Hold Item Value",
            Callback = function()
                local value = require(game:GetService("ReplicatedStorage").Modules.CalculatePlantValue)
                local tool = character:FindFirstChildWhichIsA("Tool")
                if tool then
                    if tool:GetAttribute("ITEM_TYPE") and tool:GetAttribute("ITEM_TYPE") == "Holdable" then
                        priceitem = value(tool) or 0
                    end
                end
                CheckPrice2 = true
            end
        })
        task.spawn(function()
            while _G.NoLag and task.wait(1) do
                if CheckPrice then
                    ButtonValue:SetTitle("Inventory Value: "..tostring(total))
                    CheckPrice = false
                end

                if CheckPrice2 then
                    ButtonValue2:SetTitle("Item Value: "..tostring(priceitem))
                    CheckPrice2 = false
                end
            end
        end)
        local Section = Tabs.Utility:AddSection("Night Event")
        Tabs.Utility:AddButton({
            Title = "Blood Moon Shop",
            Callback = function()
                local shop = player.PlayerGui.EventShop_UI
                shop.Enabled = not shop.Enabled
            end
        })

        Tabs.Utility:AddButton({
            Title = "Twilight Shop",
            Callback = function()
                local shop = player.PlayerGui.NightEventShop_UI
                shop.Enabled = not shop.Enabled
            end
        })

        local EventShop = Tabs.Utility:AddDropdown("EventShop", {
            Title = "Stock Whitelist",
            Description = "Auto buy item Whitelist",
            Values = {},
            Multi = true,
            Default = {""},
        })

        EventShop:OnChanged(function(Value)
            Config.WhitelistEvent = {}
            for name, _ in pairs(Value) do
                table.insert(Config.WhitelistEvent, name)
            end
        end)

        local AutoBuyEvent = Tabs.Utility:AddToggle("AutoBuyEvent", {Title = "Auto Buy Twilight", Default = false })
        AutoBuyEvent:OnChanged(function()
            Config.AutoBuyEvent = Options.AutoBuyEvent.Value
        end)

        local Section = Tabs.Utility:AddSection("Sell Fruit")
        local SellDelay = Tabs.Utility:AddInput("SellDelay", {
            Title = "Sell Delay (Seconds)",
            Default = "30",
            Numeric = true,
            Callback = function(Value)
                if Value then
                    local delay = tonumber(Value)
                    if delay then
                        Config.AutoSellDelay = math.max(1, delay)
                    end
                end
            end
        })

        local AutoSellToggle = Tabs.Utility:AddToggle("AutoSellToggle", {Title = "Auto Sell (Timer)", Default = false })
        AutoSellToggle:OnChanged(function()
            Config.AutoSellBP = false
            Config.AutoSell = Options.AutoSellToggle.Value
            if Config.AutoSell then GameLoop:AutoSell() end
        end)

        local AutoSell2 = Tabs.Utility:AddToggle("AutoSell2", {Title = "Auto Sell (Full Backpack)", Default = false })
        AutoSell2:OnChanged(function()
            Config.AutoSell = false
            Config.AutoSellBP = Options.AutoSell2.Value
            if Config.AutoSellBP then GameLoop:AutoSellBP() end
        end)

        Tabs.Utility:AddButton({
            Title = "Sell Inventory",
            Callback = function()
                GameModule:SellInventory()
            end
        })

        local Section = Tabs.Utility:AddSection("Water Tree")
        local Waterrg = Tabs.Utility:AddSlider("Waterrg", {
            Title = "Water Distance (Facing)",
            Default = 0.1,
            Min = 0.1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Config.WaterDis = Value
            end
        })

        local WaterSpd = Tabs.Utility:AddSlider("WaterSpd", {
            Title = "Water Speed",
            Default = 0.1,
            Min = 0.1,
            Max = 10,
            Rounding = 1,
            Callback = function(Value)
                Config.WaterSpeed = Value
            end
        })

        local WaterSpam = Tabs.Utility:AddToggle("WaterSpam", {Title = "Auto Water (Spam)", Default = false })
        WaterSpam:OnChanged(function()
            Config.AutoWater = Options.WaterSpam.Value
            if Config.AutoWater then GameLoop:AutoWater() end
        end)

        local Section = Tabs.Utility:AddSection("Auto Place Gear")
        local Sprinkler = Tabs.Utility:AddDropdown("Sprinkler", {
            Title = "Gear List",
            Values = {"Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Lightning Rod", "Chocolate Sprinkler", "Night Staff", "Star Caller"},
            Multi = true,
            Default = {},
        })
        Sprinkler:OnChanged(function(Value)
            Config.Sprinkler = {}
            for Value, State in next, Value do
                table.insert(Config.Sprinkler, Value)
            end
        end)

        Tabs.Utility:AddButton({
            Title = "Save Place Gear Position",
            Callback = function()
                Config.SavePos2 = {}
                local pos = character.HumanoidRootPart.CFrame.Position
                Config.SavePos2 = { pos.X, pos.Z } -- Store X and Z directly (not nested)
                SendNotification("Position saved! X: " .. pos.X .. ", Z: " .. pos.Z, 1)
            end
        })

        Tabs.Utility:AddButton({
            Title = "Place Gear",
            Callback = function()
                if #Config.Sprinkler > 0 then
                    if Config.SavePos2 and #Config.SavePos2 >= 2 then
                        for _, tool in ipairs(Config.Sprinkler) do
                            for _, item in ipairs(player.Backpack:GetChildren()) do
                                if item:GetAttribute("ItemName") == tool then
                                    character:FindFirstChildOfClass("Humanoid"):EquipTool(item)
                                    local position = CFrame.new(
                                        Config.SavePos2[1], 0.135525137, Config.SavePos2[2],
                                        0.064701885, 0.857260585, -0.510801494,
                                        -0, 0.51187402, 0.859060585,
                                        0.997904658, -0.05558284, 0.0331192128
                                    )
                                    GameEvents.SprinklerService:FireServer("Create", position)
                                    task.wait(0.2)
                                end
                            end
                        end
                    else
                        SendNotification("No saved position or invalid position data! Did you click 'Save Position'?", 1)
                    end
                else
                    SendNotification("No Gear selected in the dropdown!", 1)
                end
            end
        })
        task.spawn(function ()
            task.wait(1)
            EventShop:SetValues(Table.LoadStock.event)
        end)
    end

    -- [Item Tab]
    do
        local Section = Tabs.Item:AddSection("Auto Favorite")
        local FavSelect = Tabs.Item:AddDropdown("FavSelect", {
            Title = "Variant Favorite",
            Values = {"Any" ,"Normal", "Gold","Rainbow"},
            Multi = true,
            Default = {"Normal"},
        })

        FavSelect:OnChanged(function(Value)
            Config.Fav = {}
            for Value, State in next, Value do
                table.insert(Config.Fav, Value)
            end
        end)

        local FavSelect1 = Tabs.Item:AddDropdown("FavSelect1", {
            Title = "Mutation Favorite",
            Values = Table.Mutation,
            Multi = true,
            Default = {},
        })

        FavSelect1:OnChanged(function(Value)
            Config.Fav3 = {}
            for Value, State in next, Value do
                table.insert(Config.Fav3, Value)
            end
        end)

        local FavSelect2 = Tabs.Item:AddDropdown("FavSelect2", {
            Title = "Fruit Favorite",
            Values = {},
            Multi = true,
            Default = {},
        })

        FavSelect2:OnChanged(function(Value)
            Config.Fav2 = {}
            for Value, State in next, Value do
                table.insert(Config.Fav2, Value)
            end
        end)


        local FavAuto = Tabs.Item:AddToggle("FavAuto", {Title = "Auto Favorite", Default = false })
        FavAuto:OnChanged(function()
            Config.AutoFav = Options.FavAuto.Value
            if Config.AutoFav then GameLoop:AutoFavorite() end
        end)

        local Section = Tabs.Item:AddSection("Equip")
        local SeedEquip = Tabs.Item:AddDropdown("SeedEquip", {
            Title = "Seed",
            Description = "Auto Equip Seed",
            Values = {},
            Multi = false,
            Default = "",
        })

        SeedEquip:OnChanged(function(Value)
            Config.EquipSeed = Value
        end)

        local AutoSeed = Tabs.Item:AddToggle("AutoSeed", {Title = "Auto Equip Seed", Default = false })
        AutoSeed:OnChanged(function()
            Config.AutoSeed = Options.AutoSeed.Value
            if Config.AutoSeed then GameLoop:AutoEquipSeed() end
        end)

        Tabs.Item:AddButton({
            Title = "Equip All Seed",
            Description = "Bypass Max Equip",
            Callback = function()
                for _, tool in ipairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") and tool:GetAttribute("Seed") then
                        tool.Parent = character
                    end
                end
            end
        })

        Tabs.Item:AddButton({
            Title = "Equip All",
            Description = "Bypass Max Equip",
            Callback = function()
                for _, tool in ipairs(player.Backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        tool.Parent = character
                    end
                end
            end
        })

        local SeedAll = Tabs.Item:AddToggle("SeedAll", {Title = "Auto Equip All Seed", Default = false })
        SeedAll:OnChanged(function()
            Config.AutoSeedAll = Options.SeedAll.Value
        end)
        task.spawn(function ()
            task.wait(2)
            SeedEquip:SetValues(Table.SeedData)
            FavSelect2:SetValues(Table.SeedData)
        end)
    end

    -- [UI & ESP Tab]
    do
        local Section = Tabs.UI:AddSection("ESP Fruit")

        local EspSelect = Tabs.UI:AddDropdown("EspSelect", {
            Title = "Fruit",
            Values = {},
            Multi = true,
            Default = {},
        })

        EspSelect:OnChanged(function(Value)
            Config.EspList.fruit = {}
            for Value, State in next, Value do
                table.insert(Config.EspList.fruit, Value)
            end
        end)

        local EspSelect2 = Tabs.UI:AddDropdown("EspSelect2", {
            Title = "Mutation",
            Values = Table.Mutation,
            Multi = true,
            Default = {},
        })

        EspSelect2:OnChanged(function(Value)
            Config.EspList.mutation = {}
            for Value, State in next, Value do
                table.insert(Config.EspList.mutation, Value)
            end
        end)

        Tabs.UI:AddButton({
            Title = "Add ESP",
            Callback = function()
                GameModule:FruitEsp(true)
            end
        })

        Tabs.UI:AddButton({
            Title = "Remove ESP",
            Callback = function()
                GameModule:FruitEsp(false)
            end
        })

        local EspAuto = Tabs.UI:AddToggle("EspAuto", {Title = "Auto Enable ESP", Default = false })
        EspAuto:OnChanged(function()
            Config.AutoEsp = Options.EspAuto.Value
            if Config.AutoEsp then GameLoop:AutoEsp() end
        end)

        local Section = Tabs.UI:AddSection("UI")
        Tabs.UI:AddButton({
            Title = "Events UI",
            Description = "Click to Open",
            Callback = function()
                local shop = player.PlayerGui.NightQuest_UI
                shop.Enabled = not shop.Enabled
            end
        })

        Tabs.UI:AddButton({
            Title = "Seed Shop",
            Description = "Click to open/close",
            Callback = function()
                local shop = player.PlayerGui.Seed_Shop
                shop.Enabled = not shop.Enabled
            end
        })

        Tabs.UI:AddButton({
            Title = "Gear Shop",
            Description = "Click to open/close",
            Callback = function()
                local shop = player.PlayerGui.Gear_Shop
                shop.Enabled = not shop.Enabled
            end
        })

        Tabs.UI:AddButton({
            Title = "Daily Quest",
            Description = "Click to open/close",
            Callback = function()
                local shop = player.PlayerGui.DailyQuests_UI
                shop.Enabled = not shop.Enabled
            end
        })

        task.spawn(function()
            task.wait(2)
            EspSelect:SetValues(Table.SeedData)
        end)
    end

    -- [Shop Tab]
    do
        local Section = Tabs.Shop:AddSection("Buy")
         local MultiStock = Tabs.Shop:AddDropdown("MultiStock", {
            Title = "Stock Whitelist",
            Description = "Auto buy item Whitelist",
            Values = {},
            Multi = true,
            Default = {""},
        })

        MultiStock:OnChanged(function(Value)
            Config.WhitelistSeed = {}
            for name, _ in pairs(Value) do
                table.insert(Config.WhitelistSeed, name)
            end
        end)

        local AutoBuy = Tabs.Shop:AddToggle("AutoBuy", {Title = "Auto Buy Stock", Default = false })
        AutoBuy:OnChanged(function()
            Config.AutoBuy = Options.AutoBuy.Value
        end)

        local MultiStock2 = Tabs.Shop:AddDropdown("MultiStock2", {
            Title = "Gear Stock Whitelist",
            Description = "Auto buy item Whitelist",
            Values = {},
            Multi = true,
            Default = {""},
        })

        MultiStock2:OnChanged(function(Value)
            Config.WhitelistGear = {}
            for name, _ in pairs(Value) do
                table.insert(Config.WhitelistGear, name)
            end
        end)

        local AutoGearBuy = Tabs.Shop:AddToggle("AutoGearBuy", {Title = "Auto Gear", Default = false })
        AutoGearBuy:OnChanged(function()
            Config.AutoBuyGear = Options.AutoGearBuy.Value
        end)

        Tabs.Shop:AddButton({
            Title = "Buy Entire Stock",
            Description = "Buy Entire Seed Stock",
            Callback = function()
                local stockData = GameModule:GetStockData(player.PlayerGui.Seed_Shop.Frame.ScrollingFrame)
                local cash = player.leaderstats.Sheckles.Value

                for seedName, data in pairs(stockData) do
                    if cash >= data.price then
                        for i = 1, data.count do
                            if cash >= data.price then
                                GameEvents.BuySeedStock:FireServer(seedName)
                                cash = cash - data.price
                                task.wait()
                            else
                                break
                            end
                        end
                    end
                end
            end
        })

        local AutoBuy3 = Tabs.Shop:AddToggle("AutoBuy3", {Title = "Auto Buy All Stock (Seed & Gear)", Default = false })
        AutoBuy3:OnChanged(function()
            Config.AutoBuyAll = Options.AutoBuy3.Value
        end)

        task.spawn(function ()
            task.wait(1)
            MultiStock:SetValues(Table.LoadStock.seed)
            MultiStock2:SetValues(Table.LoadStock.gear)
        end)
    end

--[[     --[Experimential]
    do
        local Section = Tabs.Experimential:AddSection("Vuln")
    end ]]

    --[Performance Tab]
    do
        Tabs.Performance:AddButton({
            Title = "Hide/Show Other Garden (Boost FPS)",
            Description = "Click to Hide/Show Garden",
            Callback = function()
                if Config.Busy_2 == true then
                    SendNotification("On cooldown (5 Second)", 2)
                else
                    Config.Busy_2 = true
                    if Config.HideGarden == false then
                        for _, garden in pairs(workspace.Farm:GetChildren()) do
                            if garden.Important.Data.Owner.Value ~= player.Name then
                                GameModule:hideDescendants(garden)
                            end
                        end
                        Config.HideGarden = true
                    elseif Config.HideGarden == true then
                        GameModule:restoreAll()
                        Config.HideGarden = false
                    end
                    task.wait(3)
                    Config.Busy_2 = false
                end
            end
        })

        Tabs.Performance:AddButton({
            Title = "Delete Other Garden (Boost FPS)",
            Description = "You Need to rejoin, to restore !",
            Callback = function()
                for _, garden in pairs(workspace.Farm:GetChildren()) do
                    if garden.Important.Data.Owner.Value ~= player.Name then
                        garden:Destroy()
                    end
                end
            end
        })

        Tabs.Performance:AddButton({
            Title = "Hide Trees (Boost FPS)",
            Description = "Hide/Show trees to improve performance",
            Callback = function()
                if treeVisibility.hidden then
                    GameModule:showTrees()
                else
                    GameModule:hideTrees()
                end
            end
        })

        Tabs.Performance:AddButton({
            Title = "Delete Tree (Boost FPS)",
            Description = "You Need to rejoin, to restore !",
            Callback = function()
                for _, garden in pairs(workspace.Farm:GetChildren()) do
                    for _, tangkai_pohon in next, garden.Important.Plants_Physical:GetDescendants() do
                        if (tangkai_pohon:isA("Part") or tangkai_pohon:isA("TrussPart") or tangkai_pohon:isA("MeshPart")) and not tangkai_pohon:FindFirstChild("ProximityPrompt") and tangkai_pohon.Name ~= "1" then
                            tangkai_pohon:Destroy()
                        end
                    end
                end
            end
        })

        Tabs.Performance:AddButton({

            Title = "Decrease World Quality (Boost FPS) ",
            Callback = function()
                task.spawn(function()
                    local Lighting = game.Lighting
                    local Terrain = workspace.Terrain

                    Terrain.WaterWaveSize = 0
                    Terrain.WaterWaveSpeed = 0
                    Terrain.WaterReflectance = 0
                    Terrain.WaterTransparency = 0

                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    Lighting.Brightness = 0

                    settings().Rendering.QualityLevel = "Level01"

                    for _, v in ipairs(game:GetDescendants()) do
                      if v:IsA("BasePart") then
                        v.Material = Enum.Material.Plastic
                        v.Reflectance = 0
                      elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        v.Lifetime = NumberRange.new(0)
                      elseif v:IsA("Explosion") then
                        v.BlastPressure = 1
                        v.BlastRadius = 1
                      elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                        v.Enabled = false
                      elseif v:IsA("MeshPart") then
                        v.Material = Enum.Material.Plastic
                        v.Reflectance = 0
                        v.TextureID = ""
                      end
                    end

                    for _, v in ipairs(Lighting:GetChildren()) do
                      if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                        v.Enabled = false
                      end
                    end
                end)
            end
        })

        Tabs.Performance:AddButton({
            Title = "Decrease Texture Quality (Boost FPS) ",
            Callback = function()
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                        v.Material = Enum.Material.SmoothPlastic
                        if v:IsA("Texture") then
                            v:Destroy()
                        end
                    end
                end
            end
        })

        local dRender = Tabs.Performance:AddToggle("dRender", {Title = "Disable 3D Rendering", Default = false })
        dRender:OnChanged(function()
            RunService:Set3dRenderingEnabled(not Options.dRender.Value)
        end)

        -- [Save Manager]
        SaveManager:SetLibrary(Fluent)
        SaveManager:IgnoreThemeSettings()
        SaveManager:SetFolder("No-Lag/GrowAgarden")
        SaveManager:BuildConfigSection(Tabs.Settings)
        task.spawn(function()
            print("[No-Lag] Load Config...")
            task.wait(5)
            SaveManager:LoadAutoloadConfig()
        end)
        -- [Initialize]
        Window:SelectTab(1)
        SendNotification("Successfully Loaded NoLag Hub V"..tostring(version), 8)
        SendNotification("Join Discord for Dupe Glitch Information !", 8)
    end
end




