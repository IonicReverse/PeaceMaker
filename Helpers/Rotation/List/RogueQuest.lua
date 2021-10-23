PeaceMaker.Helpers.Rotation.RogueQuest = {}
local RogueQuest = PeaceMaker.Helpers.Rotation.RogueQuest
local SB = PeaceMaker.SpellBook.Rogue
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end

local function Opener()

  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

end

local function Rotation()

  local EnemyCount = checkEnemyNearby(10)

  if not IsCurrentSpell(6603) then
    Helper:AutoAttack()
  end

  if Power.ComboPoints() == 5 and castable(SB.Dispatch) then
    cast(SB.Dispatch)
    return
  end

  if Helper:CheckBuff(SB.Opportunity, "player") and castable(SB.PistolShot) then
    cast(SB.PistolShot)
    return
  end

  if castable(SB.GhostlyStrike) then
    cast(SB.GhostlyStrike)
    return
  end

  if EnemyCount >= 3 and castable(SB.AdrenalineRush) then
    cast(SB.AdrenalineRush)
    return
  end

  if EnemyCount >= 2 and castable(SB.BladeFlurry) then
    cast(SB.BladeFlurry)
    return
  end

  if castable(SB.RollTheBones) then
    cast(SB.RollTheBones)
    return
  end

  if castable(SB.SliceAndDice) and not Helper:CheckBuff(SB.SliceAndDice, "player") then
    cast(SB.SliceAndDice)
    return
  end

  if castable(SB.SinisterStrike) then
    cast(SB.SinisterStrike)
    return
  end

end

function RogueQuest:Run()

  if PeaceMaker.Player.Combat then
    if Helper:TargetExists()
      and not Helper:TargetDead()
      and Helper:TargetIsEnemy()
      and Helper:GetDistanceBetweenMobs() <= 15
    then
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