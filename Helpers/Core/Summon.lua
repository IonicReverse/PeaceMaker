local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Summon = {}

local Summon = PeaceMaker.Helpers.Core.Summon
local Log = PeaceMaker.Helpers.Core.Log
local Misc = PeaceMaker.Helpers.Core.Misc
local SummonState = false

local function SummonByClass(spellname)
  Misc:CastSpellByID(spellname)
  C_Timer.After(7, function()
    SummonState = false
    if not PeaceMaker.Player.Pet then
      Log:Run("Summon Failed! Summon Again")
    end
  end)
  return
end

local function Core(spellname)
  if SummonState then return end
  if PeaceMaker.Player.Casting then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Helpers.Core.Navigation:StopMoving() return end
  if (
    not PeaceMaker.Player.Pet 
    or 
    PeaceMaker.Player.Pet and PeaceMaker.Player.Pet.Dead
    or
    PeaceMaker.Player.Pet and not PeaceMaker.Player.Pet.Exists
  )
  then
    Log:Run("Summoning")
    SummonState = true
    SummonByClass(spellname)
  end
end

function Summon:Run(spellname)
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core(spellname)
  end
end