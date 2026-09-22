local players = game:GetService("Players")

for _, v in ipairs(game:GetDescendants()) do
    if v:IsA("Humanoid") then
        local m = v.Parent

        if m and m:IsA("Model") and m.Name ~= "ActiveBoss" and not players:GetPlayerFromCharacter(m) then
            v.Health = 0

            v.HealthChanged:Connect(function(h)
                if h > 0 then
                    v.Health = 0
                end
            end)
        end
    end
end

game.DescendantAdded:Connect(function(v)
    if v:IsA("Humanoid") then
        task.defer(function()
            local m = v.Parent

            if m and m:IsA("Model") and m.Name ~= "ActiveBoss" and not players:GetPlayerFromCharacter(m) then
                v.Health = 0

                v.HealthChanged:Connect(function(h)
                    if h > 0 then
                        v.Health = 0
                    end
                end)
            end
        end)
    end
end)
