local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestGrind = {}

local QuestGrind = PeaceMaker.Helpers.Quest.QuestGrind
local QuestMisc = PeaceMaker.Helpers.Quest.QuestMisc
local Misc = PeaceMaker.Helpers.Core.Misc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log

function QuestGrind:NodeNearHotSpot(Node) 
  local HotSpot = PeaceMaker.QuestGrindHotSpot
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

function QuestGrind:SearchInteractGrindTarget(npcid, Type)
  
  local Table = {}
  if not Type then Type = "Unit" end

  if Type == "ObjectUnit" then
    for _, i in pairs(PeaceMaker.Units) do
      if Misc:CompareList(i.ObjectID, npcid) 
        and (lb.ObjectDynamicFlags(i.GUID) == -65020 or lb.ObjectDynamicFlags(i.GUID) == 0 or lb.ObjectDynamicFlags(i.GUID) == -64988)
      then
        if self:NodeNearHotSpot(i) then
          table.insert(Table, i)
        end
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
  
    for _, Object in pairs(Table) do
      if Object.GUID then
        return Object
      end
    end
  end

  if Type == "Unit" then
    for _, i in pairs(PeaceMaker.Units) do
      if Misc:CompareList(i.ObjectID, npcid) 
        and lb.UnitNpcFlags(i.GUID) == 16777216
      then
        if self:NodeNearHotSpot(i) then
          table.insert(Table, i)
        end
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
  
    for _, Object in pairs(Table) do
      if Object.GUID then
        return Object
      end
    end
  end

  if Type == "Object" then
    for _, i in pairs(PeaceMaker.GameObjects) do
      if Misc:CompareList(i.ObjectID, npcid) 
        and (lb.ObjectDynamicFlags(i.GUID) == -65020 or lb.ObjectDynamicFlags(i.GUID) == 0 or lb.ObjectDynamicFlags(i.GUID) == -64988)
      then
        if self:NodeNearHotSpot(i) then
          table.insert(Table, i)
        end
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
  
    for _, Object in pairs(Table) do
      if Object.GUID then
        return Object
      end
    end
  end

  if Type == "SpecialObject" then
    for _, i in pairs(PeaceMaker.GameObjects) do
      if Misc:CompareList(i.ObjectID, npcid) then
        if self:NodeNearHotSpot(i) then
          table.insert(Table, i)
        end
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
  
    for _, Object in pairs(Table) do
      if Object.GUID then
        return Object
      end
    end
  end

  return false
end

function QuestGrind:InteractRun(InteractGrindTarget, Distance)

  if not InteractGrindTarget then return end
  if Distance == nil then Distance = 3 end
  
  local DistanceBetweenMobs = lb.GetDistance3D(InteractGrindTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(InteractGrindTarget.PosX, InteractGrindTarget.PosY, InteractGrindTarget.PosZ) then
      Navigation:MoveTo(InteractGrindTarget.PosX, InteractGrindTarget.PosY, InteractGrindTarget.PosZ, 2)
    else
      self:AddBlackListTarget(InteractGrindTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        Misc:Interact(InteractGrindTarget.GUID)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end

end

function QuestGrind:Kill(hotspot, npcid, type, distance)

  if not PeaceMaker.QuestGrindHotSpot then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestGrindHotSpot and hotspot then if PeaceMaker.QuestGrindHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end end

  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchQuestAttackable(npcid, type, distance)

  if hasCombatEnemy then
    Log:Run("State : Quest Grind")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if not hasCombatEnemy then
    Log:Run("State : Quest Grind Roaming")
    Navigation:QuestRoam()
    return  
  end

end 

function QuestGrind:KillAndCheckBuffAndUseItem(hotspot, npcid, type, distance, itemid, spell)
  
  if not PeaceMaker.QuestGrindHotSpot then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestGrindHotSpot and hotspot then if PeaceMaker.QuestGrindHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end end

  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchSpecialQuestAttackable(npcid, type, distance)

  if QuestMisc:CheckBuff(spell, 'target') then
    Log:Run("State : Quest Use Item On Target")
    lb.Unlock(UseItemByName, itemid)
    return
  end

  if hasCombatEnemy
    and not QuestMisc:CheckBuff(spell, 'target')
  then
    Log:Run("State : Quest Grind")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if not hasCombatEnemy then
    Log:Run("State : Quest Grind Roaming")
    Navigation:QuestRoam()
    return  
  end

end

function QuestGrind:KillAroundPos(x, y, z, radius, npcid, types, distance)

  local npc

  local hotspot = {
    [1] = { x = x, y = y, z = z, radius = radius }
  }

  if type(npcid) == "number" then npc = { npcid } end
  if type(npcid) == "table" then npc = npcid end
  
  if not PeaceMaker.QuestGrindHotSpot then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestGrindHotSpot and hotspot then if PeaceMaker.QuestGrindHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end end

  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchQuestAttackable(npc, types, distance)

  if hasCombatEnemy then
    Log:Run("State : Quest Grind")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if not hasCombatEnemy then
    Log:Run("State : Quest Grind Roaming")
    Navigation:QuestRoam()
    return  
  end

end

function QuestGrind:KillAroundPosAndInteract(x, y, z, radius, npcid, objid, types, distance)

  local npc
  local obj

  local hotspot = {
    [1] = { x = x, y = y, z = z, radius = radius }
  }

  if type(npcid) == "number" then npc = { npcid } end
  if type(npcid) == "table" then npc = npcid end
  if type(objid) == "number" then obj = { objid } end
  if type(objid) == "table" then obj = objid end
  
  if not PeaceMaker.QuestGrindHotSpot then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestGrindHotSpot and hotspot then if PeaceMaker.QuestGrindHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestGrindHotSpot = hotspot WPIndex = 1 return end end

  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchQuestAttackable(npc, types, distance)
  local hasObject = self:SearchInteractGrindTarget(obj, "SpecialObject")

  if hasCombatEnemy then
    Log:Run("State : Quest Grind")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if not hasCombatEnemy and hasObject then
    Log:Run("State : Quest Grind Interact")
    self:InteractRun(hasObject)
    return
  end

  if not hasCombatEnemy and not hasObject then
    Log:Run("State : Quest Grind Roaming")
    Navigation:QuestRoam()
    return  
  end

end