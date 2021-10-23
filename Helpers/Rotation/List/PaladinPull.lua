PeaceMaker.Helpers.Rotation.PaladinPull = {}
local Paladin = PeaceMaker.Helpers.Rotation.PaladinPull
local SB = PeaceMaker.SpellBook.Paladin
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end

local function Rotation()

  local EnemyCount = enemynearby(15)
  
  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
    return
  end

  if EnemyCount >= 2 and castable(SB.ConsecrationProt) then
    cast(SB.ConsecrationProt)
    return
  end

  if castable(SB.HammerOfTheRighteous) then
    cast(SB.HammerOfTheRighteous)
    return
  end

  if castable(SB.HammerofJustice) then
    cast(SB.HammerofJustice)
    return
  end

  if castable(SB.HammerofWrath) then
    cast(SB.HammerofWrath)
    return
  end

  if castable(SB.AvengersShield) then
    cast(SB.AvengersShield)
    return
  end

  if castable(SB.ShieldoftheRighteous) and Power.HolyPower() >= 3 then
    cast(SB.ShieldoftheRighteous)
    return
  end

  if castable(SB.Judgment) then
    cast(SB.Judgment)
    return
  end

  if castable(SB.HammerOfTheRighteous) then
    cast(SB.HammerOfTheRighteous)
    return
  end

end

local function Healing()

  if castable(SB.WordofGlory) and Power.HolyPower() < 3 then
    cast(SB.WordofGlory)
    return
  end

  if castable(SB.WordofGlory) and Helper:PlayerHealthPercent() <= 70 and (Power.HolyPower()) >= 3 then
    cast(SB.WordofGlory)
    return
  end

  if castable(SB.LayonHands) and Helper:PlayerHealthPercent() <= 20 then
    cast(SB.LayonHands)
    return
  end

  if castable(SB.DivineShield) and Helper:PlayerHealthPercent() <= 10 then
    cast(SB.DivineShield)
    return
  end

end

local function Cooldown()
  if castable(SB.AvengingWrath) then
    cast(SB.AvengingWrath)
    return
  end

  if castable(SB.ArdentDefender) and Helper:PlayerHealthPercent() <= 35 then
    cast(SB.ArdentDefender)
    return
  end

  if not castable(SB.ArdentDefender) and castable(SB.GuardianofAncientKings) and Helper:PlayerHealthPercent() <= 25 then
    cast(SB.GuardianofAncientKings)
    return
  end
end

function Paladin:Run()
  if not EnableDRotation then return end
  if PeaceMaker.Player.Combat then
    if Helper:TargetExists()
      and not Helper:TargetDead()
      and Helper:TargetIsEnemy()
    then
      Healing()
      Cooldown()
      Rotation()
    end
  end
end