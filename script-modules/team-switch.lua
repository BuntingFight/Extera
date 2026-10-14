local players = game:GetService("Players")
local pgui = players.LocalPlayer:WaitForChild("PlayerGui")

function firebtn(button, signalName)
    if not button or not button:IsA("GuiButton") then return false end

    if typeof(firesignal) ~= "function" then
        warn("firesignal is not existed in your executor")
        return false
    end

    local ok, err = pcall(function()
        if signalName == "All" then
            firesignal(button.MouseButton1Down)
            firesignal(button.MouseButton1Click)
            firesignal(button.Activated)
        elseif signalName == "Down" then
            firesignal(button.MouseButton1Down)
        elseif signalName == "Click" then
            firesignal(button.MouseButton1Click)
        elseif signalName == "Activated" then
            firesignal(button.Activated)
        end
    end)

    if not ok then warn(err)
        return false
    end

    return true
end

local function findTeamBtn(teamName, timeout)
    local deadline = os.clock() + timeout

    repeat
        local matches = {}
        local seen = {}

        for _, obj in ipairs(pgui:GetDescendants()) do
            if obj.Name == teamName and obj:IsA("GuiButton")
                and obj.Visible and obj.Active then

                local excluded = false
                local parent = obj

                while parent and parent ~= pgui do
                    if parent.Name == "ContractsGui"
                        or parent.Name == "Mission" then
                        excluded = true
                        break
                    end

                    parent = parent.Parent
                end

                if not excluded and not seen[obj] then
                    seen[obj] = true
                    table.insert(matches, obj)
                end
            end
        end

        if #matches == 1 then return matches[1]
        elseif #matches > 1 then

            for _, obj in ipairs(matches) do warn(obj:GetFullName()) end

            return nil
        end

        task.wait(0.15) until os.clock() >= deadline
    return nil
end

local function tsCheck()
    local criminal = findTeamBtn("Criminal", 0.5)
    local police = findTeamBtn("Police", 0.5)

    return criminal ~= nil or police ~= nil
end

local function ts(team)
    if team ~= "Criminal" and team ~= "Police" then return false end

    if not tsCheck() then
        local tsGui = pgui:WaitForChild("AppUI"):WaitForChild("Buttons"):WaitForChild("Sidebar"):WaitForChild("TeamSwitch"):WaitForChild("TeamSwitch")

        if not firebtn(tsGui, "All") then return false end

        local deadline = os.clock() + 10
        local gui

        repeat
            gui = pgui:FindFirstChild("ConfirmationGui")
            if gui and gui.Enabled then break end
            task.wait(0.1) until os.clock() >= deadline

        if not gui or not gui.Enabled then return false end

        local yesButton = gui:WaitForChild("Confirmation"):WaitForChild("Background"):WaitForChild("ContainerButtons"):WaitForChild("ContainerYes"):WaitForChild("Button")

        if not firebtn(yesButton, "Down") then return false end

        deadline = os.clock() + 10

        repeat if not gui.Parent or not gui.Enabled then break end

            task.wait(0.1) until os.clock() >= deadline
        task.wait(0.3)
    else end

    local teamButton = findTeamBtn(team, 5)

    if not teamButton then return false end

    return firebtn(teamButton, "All")
end

-- ts("Criminal")
-- ts("Police")
