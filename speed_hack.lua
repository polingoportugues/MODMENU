-- Speed Multiplier System - GitHub Version
-- Sistema completo de multiplicador de velocidade
-- Controlado pela GUI via variáveis globais
-- Criado por KDML

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

print("🚀 Iniciando Speed Multiplier System do GitHub...")

-- ========================================
-- VARIÁVEIS DE CONTROLE
-- ========================================

local speedConnection = nil
local velocidadeBase = 16
local sistemaAtivo = false

-- ========================================
-- DETECÇÃO DE VELOCIDADE BASE
-- ========================================

local function detectarVelocidadeBase()
    local character = Player.Character
    if not character then return 16 end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return 16 end
    
    local velocidadeAtual = humanoid.WalkSpeed
    
    -- Se velocidade for muito alta (já modificada), retornar padrão
    if velocidadeAtual > 5000 then
        print("⚠️ Velocidade atual muito alta (" .. velocidadeAtual .. "), usando padrão: 16")
        return 16
    end
    
    -- Caso contrário, usar velocidade atual como base
    velocidadeBase = velocidadeAtual
    _G.velocidadeBaseDetectada = velocidadeAtual
    print("🔍 Velocidade base detectada: " .. velocidadeAtual)
    return velocidadeAtual
end

-- ========================================
-- SISTEMA DE MULTIPLICADOR
-- ========================================

local function iniciarSistema()
    if sistemaAtivo then
        print("⚠️ Sistema já está ativo!")
        return
    end
    
    sistemaAtivo = true
    print("✅ Sistema de multiplicador INICIADO")
    
    -- Desconectar conexão anterior se existir
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    -- Detectar velocidade base
    detectarVelocidadeBase()
    
    -- Criar loop de controle
    speedConnection = RunService.Heartbeat:Connect(function()
        local character = Player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
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
        end
    end)
    
    print("🔄 Loop de controle ativo - Monitorando velocidade continuamente")
end

local function pararSistema()
    if not sistemaAtivo then
        print("⚠️ Sistema já está parado!")
        return
    end
    
    sistemaAtivo = false
    print("⏹️ Parando sistema de multiplicador...")
    
    -- Desconectar loop
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
        print("🔌 Loop de controle desconectado")
    end
    
    -- Restaurar velocidade base
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("✅ Velocidade restaurada para: " .. velocidadeBase)
        end
    end
end

-- ========================================
-- FUNÇÕES GLOBAIS (Comunicação com GUI)
-- ========================================

-- Função para ATIVAR multiplicador (chamada pela GUI)
_G.ativarMultiplicadorGitHub = function()
    print("📡 GUI solicitou ATIVAÇÃO do multiplicador")
    
    if not sistemaAtivo then
        iniciarSistema()
    end
    
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
end

-- Função para DESATIVAR multiplicador (chamada pela GUI)
_G.desativarMultiplicadorGitHub = function()
    print("📡 GUI solicitou DESATIVAÇÃO do multiplicador")
    
    -- NÃO PARAR O SISTEMA - apenas marcar toggle como false
    -- O loop continua rodando e vai manter a velocidade base
    
    -- Restaurar velocidade base IMEDIATAMENTE
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeBase
            print("✅ Velocidade restaurada para: " .. velocidadeBase)
        end
    end
end

-- Função para ATUALIZAR multiplicador (chamada pela GUI quando slider muda)
_G.atualizarMultiplicadorGitHub = function(novoMultiplicador)
    print("📡 GUI atualizou multiplicador para: x" .. novoMultiplicador)
    
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
    end
end

-- Função para atualizar velocidade base manualmente
_G.atualizarVelocidadeBase = function(novaBase)
    velocidadeBase = novaBase
    _G.velocidadeBaseDetectada = novaBase
    print("🔄 Velocidade base atualizada para: " .. velocidadeBase)
end

-- Função para detectar velocidade base (chamada pela GUI)
_G.detectarVelocidadeBaseGitHub = function()
    local velocidade = detectarVelocidadeBase()
    print("🔍 Velocidade base detectada: " .. velocidade)
    return velocidade
end

-- ========================================
-- SISTEMA DE RESPAWN
-- ========================================

Player.CharacterAdded:Connect(function(character)
    print("👤 Novo personagem detectado!")
    
    task.wait(0.3) -- Delay para garantir que tudo carregou
    
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
    end
end)

-- ========================================
-- INICIALIZAÇÃO AUTOMÁTICA
-- ========================================

-- Iniciar sistema automaticamente
iniciarSistema()

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
end

-- ========================================
-- INFORMAÇÕES FINAIS
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
