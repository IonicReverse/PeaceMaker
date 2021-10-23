local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Grinding.Gather = {}

local Gather = PeaceMaker.Helpers.Grinding.Gather
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Misc = PeaceMaker.Helpers.Core.Misc
local doingAction = false

local function GetNearbyWayPoint(WayPointTable)
  local tmp = {}
  if (WayPointTable ~= nil) then
    for i = 1, #WayPointTable do
      local px,py,pz = lb.ObjectPosition('player')
      local nx,ny,nz = WayPointTable[i].x, WayPointTable[i].y, WayPointTable[i].z
      local Dist = lb.GetDistance3D(px,py,pz,nx,ny,nz)
      table.insert(tmp, {Index = i, Distance = Dist})
    end
    if #tmp > 1 then
      table.sort(
        tmp,
        function(x, y)
          return x.Distance < y.Distance
        end
      )
    end
    WPIndex = tmp[1].Index
  end
end

function Gather:CheckNodeNearby(Distance)
  local Table = {}
  for _, Object in pairs(PeaceMaker.GameObjects) do
    if lb.NavMgr_IsReachable(Object.PosX, Object.PosY, Object.PosZ) then
      if self:NodeNearHotSpot(Object) then
        table.insert(Table, Object)
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

  for _, Object in ipairs(Table) do
    if (Object.Ore and Object.Distance < Distance and Object.ObjDynamicFlag ~= -65520 and Object.ObjDynamicFlag ~= 0) 
      or (Object.Herb and Object.Distance < Distance and Object.ObjDynamicFlag ~= -65520 and Object.ObjDynamicFlag ~= 0) 
    then
      return true
    end
  end
  return false
end

function Gather:NodeNearHotSpot(Node) 
  local HotSpot = PeaceMaker.GrindHotSpot
  for i = 1, #HotSpot do
    --local px, py, pz = lb.ObjectPosition('player')
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

function Gather:CheckGatherBlackListPos(Object)
  if PeaceMaker.GatherBlackListPos ~= nil and #PeaceMaker.GatherBlackListPos > 0 then
    for i = 1, #PeaceMaker.GatherBlackListPos do
      local nodeX, nodeY, nodeZ = unpack(PeaceMaker.GatherBlackListPos[i])
      local dist = lb.GetDistance3D(Object.PosX, Object.PosY, Object.PosZ, nodeX, nodeY, nodeZ)
      if dist and dist < 2 then
        return true
      end
    end
  end
  return false
end

function Gather:HerbSearch()
  local Table = {}
  for _, Object in pairs(PeaceMaker.GameObjects) do
    if Object.GUID and not self:CheckGatherBlackListPos(Object) then
      if Object.Herb and not Misc:CheckBlackListHerb(Object.GUID) then
        if self:NodeNearHotSpot(Object) then
          table.insert(Table, Object)
        end
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

  return false
end

function Gather:MineSearch()
  local Table = {}
  for _, Object in pairs(PeaceMaker.GameObjects) do
    if Object.GUID and not self:CheckGatherBlackListPos(Object) then
      if Object.Ore and not Misc:CheckBlackListMine(Object.GUID) then
        if self:NodeNearHotSpot(Object) then
          table.insert(Table, Object)
        end
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

  return false
end

function Gather:Run(gotHerb, gotMine)

  if CurrentObject 
    and (
      lb.ObjectDynamicFlags(CurrentObject.GUID) ~= -65536
      or PeaceMaker.Time > CurrentObject.ObjTimer
    ) 
  then
    if CurrentObject.Herb then Misc:BlackListHerb(CurrentObject.GUID) CurrentObject = nil return end
    if CurrentObject.Ore then Misc:BlackListMine(CurrentObject.GUID) CurrentObject = nil return end
  end

  if CurrentObject == nil then
    if gotHerb and not Misc:CheckBlackListHerb(gotHerb.GUID) then 
      gotHerb.ObjTimer = PeaceMaker.Time + 60
      CurrentObject = gotHerb
      return 
    end
    if gotMine and not Misc:CheckBlackListMine(gotMine.GUID) then 
      gotMine.ObjTimer = PeaceMaker.Time + 60
      CurrentObject = gotMine
      return 
    end
  end

  if CurrentObject and CurrentObject.Ore and PeaceMaker.FailedMining > 6 then
    Misc:BlackListMine(CurrentObject.GUID) CurrentObject = nil PeaceMaker.FailedMining = 0 return
  end

  if CurrentObject then
    local Distance = lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, CurrentObject.PosX, CurrentObject.PosY, CurrentObject.PosZ)
    if Distance then
      if Distance <= 10 then
        if lb.Raycast(self.PosX, self.PosY, self.PosZ + 0.5, OtherUnit.PosX, OtherUnit.PosY, OtherUnit.PosZ + 0.5, lb.ERaycastFlags.EntityCollision) == nil then 
          if CurrentObject.Herb then Misc:BlackListHerb(CurrentObject.GUID) elseif CurrentObject.Ore then Misc:BlackListMine(CurrentObject.GUID) end 
          return
        end
      end
      if Distance >= 4 then
        if lb.NavMgr_IsReachable(CurrentObject.PosX, CurrentObject.PosY, CurrentObject.PosZ) then
          Navigation:MoveTo(CurrentObject.PosX, CurrentObject.PosY, CurrentObject.PosZ, 4)
        else
          if CurrentObject.Herb then 
            Misc:BlackListHerb(CurrentObject.GUID) 
          end
          if CurrentObject.Ore then
            Misc:BlackListMine(CurrentObject.GUID)
          end
        end
      else
        if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
        if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
          Misc:Interact(CurrentObject.GUID)
          doingAction = true
          WPIndex = GetNearbyWayPoint(PeaceMaker.GrindHotSpot)
          C_Timer.After(3, function() doingAction = false end)
        end
      end
    end
  end

  return

end