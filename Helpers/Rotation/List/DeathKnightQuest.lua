PeaceMaker.Helpers.Rotation.DeathKnightQuest = {}
local DeathKnight = PeaceMaker.Helpers.Rotation.DeathKnightQuest
local SB = PeaceMaker.SpellBook.DeathKnight
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end
local doingDND = false

local function Opener()

  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if castable(SB.DeathGrip) then
    cast(SB.DeathGrip)
    return
  end

  if castable(SB.ChainsOfIce) then
    cast(SB.ChainsOfIce)
    return
  end

end

local function Rotation()

  local EnemyCount = enemynearby(15)
  
  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if castable(SB.MarkOfBlood) and not Helper:CheckBuff(SB.MarkOfBlood, "target") then
    cast(SB.MarkOfBlood)
    return
  end
  
  if castable(SB.DeathAndDecay) and EnemyCount > 2 then
    local x1, y1, z1 = lb.ObjectPosition('player')
    cast(SB.DeathAndDecay)
    doingDND = true
    C_Timer.After(1, function()
      lb.ClickPosition(x1, y1, z1)
      C_Timer.After(0.5, function()
        doingDND = false
      end)
    end)
    return
  end

  if castable(SB.BoneStorm) and EnemyCount > 2 then
    cast(SB.BoneStorm)
    return
  end

  if doingDND == false then

    if castable(SB.RaiseDead) then
      cast(SB.RaiseDead)
      return
    end

    if castable(SB.DancingRuneWeapon) and (EnemyCount >= 2 or Helper:PlayerHealthPercent() <= 50) then
      cast(SB.DancingRuneWeapon)
      return
    end

    -- Defensive CDs
    if castable(SB.IceboundFortitude) and Helper:PlayerHealthPercent() < 40 then
      cast(SB.IceboundFortitude)
      return
    end

    -- Get Aggro
    if not Helper:CheckBuff(SB.BloodPlague, "target") then
      cast(SB.BloodBoil)
      return
    end

    -- Continue do some damage and healing
    if castable(SB.Marrowrend) then
      cast(SB.Marrowrend)
      return 
    end

    if castable(SB.DeathStrike) and (Power.RunicPower() >= 75 or Helper:PlayerHealthPercent() < 40) then
      cast(SB.DeathStrike)
      return
    end

    if (Power.RunicPower()) <= 75 and castable(SB.HeartStrike) then
      cast(SB.HeartStrike)
      return
    end
  end

end

local function Cooldown()
  if castable(SB.AntiMagicShell) and Helper:PlayerHealthPercent() <= 40 then
    cast(SB.AntiMagicShell)
    return
  end

  if castable(SB.VampiricBlood) and Helper:PlayerHealthPercent() <= 40 then
    cast(SB.VampiricBlood)
    return
  end
end

function DeathKnight:Run()

  if PeaceMaker.Player.Combat then
    if Helper:TargetExists()
      and not Helper:TargetDead()
      and Helper:TargetIsEnemy()
      and Helper:GetDistanceBetweenMobs() <= 15
    then
      Cooldown()
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