local PeaceMaker = PeaceMaker
local PeaceMaker_GameObject = PeaceMaker.Classes.GameObject

function PeaceMaker_GameObject:New(GUID)
  self.GUID = GUID
  self.Name = lb.ObjectName(GUID)
  self.ObjectID = lb.ObjectId(GUID)
  self.ObjPointer = lb.ObjectPointer(self.GUID)
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.GUID)
end

function PeaceMaker_GameObject:Update()
  self.NextUpdate = PeaceMaker.Time + 0.1
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.GUID)
  self.Distance = self:GetDistance()
  if not self.Name or self.Name == "" then
    self.Name = lb.ObjectName(self.GUID)
  end
  self.Herb = self:IsHerb()
  self.Ore = self:IsOre()
  self.ObjPointer = lb.ObjectPointer(self.GUID)
  self.ObjLockType = lb.ObjectLocked(self.GUID)
  self.ObjExists = lb.ObjectExists(self.GUID)
  self.ObjDynamicFlag = lb.ObjectDynamicFlags(self.GUID)
end 

function PeaceMaker_GameObject:GetDistance(OtherUnit)
  OtherUnit = OtherUnit or PeaceMaker.Player
  local Dist = lb.GetDistance3D(self.GUID, OtherUnit.GUID)
  if Dist == nil or Dist < 0 then return 0 end
  return Dist
end

function PeaceMaker_GameObject:IsHerb()
  if PeaceMaker.Enums.Herbs[self.ObjectID]
    and PeaceMaker.Player.Professions.Herbalism 
    and PeaceMaker.Player.Professions.Herbalism >= PeaceMaker.Enums.Herbs[self.ObjectID].SkillReq
  then
    return true
  end
  return false
end

function PeaceMaker_GameObject:IsOre()
  if PeaceMaker.Enums.Ore[self.ObjectID]
    and PeaceMaker.Player.Professions.Mining 
    and PeaceMaker.Player.Professions.Mining >= PeaceMaker.Enums.Ore[self.ObjectID].SkillReq
  then
    return true
  end
  return false
end
