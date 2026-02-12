-- Speed Multiplier System - GitHub Version
-- Sistema completo de multiplicador de velocidade
-- ============================================
-- ANXIIE SCRIPTS - UNIVERSAL SPEED HACK
-- Funciona em TODOS os jogos do Roblox
-- Controlado pela GUI via variáveis globais
-- Criado por KDML
-- ============================================

print("🚀 Iniciando ANXIIE Universal Speed Hack...")
print("📡 Este script é controlado pela GUI Interface")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

print("🚀 Iniciando Speed Multiplier System do GitHub...")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ========================================
-- VARIÁVEIS DE CONTROLE
-- VARIÁVEIS GLOBAIS (Comunicação com GUI)
-- ========================================

local speedConnection = nil
local velocidadeBase = 16
local sistemaAtivo = false
_G.speedToggleAtivo = _G.speedToggleAtivo or false
_G.speedMultiplier = _G.speedMultiplier or 1
_G.velocidadeBaseDetectada = 16

-- ========================================
-- DETECÇÃO DE VELOCIDADE BASE
-- CONFIGURAÇÃO
-- ========================================

local function detectarVelocidadeBase()
    local character = Player.Character
    if not character then return 16 end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return 16 end
    
    local velocidadeAtual = humanoid.WalkSpeed
    
    -- Se velocidade for muito alta (já modificada), retornar padrão
    if velocidadeAtual > 50 then
        print("⚠️ Velocidade atual muito alta (" .. velocidadeAtual .. "), usando padrão: 16")
        return 16
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
    
    -- Caso contrário, usar velocidade atual como base
    velocidadeBase = velocidadeAtual
    _G.velocidadeBaseDetectada = velocidadeAtual
    print("🔍 Velocidade base detectada: " .. velocidadeAtual)
    return velocidadeAtual
end

-- Chamar ao iniciar
detectarVelocidadeOriginal()

-- ========================================
-- SISTEMA DE MULTIPLICADOR
-- MÉTODO 1: MODIFICAÇÃO DE WALKSPEED
-- ========================================

local function iniciarSistema()
    if sistemaAtivo then
        print("⚠️ Sistema já está ativo!")
