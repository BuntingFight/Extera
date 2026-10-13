local players = game:GetService("Players")
local cgui = game:GetService("CoreGui")
local player = players.LocalPlayer

task.spawn(function()
    local pgui = cgui:WaitForChild("RobloxPromptGui")
    local overlay = pgui:WaitForChild("promptOverlay")

    local prompt = overlay:WaitForChild("ErrorPrompt", 5)
    if not prompt then return end

    local title = prompt:WaitForChild("TitleFrame", 3)
    local msg = prompt:WaitForChild("MessageArea", 3)

    if title and msg then
        local title = title:WaitForChild("ErrorTitle", 3)
        local error = msg:WaitForChild("ErrorFrame", 3)
        local message = error and error:WaitForChild("ErrorMessage", 3)

        if title then title.Text = "Extera Tools" end

        if message then
            message.Text = "The script maybe unavailable. Check status on the Discord server or uptime.getextera.xyz."
        end
    end
end)

player:Kick("The script maybe unavailable. Check status on the Discord server or uptime.getextera.xyz.")
