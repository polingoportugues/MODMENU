-- ============================================
-- ANXIIE SCRIPTS - UNIVERSAL SPEED HACK
-- Funciona em TODOS os jogos do Roblox
-- Controlado pela GUI via variáveis globais
-- ============================================

print("🚀 Iniciando ANXIIE Universal Speed Hack...")
print("📡 Este script é controlado pela GUI Interface")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ========================================
-- VARIÁVEIS GLOBAIS (Comunicação com GUI)
-- ========================================

_G.speedToggleAtivo = _G.speedToggleAtivo or false
_G.speedMultiplier = _G.speedMultiplier or 1
_G.velocidadeBaseDetectada = 16

-- ========================================
-- CONFIGURAÇÃO
-- ========================================

local speedAtivo = false
local conexaoSpeed = nil
local conexaoVelocity = nil
local velocidadeOriginal = 16

-- Detectar velocidade original do personagem
local function detectarVelocidadeOriginal()
    if humanoid then
        velocidadeOriginal = humanoid.WalkSpeed
        if velocidadeOriginal > 100 then
            velocidadeOriginal = 16 -- Resetar se já estiver modificado
        end
        print("🔍 Velocidade original detectada:", velocidadeOriginal)
        _G.velocidadeBaseDetectada = velocidadeOriginal
    end
end

-- Chamar ao iniciar
detectarVelocidadeOriginal()

-- ========================================
-- MÉTODO 1: MODIFICAÇÃO DE WALKSPEED
-- ========================================

local function aplicarWalkSpeed()
    if not humanoid or not humanoid.Parent then
        return
    end
    
    if speedAtivo then
        local novaVelocidade = velocidadeOriginal * _G.speedMultiplier
        if humanoid.WalkSpeed ~= novaVelocidade then
            humanoid.WalkSpeed = novaVelocidade
        end
    else
        if humanoid.WalkSpeed ~= velocidadeOriginal then
            humanoid.WalkSpeed = velocidadeOriginal
        end
    end
end

-- ========================================
-- MÉTODO 2: MODIFICAÇÃO DE VELOCITY (CFrame)
-- Funciona em jogos que bloqueiam WalkSpeed
-- ========================================

local function aplicarVelocityBoost()
    if not rootPart or not rootPart.Parent or not humanoid or not humanoid.Parent then
        return
    end
    
    if not speedAtivo then
        return
    end
    
    -- Só aplicar boost se o jogador estiver se movendo
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        local velocityMultiplier = _G.speedMultiplier
        
        -- Calcular velocidade baseada na direção do movimento
        local currentVelocity = rootPart.AssemblyLinearVelocity
        local targetVelocity = moveDirection * velocidadeOriginal * velocityMultiplier
        
        -- Manter velocidade vertical (Y) original para não afetar pulos
        targetVelocity = Vector3.new(targetVelocity.X, currentVelocity.Y, targetVelocity.Z)
        
        -- Aplicar velocidade suavemente
        rootPart.AssemblyLinearVelocity = targetVelocity
    end
end

-- ========================================
-- MÉTODO 3: PROTEÇÃO CONTRA RESET
-- ========================================

local function protegerWalkSpeed()
    if not humanoid then return end
    
    -- Monitorar mudanças no WalkSpeed
    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if speedAtivo then
            task.wait(0.05)
            aplicarWalkSpeed()
        end
    end)
end

-- ========================================
-- SISTEMA DE MONITORAMENTO CONTÍNUO
-- ========================================

local function iniciarMonitoramento()
    if conexaoSpeed then
        conexaoSpeed:Disconnect()
    end
    if conexaoVelocity then
        conexaoVelocity:Disconnect()
    end
    
    print("🔄 Iniciando monitoramento de velocidade...")
    
    -- Método 1: Modificar WalkSpeed constantemente
    conexaoSpeed = RunService.Heartbeat:Connect(function()
        if speedAtivo and humanoid and humanoid.Parent then
            aplicarWalkSpeed()
        end
    end)
    
    -- Método 2: Modificar Velocity para jogos que bloqueiam WalkSpeed
    conexaoVelocity = RunService.Heartbeat:Connect(function()
        if speedAtivo and rootPart and rootPart.Parent then
            aplicarVelocityBoost()
        end
    end)
    
    -- Método 3: Proteção contra reset
    protegerWalkSpeed()
    
    print("✅ Monitoramento de velocidade ativo (3 métodos)")
end

local function pararMonitoramento()
    if conexaoSpeed then
        conexaoSpeed:Disconnect()
        conexaoSpeed = nil
    end
    if conexaoVelocity then
        conexaoVelocity:Disconnect()
        conexaoVelocity = nil
    end
    print("⏹️ Monitoramento de velocidade parado")
