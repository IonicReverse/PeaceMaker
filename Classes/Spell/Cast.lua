local PeaceMaker = PeaceMaker
local PeaceMaker_Spell = PeaceMaker.Classes.Spell
local PeaceMaker_LocalPlayer = PeaceMaker.Classes.LocalPlayer

function PeaceMaker_Spell:FacingCast(Unit, SpellID)
  if not Unit.Facing and not lb.UnitTarget(PeaceMaker.Player.GUID) == Unit.GUID then
    -- TODO
  end
end

function PeaceMaker_Spell:Cast(Unit, SpellID, Target)

  if not Unit then
    if self.IsHarmful and PeaceMaker.Player.Target then
      Unit = PeaceMaker.Player.Target
    elseif self.IsHelpful then
      Unit = PeaceMaker.Player
    else
      return false
    end
  end

  if not SpellID then
    lb.Unlock(CastSpellByName, self.SpellName)
    return true
  else
    lb.Unlock(CastSpellByID, self.SpellID)
    return true
  end

  if Target and not SpellID then
    lb.Unlock(CastSpellByName, self.SpellName, Target)
    return true
  else
    if Target and SpellID then
      lb.Unlock(CastSpellByID, self.SpellID, Target)
      return true
    end
  end
  
  return false
end

function PeaceMaker_Spell:CastGround(X,Y,Z, SpellID)
  
  if PeaceMaker.Player.Moving then
    lb.Unlock(MoveForwardStart)
    lb.Unlock(MoveForwardStop)
    C_Timer.After(0.5, function()
      if not SpellID then 
        lb.Unlock(CastSpellByName, self.SpellName)
        lb.ClickPosition(X,Y,Z)
      else
        lb.Unlock(CastSpellByID, self.SpellID)
        lb.ClickPosition(X,Y,Z)
      end
    end)
    return true
  end

  if not SpellID then
    lb.Unlock(CastSpellByName, self.SpellName)
    lb.ClickPosition(X,Y,Z)
    return true
  else
    lb.Unlock(CastSpellByID, self.SpellID)
    lb.ClickPosition(X,Y,Z)
    return true
  end
  
  return false
end