-- Speed Hack - Velocidade 10000
-- Aplica automaticamente sem GUI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local VELOCIDADE = 10000

-- Função para aplicar speed no personagem
local function aplicarSpeed(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = VELOCIDADE
        print(":white_check_mark: Speed aplicado: " .. VELOCIDADE)
        
        -- Manter velocidade constantemente
        local conexao
        conexao = RunService.Heartbeat:Connect(function()
            if not character.Parent or not humanoid.Parent then
                conexao:Disconnect()
                return
            end
            
            if humanoid.WalkSpeed ~= VELOCIDADE then
                humanoid.WalkSpeed = VELOCIDADE
            end
        end)
        
        -- Reconectar se morrer
        humanoid.Died:Connect(function()
            conexao:Disconnect()
        end)
    end
end

-- Aplicar no personagem atual
if Player.Character then
    aplicarSpeed(Player.Character)
end

-- Aplicar em novos personagens (quando respawnar)
Player.CharacterAdded:Connect(aplicarSpeed)

print(":rocket: Speed Hack ativado! Velocidade: " .. VELOCIDADE)
