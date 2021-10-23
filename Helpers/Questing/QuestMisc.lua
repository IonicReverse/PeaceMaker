local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestMisc = {}
PeaceMaker.Helpers.Quest.QuestMisc.PointIndex = 1

local QuestMisc = PeaceMaker.Helpers.Quest.QuestMisc
local Misc = PeaceMaker.Helpers.Core.Misc
local Log = PeaceMaker.Helpers.Core.Log
local Navigation = PeaceMaker.Helpers.Core.Navigation
local PointIndex = PeaceMaker.Helpers.Quest.QuestMisc.PointIndex
local MacroDelay = 0
local NextProfile = false
local WaitTimer = 0
local SealTimer = false

local QuestAction = {
  IsInteract = false,
  IsQuestTimePassed = false,
  IsFacingUnit = false
}

local function SearchNpc(id)
  for _, i in ipairs(lb.GetObjects(60)) do
    local ids = lb.ObjectId(i)
    if ids == id then
      return i
    end
  end
end

local function SearchNearbyEnemy(id)
  for _, i in ipairs(lb.GetObjects(30)) do
    local ids = lb.ObjectId(i)
    local distance = lb.GetDistance3D(i)
    if ids == id and distance <= 5 then
      return i
    end
  end
end

function QuestMisc:LoadNextProfile(profilename)
  if NextProfile then return end
  lb.Unlock(RunMacroText, "/pc stop")
  lb.Unlock(RunMacroText, "/pc quest load " .. profilename)
  PeaceMaker.Settings.profile.Questing.QuestStep = 1
  C_Timer.After(0.5, function() lb.Unlock(RunMacroText, "/pc start quest") end)
  NextProfile = true
  C_Timer.After(1, function() NextProfile = false end)
end

function QuestMisc:ParseProfile()
  local QuestOrder = PeaceMaker.QuestOrder
  local Index = PeaceMaker.Settings.profile.Questing.QuestStep
  if QuestOrder and Index > #QuestOrder then Log:Run("Bot Stopped! Quest Done") lb.Unlock(RunMacroText, "/pc stop") return end 
  return QuestOrder[Index].Quest_Name, QuestOrder[Index].Quest_Settings
end

function QuestMisc:ParseProfileSettings(index)
  local QuestSettings = PeaceMaker.QuestSettingsList[index]
  return QuestSettings or false
end

function QuestMisc:MoveToNextStep()
  PeaceMaker.Settings.profile.Questing.QuestStep = PeaceMaker.Settings.profile.Questing.QuestStep + 1
  Log:Run(tostring(PeaceMaker.Settings.profile.Questing.QuestStep))
end

function QuestMisc:TargetNearestNpcID(id)
  local target = SearchNearbyEnemy(id)
  if not target then return end
  lb.UnitTagHandler(TargetUnit, target)
end

function QuestMisc:InteractNpcNearby(id)
  if QuestAction.IsInteract then return end
  Misc:InteractUnitWithinDistance(id, "Unit", 15)
  QuestAction.IsInteract = true
  C_Timer.After(1, function() QuestAction.IsInteract = false end)
end

function QuestMisc:InteractNpcNearbyAndAcceptQuest(id, questid)
  if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then
    self:InteractNpcNearby(id)
  else
    self:AcceptQuestNoMove(questid)
  end
end

function QuestMisc:InteractNpcNearbyAndCompleteQuest(id)
  if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then
    self:InteractNpcNearby(id)
  else
    self:TurnInAcceptQuestReward()
  end
end

function QuestMisc:InteractNpcNearbyAndGossip(id, option)
  if option == nil then option = 1 end
  if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
    self:InteractNpcNearby(id)
    PeaceMaker.Pause = PeaceMaker.Time + 2
  else
    if GossipFrame and GossipFrame:IsVisible() then C_GossipInfo.SelectOption(option) end
  end
end

function QuestMisc:InteractNpcNearbyAndGossipAndChangeState(id, option, state)
  if option == nil then option = 1 end
  if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
    self:InteractNpcNearby(id)
    PeaceMaker.Pause = PeaceMaker.Time + 2
  else
    if GossipFrame and GossipFrame:IsVisible() then C_GossipInfo.SelectOption(option) _G[state] = true end
  end
end

