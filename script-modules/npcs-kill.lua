local players = game:GetService("Players")
local rs = game:GetService("ReplicatedStorage")

local NPCUtils = require(rs.NPC.NPCUtils)

for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("Humanoid") then
        local model = v.Parent
        if model and model:IsA("Model") and model.Name ~= "ActiveBoss" and not players:GetPlayerFromCharacter(model) then
            if not v:GetAttribute("IsProcessed") then
                v:SetAttribute("IsProcessed", true)
                v.Health = 0

                v.HealthChanged:Connect(function(h)
                    if h > 0 then
                        v.Health = 0
                    end
                end)

                if NPCUtils then
                    pcall(function()
                        NPCUtils.setTarget(model, nil)
                        NPCUtils.setLookAt(model, nil)
                    end)
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Humanoid") then
        task.defer(function()
            local model = v.Parent
            if model and model:IsA("Model") and model.Name ~= "ActiveBoss" and not players:GetPlayerFromCharacter(model) then
                if not v:GetAttribute("IsProcessed") then
                    v:SetAttribute("IsProcessed", true)
                    v.Health = 0

                    v.HealthChanged:Connect(function(h)
                        if h > 0 then
                            v.Health = 0
                        end
                    end)

                    if NPCUtils then
                        pcall(function()
                            NPCUtils.setTarget(model, nil)
                            NPCUtils.setLookAt(model, nil)
                        end)
                    end
                end
            end
        end)
    end
end)
