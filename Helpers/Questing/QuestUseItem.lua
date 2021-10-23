local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestUseItem = {}

local QuestUseItem = PeaceMaker.Helpers.Quest.QuestUseItem
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Misc = PeaceMaker.Helpers.Core.Misc
local Log = PeaceMaker.Helpers.Core.Log
local BlackListUnit = {}
local doingAction = false

function QuestUseItem:AddBlackListTarget(guid)
  table.insert(BlackListUnit, guid)
end

function QuestUseItem:CheckBlackListTarget(guid)
  for _, i in pairs(BlackListUnit) do
    if i == guid then
      return true
    end
  end
  return false
end

function QuestUseItem:NodeNearHotSpot(Node) 
  local HotSpot = PeaceMaker.QuestUseItemHotspot
  if not HotSpot then return false end
  for i = 1, #HotSpot do
    local hx, hy, hz = HotSpot[i].x, HotSpot[i].y, HotSpot[i].z
    local radius = HotSpot[i].radius or 100
    if Node.PosX and Node.PosY and Node.PosZ and hx and hy and hz then
      if lb.GetDistance3D(Node.PosX, Node.PosY, Node.PosZ, hx, hy, hz) <= radius then
        return true
      end
    end
  end
  return false
end

function QuestUseItem:SearchAttackable(id)

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if self:NodeNearHotSpot(Unit) 
        and Misc:CompareList(Unit.ObjectID, id) 
        and not Unit.Dead 
      then
        table.insert(Table, Unit)
      end
    end
  end

  if Table and #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    return Unit
  end

  return false
end

