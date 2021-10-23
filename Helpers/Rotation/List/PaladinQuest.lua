PeaceMaker.Helpers.Rotation.PaladinQuest = {}
local Paladin = PeaceMaker.Helpers.Rotation.PaladinQuest
local SB = PeaceMaker.SpellBook.Paladin
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end

local function Opener()

  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if castable(SB.Judgment) then
    cast(SB.Judgment)
    return
  end

  if UnitLevel("player") < 10 then
    if castable(SB.CrusaderStrike) then
      cast(SB.CrusaderStrike)
      return
    end
  end

end

local function Rotation()

  local EnemyCount = enemynearby(10)
  
  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if UnitLevel("player") < 10 then
    if castable(SB.CrusaderStrike) then
      cast(SB.CrusaderStrike)
      return
    end
  end

  if castable(SB.HammerofJustice) then
    cast(SB.HammerofJustice)
    return
  end

  if castable(SB.Judgment) then
    cast(SB.Judgment)
    return
  end

  if EnemyCount >= 2 and castable(SB.ConsecrationProt) then
    cast(SB.ConsecrationProt)
    return
  end

  if castable(SB.AvengersShield) then
    cast(SB.AvengersShield)
    return
  end

  if castable(SB.HammerOfTheRighteous) then
    cast(SB.HammerOfTheRighteous)
    return
  end

  if castable(SB.ShieldoftheRighteous) then
    cast(SB.ShieldoftheRighteous)
    return
  end

end

local function Healing()
  if castable(SB.WordofGlory) and Helper:PlayerHealthPercent() <= 40 and (Power.HolyPower()) >= 3 then
    cast(SB.WordofGlory)
    return
  end
  
  if castable(SB.FlashofLight) and Helper:PlayerHealthPercent() <= 50 then
    cast(SB.FlashofLight)
    return
  end
end

local function Cooldown()
  if castable(SB.AvengingWrath) then
    cast(SB.AvengingWrath)
    return
  end
end

function Paladin:Run()

  if PeaceMaker.Player.Combat then
    if Helper:TargetExists()
      and not Helper:TargetDead()
      and Helper:TargetIsEnemy()
      and Helper:GetDistanceBetweenMobs() <= 15
    then
      Healing()
      --Cooldown()
      Rotation()
    end
  end

  if not PeaceMaker.Player.Combat then
    if Helper:TargetExists()
      and not Helper:TargetDead()
      and Helper:TargetIsEnemy()
      and Helper:GetDistanceBetweenMobs() <= 15
    then
      Opener()
    end
  end

end