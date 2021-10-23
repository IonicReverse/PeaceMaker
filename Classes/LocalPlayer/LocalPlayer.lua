local PeaceMaker = PeaceMaker
local PeaceMaker_LocalPlayer = PeaceMaker.Classes.LocalPlayer

function PeaceMaker_LocalPlayer:New(GUID)
  self.GUID = GUID
  self.Pointer = lb.ObjectPointer(GUID)
  self.Name = lb.UnitTagHandler(UnitName, self.GUID)
  --self.Class = (select(3, lb.UnitTagHandler(UnitClass, self.GUID)))
  self.Class = (select(3, UnitClass('player')))
  --self.ClassName = (select(2, lb.UnitTagHandler(UnitClass, self.GUID)))
  self.ClassName = (select(2, UnitClass('player')))
  self.CombatReach = lb.UnitCombatReach(self.GUID)
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.Pointer)
  self.Distance = 0
  --self.Combat = lb.UnitTagHandler(UnitAffectingCombat, self.GUID)
  self.Combat = UnitAffectingCombat('player')
  self.CombatLeft = false
  self.Level = lb.UnitTagHandler(UnitLevel, self.GUID)
  self.Looting = false
  self.Mounted = IsMounted()
  self.Swimming = IsSwimming()
  self.Submerged = IsSubmerged()
  self.Faction = (select(1, lb.UnitTagHandler(UnitFactionGroup, self.GUID)))
  self.Race = (select(1, UnitRace("player")))
  self.Professions = {}
  self:UpdateProfessions()
  --self:GetSpells()
  --self:GetTalents()
end

function PeaceMaker_LocalPlayer:Update()
  self.PosX, self.PosY, self.PosZ = lb.ObjectPosition(self.GUID)
  self.Level = lb.UnitTagHandler(UnitLevel, self.GUID)
  self.Health = lb.UnitTagHandler(UnitHealth, self.GUID)
  self.HealthMax = lb.UnitTagHandler(UnitHealthMax, self.GUID)
  self.HP = self.Health / self.HealthMax * 100
  self.PowerType = lb.UnitTagHandler(UnitPowerType, self.GUID)
  self.Power = lb.UnitTagHandler(UnitPower, self.GUID, self.PowerType)
  self.PowerMax = lb.UnitTagHandler(UnitPowerMax, self.GUID, self.PowerType)
  self.PowerPct = self.Power / self.PowerMax * 100
  if self.Class == 4 or self.Class == 11 then
    self.ComboPoints = GetComboPoints("player", "target")
    self.ComboMax = 5
  end
  self.Casting = lb.UnitTagHandler(UnitCastingInfo, self.GUID)
  self.Channeling = lb.UnitTagHandler(ChannelInfo, self.GUID) or false
  --self.Combat = lb.UnitTagHandler(UnitAffectingCombat, self.GUID)
  self.Combat = UnitAffectingCombat('player')
  self.Moving = self:HasMovementFlag()
  self.Mounted = IsMounted()
  self.Swimming = __LB__.UnitHasMovementFlag("player", __LB__.EMovementFlags.Swimming)
  self.PetActive = UnitIsVisible("pet")
  self.PetDead = UnitIsDeadOrGhost("pet")
  self.Submerged = IsSubmerged()
  self.Alive = lb.UnitTagHandler(UnitIsDeadOrGhost, self.GUID) == false
  self.Dead = lb.UnitTagHandler(UnitIsDeadOrGhost, self.GUID)
  self.Ghost = lb.UnitTagHandler(UnitIsGhost, self.GUID)
  self.InInstance = (select(1, IsInInstance()))
  self:UpdateProfessions()
end

function PeaceMaker_LocalPlayer:GCDRemain()
  local GCDSpell = 61304
  local start, cd = GetSpellCooldown(GCDSpell)
  if start == 0 then return 0 end
  return math.max(0, (start + cd) - PeaceMaker.Time)
end

function PeaceMaker_LocalPlayer:IsStanding()
  if lb.UnitMovementFlags(self.GUID) == 0 then 
    return true
  end
  return false
end

function PeaceMaker_LocalPlayer:HasMovementFlag()
  if lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Forward)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Backward)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.StrafeLeft)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.StrafeRight)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Falling)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Ascending)
    or lb.UnitHasMovementFlag(self.GUID, __LB__.EMovementFlags.Descending) 
    or GetUnitSpeed("player") > 0
  then 
    return true
  end
  return false
end

itemSlots = { "HeadSlot", "ShoulderSlot", "ChestSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot" }
for index, slotName in ipairs(itemSlots) do
	itemSlots[slotName] = { slot = GetInventorySlotInfo(slotName) }
	itemSlots[index] = nil
end

function PeaceMaker_LocalPlayer:Durability()
	local cur, max
	local count = 0
	local percentSum = 0
	local percentItem = 0
	for slotName, tbl in next, itemSlots do
		tbl.min, tbl.max = GetInventoryItemDurability(tbl.slot)
		if (tbl.min and tbl.max) then
			count = count + 1
			percentItem = tbl.min / tbl.max * 100
			percentSum = percentSum + percentItem
			percentItem = 0
		end
	end
	return (percentSum / count)
end
