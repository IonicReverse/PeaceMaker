PeaceMaker.Helpers.Rotation.Paladin = {}
local Paladin = PeaceMaker.Helpers.Rotation.Paladin
local SB = PeaceMaker.SpellBook.Paladin
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end

local function Opener()
  if Helper:TargetExists()
    and Helper:TargetIsEnemy()
    and not Helper:TargetDead() 
  then
    if not IsCurrentSpell(6603) then
      Helper:AutoAttack()
    end

    if castable(SB.Judgment) then
      cast(SB.Judgment)
      return
    end
  end
end

local function Rotation()

  local EnemyCount = enemynearby(10)
  local MapId = lb.GetMapId()
  
  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if castable(SB.DivineToll) and MapId == 2222 then
    cast(SB.DivineToll)
    return
  end

  if castable(SB.CrusaderStrike) then
    cast(SB.CrusaderStrike)
    return
  end

  if castable(SB.ShieldoftheRighteous) then
    cast(SB.ShieldoftheRighteous)
    return
  end

  if castable(SB.WakeofAshes) and ((Power.HolyPower()) == 0 or ((Power.HolyPower()) == 1 and not castable(SB.BladeOfJustice))) then
    cast(SB.WakeofAshes)
    return
  end

  if castable(SB.DivineStorm) and EnemyCount >= 2 and (Power.HolyPower()) == 3 then
    cast(SB.DivineStorm)
    return
  end

  if castable(SB.BladeOfJustice) and (Power.HolyPower()) <= 3 then
    cast(SB.BladeOfJustice)
    return
  end

  if ((Power.HolyPower()) == 3 or ((Power.HolyPower()) <= 3 and not castable(SB.BladeOfJustice))) and castable(SB.Judgment) then
    cast(SB.Judgment)
    return
  end

  if castable(SB.HammerofWrath) and Helper:TargetHealthPercent() <= 20 then
    cast(SB.HammerofWrath)
    return
  end

  if (Power.HolyPower()) <= 3 and castable(SB.ConsecrationRet) and EnemyCount >= 2 then
    cast(SB.ConsecrationRet)
    return
  end

  if castable(SB.CrusaderStrike) and (Power.HolyPower()) <= 3 then
    cast(SB.CrusaderStrike)
    return
  end

  if castable(SB.TemplarsVerdict) and (Power.HolyPower()) >= 3 and Helper:PlayerHealthPercent() >= 60 then
    cast(SB.TemplarsVerdict)
    return
  end

  if castable(SB.JusticarsVengeance) and (Power.HolyPower()) >= 3 and Helper:PlayerHealthPercent() <= 60 then
    cast(SB.JusticarsVengeance)
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
end

local function Buff()
  if castable(SB.DevotionAura) and not Helper:CheckBuff(SB.DevotionAura, "player") then
    cast(SB.DevotionAura)
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
      Cooldown()
      Rotation()
    end
  end

  if not PeaceMaker.Player.Combat then
    Buff()
    Opener()
  end

end