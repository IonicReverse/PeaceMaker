local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestInteract = {}

local QuestInteract = PeaceMaker.Helpers.Quest.QuestInteract
local Misc = PeaceMaker.Helpers.Core.Misc
local QuestMisc = PeaceMaker.Helpers.Quest.QuestMisc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log
BlackListInteractTarget = {}
local doingAction = false

function QuestInteract:AddBlackListTarget(guid)
  table.insert(BlackListInteractTarget, guid)
end

function QuestInteract:CheckBlackListTarget(guid)
  for _, i in pairs(BlackListInteractTarget) do
    if i == guid then
      return true
    end
  end
  return false
end

function QuestInteract:NodeNearHotSpot(Node) 
  local HotSpot = PeaceMaker.QuestInteractHotSpot
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

function QuestInteract:SearchInteractTarget(npcid, Type)
  
  local Table = {}
  if not Type then Type = "Unit" end

  if Type == "ManualOMUnit" then
    local OM = lb.GetObjects()
    for _, guid in ipairs(OM) do
      if Misc:CompareList(lb.ObjectId(guid), npcid) then
        local x, y, z = lb.ObjectPosition(guid)
        table.insert(Table, {GUID = guid, PosX = x, PosY = y, PosZ = z})
      end
    end 
  
    for _, Object in pairs(Table) do
      if Object.GUID then
        return Object
      end
    end
  end

  if Type == "NormalUnit" then
    for _, i in pairs(PeaceMaker.Units) do
      if Misc:CompareList(i.ObjectID, npcid) 
        and not self:CheckBlackListTarget(i.GUID)
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

  if Type == "ObjectUnit" then
    for _, i in pairs(PeaceMaker.Units) do
      if Misc:CompareList(i.ObjectID, npcid) 
        and not self:CheckBlackListTarget(i.GUID)
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
        and not self:CheckBlackListTarget(i.GUID)
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
        and not self:CheckBlackListTarget(i.GUID)
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

  return false
end