local function aplicarWalkSpeed()
    if not humanoid or not humanoid.Parent then
        return
    end

    sistemaAtivo = true
    print("✅ Sistema de multiplicador INICIADO")
    
    -- Desconectar conexão anterior se existir
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
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

    -- Detectar velocidade base
    detectarVelocidadeBase()
    if not speedAtivo then
        return
    end

    -- Criar loop de controle
    speedConnection = RunService.Heartbeat:Connect(function()
        local character = Player.Character
        if not character then return end
    -- Só aplicar boost se o jogador estiver se movendo
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        local velocityMultiplier = _G.speedMultiplier

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        -- Calcular velocidade baseada na direção do movimento
        local currentVelocity = rootPart.AssemblyLinearVelocity
        local targetVelocity = moveDirection * velocidadeOriginal * velocityMultiplier

        -- Verificar se toggle está ativo (via variável global da GUI)
        if _G.speedToggleAtivo then
            -- Toggle ATIVADO: Aplicar multiplicador
            local multiplicador = _G.speedMultiplier or 1
            local velocidadeEsperada = velocidadeBase * multiplicador
            
            -- Aplicar velocidade multiplicada
            if humanoid.WalkSpeed ~= velocidadeEsperada then
                humanoid.WalkSpeed = velocidadeEsperada
            end
        else
            -- Toggle DESATIVADO: Manter velocidade base
            if humanoid.WalkSpeed ~= velocidadeBase then
                humanoid.WalkSpeed = velocidadeBase
            end
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
    
    print("🔄 Loop de controle ativo - Monitorando velocidade continuamente")
end

local function pararSistema()
    if not sistemaAtivo then
        print("⚠️ Sistema já está parado!")
        return
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

    sistemaAtivo = false
    print("⏹️ Parando sistema de multiplicador...")
    print("🔄 Iniciando monitoramento de velocidade...")

    -- Desconectar loop
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
        print("🔌 Loop de controle desconectado")
    end
    -- Método 1: Modificar WalkSpeed constantemente
    conexaoSpeed = RunService.Heartbeat:Connect(function()
        if speedAtivo and humanoid and humanoid.Parent then
            aplicarWalkSpeed()
        end
    end)

    -- Restaurar velocidade base
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("✅ Velocidade restaurada para: " .. velocidadeBase)
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
-- FUNÇÕES GLOBAIS (Comunicação com GUI)
-- FUNÇÕES GLOBAIS PARA A GUI
-- ========================================

-- Função para ATIVAR multiplicador (chamada pela GUI)
_G.ativarMultiplicadorGitHub = function()
    print("📡 GUI solicitou ATIVAÇÃO do multiplicador")
function _G.ativarMultiplicadorGitHub()
    print("🟢 Ativando Speed Multiplier...")
    speedAtivo = true

    if not sistemaAtivo then
        iniciarSistema()
    end
    -- Detectar velocidade original novamente
    detectarVelocidadeOriginal()

    -- Aplicar multiplicador imediatamente
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local multiplicador = _G.speedMultiplier or 1
            local velocidadeFinal = velocidadeBase * multiplicador
            humanoid.WalkSpeed = velocidadeFinal
            print("✅ Multiplicador aplicado: " .. velocidadeBase .. " x" .. multiplicador .. " = " .. velocidadeFinal)
        end
    end
    -- Aplicar imediatamente
    aplicarWalkSpeed()
    
    -- Iniciar monitoramento
    iniciarMonitoramento()
    
    print("✅ Speed Multiplier ATIVADO - x" .. _G.speedMultiplier)
    print("🎯 Usando 3 métodos simultâneos para máxima compatibilidade")
end

-- Função para DESATIVAR multiplicador (chamada pela GUI)
_G.desativarMultiplicadorGitHub = function()
    print("📡 GUI solicitou DESATIVAÇÃO do multiplicador")
function _G.desativarMultiplicadorGitHub()
    print("🔴 Desativando Speed Multiplier...")
    speedAtivo = false

    -- NÃO PARAR O SISTEMA - apenas marcar toggle como false
    -- O loop continua rodando e vai manter a velocidade base
    -- Parar monitoramento
    pararMonitoramento()

    -- Restaurar velocidade base IMEDIATAMENTE
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("✅ Velocidade restaurada para: " .. velocidadeBase)
        end
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

-- Função para ATUALIZAR multiplicador (chamada pela GUI quando slider muda)
_G.atualizarMultiplicadorGitHub = function(novoMultiplicador)
    print("📡 GUI atualizou multiplicador para: x" .. novoMultiplicador)
function _G.atualizarMultiplicadorGitHub(novoMultiplicador)
    print("📊 Atualizando Speed Multiplier de x" .. _G.speedMultiplier .. " para x" .. novoMultiplicador)

    _G.speedMultiplier = novoMultiplicador

    -- Se toggle estiver ativo, aplicar novo multiplicador imediatamente
    if _G.speedToggleAtivo then
        local character = Player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local velocidadeFinal = velocidadeBase * novoMultiplicador
                humanoid.WalkSpeed = velocidadeFinal
                print("⚡ Multiplicador atualizado: " .. velocidadeBase .. " x" .. novoMultiplicador .. " = " .. velocidadeFinal)
            end
        end
    -- Se estiver ativo, aplicar imediatamente
    if speedAtivo then
        aplicarWalkSpeed()
        print("✅ Novo Speed Multiplier aplicado: x" .. novoMultiplicador)
    end
end

-- Função para atualizar velocidade base manualmente
_G.atualizarVelocidadeBase = function(novaBase)
    velocidadeBase = novaBase
    _G.velocidadeBaseDetectada = novaBase
    print("🔄 Velocidade base atualizada para: " .. velocidadeBase)
function _G.detectarVelocidadeBaseGitHub()
    detectarVelocidadeOriginal()
    return velocidadeOriginal
end

-- Função para detectar velocidade base (chamada pela GUI)
_G.detectarVelocidadeBaseGitHub = function()
    local velocidade = detectarVelocidadeBase()
    print("🔍 Velocidade base detectada: " .. velocidade)
    return velocidade
function _G.atualizarVelocidadeBase(novaBase)
    velocidadeOriginal = novaBase
    _G.velocidadeBaseDetectada = novaBase
    print("🔄 Velocidade base atualizada para: " .. velocidadeOriginal)
end

-- ========================================
-- SISTEMA DE RESPAWN
-- EVENTOS DE PERSONAGEM
-- ========================================

Player.CharacterAdded:Connect(function(character)
    print("👤 Novo personagem detectado!")
-- Reconectar quando o personagem for recarregado
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")

    task.wait(0.3) -- Delay para garantir que tudo carregou
    print("🔄 Novo personagem detectado, redetectando velocidade original...")
    detectarVelocidadeOriginal()

    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then
        warn("⚠️ Humanoid não encontrado!")
        return
    end
    
    -- Detectar velocidade base do novo personagem
    detectarVelocidadeBase()
    
    -- Se sistema estiver ativo e toggle ativado, aplicar multiplicador
    if sistemaAtivo and _G.speedToggleAtivo then
        local multiplicador = _G.speedMultiplier or 1
        local velocidadeFinal = velocidadeBase * multiplicador
        humanoid.WalkSpeed = velocidadeFinal
        print("✅ Respawn: Multiplicador reaplicado (" .. velocidadeBase .. " x" .. multiplicador .. " = " .. velocidadeFinal .. ")")
    else
        -- Caso contrário, garantir velocidade base
        humanoid.WalkSpeed = velocidadeBase
        print("✅ Respawn: Velocidade base aplicada (" .. velocidadeBase .. ")")
    -- Se estava ativo, reativar
    if speedAtivo then
        task.wait(1) -- Esperar o personagem carregar completamente
        print("🔄 Reativando Speed Multiplier após respawn...")
        iniciarMonitoramento()
        aplicarWalkSpeed()
    end
end)

-- ========================================
-- INICIALIZAÇÃO AUTOMÁTICA
-- PROTEÇÃO ADICIONAL CONTRA ANTI-CHEAT
-- ========================================

-- Iniciar sistema automaticamente
iniciarSistema()
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

-- Se já existir um personagem, aplicar configurações
if Player.Character then
    task.spawn(function()
        task.wait(0.3)
        
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            detectarVelocidadeBase()
            
            if _G.speedToggleAtivo then
                local multiplicador = _G.speedMultiplier or 1
                humanoid.WalkSpeed = velocidadeBase * multiplicador
                print("✅ Multiplicador aplicado no personagem inicial")
            else
                humanoid.WalkSpeed = velocidadeBase
                print("✅ Velocidade base aplicada no personagem inicial")
            end
        end
    end)
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
-- INFORMAÇÕES FINAIS
-- INICIALIZAÇÃO COMPLETA
-- ========================================

print("========================================")
print("✅ Speed Multiplier System CARREGADO!")
print("========================================")
print("📊 Sistema iniciado e pronto")
print("🔄 Loop de controle ativo")
print("📡 Funções globais disponíveis:")
print("   • _G.ativarMultiplicadorGitHub()")
print("   • _G.desativarMultiplicadorGitHub()")
print("   • _G.atualizarMultiplicadorGitHub(valor)")
print("   • _G.detectarVelocidadeBaseGitHub()")
print("   • _G.atualizarVelocidadeBase(valor)")
print("========================================")
print("🎮 Aguardando comandos da GUI...")
print("========================================")
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
