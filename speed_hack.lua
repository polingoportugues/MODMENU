-- Speed Multiplier - Sistema de Multiplicador de Velocidade
-- Detecta a velocidade atual e multiplica por um valor configurável
-- Criado por KDML

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- IMPORTANTE: Este script usa variáveis globais da GUI
-- _G.speedMultiplier = multiplicador de velocidade (ex: 2, 5, 10, 100)
-- _G.speedToggleAtivo = se o multiplicador está ativo

local speedConnection = nil
local velocidadeBase = 16 -- Velocidade padrão do Roblox

-- Função para detectar a velocidade base real do jogo
local function detectarVelocidadeBase(humanoid)
    -- Tentar detectar a velocidade original do jogo
    -- Alguns jogos usam velocidades diferentes de 16
    local velocidadeAtual = humanoid.WalkSpeed
    
    -- Se a velocidade atual for muito alta (já multiplicada), usar padrão
    if velocidadeAtual > 50 then
        return 16
    end
    
    -- Caso contrário, usar a velocidade atual como base
    velocidadeBase = velocidadeAtual
    return velocidadeAtual
end

-- Função para aplicar multiplicador no personagem
local function aplicarMultiplicador(character)
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Verificar se multiplicador existe (definido pela GUI)
    if not _G.speedMultiplier then
        _G.speedMultiplier = 1 -- Multiplicador padrão (sem alteração)
    end
    
    -- Detectar velocidade base do jogo
    local velocidadeOriginal = detectarVelocidadeBase(humanoid)
    
    -- Calcular velocidade multiplicada
    local velocidadeMultiplicada = velocidadeOriginal * _G.speedMultiplier
    
    -- Aplicar velocidade multiplicada
    humanoid.WalkSpeed = velocidadeMultiplicada
    print("✅ Multiplicador aplicado: x" .. _G.speedMultiplier .. " | Velocidade: " .. velocidadeOriginal .. " → " .. velocidadeMultiplicada)
    
    -- Desconectar conexão anterior se existir
    if speedConnection then
        speedConnection:Disconnect()
    end
    
    -- Manter multiplicador constantemente ativo
    speedConnection = RunService.Heartbeat:Connect(function()
        -- Verificar se o personagem ainda existe
        if not character.Parent or not humanoid.Parent then
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            return
        end
        
        -- Verificar se o toggle está ativo
        if _G.speedToggleAtivo == false then
            -- Se toggle foi desativado, restaurar velocidade base
            if speedConnection then
                speedConnection:Disconnect()
                speedConnection = nil
            end
            humanoid.WalkSpeed = velocidadeBase
            print("⏹️ Multiplicador desativado - Velocidade restaurada para:", velocidadeBase)
            return
        end
        
        -- Recalcular velocidade multiplicada (caso o multiplicador tenha mudado)
        local novaVelocidade = velocidadeBase * _G.speedMultiplier
        
        -- Aplicar se mudou
        if humanoid.WalkSpeed ~= novaVelocidade then
            humanoid.WalkSpeed = novaVelocidade
            print("⚡ Velocidade atualizada: x" .. _G.speedMultiplier .. " = " .. novaVelocidade)
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

-- Função global para desativar o multiplicador (chamada pela GUI)
_G.desativarMultiplicadorGitHub = function()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("❌ Multiplicador GitHub desativado - Velocidade:", velocidadeBase)
        end
    end
end

-- Função global para atualizar velocidade base (chamada quando o jogo muda)
_G.atualizarVelocidadeBase = function(novaBase)
    velocidadeBase = novaBase
    print("🔄 Velocidade base atualizada para:", velocidadeBase)
end

-- Aplicar no personagem atual
if Player.Character then
    aplicarMultiplicador(Player.Character)
end

-- Aplicar em novos personagens (quando respawnar)
Player.CharacterAdded:Connect(function(character)
    -- Só aplicar se o toggle estiver ativo
    if _G.speedToggleAtivo ~= false then
        task.wait(0.2) -- Pequeno delay para garantir que o personagem carregou
        aplicarMultiplicador(character)
    end
end)

print("🚀 Speed Multiplier GitHub carregado e sincronizado com GUI!")
print("📊 Sistema de multiplicador ativo - Detecta velocidade base automaticamente")
