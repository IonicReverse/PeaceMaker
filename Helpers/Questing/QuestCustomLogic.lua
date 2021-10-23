local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestCustomLogic = {}

local QuestCustomLogic = PeaceMaker.Helpers.Quest.QuestCustomLogic
local Misc = PeaceMaker.Helpers.Core.Misc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local BlackListUnit = {}
local doingAction = false
local ShootDelay = false

function QuestCustomLogic:AddBlackListTarget(guid)
  table.insert(BlackListUnit, guid)
end

function QuestCustomLogic:CheckBlackListTarget(guid)
  for _, i in pairs(BlackListUnit) do
    if i == guid then
      return true
    end
  end
  return false
end

function QuestCustomLogic:SearchTarget(id)
  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Misc:CompareList(Unit.ObjectID, id) 
      and not Unit.Dead
      and not self:CheckBlackListTarget(Unit.GUID)
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

function QuestCustomLogic:AimTarget(button, Target)
  if not Target then return end
  if CurrentAimTarget and lb.UnitTagHandler(UnitDeadIsOrGhost, CurrentAimTarget.GUID) then
    self:AddBlackListTarget(CurrentAimTarget.GUID)
    CurrentUseItemTarget = nil
    return
  end
  if CurrentAimTarget == nil then CurrentAimTarget = Target return end
  if CurrentAimTarget then
    if not doingAction then
      lb.Unlock(RunMacroText, button)
      doingAction = true
      C_Timer.After(1, function() lb.ClickPosition(CurrentAimTarget.PosX, CurrentAimTarget.PosY, CurrentAimTarget.PosZ) end)
      C_Timer.After(2, function() doingAction = false end)
    end
  end
end

function QuestCustomLogic:VechileAimAndShoot(button, id)
  local SearchTarget = self:SearchTarget(id)
  if SearchTarget then
    self:AimTarget(button, SearchTarget)
  end
end

function QuestCustomLogic:TargetUnitAndAttack(id)
  if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
  Misc:TargetUnit(id)
  C_Timer.After(0.5, function() lb.Unlock(RunMacroText, "/startattack") end)
end

function QuestCustomLogic:TargetUnitAndEmo(id, emoticon)
  if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
  Misc:TargetUnit(id)
  C_Timer.After(0.5, function() lb.Unlock(RunMacroText, emoticon) end)
end

function QuestCustomLogic:MoveToUseItemOnNPC(x, y, z, itemid, npc, distance)
  if PeaceMaker.Player.Casting then return end
  if distance == nil then distance = 3 end
  if lb.GetDistance3D(x,y,z) > distance then
    Navigation:MoveTo(x,y,z, 2)
  else
    if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
    Misc:TargetUnit(npc)
    C_Timer.After(0.5, function() lb.Unlock(UseItemByName, itemid) end)
  end
end

function QuestCustomLogic:HardCodedFlyingBombQuest()
  if not ShootDelay then
    lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
    lb.ClickPosition(159, -2387, 86)
    C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
      lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
      lb.ClickPosition(189, -2356, 84)
      C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
        lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
        lb.ClickPosition(185, -2314, 83)
        C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
          lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
          lb.ClickPosition(220, -2321, 83)
          C_Timer.After((0.5 + math.random(0.1, 0.2)), function()
            lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
            lb.ClickPosition(245, -2334, 81)
            C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
              lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
              lb.ClickPosition(209, -2287, 82)
              C_Timer.After((0.5 + math.random(0.1, 0.2)), function()
                lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
                lb.ClickPosition(258, -2303, 83)
                C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
                  lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
                  lb.ClickPosition(240, -2273, 81)
                end)
              end)
            end)
          end)
        end)
      end)
    end)
    ShootDelay = true
    C_Timer.After(7, function() ShootDelay = false end)
  end
end

function QuestCustomLogic:HardCodedCannonTank()
  if not ShootDelay then
    lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
    lb.ClickPosition(3961.25, -2012.775, 25.11)
    C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
      lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
      lb.ClickPosition(3985.594, -2009.8081, 28.25)
      C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
        lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
        lb.ClickPosition(3993.743, -2004.154, 29.1704)
        C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
          lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
          lb.ClickPosition(3984.066, -1982.4782, 29.1473)
          C_Timer.After((0.5 + math.random(0.1, 0.3)), function()
            lb.Unlock(RunMacroText, "/click OverrideActionBarButton1")
            lb.ClickPosition(3914.506, -2029.2977, 18.6004)
          end)
        end)
      end)
    end)
    ShootDelay = true
    C_Timer.After(5, function() ShootDelay = false end)
  end
end

function QuestCustomLogic:HardCodedMissionProbable()
  local missionID = 2
  local followerID = 34
  local allFollowers = C_Garrison.GetFollowers(1);
  for i=1, #allFollowers do
    if (allFollowers[i].garrFollowerID == followerID)  then  
      C_Garrison.AddFollowerToMission(missionID, allFollowers[i].followerID);
      break
    end
  end
  C_Garrison.StartMission(2)
  C_Timer.After(3, function() GarrisonMissionFrame.CloseButton:Click() end)
end