function QuestInteract:Run(InteractTarget, Distance, Type)

  if not InteractTarget then return end
  if Distance == nil then Distance = 3 end
  if CurrentInteractObject == nil then CurrentInteractObject = InteractTarget return end
  
  if Type == "Unit" then
    if CurrentInteractObject and (lb.UnitNpcFlags(CurrentInteractObject.GUID) == 0 or lb.UnitHasFlag(CurrentInteractObject.GUID, lb.EUnitFlags.NotSelectable)) then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end

  if Type == "Object" or Type == "ObjectUnit" then
    if CurrentInteractObject and not (
      lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -65020 
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == 0
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -64988
    ) 
    then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end
  
  local DistanceBetweenMobs = lb.GetDistance3D(InteractTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ) then
      Navigation:MoveTo(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ, 2)
    else
      self:AddBlackListTarget(InteractTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if GossipFrame and GossipFrame:IsVisible() then C_GossipInfo.SelectOption(1) end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        Misc:Interact(InteractTarget.GUID)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end

end

function QuestInteract:DelayRun(InteractTarget, Distance, Type, Delay)

  if not InteractTarget then return end
  if Distance == nil then Distance = 3 end
  if CurrentInteractObject == nil then CurrentInteractObject = InteractTarget return end
  
  if Type == "Unit" then
    if CurrentInteractObject and (lb.UnitNpcFlags(CurrentInteractObject.GUID) == 0 or lb.UnitHasFlag(CurrentInteractObject.GUID, lb.EUnitFlags.NotSelectable)) then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end

  if Type == "Object" then
    if CurrentInteractObject and not (
      lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -65020 
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == 0
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -64988
    ) 
    then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end
  
  local DistanceBetweenMobs = lb.GetDistance3D(InteractTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ) then
      Navigation:MoveTo(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ, 2)
    else
      self:AddBlackListTarget(InteractTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        Misc:Interact(InteractTarget.GUID)
        doingAction = true
        PeaceMaker.Pause = PeaceMaker.Time + Delay
        C_Timer.After(Delay, function() doingAction = false end)
      end
    end
  end

end

function QuestInteract:TargetRun(InteractTarget, Distance, Type)

  if not InteractTarget then return end
  if Distance == nil then Distance = 3 end
  if CurrentInteractObject == nil then CurrentInteractObject = InteractTarget return end
  
  if Type == "Unit" then
    if CurrentInteractObject and (lb.UnitNpcFlags(CurrentInteractObject.GUID) == 0 or lb.UnitHasFlag(CurrentInteractObject.GUID, lb.EUnitFlags.NotSelectable)) then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end

  if Type == "Object" then
    if CurrentInteractObject and not (
      lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -65020 
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == 0
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -64988
    )
    then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end
  
  local DistanceBetweenMobs = lb.GetDistance3D(InteractTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ) then
      Navigation:MoveTo(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ, 2)
    else
      self:AddBlackListTarget(InteractTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        lb.UnitTagHandler(TargetUnit, InteractTarget.GUID)
        Misc:Interact(InteractTarget.GUID)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end

end

function QuestInteract:NpcRun(InteractTarget, Distance)

  if not InteractTarget then return end
  if Distance == nil then Distance = 3 end
  if CurrentInteractObject == nil then CurrentInteractObject = InteractTarget return end
  
  if CurrentInteractObject and (lb.UnitNpcFlags(CurrentInteractObject.GUID) == 0 or lb.UnitHasFlag(CurrentInteractObject.GUID, lb.EUnitFlags.NotSelectable)) then 
    self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
  end
  
  local DistanceBetweenMobs = lb.GetDistance3D(InteractTarget.GUID)
  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    if lb.NavMgr_IsReachable(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ) then
      Navigation:MoveTo(InteractTarget.PosX, InteractTarget.PosY, InteractTarget.PosZ, 2)
    else
      self:AddBlackListTarget(InteractTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if GossipFrame and GossipFrame:IsVisible() then C_GossipInfo.SelectOption(1) end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        Misc:Interact(InteractTarget.GUID)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end

end

function QuestInteract:RunFloat(InteractTarget, Distance, Type)

  if not InteractTarget then return end
  if Distance == nil then Distance = 3 end
  if CurrentInteractObject == nil then CurrentInteractObject = InteractTarget return end
  
  if Type == "Unit" then
    if CurrentInteractObject and (lb.UnitNpcFlags(CurrentInteractObject.GUID) == 0 or lb.UnitHasFlag(CurrentInteractObject.GUID, lb.EUnitFlags.NotSelectable)) then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end

  if Type == "Object" or Type == "ObjectUnit" then
    if CurrentInteractObject and not (
      lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -65020 
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == 0
      or lb.ObjectDynamicFlags(CurrentInteractObject.GUID) == -64988
    ) 
    then 
      self:AddBlackListTarget(CurrentInteractObject.GUID) CurrentInteractObject = nil return 
    end
  end
  
  local DistanceBetweenMobs = QuestMisc:GetDistance2D(InteractTarget.PosX, InteractTarget.PosY)

  if DistanceBetweenMobs and DistanceBetweenMobs > Distance then
    local z
    if InteractTarget.PosZ > PeaceMaker.Player.PosZ then
      z = InteractTarget.PosZ - (InteractTarget.PosZ - PeaceMaker.Player.PosZ)
    else
      z = InteractTarget.PosZ
    end
    if lb.NavMgr_IsReachable(InteractTarget.PosX, InteractTarget.PosY, z) then
      Navigation:MoveTo(InteractTarget.PosX, InteractTarget.PosY, z, 2)
    else
      self:AddBlackListTarget(InteractTarget.GUID)
    end
  else
    if DistanceBetweenMobs and DistanceBetweenMobs <= Distance then
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
      if GossipFrame and GossipFrame:IsVisible() then C_GossipInfo.SelectOption(1) end
      if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
        Misc:Interact(InteractTarget.GUID)
        doingAction = true
        C_Timer.After(3, function() doingAction = false end)
      end
    end
  end

end

function QuestInteract:Interact(hotspot, npcid, type, distance)

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npcid, type)

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:Run(hasInteractTarget, distance, type)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end 

function QuestInteract:InteractFloatObject(hotspot, npcid, type, distance)

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npcid, type)

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:RunFloat(hasInteractTarget, distance, type)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end

function QuestInteract:InteractAndDelay(hotspot, npcid, type, delay, distance)

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npcid, type)

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:DelayRun(hasInteractTarget, distance, type, delay)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end 

function QuestInteract:InteractAroundPos(x, y, z, radius, npcid, types, distance)

  local npc

  local hotspot = {
    [1] = { x = x, y = y, z = z, radius = radius }
  }

  if type(npcid) == "number" then npc = { npcid } end
  if type(npcid) == "table" then npc = npcid end

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npc, types)

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:Run(hasInteractTarget, distance, types)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end

function QuestInteract:InteractTarget(hotspot, npcid, type, distance)

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npcid, type)

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:TargetRun(hasInteractTarget, distance, type)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end 

function QuestInteract:InteractNpcAndKill(x, y, z, radius, npcid, distance)

  local npc

  local hotspot = {
    [1] = { x = x, y = y, z = z, radius = radius }
  }

  if type(npcid) == "number" then npc = { npcid } end
  if type(npcid) == "table" then npc = npcid end

  if not PeaceMaker.QuestInteractHotSpot then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestInteractHotSpot and hotspot then if PeaceMaker.QuestInteractHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestInteractHotSpot = hotspot WPIndex = 1 return end end

  local hasInteractTarget = self:SearchInteractTarget(npc, "NormalUnit")

  if hasInteractTarget then
    Log:Run("State : Quest Interact")
    self:NpcRun(hasInteractTarget, distance)
    return
  end

  if not hasInteractTarget then
    Log:Run("State : Quest Interact Roaming")
    Navigation:QuestInteractRoam()
    return  
  end

end