function QuestMisc:MoveToInteractAndWait(x, y, z, id, second, type)
  local px, py, pz = lb.ObjectPosition('player')
  if type == nil then type = "Object" end
  if second == nil then second = 1 end
  if lb.GetDistance3D(px, py, pz, x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    Misc:InteractUnit(id, type)
    QuestAction.IsInteract = true
    PeaceMaker.Pause = PeaceMaker.Time + second
    C_Timer.After(3, function() QuestAction.IsInteract = false end)
  end
end

function QuestMisc:SearchNpcAndInteract(npcid, option)
  local target = SearchNpc(npcid)
  if not target then return end
  if option == nil then option = 1 end
  if lb.GetDistance3D(target) > 3 then
    local x, y, z = lb.ObjectPosition(target)
    Navigation:MoveTo(x, y, z, 2)
  else
    if not GossipFrame:IsVisible() then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 1 end
    if GossipFrame and GossipFrame:IsVisible() then 
      C_GossipInfo.SelectOption(option) 
      C_Timer.After(2, function() 
        if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
        if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end 
      end) 
    end
  end
end

function QuestMisc:SearchNpcAndInteractAndDelay(npcid, delay, option)
  local target = SearchNpc(npcid)
  if not target then return end
  if option == nil then option = 1 end
  if lb.GetDistance3D(target) > 3 then
    local x, y, z = lb.ObjectPosition(target)
    Navigation:MoveTo(x, y, z, 2)
  else
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + delay end
    if GossipFrame and GossipFrame:IsVisible() then 
      C_GossipInfo.SelectOption(option) 
      C_Timer.After(2, function() 
        if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
        if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end 
      end) 
    end
  end
end

function QuestMisc:SearchNpcAndAcceptQuest(questid, npcid)
  local target = SearchNpc(npcid)
  if not target then return end
  local x, y, z = lb.ObjectPosition(target)
  self:AcceptQuest(x, y, z, questid, npcid)
end

function QuestMisc:SearchNpcAndCompleteQuest(questid, npcid, reward)
  local target = SearchNpc(npcid)
  if not target then return end
  if reward == nil then reward = 1 end
  local x, y, z = lb.ObjectPosition(target)
  self:CompleteQuest(x, y, z, questid, npcid, reward)
end

function QuestMisc:MoveToNpcAndInteract(x, y, z, npcid, option)
  local px, py, pz = lb.ObjectPosition('player')
  if option == nil then option = 1 end
  if lb.GetDistance3D(px, py, pz, x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 2 end
    if GossipFrame and GossipFrame:IsVisible() then 
      if StaticPopup1 and StaticPopup1Button1:IsVisible() then StaticPopup1Button1:Click() end
      C_GossipInfo.SelectOption(option) 
      C_Timer.After(5, function() 
        if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
        if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end 
      end) 
    end
  end
end

function QuestMisc:MoveToObjectAndInteract(x, y, z, objid, distance)
  if distance == nil then distance = 3 end
  if lb.GetDistance3D(x, y, z) > distance then
    Navigation:MoveTo(x, y, z, 2)
  else
    if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
    Misc:InteractUnit(objid, "Object") 
    PeaceMaker.Pause = PeaceMaker.Time + 1
  end
end

function QuestMisc:MoveToAndWait(x,y,z,second,distance)
  local px, py, pz = lb.ObjectPosition('player')
  if distance == nil then distance = 2.5 end
  if lb.GetDistance3D(px, py, pz, x, y, z) > distance then
    Navigation:MoveTo(x, y, z, 2)
  else
    PeaceMaker.Navigator.Stop()
    PeaceMaker.Pause = PeaceMaker.Time + second
  end
end

function QuestMisc:MoveToAndClickMoveToAndWait(x,y,z,cx,cy,cz,second)
  if PeaceMaker.Time > PeaceMaker.Pause then
    local px, py, pz = lb.ObjectPosition('player')
    if distance == nil then distance = 2.5 end
    if lb.GetDistance3D(px, py, pz, x, y, z) > distance then
      Navigation:MoveTo(x, y, z, 2)
    else
      lb.MoveTo(cx,cy,cz)
      PeaceMaker.Pause = PeaceMaker.Time + second
    end
  end
end

function QuestMisc:MoveToInteractFlightPathAndPlace(x, y, z, npcid, mapname)
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not FlightMapFrame or (FlightMapFrame and not FlightMapFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 2 end
    if FlightMapFrame and FlightMapFrame:IsVisible() then 
      for i = 1, NumTaxiNodes() do
        if TaxiNodeName(i) == mapname then
          TakeTaxiNode(i)
        end
      end
    end
  end
end

function QuestMisc:ClickToMoveAndInteractNpc(x,y,z,npcid,option)
  if PeaceMaker.Time > PeaceMaker.Pause then
    local px, py, pz = lb.ObjectPosition('player')
    if distance == nil then distance = 2.5 end
    if lb.GetDistance3D(px, py, pz, x, y, z) > distance then
      lb.MoveTo(x,y,z)
    else
      self:InteractNpcNearbyAndGossip(npcid, option)
    end
  end
end

function QuestMisc:MoveToInteractBoardAndSelectChoice(x, y, z, objid, option, distance)
  if distance == nil then distance = 3 end
  if lb.GetDistance3D(x,y,z) > distance then
    self:MoveToObjectAndInteract(x, y, z, objid, distance)
  else
    if not PlayerChoiceFrame or (PlayerChoiceFrame and not PlayerChoiceFrame:IsVisible()) then
      Misc:InteractUnit(objid, "Object") 
      PeaceMaker.Pause = PeaceMaker.Time + 2
    else
      self:SelectBoardChoice(option)
    end
  end
end 

function QuestMisc:ClickMoveToAcceptQuest(x,y,z, questid, npcid)
  local px, py, pz = lb.ObjectPosition('player')
  if lb.GetDistance3D(px, py, pz, x, y, z) > 3 then
    lb.MoveTo(x,y,z)
  else
    if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 1 end
    if QuestFrame:IsVisible() then
      self:AcceptQuestNoMove(questid)
    end
  end
end

function QuestMisc:ClickMoveToNpcAndInteract(x,y,z, npcid, option)
  local px, py, pz = lb.ObjectPosition('player')
  if option == nil then option = 1 end
  if lb.GetDistance3D(px, py, pz, x, y, z) > 3 then
    lb.MoveTo(x,y,z)
  else
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 1 end
    if GossipFrame and GossipFrame:IsVisible() then 
      C_GossipInfo.SelectOption(option) 
      C_Timer.After(2, function() 
        if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
        if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end 
      end) 
    end
  end
end

-- Quest
  
function QuestMisc:HasQuest(questID)
  if not C_QuestLog.IsQuestFlaggedCompleted(questID) and C_QuestLog.IsOnQuest(questID) then
    return true
  end
  return false
end

function QuestMisc:IsObjectiveCompleted(questID, part)
  if C_QuestLog.GetQuestObjectives(questID) and C_QuestLog.GetQuestObjectives(questID)[part] and C_QuestLog.GetQuestObjectives(questID)[part].finished == true then
    return true
  end
  return false
end

function QuestMisc:IsObjectivePartFulfilled(questID, part)
  return C_QuestLog.GetQuestObjectives(questID)[part].numFulfilled
end

function QuestMisc:IsQuestComplete(questID)
  if C_QuestLog.IsComplete(questID) then
    return true
  end
  return false
end

function QuestMisc:IsQuestCompleted(questID)
  if C_QuestLog.IsQuestFlaggedCompleted(questID) then
    return true
  end
  return false
end

function QuestMisc:AcceptQuestNoMove(questID)
  C_Timer.After(5, function() if QuestFrame and QuestFrame:IsVisible() and GetNumAvailableQuests() == 0 then CloseQuest() QuestFrameCloseButton:Click() end end) 
  if QuestInfoDescriptionText:IsVisible() then AcceptQuest() end
  for i = 1, GetNumAvailableQuests() do
    local _, _, _, _, questid = GetAvailableQuestInfo(i)
    if questid == questID then
      SelectAvailableQuest(i)
    end
  end
end

function QuestMisc:AcceptQuest(x, y, z, questID, npcid, type)
  if not lb.GetDistance3D(x, y, z) then return end
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if QuestInfoDescriptionText:IsVisible() then 
      AcceptQuest()
      C_Timer.After(5, function() if QuestFrame and QuestFrame:IsVisible() and GetNumAvailableQuests() == 0 then CloseQuest() QuestFrameCloseButton:Click() end end) 
    end
    if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then
      Misc:InteractUnit(npcid, type)
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      for i = 1, GetNumAvailableQuests() do
        local _, _, _, _, questid = GetAvailableQuestInfo(i)
        if questid == questID then
          SelectAvailableQuest(i)
          --C_Timer.After(8, function() if QuestFrame and QuestFrame:IsVisible() then CloseQuest() QuestFrameCloseButton:Click() end end)
          C_Timer.After(5, function() if QuestFrame and QuestFrame:IsVisible() and GetNumAvailableQuests() == 0 then CloseQuest() QuestFrameCloseButton:Click() end end)
        end
      end
    end
  end
end

function QuestMisc:AcceptChainQuest(questList, npcList, hotspotList)
  for i = 1, #questList do
    if not self:IsQuestCompleted(questList[i]) and not self:HasQuest(questList[i]) then
      local x, y, z = unpack(hotspotList[i])
      self:AcceptQuest(x, y, z, questList[i], npcList[i])
      return
    end
  end
end

function QuestMisc:CheckChainQuest(questList)

  if #questList == 2 then
    if (self:HasQuest(questList[1]) and self:HasQuest(questList[2])) 
      or (self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]))
      or (self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]))
      or (self:HasQuest(questList[1]) and self:IsQuestCompleted(questList[2]))
      or (self:HasQuest(questList[2]) and self:IsQuestCompleted(questList[1])) 
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[2]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[1]))
    then
      self:MoveToNextStep()
    end
  end

  if #questList == 3 then
    if (self:HasQuest(questList[1]) and self:HasQuest(questList[2]) and self:HasQuest(questList[3])) 
      or (self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[3]))
      or (self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]))
      or (self:HasQuest(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[3]))
      or (self:HasQuest(questList[2]) and self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[3]))
      or (self:HasQuest(questList[3]) and self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]))
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[3]))
      or (self:HasQuest(questList[3]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]))
    then
      self:MoveToNextStep()
    end
  end

  if #questList == 4 then
    if (self:HasQuest(questList[1]) and self:HasQuest(questList[2]) and self:HasQuest(questList[3]) and self:HasQuest(questList[4])) 
      or (self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[3]) and self:IsQuestCompleted(questList[4]))
      or (self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[4]))
      or (self:HasQuest(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[3]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[2]) and self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[3]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[3]) and self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[4]) and self:IsQuestCompleted(questList[1]) and self:IsQuestCompleted(questList[2]) and self:IsQuestCompleted(questList[1]))
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[4]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[4]))
      or (self:HasQuest(questList[3]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[4]))
      or (self:HasQuest(questList[4]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]))
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[3]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[3]))
      or (self:HasQuest(questList[1]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[2]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[1]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[3]))
      or (self:HasQuest(questList[2]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[1]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[3]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[2]) and self:IsQuestCompleted(questList[4]))
      or (self:HasQuest(questList[3]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[2]))
      or (self:HasQuest(questList[3]) and self:IsQuestComplete(questList[2]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[1]))
      or (self:HasQuest(questList[4]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[3]) and self:IsQuestCompleted(questList[2]))
      or (self:HasQuest(questList[4]) and self:IsQuestComplete(questList[1]) and self:IsQuestComplete(questList[4]) and self:IsQuestCompleted(questList[3]))
      or (self:HasQuest(questList[4]) and self:IsQuestComplete(questList[3]) and self:IsQuestComplete(questList[2]) and self:IsQuestCompleted(questList[1]))
    then
      self:MoveToNextStep()
    end
  end
