PeaceMaker.Helpers.Rotation.Paladin = {}
local DruidYolo = PeaceMaker.Helpers.Rotation.DruidYolo
local SB = PeaceMaker.SpellBook.Druid
local Helper = PeaceMaker.Helpers.Rotation.Helper
local Power = PeaceMaker.Helpers.Rotation.Power

local castable = function(spell) return Helper:Castable(spell) end
local cast = function(spell) return Helper:Cast(spell) end
local enemynearby = function(distance) return Helper:CheckEnemyNearby(distance) end

local function Rotation()
  if castable(SB.Rejuvenation) and Helper:PlayerHealthPercent() <= 70 and not Helper:CheckBuff(SB.Rejuvenation, "player") then
    cast(SB.Rejuvenation)
    return
  end

  if castable(SB.Swiftmend) and Helper:CheckBuff(SB.Rejuvenation, "player") then
    cast(SB.Swiftmend)
    return
  end

  if castable(SB.Renewal) and Helper:PlayerHealthPercent() <= 50 then
    cast(SB.Renewal)
    return
  end
end

local function avoidShit()
  if castable(SB.IncapacitatingRoar)
    and Helpers:Target:TargetIsEnemy()
    and Helper:GetDistanceBetweenMobs() <= 10
    and _G.GetShapeshiftForm() ~= 3
  then
    if castable(SB.IncapacitatingRoar) then
      cast(SB.IncapacitatingRoar)
      return
    end
  end
end

function DruidYolo:Run()
  if PeaceMaker.Player.Combat then
    Rotation()
    avoidShit()
  end
end