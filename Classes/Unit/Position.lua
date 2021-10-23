local PeaceMaker = PeaceMaker
local PeaceMaker_Unit = PeaceMaker.Classes.Unit

function PeaceMaker_Unit:GetDistance(OtherUnit)
  OtherUnit = OtherUnit or PeaceMaker.Player
  local dist = lb.GetDistance3D(self.PosX, self.PosY, self.PosZ, OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ)
  return dist
end

function PeaceMaker_Unit:GetAggroDistance()
  local maxRadius = 45 
  local minRadius = 5 
  local expansionMaxLevel = 60

  local playerLevel = PeaceMaker.Player.Level
  local creatureLevel = self.Level
  local leveldif = creatureLevel - playerLevel

  if lb.UnitTagHandler(UnitReaction, self.GUID, "player") then --neutral mob
    if lb.UnitTagHandler(UnitReaction, self.GUID, "player") >= 4 then
      return 0
    end
  end

  local baseAggroDistance = 20 - lb.UnitCombatReach(self.GUID)
  local aggroRadius = baseAggroDistance

  if creatureLevel and creatureLevel > 60 then
    aggroRadius = aggroRadius + (expansionMaxLevel - playerLevel)
  else
    aggroRadius = aggroRadius + (creatureLevel - playerLevel)
  end

  -- // Make sure that we wont go over the total range limits
  if aggroRadius > maxRadius then
    aggroRadius = maxRadius
  elseif aggroRadius < minRadius then
    aggroRadius = minRadius
  end
  
  return aggroRadius - 1
end