end

function QuestMisc:AcceptQuestGossip(x, y, z, questID, npcid, type)
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if QuestInfoDescriptionText:IsVisible() then AcceptQuest() end
    if GossipFrame and GossipFrame:IsVisible() and #C_GossipInfo.GetAvailableQuests() == 0 then C_GossipInfo.CloseGossip() QuestFrameCloseButton:Click() end
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
      Misc:InteractUnit(npcid, type)
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      for i = 1, #C_GossipInfo.GetAvailableQuests() do
        if C_GossipInfo.GetAvailableQuests(1)[i].questID == questID then
          C_GossipInfo.SelectAvailableQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteQuest(x, y, z, questID, npcid, reward)
  if reward == nil then reward = 1 end
  if lb.GetDistance3D(x, y, z) > 3 then
    if QuestFrame and QuestFrameProgressPanel:IsVisible() then CloseQuest() end
    Navigation:MoveTo(x, y, z, 2)
  else
    if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then
      Misc:InteractUnit(npcid)
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
      if QuestFrameGreetingPanel:IsVisible() then
        for i = 1, GetNumActiveQuests() do
          SelectActiveQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteQuestObject(x, y, z, questID, npcid, reward)
  if reward == nil then reward = 1 end
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not QuestFrame or (QuestFrame and not QuestFrame:IsVisible()) then
      Misc:InteractUnit(npcid, "Object")
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
      if QuestFrameGreetingPanel:IsVisible() then
        for i = 1, GetNumActiveQuests() do
          SelectActiveQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteQuestGossip(x, y, z, questID, npcid, reward)
  if reward == nil then reward = 1 end
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
      Misc:InteractUnit(npcid)
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
      for i = 1, #C_GossipInfo.GetAvailableQuests() do
        if C_GossipInfo.GetAvailableQuests(1)[i].questID == questID then
          C_GossipInfo.SelectAvailableQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteActiveQuest(x, y, z, questID, npcid, reward)
  if reward == nil then reward = 1 end
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if QuestFrame:IsVisible() then
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
    end
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
      Misc:InteractUnit(npcid)
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
      for i = 1, C_GossipInfo.GetNumActiveQuests() do
        if C_GossipInfo.GetActiveQuests()[i].questID == questID then
          C_GossipInfo.SelectActiveQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteQuestObjectGossip(x, y, z, questID, npcid, reward)
  if reward == nil then reward = 1 end
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not GossipFrame or (GossipFrame and not GossipFrame:IsVisible()) then
      Misc:InteractUnit(npcid, "Object")
      PeaceMaker.Pause = PeaceMaker.Time + 1
    else
      if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then
        GetQuestReward(reward)
        CompleteQuest()
      end
      for i = 1, #C_GossipInfo.GetAvailableQuests() do
        if C_GossipInfo.GetAvailableQuests(1)[i].questID == questID then
          C_GossipInfo.SelectAvailableQuest(i)
        end
      end
    end
  end
