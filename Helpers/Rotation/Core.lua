local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Rotation.Core = {}

local Rotation = PeaceMaker.Helpers.Rotation.Core
local Mount = PeaceMaker.Helpers.Core.Mount

local RotationCore = function()
  local CombatRotation = {}
  CombatRotation.IsRunning = function()
    if CombatRotation.Enable then return true end
    return false
  end
  CombatRotation.Run = function()
    if not CombatRotation.Enable then CombatRotation.Enable = true end
    return
  end
  local OnCombatPulse = function() 
    if CombatRotation.Enable then
      if not PeaceMaker.Player.Combat then CombatRotation.Enable = false end
      if PeaceMaker.IsRunning and PeaceMaker.Settings.profile.General.RotationName and Mount:CheckMountedMount() then
        PeaceMaker.Helpers.Rotation[PeaceMaker.Settings.profile.General.RotationName]:Run() 
      end
    end
  end
  C_Timer.NewTicker(0.2, OnCombatPulse)
  return CombatRotation
end

function Rotation:Run()
  if not Rotation.Engine then
    Rotation.Engine = RotationCore()
  end
end