function QuestUseItem:SearchUnit(id)

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Misc:CompareList(Unit.ObjectID, id) 
      and not self:CheckBlackListTarget(Unit.GUID)
      and self:NodeNearHotSpot(Unit) 
      and not Unit.Dead
    then
      table.insert(Table, Unit)
    end
  end

  if #Table > 1 then
    table.sort(
      Table,
      function(x, y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in pairs(Table) do
    return Unit
  end

end

function QuestUseItem:SearchDeadUnit(id, buff, bufftype)

  if bufftype == 1 then bufftype = UnitBuff end
  if bufftype == 2 then bufftype = UnitDebuff end

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Misc:CompareList(Unit.ObjectID, id) 
      and not self:CheckBlackListTarget(Unit.GUID)
      and self:NodeNearHotSpot(Unit) 
      and not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID)
      and Unit.Dead
    then
      table.insert(Table, Unit)
    end
  end

  if #Table > 1 then
    table.sort(
      Table,
      function(x, y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in pairs(Table) do
    if not Misc:CheckGuidBuff(buff, Unit.GUID, bufftype) then
      return Unit
    end
  end

end

function QuestUseItem:Run(UseItemTarget, Itemid, Distance, Buff)

  if not UseItemTarget then return end
  if Distance == nil then Distance = 4 end

  if CurrentUseItemTarget and 
    (lb.UnitHasFlag(CurrentUseItemTarget.GUID, lb.EUnitFlags.NotSelectable) or Misc:CheckGuidBuff(Buff, CurrentUseItemTarget.GUID) or NoValidTargetError)
  then
    self:AddBlackListTarget(UseItemTarget.GUID)
    CurrentUseItemTarget = nil
    return
  end

  if CurrentUseItemTarget == nil then CurrentUseItemTarget = UseItemTarget return end

  local DistanceBetweenMobs = lb.GetDistance3D(UseItemTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(UseItemTarget.PosX, UseItemTarget.PosY, UseItemTarget.PosZ) then
      Navigation:MoveTo(UseItemTarget.PosX, UseItemTarget.PosY, UseItemTarget.PosZ, 2)
    else
      self:AddBlackListTarget(UseItemTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() PeaceMaker.Pause = PeaceMaker.Time + 0.5 return end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        lb.UnitTagHandler(TargetUnit, UseItemTarget.GUID)
        C_Timer.After(0.5, function() lb.Unlock(UseItemByName, Itemid) end)
        doingAction = true
        C_Timer.After(5, function() doingAction = false end)
      end
    end
  end
end

function QuestUseItem:ActionRun(UseItemTarget, action, Distance, Buff)

  if not UseItemTarget then return end
  if Distance == nil then Distance = 4 end

  if CurrentUseItemTarget and 
    (lb.UnitHasFlag(CurrentUseItemTarget.GUID, lb.EUnitFlags.NotSelectable) or Misc:CheckGuidBuff(Buff, CurrentUseItemTarget.GUID) or NoValidTargetError)
  then
    self:AddBlackListTarget(UseItemTarget.GUID)
    CurrentUseItemTarget = nil
    return
  end

  if CurrentUseItemTarget == nil then CurrentUseItemTarget = UseItemTarget return end

  local DistanceBetweenMobs = lb.GetDistance3D(UseItemTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(UseItemTarget.PosX, UseItemTarget.PosY, UseItemTarget.PosZ) then
      Navigation:MoveTo(UseItemTarget.PosX, UseItemTarget.PosY, UseItemTarget.PosZ, 2)
    else
      self:AddBlackListTarget(UseItemTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() PeaceMaker.Pause = PeaceMaker.Time + 0.5 return end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        lb.UnitTagHandler(TargetUnit, UseItemTarget.GUID)
        C_Timer.After(0.5, function() lb.Unlock(RunMacroText, action) end)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end
end

function QuestUseItem:UseItem(hotspot, npcid, itemid, distance)

  if not PeaceMaker.QuestUseItemHotspot then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestUseItemHotspot and hotspot then if PeaceMaker.QuestUseItemHotspot[1].x ~= hotspot[1].x then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end end

  local SearchUnit = self:SearchUnit(npcid)

  if SearchUnit then
    Log:Run("State : Quest Use Item")
    self:Run(SearchUnit, itemid, distance)
    return
  end

  if not SearchUnit then
    Log:Run("State : Quest Roaming Use Item")
    Navigation:QuestUseItemRoam()
    return
  end

end

function QuestUseItem:UseItemAction(hotspot, npcid, action, distance, buff)

  if not PeaceMaker.QuestUseItemHotspot then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestUseItemHotspot and hotspot then if PeaceMaker.QuestUseItemHotspot[1].x ~= hotspot[1].x then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end end

  local SearchUnit = self:SearchUnit(npcid)

  if SearchUnit then
    Log:Run("State : Quest Use Item")
    self:ActionRun(SearchUnit, action, distance, buff)
    return
  end

  if not SearchUnit then
    Log:Run("State : Quest Roaming Use Item")
    Navigation:QuestUseItemRoam()
    return
  end

end

function QuestUseItem:KillAndUseItemOnCorpse(hotspot, npcid, itemid, distance, buff, buffType)

  if not PeaceMaker.QuestUseItemHotspot then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestUseItemHotspot and hotspot then if PeaceMaker.QuestUseItemHotspot[1].x ~= hotspot[1].x then PeaceMaker.QuestUseItemHotspot = hotspot WPIndex = 1 return end end

  local SearchUnit = self:SearchDeadUnit(npcid, buff, buffType)
  local hasCombatEnemy = self:SearchAttackable(npcid)

  if not SearchUnit and hasCombatEnemy then
    Log:Run("State : Quest Grind")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if SearchUnit then
    Log:Run("State : Quest Use Item")
    self:Run(SearchUnit, itemid, distance, buff)
    return
  end

  if not SearchUnit and not hasCombatEnemy then
    Log:Run("State : Quest Roaming Use Item")
    Navigation:QuestUseItemRoam()
    return
  end

end

function QuestUseItem:UseItemOnLocation(hotspot, itemid, second, distance)
  if not PeaceMaker.QuestUseItemOnLocation then PeaceMaker.QuestUseItemOnLocation = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestUseItemOnLocation and hotspot then if PeaceMaker.QuestUseItemOnLocation[1].x ~= hotspot[1].x then PeaceMaker.QuestUseItemOnLocation = hotspot WPIndex = 1 return end end
  if IsMounted() then Dismount() end
  Navigation:QuestUseItemOnLocationRoam(itemid, distance)
end

function QuestUseItem:UseItemOnSelf(itemid)
  if not PeaceMaker.Player.Casting then
    lb.Unlock(UseItemByName, itemid)
  end
end