end

function QuestMisc:CompleteQuestLog(questID)
  if QuestFrame and (QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible()) then
    GetQuestReward(reward)
    CompleteQuest()
    WorldMapFrame:Hide()
  else
    WorldMapFrame:Show()
    ShowQuestComplete(questID)
  end
end

function QuestMisc:TurnInAcceptQuestReward(reward, index)
  C_Timer.After(5, function() QuestAction.IsQuestTimePassed = true end)
  if index == nil then index = 1 end
  if reward == nil then reward = 1 end
  if QuestFrame and not QuestFrame:IsVisible() then return end
  if not QuestInfoDescriptionText:IsVisible() then C_GossipInfo.SelectAvailableQuest(index) end
  if not QuestInfoDescriptionText:IsVisible() then SelectAvailableQuest(index) end
  if not QuestInfoRewardText:IsVisible() then SelectActiveQuest(index) end
  if GossipFrame and GossipFrame:IsVisible() and GossipFrame_GetTitleButton and GossipFrame_GetTitleButton(1) then GossipFrame_GetTitleButton(1):Click() end
  if QuestInfoDescriptionText:IsVisible() then AcceptQuest() end
  if QuestFrameProgressPanel:IsVisible() or QuestFrameRewardPanel:IsVisible() then print("Here") GetQuestReward(reward) CompleteQuest() return end
  if not QuestInfoDescriptionText:IsVisible() or QuestAction.IsQuestTimePassed then
    QuestAction.IsQuestTimePassed = false
    CloseQuest()
    C_GossipInfo.CloseGossip()
    if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
    if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end
  end
