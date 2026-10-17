local players = game:GetService("Players")

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

                local rootPart = model:FindFirstChild("HumanoidRootPart")
                    or model:FindFirstChild("Torso")
                    or model:FindFirstChild("UpperTorso")

                if rootPart then
                    rootPart.Anchored = true
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

                    local rootPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso")

                    if rootPart then
                        rootPart.Anchored = true
                    end
                end
            end
        end)
    end
end)
