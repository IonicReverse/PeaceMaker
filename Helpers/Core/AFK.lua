local PeaceMaker = PeaceMaker
local AFKRun = false
PeaceMaker.Helpers.Core.AFK = {}

local AFK = PeaceMaker.Helpers.Core.AFK

local function InitialAFK()
  local Pulse = function()
    lb.UpdateAFK()
  end
  C_Timer.NewTicker(10, Pulse)
  return
end

function AFK:Run()
  if not AFKRun then
    InitialAFK()
    AFKRun = true
  end
end