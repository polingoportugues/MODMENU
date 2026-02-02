--[[
═══════════════════════════════════════════════════════════════
    SPEED HACK - Simples e Funcional
    
    Aumenta a velocidade de movimento do personagem
    Compatível com a maioria dos jogos Roblox
═══════════════════════════════════════════════════════════════
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Esperar o PlayerGui carregar
repeat task.wait() until Player and Player:FindFirstChild("PlayerGui")

-- ========================================
-- CONFIGURAÇÕES
-- ========================================

local speedAtivo = false
local speedValue = 500  -- Velocidade padrão (16 é normal)
local speedConnection = nil

-- ========================================
-- FUNÇÕES PRINCIPAIS
-- ========================================

local function aplicarSpeed()
    local character = Player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Aplicar velocidade
    humanoid.WalkSpeed = speedValue
end

local function ativarSpeed()
    if speedAtivo then return end
    
    speedAtivo = true
    
    -- Aplicar speed imediatamente
    aplicarSpeed()
    
    -- Manter speed ativo (caso o jogo tente resetar)
    if speedConnection then
        speedConnection:Disconnect()
    end
    
    speedConnection = RunService.Heartbeat:Connect(function()
        if not speedAtivo then return end
        
        local character = Player.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        -- Verificar se a velocidade foi alterada pelo jogo
        if humanoid.WalkSpeed ~= speedValue then
            humanoid.WalkSpeed = speedValue
        end
    end)
    
    print("✅ Speed Hack ATIVADO | Velocidade:", speedValue)
end

local function desativarSpeed()
    if not speedAtivo then return end
    
    speedAtivo = false
    
    -- Desconectar loop
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    -- Restaurar velocidade normal
    local character = Player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16  -- Velocidade normal do Roblox
        end
    end
    
    print("❌ Speed Hack DESATIVADO | Velocidade restaurada para 16")
end

local function alterarSpeed(novaVelocidade)
    speedValue = novaVelocidade
    
    if speedAtivo then
        aplicarSpeed()
        print("🔄 Velocidade alterada para:", speedValue)
    end
end

-- ========================================
-- CONFIGURAR NOVO PERSONAGEM
-- ========================================

local function configurarPersonagem(character)
    if not character then return end
    
    -- Esperar o Humanoid
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not humanoid then return end
    
    -- Se speed estava ativo, reaplicar
    if speedAtivo then
        task.wait(0.5)  -- Pequeno delay para garantir que o personagem carregou
        aplicarSpeed()
    end
end

-- Conectar evento de personagem
Player.CharacterAdded:Connect(configurarPersonagem)

-- Aplicar no personagem atual (se existir)
if Player.Character then
    configurarPersonagem(Player.Character)
end

-- ========================================
-- GUI SIMPLES
-- ========================================

local gui_parent = gethui and gethui() or game:GetService("CoreGui")
if not gui_parent or gui_parent == game:GetService("CoreGui") then
    gui_parent = Player.PlayerGui
end

local screenGui = Instance.new("ScreenGui", gui_parent)
screenGui.Name = "SpeedHackGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 9999

-- Frame principal
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 280, 0, 180)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(70, 130, 255)
stroke.Thickness = 2

-- Título
local titulo = Instance.new("TextLabel", mainFrame)
titulo.Size = UDim2.new(1, 0, 0, 40)
titulo.Position = UDim2.new(0, 0, 0, 0)
titulo.Text = "⚡ SPEED HACK"
titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
titulo.TextSize = 18
titulo.Font = Enum.Font.GothamBold
titulo.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
titulo.BorderSizePixel = 0

local tituloCorner = Instance.new("UICorner", titulo)
tituloCorner.CornerRadius = UDim.new(0, 10)

-- Label de velocidade
local speedLabel = Instance.new("TextLabel", mainFrame)
speedLabel.Size = UDim2.new(1, -20, 0, 30)
speedLabel.Position = UDim2.new(0, 10, 0, 50)
speedLabel.Text = "Velocidade: " .. speedValue
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextSize = 14
speedLabel.Font = Enum.Font.Gotham
speedLabel.BackgroundTransparency = 1

-- Slider
local sliderFrame = Instance.new("Frame", mainFrame)
sliderFrame.Size = UDim2.new(1, -40, 0, 20)
sliderFrame.Position = UDim2.new(0, 20, 0, 85)
sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
sliderFrame.BorderSizePixel = 0

local sliderCorner = Instance.new("UICorner", sliderFrame)
sliderCorner.CornerRadius = UDim.new(0, 10)

local sliderButton = Instance.new("TextButton", sliderFrame)
sliderButton.Size = UDim2.new(0, 20, 1, 0)
sliderButton.Position = UDim2.new((speedValue - 16) / (500 - 16), -10, 0, 0)
sliderButton.Text = ""
sliderButton.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
sliderButton.BorderSizePixel = 0

local btnCorner = Instance.new("UICorner", sliderButton)
btnCorner.CornerRadius = UDim.new(1, 0)

-- Função do slider
local dragging = false

sliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

sliderButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relativeX = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
        
        -- Calcular velocidade (16 a 200)
        local novaVelocidade = math.floor(16 + (relativeX * (200 - 16)))
        
        -- Atualizar posição do botão
        sliderButton.Position = UDim2.new(relativeX, -10, 0, 0)
        
        -- Atualizar velocidade
        alterarSpeed(novaVelocidade)
        speedLabel.Text = "Velocidade: " .. novaVelocidade
    end
end)

-- Botão ON/OFF
local btnToggle = Instance.new("TextButton", mainFrame)
btnToggle.Size = UDim2.new(1, -40, 0, 40)
btnToggle.Position = UDim2.new(0, 20, 0, 120)
btnToggle.Text = "ATIVAR SPEED"
btnToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
btnToggle.TextSize = 16
btnToggle.Font = Enum.Font.GothamBold
btnToggle.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
btnToggle.BorderSizePixel = 0

local toggleCorner = Instance.new("UICorner", btnToggle)
toggleCorner.CornerRadius = UDim.new(0, 8)

btnToggle.MouseButton1Click:Connect(function()
    if speedAtivo then
        desativarSpeed()
        btnToggle.Text = "ATIVAR SPEED"
        btnToggle.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
    else
        ativarSpeed()
        btnToggle.Text = "DESATIVAR SPEED"
        btnToggle.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
    end
end)

-- ========================================
-- COMANDOS DE CONSOLE (OPCIONAL)
-- ========================================

-- Você pode usar esses comandos no console do executor:

_G.SpeedHack = {
    Ativar = ativarSpeed,
    Desativar = desativarSpeed,
    SetSpeed = alterarSpeed,
    GetSpeed = function() return speedValue end,
    IsAtivo = function() return speedAtivo end
}

-- Exemplos de uso no console:
-- _G.SpeedHack.Ativar()
-- _G.SpeedHack.SetSpeed(150)
-- _G.SpeedHack.Desativar()

-- ========================================
-- INFORMAÇÕES
-- ========================================

print("═══════════════════════════════════════")
print("✅ Speed Hack carregado com sucesso!")
print("═══════════════════════════════════════")
print("📌 Use a GUI para controlar o speed")
print("📌 Velocidade padrão: 16")
print("📌 Range: 16 - 200")
print("═══════════════════════════════════════")
print("💡 Comandos disponíveis:")
print("   _G.SpeedHack.Ativar()")
print("   _G.SpeedHack.Desativar()")
print("   _G.SpeedHack.SetSpeed(velocidade)")
print("═══════════════════════════════════════")
