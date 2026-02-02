-- Obfuscated Speed System by KDML
-- Protection: Medium (Functional)

local _0xP=game:GetService("Players")
local _0xR=game:GetService("RunService")
local _0xL=_0xP.LocalPlayer
local _0xC=nil
local _0xB=16
local _0xA=false

local function _0xD()
    local _0x1=_0xL.Character
    if not _0x1 then return 16 end
    local _0x2=_0x1:FindFirstChildOfClass("Humanoid")
    if not _0x2 then return 16 end
    local _0x3=_0x2.WalkSpeed
    if _0x3>50 then return 16 end
    _0xB=_0x3
    _G.velocidadeBaseDetectada=_0x3
    return _0x3
end

local function _0xI()
    if _0xA then return end
    _0xA=true
    if _0xC then _0xC:Disconnect()_0xC=nil end
    _0xD()
    _0xC=_0xR.Heartbeat:Connect(function()
        local _0x4=_0xL.Character
        if not _0x4 then return end
        local _0x5=_0x4:FindFirstChildOfClass("Humanoid")
        if not _0x5 then return end
        if _G.speedToggleAtivo then
            local _0x6=_G.speedMultiplier or 1
            local _0x7=_0xB*_0x6
            if _0x5.WalkSpeed~=_0x7 then
                _0x5.WalkSpeed=_0x7
            end
        else
            if _0x5.WalkSpeed~=_0xB then
                _0x5.WalkSpeed=_0xB
            end
        end
    end)
end

_G.ativarMultiplicadorGitHub=function()
    if not _0xA then _0xI()end
    local _0x8=_0xL.Character
    if _0x8 then
        local _0x9=_0x8:FindFirstChildOfClass("Humanoid")
        if _0x9 then
            local _0xa=_G.speedMultiplier or 1
            local _0xb=_0xB*_0xa
            _0x9.WalkSpeed=_0xb
        end
    end
end

_G.desativarMultiplicadorGitHub=function()
    local _0xc=_0xL.Character
    if _0xc then
        local _0xd=_0xc:FindFirstChildOfClass("Humanoid")
        if _0xd then
            _0xd.WalkSpeed=_0xB
        end
    end
end

_G.atualizarMultiplicadorGitHub=function(_0xe)
    _G.speedMultiplier=_0xe
    if _G.speedToggleAtivo then
        local _0xf=_0xL.Character
        if _0xf then
            local _0x10=_0xf:FindFirstChildOfClass("Humanoid")
            if _0x10 then
                local _0x11=_0xB*_0xe
                _0x10.WalkSpeed=_0x11
            end
        end
    end
end

_G.atualizarVelocidadeBase=function(_0x12)
    _0xB=_0x12
    _G.velocidadeBaseDetectada=_0x12
end

_G.detectarVelocidadeBaseGitHub=function()
    return _0xD()
end

_0xL.CharacterAdded:Connect(function(_0x13)
    task.wait(0.3)
    local _0x14=_0x13:WaitForChild("Humanoid",5)
    if not _0x14 then return end
    _0xD()
    if _0xA and _G.speedToggleAtivo then
        local _0x15=_G.speedMultiplier or 1
        local _0x16=_0xB*_0x15
        _0x14.WalkSpeed=_0x16
    else
        _0x14.WalkSpeed=_0xB
    end
end)

_0xI()

if _0xL.Character then
    task.spawn(function()
        task.wait(0.3)
        local _0x17=_0xL.Character:FindFirstChildOfClass("Humanoid")
        if _0x17 then
            _0xD()
            if _G.speedToggleAtivo then
                local _0x18=_G.speedMultiplier or 1
                _0x17.WalkSpeed=_0xB*_0x18
            else
                _0x17.WalkSpeed=_0xB
            end
        end
    end)
end
