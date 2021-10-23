local PeaceMaker = PeaceMaker
local PeaceMaker_Spell = PeaceMaker.Classes.Spell

function PeaceMaker_Spell:New(SpellID, CastType)
  self.SpellID = SpellID
  self.SpellType = SpellType or "Normal"
  self.SpellName = GetSpellInfo(self.SpellID)
  self.BaseCD = GetSpellBaseCooldown(self.SpellID) / 1000
  self.BaseGCD = select(2, GetSpellBaseCooldown(self.SpellID)) / 1000
  self.MinRange = select(5, GetSpellInfo(self.SpellID)) or 0
  self.MaxRange = select(6, GetSpellInfo(self.SpellID)) or 0
  self.CastType = CastType or "Normal"
  self.IsHarmful = IsHarmfulSpell(self.SpellName) or false
  self.IsHelpful = IsHelpfulSpell(self.SpellName) or false
  self.LastCastTime = 0
  self.LastBotTarget = "player"
end

function PeaceMaker_Spell:Cost()
  local costTable = GetSpellPowerCost(self.SpellName)
  if costTable then
    for _, costinfo in pairs(costTable) do
      if costinfo.cost > 0 then
        return costinfo.cost
      end
    end
  end
  return 0
end

function PeaceMaker_Spell:CD(Rank)
  local time, value = GetSpellCooldown(self.SpellName)

  if not time or time == 0 then
    return 0
  end

  local cd = (time + value - GetTime() - (select(4, GetNetStats()) / 1000))

  if cd > 0 then
    return cd
  else
    return 0
  end
end

function PeaceMaker_Spell:CastTime(Rank)
  return select(4, GetSpellInfo(self.SpellName)) / 1000
end

function PeaceMaker_Spell:Charges()
  return GetSpellCharges(self.SpellID) or 0
end

function PeaceMaker_Spell:Usable(Rank)

  if IsUsableSpell(self.SpellName) then
    if self:CD(Rank) == 0 then
      return true
    end
  end

  return false
end

function PeaceMaker_Spell:Known(Rank)
  return GetSpellInfo(self.SpellName)
end

function PeaceMaker_Spell:IsReady(Rank)
  if self:Known(Rank) and self:Usable(Rank) then
    return true
  end
  return false
end