end

function QuestMisc:MoveToAndTurnInAcceptQuestReward(x, y, z, npcid, reward, index)
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x,y,z, 2)
  else
    if not QuestFrame:IsVisible() then
      Misc:InteractUnit(npcid)
      PeaceMaker.Pause = PeaceMaker.Time + 0.5
    else
      self:TurnInAcceptQuestReward(reward, index)
    end
  end
end

function QuestMisc:GetMaxBagSlots()
  local Total = 0
  for i = 0, NUM_BAG_SLOTS do
    local Free = GetContainerNumSlots(i)
    Total = Total + Free
  end
  return Total
end

function QuestMisc:GetFreeBagSlots()
  local Total = 0
  for i = 0, NUM_BAG_SLOTS do
    local Free = GetContainerNumFreeSlots(i)
    Total = Total + Free
  end
  return Total
end

function QuestMisc:GetDistance2D(x, y)
  local pX, pY = lb.ObjectPosition("player")
  return sqrt(((x - pX) ^ 2) + ((y - pY) ^ 2))
end

function QuestMisc:GetNpcDistance(npcid)
  local target = SearchNpc(npcid)
  if not target then return end
  local Distance = lb.GetDistance3D(target)
  return Distance or 0
end

function QuestMisc:FaceUnit(npcid)
  if QuestAction.IsFacingUnit then return end
  local target = SearchNpc(npcid)
  if not target then return end
  Misc:FaceUnit(target)
  QuestAction.IsFacingUnit = true
  C_Timer.After(1, function() QuestAction.IsFacingUnit = false end)
