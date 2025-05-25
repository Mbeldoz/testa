repeat task.wait() until game:IsLoaded() and game.Players and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local Library = (loadstring or load)(game:HttpGet("https://raw.githubusercontent.com/Mbeldoz/testa/refs/heads/main/wth.lua"))()
local _Settings = (loadstring or load)(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Settings.lua"))()
local Funcs = (loadstring or load)(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Main/main/Library/Example/FuncsV3"))()

local Window = Library:CreateWindow({
	Title = "NoLag Premium | Version: 1.0.0",
	Description = "",
	["Tab Width"] = 160
})
--loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/refs/heads/main/Garden/utility/MobileDex.lua"))()
--loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Mbeldoz/testa/refs/heads/main/haha.lua"))()
local Home = Window:CreateTab({["Name"] = " | Home", ["Icon"] = "rbxassetid://10734942198"})
local Main = Window:CreateTab({["Name"] = " | Main", ["Icon"] = "rbxassetid://10723407389"})
local Misc = Window:CreateTab({["Name"] = " | Miscellaneous", ["Icon"] = "rbxassetid://11447063791"})
local Settings = Window:CreateTab({["Name"] = " | Settings", ["Icon"] = "rbxassetid://10734950309"})

local setclipboard = setclipboard or function(...) return ... end

local _spawn = task.spawn

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualInputManager = Instance.new("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Place = game.PlaceId

_spawn(function()
  if _G.Anti_AFK then return end
  _G.Anti_AFK = true

  while task.wait(600) do
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
  end
end)

local _Connect = {}

local LastFired = {}

local SaveManager, _SaveConfig = {}, {} do
  local FolderPath = "NoLag"
  local FilePath = FolderPath .. "/GrowAGarden.json"

  function SaveManager:SetSave(Name, Value, Type)
    local Type = Type or false

    if not Type and typeof(Value) == "table" then
      for i,v in next, Value do
        _SaveConfig[Name] = v
      end
    else
      _SaveConfig[Name] = Value
    end

    pcall(function()
      local json = HttpService:JSONEncode(_SaveConfig)

      if writefile and isfolder and makefolder then
        if not isfolder(FolderPath) then makefolder(FolderPath) end
        writefile(FilePath, json)
      end
    end)
  end

  function SaveManager:SetLoad()
    if not isfile then return end

    pcall(function()
      if isfile(FilePath) then
        _SaveConfig = HttpService:JSONDecode(readfile(FilePath))
      end
    end)
  end

  SaveManager:SetLoad()
  Funcs:SetTable(_SaveConfig)
end

local Module = {} do
  function Module:Run_Loop(Name, Func)
    _spawn(function()
      while wait() do
        if Library.Unloaded then break end

        if _SaveConfig[Name] then
          pcall(Func)
        end
      end
    end)
  end

  function Module:GetTo(Tween_Pos)
    local Distance = (Tween_Pos.Position - Player.Character.HumanoidRootPart.Position).Magnitude

    local Tween = TweenService:Create(Player.Character.HumanoidRootPart, TweenInfo.new(Distance / 16, Enum.EasingStyle.Linear), {CFrame = Tween_Pos})
    Tween:Play()

    if Distance <= 70 then
      Player.Character.HumanoidRootPart.CFrame = Tween_Pos
    end
  end

  function Module:FirePrompt(prompt, Distance)
    if not (prompt and prompt:IsA("ProximityPrompt")) then return end

    prompt.MaxActivationDistance = Distance or 10
    prompt.HoldDuration = 0

    pcall(function()
      prompt:InputHoldBegin()
      wait(prompt.HoldDuration)
      prompt:InputHoldEnd()
    end)
  end

  function Module:Webhooks(URL, Data)
    local _req = request or syn and syn.request or http and http.request or fluxus and fluxus.request or http_request
    if not _req then return end

    local body = HttpService:JSONEncode(Data)
    local headers = {["Content-Type"] = "application/json"}

    _req({Url = URL, Body = body, Method = "POST", Headers = headers})
  end

  function Module:EquipTool(Name)
    local Backpack = Player.Backpack
    if Backpack then
      local _Tool = Backpack:FindFirstChild(Name)
      if _Tool and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid:EquipTool(_Tool)
      end
    end
  end
end

local _Discord = Home:AddSection("Discord", true) do
  Funcs:Button(_Discord, "Discord Invite", "Click to Copy Invite Link", function()
    if Discord then
      setclipboard(Discord)
    end
  end)
end

local _LP = Home:AddSection("LocalPlayer") do
  Funcs:Textbox(_LP, "Set Speed", "", "Save", function(Value)
    SaveManager:SetSave("Set Speed", Value)
  end)

  Funcs:Toggle(_LP, "Enable Walkspeed", "", "Save", function(Value)
    SaveManager:SetSave("Enable Walkspeed", Value)
  end)

  _spawn(function()
    Module:Run_Loop("Enable Walkspeed", function()
      while _SaveConfig["Enable Walkspeed"] and not Library.Unloaded do
        local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
          Humanoid.WalkSpeed = tonumber(_SaveConfig["Set Speed"]) or 20
        end
        task.wait()
      end

      local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
      if Humanoid then
        Humanoid.WalkSpeed = 16
      end
    end)
  end)

  Funcs:Toggle(_LP, "No Clip", "", "Save", function(Value)
    SaveManager:SetSave("No Clip", Value)
  end)

  _spawn(function()
    Module:Run_Loop("No Clip", function()
      while _SaveConfig["No Clip"] and not Library.Unloaded do
        local Character = Player.Character

        if Character then
          for _, Base in ipairs(Character:GetDescendants()) do
            if Base:IsA("BasePart") then
              Base.CanCollide = false
            end
          end
        end

        task.wait()
      end

      local Character = Player.Character

      if Character then
        for _, Base in ipairs(Character:GetDescendants()) do
          if Base:IsA("BasePart") then
            Base.CanCollide = true
          end
        end
      end
    end)
  end)

  Funcs:Toggle(_LP, "Infinite Jump", "", "Save", function(Value)
    SaveManager:SetSave("Infinite Jump", Value)
  end)

  _spawn(function()
    if _Connect["InfJump"] then
      _Connect["InfJump"]:Disconnect()
      _Connect["InfJump"] = nil
    end

    _Connect["InfJump"] = UserInputService.JumpRequest:Connect(function()
      if Library.Unloaded then
        _Connect["InfJump"]:Disconnect()
        _Connect["InfJump"] = nil
        return
      end

      if _SaveConfig["Infinite Jump"] then
        Player.Character.Humanoid:ChangeState("Jumping")
      end
    end)
  end)

  Funcs:Toggle(_LP, "CTRL + Click to Teleport", "", "Save", function(Value)
    SaveManager:SetSave("CTRL + Click to Teleport", Value)
  end)

  _spawn(function()
    if _Connect["ClickTP"] then
      _Connect["ClickTP"]:Disconnect()
      _Connect["ClickTP"] = nil
    end

    _Connect["ClickTP"] = Player:GetMouse().Button1Down:Connect(function()
      if not Player:GetMouse().Target or Library.Unloaded then _Connect["ClickTP"]:Disconnect() return end

      if _SaveConfig["CTRL + Click to Teleport"] then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService.TouchEnabled then
          Player.Character:MoveTo(Player:GetMouse().Hit.p)
        end
      end
    end)
  end)
end

local _MoreFPS = Misc:AddSection("More FPS") do
  Funcs:Toggle(_MoreFPS, "Reduce Lag", "", "Save", function(Value)
    SaveManager:SetSave("Reduce Lag", Value)

    _spawn(function()
      if _SaveConfig["Reduce Lag"] then
        for _, v in pairs(Workspace:GetDescendants()) do
          if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
            v.Material = Enum.Material.SmoothPlastic
            if v:IsA("Texture") then
              v:Destroy()
            end
          end
        end
      end
    end)
  end)

  Funcs:Toggle(_MoreFPS, "Boost FPS", "", "Save", function(Value)
    SaveManager:SetSave("Boost FPS", Value)

    _spawn(function()
      if _SaveConfig["Boost FPS"] then
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
      end
    end)
  end)

  Funcs:Toggle(_MoreFPS, "Show Screen White", "", "Save", function(Value)
    SaveManager:SetSave("Show Screen White", Value)

    _spawn(function()
      if _SaveConfig["Show Screen White"] ~= nil then
        RunService:Set3dRenderingEnabled(not _SaveConfig["Show Screen White"])
      end
    end)
  end)

  Funcs:Toggle(_MoreFPS, "Show Screen Black", "", "Save", function(Value)
    SaveManager:SetSave("Show Screen Black", Value)

    _spawn(function()
      if _SaveConfig["Show Screen Black"] ~= nil then
        if _SaveConfig["Show Screen Black"] then
          Lighting.ExposureCompensation = -10
        else
          Lighting.ExposureCompensation = 0
        end
      end
    end)
  end)
end

local _Other = Misc:AddSection("Other") do
  Funcs:Toggle(_Other, "Full Bright", "", "Save", function(Value)
    SaveManager:SetSave("Full Bright", Value)

    _spawn(function()
      while _SaveConfig["Full Bright"] and not Library.Unloaded do task.wait()
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
      end
    end)
  end)
end

local _ResetConfig = Settings:AddSection("Reset Config") do
  Funcs:Button(_ResetConfig, "Reset Script Config", "", function()
    for _, v in next, {"Speed_Hub", "SpeedHubX", "Speed Hub X", "Speed Hub", "Speed_Hub_X"} do
      if isfolder(v) then
        delfolder(v)
      end
    end
  end)
end

local _Server = Settings:AddSection("Server") do
  Funcs:Textbox(_Server, "Job ID", "", "Save", function(Value)
    SaveManager:SetSave("Job ID", Value)
  end)

  Funcs:Button(_Server, "Join Job ID", "", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, _SaveConfig["Job ID"], Player)
  end)

  Funcs:Toggle(_Server, "Auto Reconnect", "", "Save", function(Value)
    SaveManager:SetSave("Auto Reconnect", Value)
  end)

  _spawn(function()
    game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v)
      if _SaveConfig["Auto Reconnect"] and not Library.Unloaded then
        if v.Name == "ErrorPrompt" and v:FindFirstChild("MessageArea") and v.MessageArea:FindFirstChild("ErrorFrame") then
          game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
        end
      end
    end)
  end)
end
