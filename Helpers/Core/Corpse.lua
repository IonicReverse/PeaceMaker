local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Corpse = {}

local Corpse = PeaceMaker.Helpers.Core.Corpse
local Navigation = PeaceMaker.Helpers.Core.Navigation

local function Core()
  if PeaceMaker.Player.Ghost then
    if not PeaceMaker.Player.Moving then
      Navigation:MoveToCorpse()
    end
  else
    if PeaceMaker.Player.Dead and not PeaceMaker.Player.Ghost then
      RepopMe()
    end
  end
end

function Corpse:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end