end

-- ========================================
-- FUNÇÕES GLOBAIS PARA A GUI
-- ========================================

function _G.ativarMultiplicadorGitHub()
    print("🟢 Ativando Speed Multiplier...")
    speedAtivo = true
    
    -- Detectar velocidade original novamente
    detectarVelocidadeOriginal()
    
    -- Aplicar imediatamente
    aplicarWalkSpeed()
    
    -- Iniciar monitoramento
    iniciarMonitoramento()
    
    print("✅ Speed Multiplier ATIVADO - x" .. _G.speedMultiplier)
    print("🎯 Usando 3 métodos simultâneos para máxima compatibilidade")
end

function _G.desativarMultiplicadorGitHub()
    print("🔴 Desativando Speed Multiplier...")
    speedAtivo = false
    
    -- Parar monitoramento
    pararMonitoramento()
    
    -- Restaurar velocidade original
    if humanoid and humanoid.Parent then
        humanoid.WalkSpeed = velocidadeOriginal
        print("✅ Velocidade restaurada para valor original:", velocidadeOriginal)
    end
    
    -- Limpar velocity boost
    if rootPart and rootPart.Parent then
        local currentVelocity = rootPart.AssemblyLinearVelocity
        rootPart.AssemblyLinearVelocity = Vector3.new(0, currentVelocity.Y, 0)
    end
    
    print("✅ Speed Multiplier DESATIVADO")
end

function _G.atualizarMultiplicadorGitHub(novoMultiplicador)
    print("📊 Atualizando Speed Multiplier de x" .. _G.speedMultiplier .. " para x" .. novoMultiplicador)
    
    _G.speedMultiplier = novoMultiplicador
    
    -- Se estiver ativo, aplicar imediatamente
    if speedAtivo then
        aplicarWalkSpeed()
        print("✅ Novo Speed Multiplier aplicado: x" .. novoMultiplicador)
    end
end

function _G.detectarVelocidadeBaseGitHub()
    detectarVelocidadeOriginal()
    return velocidadeOriginal
end

function _G.atualizarVelocidadeBase(novaBase)
    velocidadeOriginal = novaBase
    _G.velocidadeBaseDetectada = novaBase
    print("🔄 Velocidade base atualizada para: " .. velocidadeOriginal)
end

-- ========================================
-- EVENTOS DE PERSONAGEM
-- ========================================

-- Reconectar quando o personagem for recarregado
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    print("🔄 Novo personagem detectado, redetectando velocidade original...")
    detectarVelocidadeOriginal()
    
    -- Se estava ativo, reativar
    if speedAtivo then
        task.wait(1) -- Esperar o personagem carregar completamente
        print("🔄 Reativando Speed Multiplier após respawn...")
        iniciarMonitoramento()
        aplicarWalkSpeed()
    end
end)

-- ========================================
-- PROTEÇÃO ADICIONAL CONTRA ANTI-CHEAT
-- ========================================

-- Alguns jogos detectam mudanças muito rápidas
local lastSpeedChange = tick()
local function podeMudarVelocidade()
    local now = tick()
    if now - lastSpeedChange > 0.1 then -- Cooldown de 0.1 segundos
        lastSpeedChange = now
        return true
    end
    return false
end

-- ========================================
-- AUTO-ATIVAÇÃO SE GUI JÁ ESTAVA ATIVA
-- ========================================

-- Se a GUI já estava com o toggle ativo quando este script foi carregado
if _G.speedToggleAtivo then
    print("🔄 GUI já estava ativa, ativando Speed Multiplier...")
    task.wait(1)
    _G.ativarMultiplicadorGitHub()
end

-- ========================================
-- INICIALIZAÇÃO COMPLETA
-- ========================================

print("✅ ANXIIE Universal Speed Hack carregado com sucesso!")
print("📊 Velocidade Base:", velocidadeOriginal)
print("📊 Multiplicador atual: x" .. _G.speedMultiplier)
print("🎮 Status: " .. (speedAtivo and "ATIVO" or "INATIVO"))
print("💡 Use a GUI para controlar a velocidade")
print("🎯 Usando 3 métodos para funcionar em TODOS os jogos:")
print("   ✓ Método 1: WalkSpeed modification")
print("   ✓ Método 2: Velocity/CFrame boost")
print("   ✓ Método 3: Anti-reset protection")
print("")
print("Funções disponíveis:")
print("  _G.ativarMultiplicadorGitHub()")
print("  _G.desativarMultiplicadorGitHub()")
print("  _G.atualizarMultiplicadorGitHub(multiplicador)")
print("  _G.detectarVelocidadeBaseGitHub()")
print("  _G.atualizarVelocidadeBase(valor)")