end

function QuestMisc:CheckBuff(spellname, target)
  local buff, count, caster, expires, spellID
  local i = 0
  local go = true
  while i <= 40 and go do
    i = i + 1
    buff, _, count, _, duration, expires, caster, stealable, _, spellID = _G['UnitBuff'](target, i)
    if buff and buff == spellname then go = false return true end
  end
  return false
end

function QuestMisc:CheckNpcFlags(id, name)
  for _, i in pairs(PeaceMaker.Units) do
    if not name then
      if lb.ObjectId(i.GUID) == id then
        return i.UnitHasFlag
      end
    end
    if name then
      if lb.ObjectId(i.GUID) == id and i.Name == name then
        return i.UnitHasFlag
      end
    end
  end
  return 0
end

function QuestMisc:DisableInternalCombat()
  DisableCombat = true
  return DisableCombat
end

function QuestMisc:EnableInternalCombat()
  DisableCombat = false
  return DisableCombat
end

function QuestMisc:EnableCombatLootQuest()
  EnableCombatLootQuest = true
  return EnableCombatLootQuest
end

function QuestMisc:DisableCombatLootQuest()
  EnableCombatLootQuest = false
  return EnableCombatLootQuest
end

function QuestMisc:EnableUnstuck()
  DisableNaviUnstuck = true
  return DisableNaviUnstuck
end

function QuestMisc:DisableUnstuck()
  DisableNaviUnstuck = false
  return DisableNaviUnstuck
end

function QuestMisc:DisableMount()
  DisableMountQuest = true
  return DisableMountQuest
end

function QuestMisc:EnableMount()
  DisableMountQuest = false
  return DisableMountQuest
end

function QuestMisc:SellAllItem(RarityIndex)
  for BagID = 0, 5 do
    for BagSlot = 1, GetContainerNumSlots(BagID) do
      local itemID = select(10,GetContainerItemInfo(BagID, BagSlot))
      if itemID and itemID ~= 6948 then
        local itemClassID = select(12, GetItemInfo(itemID))
        local itemRarity = select(3, GetItemInfo(itemID))
        local itemLevel = select(4, GetItemInfo(itemID))
        local itemSellPrice = select(11, GetItemInfo(itemID))
        if itemRarity < RarityIndex and itemSellPrice > 0 then
          UseContainerItem(BagID, BagSlot)
        end
      end
    end
  end
end

function QuestMisc:JoinDungeon(category, joinType, dungeonList, hiddenCollapseList)
  return lb.Unlock(LFG_JoinDungeon, category, joinType, dungeonList, hiddenCollapseList)
end

function QuestMisc:LearnRidingSkill(x, y, z, npcid, ridingskill)
  if not GetSpellInfo(ridingskill) then 
    if lb.GetDistance3D(x,y,z) > 3 then
      Navigation:MoveTo(x,y,z,2)
    else
      if not ClassTrainerFrame or (ClassTrainerFrame and not ClassTrainerFrame:IsVisible()) then
        Misc:InteractUnit(npcid)
        PeaceMaker.Pause = PeaceMaker.Time + 1
      else
        ClassTrainerScrollFrameButton1:Click()
        ClassTrainerTrainButton:Click()
        lb.Unlock(RunMacroText, "/click StaticPopup1Button1")
      end
    end
  end
