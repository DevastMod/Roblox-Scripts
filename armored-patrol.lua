-- Get the UserInputService
local userInputService = game:GetService("UserInputService")

-- Variables to keep track of input state
local isQDown = false
local clickDelay = 0.15
local lastClickTime = 0

-- Function to handle user input for Q key
local function onUserInput(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Q then
        if input.UserInputState == Enum.UserInputState.Begin then
            isQDown = true
        elseif input.UserInputState == Enum.UserInputState.End then
            isQDown = false
        end
    end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.K then
        -- Get the local player
        local player = game:GetService("Players").LocalPlayer

        -- Get the C4, RPG, and Rifle tools from the player's backpack
        local c4 = player.Backpack:FindFirstChild("C4")
        local rpg = player.Backpack:FindFirstChild("RPG")
        --local rifle = player.Backpack:FindFirstChild("Rifle")
        local grenade = player.Backpack:FindFirstChild("Grenade")
        local dynamite = player.Backpack:FindFirstChild("Dynamite")

        -- Move the tools to the workspace
        if c4 then
            c4.Parent = game:GetService("Workspace")[player.Name]
        end

        if rpg then
            rpg.Parent = game:GetService("Workspace")[player.Name]
        end

        --if rifle then
        --    rifle.Parent = game:GetService("Workspace")[player.Name]
        --end

        if grenade then
            grenade.Parent = game:GetService("Workspace")[player.Name]
        end

        if dynamite then
            dynamite.Parent = game:GetService("Workspace")[player.Name]
        end

    end
end


local function bringcrate()
    -- Get the local player
    local player = game:GetService("Players").LocalPlayer

    -- Define the part name to search for
    local partName = "Cache"

    -- Search for the part and its children in ManagedObjects
    local part = game:GetService("Workspace").ManagedObjects:FindFirstChild(partName, true)
    if not part then
        print("Error: Part not found")
        return
    end

    -- Teleport the part and its children to the player
    local rootPart = part:FindFirstChild("HumanoidRootPart", true)
    if rootPart then
        rootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    else
        part.CFrame = player.Character.HumanoidRootPart.CFrame
    end
end

-- Bind the onUserInput function to the UserInputService
userInputService.InputBegan:Connect(onUserInput)
userInputService.InputEnded:Connect(onUserInput)


-- Loop to simulate mouse click when Q is held down
game:GetService("RunService").Heartbeat:Connect(function()
    if isQDown then
        local currentTime = os.clock()
        if currentTime - lastClickTime >= clickDelay then
            mouse1click()
            bringcrate()
            lastClickTime = currentTime
        end
    end
end)
