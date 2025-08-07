-- Credits To The LegionX Owner
getgenv().Config = {
    Invite = "LX.HUB",
    Version = "0.0",
}

getgenv().luaguardvars = {
    DiscordName = "LX.OWNER",
}

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Legendbattlehero/buildaboatgui/refs/heads/main/gui.lua"))()

library:init() -- Initializes Library (Do Not Delete)

local Window = library.NewWindow({
    title = "LegionX | Auto Farm",
    size = UDim2.new(0, 525, 0, 650)
})

local tabs = {
    Main = Window:AddTab("Main"),
    Settings = library:CreateSettingsTab(Window),
}

local sections = {
    AutoFarm = tabs.Main:AddSection("Auto Farm", 1),
    Player = tabs.Main:AddSection("Player", 2),
}

-- Auto Farm Variables
local autoFarming = false
local flySpeed = 390.45
local flyDuration = 21
local centerPosition = Vector3.new(0, 100, 0)
local chestPosition = Vector3.new(15, -5, 9495)
local bodyVelocity
local player = game.Players.LocalPlayer
local antiAFKEnabled = false

-- Player Modifiers
local currentWalkSpeed = 16
local currentJumpPower = 50

-- Core Functions
function startAntiAFK()
    spawn(function()
        while antiAFKEnabled do
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, math.random(-1, 1))
            end
            wait(2)
        end
    end)
end

function startAutoFarm()
    spawn(function()
        while autoFarming do
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if hrp and humanoid then
                -- Apply speed/jump if modified
                humanoid.WalkSpeed = currentWalkSpeed
                humanoid.JumpPower = currentJumpPower

                -- Teleport and fly
                hrp.CFrame = CFrame.new(centerPosition)
                enableNoclip(character)
                
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                bodyVelocity.Velocity = Vector3.new(0, 0, flySpeed)
                bodyVelocity.Parent = hrp

                wait(flyDuration)
                
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end

                -- Finish cycle
                hrp.CFrame = CFrame.new(chestPosition)
                character:BreakJoints()
                wait(9)
            end
        end
    end)
end

function stopFlying()
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
end

function teleportToTeamBase()
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(0, 10, 0)
    end
end

function enableNoclip(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

-- GUI Elements
sections.AutoFarm:AddToggle({
    text = "Auto Farm",
    flag = "AutoFarm_Toggle",
    risky = false,
    callback = function(state)
        autoFarming = state
        if state then
            startAutoFarm()
            library:SendNotification("Auto Farm Enabled", 3, Color3.new(0, 255, 0))
        else
            stopFlying()
            teleportToTeamBase()
            library:SendNotification("Auto Farm Disabled", 3, Color3.new(255, 0, 0))
        end
    end
})

sections.AutoFarm:AddToggle({
    text = "Anti-AFK",
    flag = "AntiAFK_Toggle",
    risky = false,
    callback = function(state)
        antiAFKEnabled = state
        if state then
            startAntiAFK()
        end
    end
})

sections.AutoFarm:AddSlider({
    text = "Fly Speed", 
    flag = 'FlySpeed_Slider', 
    suffix = "km/h", 
    value = 390.45,
    min = 100, 
    max = 1000,
    increment = 0.1,
    callback = function(v) 
        flySpeed = v
    end
})

sections.AutoFarm:AddSlider({
    text = "Fly Duration", 
    flag = 'FlyDuration_Slider', 
    suffix = "sec", 
    value = 21,
    min = 5, 
    max = 60,
    increment = 1,
    callback = function(v) 
        flyDuration = v
    end
})

sections.Player:AddSlider({
    text = "Walk Speed", 
    flag = 'WalkSpeed_Slider', 
    suffix = "studs", 
    value = 16,
    min = 16, 
    max = 200,
    increment = 1,
    callback = function(v) 
        currentWalkSpeed = v
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = v
            end
        end
    end
})

sections.Player:AddSlider({
    text = "Jump Power", 
    flag = 'JumpPower_Slider', 
    suffix = "studs", 
    value = 50,
    min = 50, 
    max = 200,
    increment = 1,
    callback = function(v) 
        currentJumpPower = v
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = v
            end
        end
    end
})

sections.Player:AddButton({
    text = "Reset Character",
    callback = function()
        player.Character:BreakJoints()
        library:SendNotification("Character Reset", 3, Color3.new(255, 255, 0))
    end
})

library:SendNotification("Legion.X Loaded", 5, Color3.new(0, 170, 255))