end

function QuestMisc:SaveHome(x, y, z, npcid, option, homename)
  if GetBindLocation() ~= homename then
    if StaticPopup1 and StaticPopup1:IsVisible() then StaticPopup1Button1:Click() end
    if option == nil then option = 1 end
    if lb.GetDistance3D(x, y, z) > 3 then
      Navigation:MoveTo(x, y, z, 2)
    else
      if not GossipFrame:IsVisible() then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 1 end
      if GossipFrame and GossipFrame:IsVisible() then 
        C_GossipInfo.SelectOption(option) 
        C_Timer.After(2, function() 
          if GossipFrameCloseButton and GossipFrameCloseButton:IsVisible() then GossipFrameCloseButton:Click() end
          if QuestFrameGoodbyeButton and QuestFrameGoodbyeButton:IsVisible() then QuestFrameGoodbyeButton:Click() end 
        end) 
      end
    end
  end
end

function QuestMisc:SelectBoardChoice(option)
  if PlayerChoiceFrame and PlayerChoiceFrame:IsVisible() then
    lb.Unlock(RunMacroText, "/run PlayerChoiceFrame.Option" .. option .. ".OptionButtonsContainer.button1:Click()")
  end
end

function QuestMisc:MoveToList(hotspot)
  if not PeaceMaker.QuestMoveToList then PeaceMaker.QuestMoveToList = hotspot return end
  if PeaceMaker.QuestMoveToList then if PeaceMaker.QuestMoveToList[1].x ~= hotspot[1].x then PeaceMaker.QuestMoveToList = hotspot return end end
  local HotSpot = PeaceMaker.QuestMoveToList
  if HotSpot ~= nil and HotSpot then
    if PointIndex > #HotSpot then PointIndex = 1 end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[PointIndex].x, HotSpot[PointIndex].y, HotSpot[PointIndex].z
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 3 then
        PointIndex = PointIndex + 1
        if PointIndex > #HotSpot then
          PointIndex = 1
        end
      else
        Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

function QuestMisc:DelayMacroText(text, second)
  if not MacroDelay then
    lb.Unlock(RunMacroText, text)
    MacroDelay = true
    C_Timer.After(second, function() MacroDelay = false end)
  end
end

function QuestMisc:CastSpell(spell)
  if Misc:SpellIsCastable(spell) then
    Misc:CastSpellByID(spell)
  end
end

function QuestMisc:MoveToMerchantAndBuyItem(x, y, z, npcid, itemid, quantity)

  local function AutoSelectVendorGossip()
    for i = 1, #C_GossipInfo.GetOptions() do
      if C_GossipInfo.GetOptions()[i].type == "vendor" then
        C_GossipInfo.SelectOption(i)
      end
    end
  end

  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x,y,z, 2)
  else
    if GossipFrame and GossipFrame:IsVisible() then AutoSelectVendorGossip() end
    if not MerchantFrame or (MerchantFrame and not MerchantFrame:IsVisible()) then
      self:InteractNpcNearby(npcid)
    else
      for i=1, GetMerchantNumItems() do
        local merchantitem_name = select(1, GetMerchantItemInfo(i));        
        if merchantitem_name == GetItemInfo(itemid) then
          BuyMerchantItem(i, quantity)
        end
      end
    end
  end

end

function QuestMisc:CheckAreaID()
  local ContinentID = C_Map.GetBestMapForUnit("player")
  return C_Map.GetMapInfo(ContinentID).mapID
end

function QuestMisc:ScenarioStepQuestIsComplete(num)
  local ScenarioName, ScenarioType, completed = C_Scenario.GetCriteriaInfo(num)
  return (completed == true or false)
end

function QuestMisc:CheckObjectExists(id)
  return Misc:CheckObjectExists(id)
end

function QuestMisc:Wait(sec)
  if PeaceMaker.Time > WaitTimer and not SealTimer then
    WaitTimer = PeaceMaker.Time + sec
    PeaceMaker.Pause = WaitTimer
    return
  else
    SealTimer = true
    C_Timer.After(sec, function() SealTimer = false end)
    return
  end
end