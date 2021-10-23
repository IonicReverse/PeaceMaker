local PeaceMaker = PeaceMaker
local PeaceMaker_Unit = PeaceMaker.Classes.Unit

function PeaceMaker_Unit:New(GUID)
  if not UnitIsUnit then UnitIsUnit = _G.UnitIsUnit end
  self.GUID = GUID
  self.Pointer = lb.ObjectPointer(GUID)
  self.Name = lb.UnitTagHandler(UnitName, self.GUID)
  self.Player = lb.UnitTagHandler(UnitIsPlayer, self.GUID)
  if self.Player then self.Class = (select(2, lb.UnitTagHandler(UnitClass, self.GUID))) end
  self.Friend = lb.UnitTagHandler(UnitIsFriend, PeaceMaker.Player.GUID, self.GUID)
  self.CombatReach = lb.UnitCombatReach(self.GUID)
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.GUID)
  self.ObjectID = lb.ObjectId(self.GUID)
  self.Level = lb.UnitTagHandler(UnitLevel, self.GUID)
  self.LosCache = {}
  self.Classification = lb.UnitTagHandler(UnitClassification, self.GUID)
  self.Type = lb.UnitTagHandler(UnitCreatureType, self.GUID)
  self.Exists = lb.UnitTagHandler(UnitExists, self.GUID)
  self.ObjDynamicFlag = lb.ObjectDynamicFlags(self.GUID)
  self.UnitHasFlag = lb.UnitNpcFlags(self.GUID)
  self.DistanceAggro = self:GetAggroDistance()
end

function PeaceMaker_Unit:Update()
  self.NextUpdate = PeaceMaker.Time + 0.05
  self:UpdatePosition()
  self.Distance = self:GetDistance()
  self.HealthMax = lb.UnitTagHandler(UnitHealthMax, self.GUID)
  self.Health = lb.UnitTagHandler(UnitHealth, self.GUID)
  self.HP = self.Health / self.HealthMax * 100
  self.Dead = lb.UnitTagHandler(UnitIsDeadOrGhost, self.GUID)
  self.Attackable = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, self.GUID) and not self.Dead or false
  self.ValidEnemy = self.Attackable and self:IsEnemy() or false
  self.Target = self:HasTargetUnit(self.GUID)
  self.Moving = self:HasMovementFlag()
  self.Facing = self:IsFacing(self.GUID)
  self.Castng = UnitCastingInfo(self.GUID)
  self.Exists = lb.UnitTagHandler(UnitExists, self.GUID)
  self.UnitHasFlag = lb.UnitNpcFlags(self.GUID)
  self.TTD = self:GetTTD()
  self.Los = false
  if self.Distance < 50 and not self.Dead then
    self.Los = self:LineOfSight()
  end
  if self.Name == "Unknown" or self.Name == nil then
    self.Name = lb.UnitTagHandler(UnitName, self.GUID)
  end
  self.ObjDynamicFlag = lb.ObjectDynamicFlags(self.GUID)
end

function PeaceMaker_Unit:UpdatePosition()
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.GUID)
end

function PeaceMaker_Unit:HasTargetUnit(GUID)
  if lb.UnitTarget(GUID) == "0000000000000000" then
    return nil
  end
  return lb.UnitTarget(GUID)
end

function PeaceMaker_Unit:IsEnemy()
  return self.Los and self.Attackable and self:HasThreat() and (not self.Friend or lb.UnitTarget(self.GUID) == PeaceMaker.Player.GUID)
end

function PeaceMaker_Unit:IsFacing (Other)
  local SelfX, SelfY, SelfZ = lb.ObjectPosition('player')
  local SelfFacing = lb.ObjectFacing('player')
  local OtherX, OtherY, OtherZ = lb.ObjectPosition(Other)
  local Angle = SelfX and SelfY and OtherX and OtherY and SelfFacing and ((SelfX - OtherX) * math.cos(-SelfFacing)) - ((SelfY - OtherY) * math.sin(-SelfFacing)) or 0
  return Angle < 0
end

function PeaceMaker_Unit:HasThreat()
  if lb.UnitTagHandler(UnitAffectingCombat, self.GUID) then
    return true
  end
  return false
end

function PeaceMaker_Unit:HasMovementFlag()
  if GetUnitSpeed('player') > 0
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Forward)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Backward)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.StrafeLeft)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.StrafeRight)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Falling)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Ascending)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Descending) 
  then 
    return true
  end
  return false
end

function PeaceMaker_Unit:GetUnitSize(Unit)
  local boundingHeight = lb.UnitBoundingHeight(Unit)
  local collisionScale = lb.UnitCollisionScale(Unit)
  if not boundingHeight or not collisionScale then return 0 end
  return ((boundingHeight and collisionScale) and (boundingHeight * collisionScale)) / 2 or 25
end

function PeaceMaker_Unit:LineOfSight(OtherUnit)

  if PeaceMaker.Enums.Los[self.ObjectID] then
    return true
  end

  OtherUnit = OtherUnit or PeaceMaker.Player

  local playerheight = self:GetUnitSize('player')
  local enemyheight = self:GetUnitSize(OtherUnit.GUID)

  if self.LosCache.Result ~= nil 
    and self.PosX == self.LosCache.PosX
    and self.PosY == self.LosCache.PosY
    and self.PosZ == self.LosCache.PosZ
    and OtherUnit.PosX == self.LosCache.TPosX
    and OtherUnit.PosY == self.LosCache.TPosY
    and OtherUnit.PosZ == self.LosCache.TPosZ
  then
    return self.LosCache.Result
  end
  
  if self.PosX and self.PosY and self.PosZ then
    self.LosCache.Result = lb.Raycast(self.PosX, self.PosY, self.PosZ + playerheight, OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ + enemyheight, lb.ERaycastFlags.LineOfSight) == nil
    self.LosCache.PosX, self.LosCache.PosY, self.LosCache.PosZ = self.PosX, self.PosY, self.PosZ
    self.LosCache.TPosX, self.LosCache.TPosY, self.LosCache.TPosZ = OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ
  end

  return self.LosCache.Result
end