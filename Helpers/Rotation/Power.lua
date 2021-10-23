local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Rotation.Power = {}
local Power = PeaceMaker.Helpers.Rotation.Power

function Power:HolyPower()
  return UnitPower("player", Enum.PowerType.HolyPower)
end

function Power:Mana()
  return UnitPower("player", Enum.PowerType.Mana)
end

function Power:Rage()
  return UnitPower("player", Enum.PowerType.Rage)
end

function Power:Focus()
  return UnitPower("player", Enum.PowerType.Focus)
end

function Power:Energy()
  return UnitPower("player", Enum.PowerType.Energy)
end

function Power:ComboPoints()
  return UnitPower("player", Enum.PowerType.ComboPoints)
end

function Power:Runes()
  return UnitPower("player", Enum.PowerType.Runes)
end

function Power:RunicPower()
  return UnitPower("player", Enum.PowerType.RunicPower)
end

function Power:SoulShards()
  return UnitPower("player", Enum.PowerType.SoulShards)
end

function Power:LunarPower()
  return UnitPower("player", Enum.PowerType.LunarPower)
end

function Power:Alternate()
  return UnitPower("player", Enum.PowerType.Alternate)
end

function Power:Maelstrom()
  return UnitPower("player", Enum.PowerType.Maelstrom)
end

function Power:Chi()
  return UnitPower("player", Enum.PowerType.Chi)
end

function Power:Insanity()
  return UnitPower("player", Enum.PowerType.Insanity)
end

function Power:Fury()
  return UnitPower("player", Enum.PowerType.Fury)
end

function Power:Pain()
  return UnitPower("player", Enum.PowerType.Pain)
end

function Power:ArcaneCharges()
  return UnitPower("player", Enum.PowerType.ArcaneCharges)
end