getgenv().esplib = {
    box = { enabled = false, type = "normal", padding = 1.15, fill = Color3.new(1,1,1), outline = Color3.new(0,0,0) },
    healthbar = { enabled = false, fill = Color3.new(0,1,0), outline = Color3.new(0,0,0) },
    name = { enabled = false, fill = Color3.new(1,1,1), size = 13 },
    distance = { enabled = false, fill = Color3.new(1,1,1), size = 13 },
    tracer = { enabled = false, fill = Color3.new(1,1,1), outline = Color3.new(0,0,0), from = "bottom" },
}

getgenv().SyncAimbot = {
    Settings = { Enabled = false, TeamCheck = false, AliveCheck = true, WallCheck = false, LockPart = "Head", Sensitivity = 3.5, FOV = 100 },
    FOV = { Enabled = false, Visible = false, Radius = 100, Thickness = 1, Color = Color3.fromRGB(255,255,255) }
}

getgenv().TriggerBotSettings = { Enabled = false, TeamCheck = false }

getgenv().WeaponSettings = {
    InfAmmo = false,
    FastFire = false,
    InstaReload = false,
    NoSpread = false,
    NoRecoil = false,
    ForceAuto = false
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/chariacthus/yocutie/refs/heads/main/ui.luau"))()
local ESPLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tulontop/esp-lib.lua/refs/heads/main/source.lua"))()

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function SetupESP(plr)
    if plr ~= LocalPlayer then
        if plr.Character then
            ESPLib.add_box(plr.Character)
            ESPLib.add_healthbar(plr.Character)
            ESPLib.add_name(plr.Character)
            ESPLib.add_distance(plr.Character)
            ESPLib.add_tracer(plr.Character)
        end
        plr.CharacterAdded:Connect(function(character)
            ESPLib.add_box(character)
            ESPLib.add_healthbar(character)
            ESPLib.add_name(character)
            ESPLib.add_distance(character)
            ESPLib.add_tracer(character)
        end)
    end
end

for _, plr in ipairs(Players:GetPlayers()) do
    SetupESP(plr)
end
Players.PlayerAdded:Connect(SetupESP)

local HitboxManager = (function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local localPlayer = Players.LocalPlayer

    local config = {
        hitboxEnabled = false,
        hitboxSize = 10,
        hitboxExpandedParts = {},
        hitboxOriginalSizes = {},
        hitboxColor = Color3.fromRGB(255, 255, 255),
        ignoreForcefield = true,
        masterTeamTarget = "Enemies"
    }

    local function plralive(player)
        if not player or not player:IsA("Player") then return false end
        local char = player.Character
        if not char then return false end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        return humanoid.Health > 0
    end

    local function isTeammate(p)
        if localPlayer.Team and p.Team then
            return localPlayer.Team == p.Team
        end
        return false
    end

    local function targethb(player)
        if not player or player == localPlayer then return false end
        if not plralive(player) then return false end
        
        local char = player.Character
        if config.ignoreForcefield and char then
            for _, c in ipairs(char:GetChildren()) do
                if c:IsA("ForceField") then return false end
            end
        end

        if config.masterTeamTarget == "Enemies" then
            return not isTeammate(player)
        elseif config.masterTeamTarget == "Teams" then
            return isTeammate(player)
        elseif config.masterTeamTarget == "All" then
            return true
        end
        return false
    end

    local function restoreTorso(player)
        local original = config.hitboxOriginalSizes[player]
        if original and original.part then
            pcall(function()
                if original.part and original.part.Parent then
                    original.part.Size = original.size
                    original.part.Transparency = 0
                    original.part.CanCollide = true
                end
            end)
        end
        config.hitboxExpandedParts[player] = nil
        config.hitboxOriginalSizes[player] = nil
    end

    local function expandhb(player, size)
        if not config.hitboxEnabled then return end
        
        local char = player.Character
        if not char then return end
        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("HumanoidRootPart")
        if not torso then return end

        if not config.hitboxOriginalSizes[player] then
            config.hitboxOriginalSizes[player] = { part = torso, size = torso.Size }
        end

        local expansionSize = Vector3.new(size, size, size)
        
        config.hitboxExpandedParts[player] = true

        pcall(function()
            torso.Size = expansionSize
            torso.Transparency = 0.9
            torso.CanCollide = false
            torso.Massless = true
            torso.Color = config.hitboxColor
        end)
    end

    RunService.Heartbeat:Connect(function()
        if config.hitboxEnabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    if targethb(player) then
                        expandhb(player, config.hitboxSize)
                    else
                        if config.hitboxExpandedParts[player] then
                            restoreTorso(player)
                        end
                    end
                end
            end
        else
            for player, _ in pairs(config.hitboxExpandedParts) do
                restoreTorso(player)
            end
        end
    end)

    Players.PlayerRemoving:Connect(function(player)
        restoreTorso(player)
    end)

    return {
        toggle = function(enabled)
            config.hitboxEnabled = enabled
        end,
        setSize = function(size)
            config.hitboxSize = size
        end,
        setTeamTarget = function(mode)
            config.masterTeamTarget = mode
        end,
        setColor = function(color)
            config.hitboxColor = color
        end,
        setIgnoreForcefield = function(enabled)
            config.ignoreForcefield = enabled
        end
    }
end)()

local OriginalValues = {}
setmetatable(OriginalValues, {__mode = "k"})

task.spawn(function()
    local weapons = ReplicatedStorage:WaitForChild("Weapons")
    while true do
        for _, obj in ipairs(weapons:GetDescendants()) do
            if obj.Name == "Ammo" and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
                if getgenv().WeaponSettings.InfAmmo then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = 999
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            elseif (obj.Name == "FireRate" or obj.Name == "Firerate") and obj:IsA("NumberValue") then
                if getgenv().WeaponSettings.FastFire then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = 0.05
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            elseif obj.Name == "ReloadTime" and obj:IsA("NumberValue") then
                if getgenv().WeaponSettings.InstaReload then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = 0.1
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            elseif (obj.Name == "Spread" or obj.Name == "MaxSpread") and obj:IsA("NumberValue") then
                if getgenv().WeaponSettings.NoSpread then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = 0
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            elseif (obj.Name == "Recoil" or obj.Name == "RecoilControl") and obj:IsA("NumberValue") then
                if getgenv().WeaponSettings.NoRecoil then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = 0
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            elseif obj.Name == "Auto" and obj:IsA("BoolValue") then
                if getgenv().WeaponSettings.ForceAuto then
                    if OriginalValues[obj] == nil then OriginalValues[obj] = obj.Value end
                    obj.Value = true
                else
                    if OriginalValues[obj] ~= nil then
                        obj.Value = OriginalValues[obj]
                        OriginalValues[obj] = nil
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

local Circle = Drawing.new("Circle")
Circle.Thickness = 1
Circle.NumSides = 64
Circle.Filled = false
Circle.Transparency = 1

local function IsEnemy(p)
    if p.Team ~= LocalPlayer.Team then return true end
    if p.TeamColor ~= LocalPlayer.TeamColor then return true end
    return false
end

local function GetClosest()
    local best, dist = nil, getgenv().SyncAimbot.Settings.FOV
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(getgenv().SyncAimbot.Settings.LockPart) then
            if getgenv().SyncAimbot.Settings.TeamCheck and not IsEnemy(p) then continue end
            if getgenv().SyncAimbot.Settings.AliveCheck and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health <= 0 then continue end
            
            local part = p.Character[getgenv().SyncAimbot.Settings.LockPart]
            local pos, vis = Camera:WorldToViewportPoint(part.Position)
            
            if getgenv().SyncAimbot.Settings.WallCheck then
                local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Blacklist; params.FilterDescendantsInstances = {LocalPlayer.Character}
                local hit = workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
                if hit and not hit.Instance:IsDescendantOf(p.Character) then vis = false end
            end

            if vis then
                local mag = (UserInputService:GetMouseLocation() - Vector2.new(pos.X, pos.Y)).Magnitude
                if mag < dist then dist = mag; best = part end
            end
        end
    end
    return best
end

local _speedVal = 16
local _jumpVal = 50
local _infJump = false
local connections = {}

local MainLoop = RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if _speedVal > 16 then LocalPlayer.Character.Humanoid.WalkSpeed = _speedVal end
        if _jumpVal > 50 then LocalPlayer.Character.Humanoid.JumpPower = _jumpVal end
    end

    local s = getgenv().SyncAimbot.Settings
    local f = getgenv().SyncAimbot.FOV
    Circle.Position = UserInputService:GetMouseLocation()
    Circle.Radius = s.FOV
    Circle.Color = f.Color
    Circle.Visible = f.Enabled and f.Visible

    if s.Enabled then
        local target = GetClosest()
        if target then
            local pos = Camera:WorldToViewportPoint(target.Position)
            local mouse = UserInputService:GetMouseLocation()
            local relX = (pos.X - mouse.X) / s.Sensitivity
            local relY = (pos.Y - mouse.Y) / s.Sensitivity
            mousemoverel(relX, relY)
        end
    end

    if getgenv().TriggerBotSettings.Enabled then
        local target = Mouse.Target
        if target and target.Parent then
            local hum = target.Parent:FindFirstChildOfClass("Humanoid") or target.Parent.Parent:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local p = Players:GetPlayerFromCharacter(hum.Parent)
                local shoot = true
                
                if getgenv().TriggerBotSettings.TeamCheck and p then
                    if not IsEnemy(p) then shoot = false end
                end

                if shoot then mouse1press() else mouse1release() end
            else mouse1release() end
        else mouse1release() end
    end
end)
table.insert(connections, MainLoop)

local JumpConnection = UserInputService.JumpRequest:Connect(function()
    if _infJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
table.insert(connections, JumpConnection)

local Window = Library:Window({
    Title = "reborn",
    Desc = "BETA",
    Icon = 129135954720492,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.RightControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "reborn"
    }
})

local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 140, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
pcall(function() SidebarLine.Parent = game:GetService("CoreGui") end)

local Combat = Window:Tab({Title = "Combat", Icon = "swords"}) do
    Combat:Section({Title = "Aimbot"})
    Combat:Toggle({
        Title = "Enable Aimbot",
        Desc = "Locks onto enemies",
        Value = false,
        Callback = function(v) getgenv().SyncAimbot.Settings.Enabled = v end
    })
    Combat:Dropdown({
        Title = "Target Part",
        List = {"Head", "HumanoidRootPart", "UpperTorso"},
        Value = "Head",
        Callback = function(choice)
            getgenv().SyncAimbot.Settings.LockPart = choice
        end
    })
    Combat:Toggle({
        Title = "Team Check",
        Desc = "Ignore teammates",
        Value = false,
        Callback = function(v) getgenv().SyncAimbot.Settings.TeamCheck = v end
    })
    Combat:Toggle({
        Title = "Wall Check",
        Desc = "Visible check",
        Value = false,
        Callback = function(v) getgenv().SyncAimbot.Settings.WallCheck = v end
    })
    Combat:Section({Title = "FOV"})
    Combat:Toggle({
        Title = "Show FOV",
        Desc = "Draw circle",
        Value = false,
        Callback = function(v) 
            getgenv().SyncAimbot.FOV.Enabled = v 
            getgenv().SyncAimbot.FOV.Visible = v 
        end
    })
    Combat:Slider({
        Title = "FOV Radius",
        Min = 10,
        Max = 500,
        Rounding = 0,
        Value = 100,
        Callback = function(v) 
            getgenv().SyncAimbot.Settings.FOV = v 
            getgenv().SyncAimbot.FOV.Radius = v
        end
    })
    Combat:Section({Title = "Hitbox Expander"})
    Combat:Toggle({
        Title = "Enable Hitbox",
        Desc = "Expands enemy hitboxes",
        Value = false,
        Callback = function(v) HitboxManager.toggle(v) end
    })
    Combat:Slider({
        Title = "Hitbox Size",
        Min = 2,
        Max = 30,
        Rounding = 0,
        Value = 10,
        Callback = function(v) HitboxManager.setSize(v) end
    })
    Combat:Section({Title = "Triggerbot"})
    Combat:Toggle({
        Title = "Triggerbot",
        Desc = "Auto shoot",
        Value = false,
        Callback = function(v) getgenv().TriggerBotSettings.Enabled = v end
    })
    Combat:Toggle({
        Title = "TB Team Check",
        Desc = "Triggerbot ignores team",
        Value = false,
        Callback = function(v) getgenv().TriggerBotSettings.TeamCheck = v end
    })
end

local Visuals = Window:Tab({Title = "Visuals", Icon = "eye"}) do
    Visuals:Section({Title = "ESP"})
    Visuals:Toggle({
        Title = "Boxes",
        Desc = "Draw boxes",
        Value = false,
        Callback = function(v) getgenv().esplib.box.enabled = v end
    })
    Visuals:Toggle({
        Title = "Tracers",
        Desc = "Draw lines",
        Value = false,
        Callback = function(v) getgenv().esplib.tracer.enabled = v end
    })
    Visuals:Dropdown({
        Title = "Tracer Origin",
        List = {"mouse", "center", "bottom", "top", "head"},
        Value = "bottom",
        Callback = function(choice)
            getgenv().esplib.tracer.from = choice
        end
    })
    Visuals:Toggle({
        Title = "Names",
        Desc = "Show names",
        Value = false,
        Callback = function(v) getgenv().esplib.name.enabled = v end
    })
    Visuals:Toggle({
        Title = "Health Bar",
        Desc = "Show health",
        Value = false,
        Callback = function(v) getgenv().esplib.healthbar.enabled = v end
    })
    Visuals:Toggle({
        Title = "Distance",
        Desc = "Show distance",
        Value = false,
        Callback = function(v) getgenv().esplib.distance.enabled = v end
    })
end

local Weapon = Window:Tab({Title = "Weapon", Icon = "crosshair"}) do
    Weapon:Section({Title = "Mods"})
    Weapon:Toggle({
        Title = "Infinite Ammo",
        Desc = "Sets ammo to 999",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.InfAmmo = v end
    })
    Weapon:Toggle({
        Title = "Fast Fire Rate",
        Desc = "Sets firerate to 0.05",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.FastFire = v end
    })
    Weapon:Toggle({
        Title = "Instant Reload",
        Desc = "Sets reload to 0.1",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.InstaReload = v end
    })
    Weapon:Toggle({
        Title = "No Spread",
        Desc = "Removes spread",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.NoSpread = v end
    })
    Weapon:Toggle({
        Title = "No Recoil",
        Desc = "Removes recoil",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.NoRecoil = v end
    })
    Weapon:Toggle({
        Title = "Force Auto",
        Desc = "Makes guns automatic",
        Value = false,
        Callback = function(v) getgenv().WeaponSettings.ForceAuto = v end
    })
end

local Misc = Window:Tab({Title = "Misc", Icon = "component"}) do
    Misc:Section({Title = "Local Player"})
    Misc:Slider({
        Title = "Walk Speed",
        Min = 16,
        Max = 150,
        Rounding = 0,
        Value = 16,
        Callback = function(val) _speedVal = val end
    })
    Misc:Slider({
        Title = "Jump Power",
        Min = 50,
        Max = 200,
        Rounding = 0,
        Value = 50,
        Callback = function(val) _jumpVal = val end
    })
    Misc:Toggle({
        Title = "Infinite Jump",
        Desc = "Jump in mid-air",
        Value = false,
        Callback = function(state) _infJump = state end
    })
    Misc:Section({Title = "Server"})
    Misc:Button({
        Title = "Rejoin Server",
        Desc = "Reconnect to the game",
        Callback = function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    })
end

local Settings = Window:Tab({Title = "Settings", Icon = "wrench"}) do
    Settings:Section({Title = "Config"})
    Settings:Button({
        Title = "Copy Discord Link",
        Desc = "Copies invite",
        Callback = function()
            setclipboard("https://discord.gg/mx5baSY83z")
            Window:Notify({Title = "Success", Desc = "Copied!", Time = 3})
        end
    })
    Settings:Button({
        Title = "Unload UI",
        Desc = "Fully destroys the interface",
        Callback = function()
            if SidebarLine then SidebarLine:Destroy() end
            for _, v in pairs(game:GetService("CoreGui"):GetChildren()) do
                if v:IsA("ScreenGui") and v.Name == "reborn" then v:Destroy() end
            end
            for _, c in ipairs(connections) do c:Disconnect() end
            Circle:Remove()
        end
    })
end

Window:Notify({
    Title = "reborn",
    Desc = "Loaded Successfully",
    Time = 4
})