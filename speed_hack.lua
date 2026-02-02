-- Speed Multiplier - Sistema de Multiplicador de Velocidade
-- Detecta a velocidade atual e multiplica por um valor configurável
-- Criado por KDML
-- VERSÃO CORRIGIDA: Não cria loop próprio, sincroniza com GUI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- IMPORTANTE: Este script usa variáveis globais da GUI
-- _G.speedMultiplier = multiplicador de velocidade (ex: 2, 5, 10, 100)
-- _G.speedToggleAtivo = se o multiplicador está ativo

local velocidadeBase = 16 -- Velocidade padrão do Roblox

-- Função para detectar a velocidade base real do jogo
local function detectarVelocidadeBase(humanoid)
    if not humanoid then return 16 end
    
    -- Tentar detectar a velocidade original do jogo
    local velocidadeAtual = humanoid.WalkSpeed
    
    -- Se a velocidade atual for muito alta (já multiplicada), usar padrão
    if velocidadeAtual > 50 then
        return 16
    end
    
    -- Caso contrário, usar a velocidade atual como base
    velocidadeBase = velocidadeAtual
    return velocidadeAtual
end

-- Função para aplicar multiplicador no personagem (CHAMADA PELA GUI)
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
    
    -- NÃO CRIAR LOOP AQUI - A GUI JÁ TEM UM LOOP ATIVO
    -- Isso evita conflito entre os dois sistemas
end

-- Função global para desativar o multiplicador (chamada pela GUI)
_G.desativarMultiplicadorGitHub = function()
    print("🔄 Restaurando velocidade base do GitHub...")
    
    -- Apenas restaurar a velocidade base
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("✅ Velocidade restaurada para:", velocidadeBase)
        end
    end
    
    print("❌ Multiplicador GitHub desativado")
end

-- Função global para atualizar velocidade base (chamada quando o jogo muda)
_G.atualizarVelocidadeBase = function(novaBase)
    velocidadeBase = novaBase
    print("🔄 Velocidade base atualizada para:", velocidadeBase)
end

-- Função global para detectar e retornar velocidade base (usada pela GUI)
_G.detectarVelocidadeBaseGitHub = function()
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local velocidade = detectarVelocidadeBase(humanoid)
            print("🔍 Velocidade base detectada:", velocidade)
            return velocidade
        end
    end
    return 16
end

-- NÃO aplicar automaticamente - deixar a GUI controlar
-- A GUI já tem um loop Heartbeat que controla a velocidade

-- Apenas sincronizar evento de respawn
Player.CharacterAdded:Connect(function(character)
    task.wait(0.2)
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Detectar velocidade base do novo personagem
    detectarVelocidadeBase(humanoid)
    
    -- Se toggle estiver ativo, a GUI vai reaplicar automaticamente
    -- Se toggle estiver desativado, garantir velocidade base
    if _G.speedToggleAtivo == false then
        humanoid.WalkSpeed = velocidadeBase
        print("✅ Novo personagem spawnou com velocidade base:", velocidadeBase)
    else
        print("ℹ️ Toggle ativo - GUI vai aplicar multiplicador")
    end
end)

print("🚀 Speed Multiplier GitHub carregado (Modo sincronizado com GUI)")
print("📊 Sistema preparado - Loop controlado pela GUI")
print("⚙️ Este script apenas fornece funções auxiliares e detecção de velocidade base")
