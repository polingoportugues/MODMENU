-- Speed Hack Adaptado para GUI
-- Este script funciona com a GUI e respeita o slider de velocidade
-- Criado por KDML

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- IMPORTANTE: Este script usa a variável global playerSpeedValue da GUI
-- Não define velocidade fixa, usa o valor do slider

local speedConnection = nil

-- Função para aplicar speed no personagem
local function aplicarSpeedGitHub(character)
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Verifica se playerSpeedValue existe (definido pela GUI)
    if not _G.playerSpeedValue then
        _G.playerSpeedValue = 16 -- Valor padrão se GUI não estiver carregada
    end
    
    -- Aplicar velocidade do slider
    humanoid.WalkSpeed = _G.playerSpeedValue
    print("✅ Speed GitHub aplicado: " .. _G.playerSpeedValue)
    
    -- Desconectar conexão anterior se existir
    if speedConnection then
        speedConnection:Disconnect()
    end
    
    -- Manter velocidade constantemente (respeita o toggle da GUI)
    speedConnection = RunService.Heartbeat:Connect(function()
        -- Verificar se o personagem ainda existe
        if not character.Parent or not humanoid.Parent then
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            return
        end
        
        -- Verificar se o toggle está ativo (se _G.speedToggleAtivo existir)
        if _G.speedToggleAtivo == false then
            -- Se toggle foi desativado, parar o loop
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            humanoid.WalkSpeed = 16 -- Restaurar velocidade normal
            return
        end
        
        -- Aplicar velocidade do slider se mudou
        if humanoid.WalkSpeed ~= _G.playerSpeedValue then
            humanoid.WalkSpeed = _G.playerSpeedValue
        end
    end)
    
    -- Limpar conexão quando morrer
    humanoid.Died:Connect(function()
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
    end)
end

-- Função global para desativar o speed (chamada pela GUI)
_G.desativarSpeedGitHub = function()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
    
    print("❌ Speed GitHub desativado")
end

-- Aplicar no personagem atual
if Player.Character then
    aplicarSpeedGitHub(Player.Character)
end

-- Aplicar em novos personagens (quando respawnar)
Player.CharacterAdded:Connect(function(character)
    -- Só aplicar se o toggle estiver ativo
    if _G.speedToggleAtivo ~= false then
        task.wait(0.2) -- Pequeno delay para garantir que o personagem carregou
        aplicarSpeedGitHub(character)
    end
end)

print("🚀 Speed Hack GitHub carregado e sincronizado com GUI!")
