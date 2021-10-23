local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestGather = {}

local QuestGather = PeaceMaker.Helpers.Quest.QuestGather
local QuestMisc = PeaceMaker.Helpers.Quest.QuestMisc
local Misc = PeaceMaker.Helpers.Core.Misc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log
local doingAction = false

function QuestGather:NodeNearHotSpot(Node) 
  local HotSpot = PeaceMaker.QuestGatherHotSpot
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

function QuestGather:ObjectSearch(objectID)
  local Table = {}
  for _, Object in pairs(PeaceMaker.GameObjects) do
    if Object.GUID then
      if Misc:CompareList(Object.ObjectID, objectID) and not Misc:CheckBlackListGameObject(Object.GUID) then
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

function QuestGather:Gathering(objectID)
  
  local gotQuestObject = self:ObjectSearch(objectID)

  if CurrentQuestObject == nil then 
    gotQuestObject.ObjTimer = PeaceMaker.Time + 60 
    CurrentQuestObject = gotQuestObject 
  end

  if CurrentQuestObject 
    and (not lb.ObjectExists(CurrentQuestObject.GUID)
      or PeaceMaker.Time > CurrentQuestObject.ObjTimer)
  then
    Misc:BlackListGameObject(CurrentQuestObject.GUID) CurrentQuestObject = nil return 
  end

  if CurrentQuestObject then
    local Distance = lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, CurrentQuestObject.PosX, CurrentQuestObject.PosY, CurrentQuestObject.PosZ)
    if Distance then
      if Distance >= 4 then
        if lb.NavMgr_IsReachable(CurrentQuestObject.PosX, CurrentQuestObject.PosY, CurrentQuestObject.PosZ) then
          Navigation:MoveTo(CurrentQuestObject.PosX, CurrentQuestObject.PosY, CurrentQuestObject.PosZ, 3)
        else
          Misc:BlackListGameObject(CurrentQuestObject.GUID)
          CurrentQuestObject = nil
        end
      else
        if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
        if (not lb.ObjectExists(CurrentQuestObject.GUID)
          or PeaceMaker.Time > CurrentQuestObject.ObjTimer)
        then
          Misc:BlackListGameObject(CurrentQuestObject.GUID)
          CurrentQuestObject = nil
          return
        end
        if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
          Misc:Interact(CurrentQuestObject.GUID)
          doingAction = true
          C_Timer.After(1, function() doingAction = false end)
        end
      end
    end
    return
  end

end

function QuestGather:Gather(hotspot, objectid)
  
  if not PeaceMaker.QuestGatherHotSpot then PeaceMaker.QuestGatherHotSpot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestGatherHotSpot and hotspot then if PeaceMaker.QuestGatherHotSpot[1].x ~= hotspot[1].x then PeaceMaker.QuestGatherHotSpot = hotspot WPIndex = 1 return end end

  local hasObject = self:ObjectSearch(objectid)

  if hasObject then
    Log:Run("State : Quest Gather")
    self:Gathering(objectid)
    return
  end

  if not hasObject then
    Log:Run("State : Quest Gather Roaming")
    Navigation:QuestGatherRoam()
    return  
  end

end