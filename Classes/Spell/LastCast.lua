local PeaceMaker = PeaceMaker
local LastSpell = 0
local PeaceMaker_Spell = PeaceMaker.Classes.Spell

function PeaceMaker_Spell:LastCast(Index)
  Index = Index or 1
  if PeaceMaker.Player.LastCast and PeaceMaker.Player.LastCast[Index] then
    return PeaceMaker.Player.LastCast[Index].SpellName == self.SpellName
  end
  return false
end

function PeaceMaker_Spell:TimeSinceLastCast()
  if self.LastCastTime > 0 then
    return PeaceMaker.Time - self.LastCastTime
  end
  return 999
end

function PeaceMakerSpell(SpellID)
  
  if not PeaceMaker.Player.LastCast then
    PeaceMaker.Player.LastCast = {}
  end

  local SpellName = GetSpellInfo(SpellID)

  if PeaceMaker.Player.Spells then
    for k, v in pairs(PeaceMaker.Player.Spells) do
      if v.SpellName == SpellName then
        local Temp = {}
        Temp.SpellName = v.SpellName
        Temp.CastTime = PeaceMaker.Time
        tinsert(PeaceMaker.Player.LastCast, 1, Temp)
        if #PeaceMaker.Player.LastCast == 10 then
          PeaceMaker.Player.LastCast[10] = nil
        end
        return true
      end
    end
  end

  return false
end


