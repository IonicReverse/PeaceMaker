local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.Questing = {}

local Quest = PeaceMaker.Helpers.Quest.Questing
local Grind = PeaceMaker.Helpers.Quest.QuestGrind
local Gather = PeaceMaker.Helpers.Quest.QuestGather
local Log = PeaceMaker.Helpers.Core.Log
local LoadAPI = false

local AFKTimer = 0

QuestState = {
  Idle = "Idle",
  Safety = "Safety", 
  Dead = "Dead",
  Alive = "Alive",
  Combat = "Combat",
  Rest = "Rest",
  Loot = "Loot",
  Interact = "Interact",
  Gather = "Gather",
  Mount = "Mount",
  Vendor = "Vendor",
  Grind = "Grind",
  Kill = "Kill",
  Roaming = "Roaming",
  Quest = "Quest"
}

QuestCurrentState = QuestState.Idle

local function LoadQuestAPI()

  PeaceMaker_Log = function(...) return PeaceMaker.Helpers.Core.Log:Run(...) end
  PeaceMaker_QuestIDLog = function(...) return PeaceMaker.Helpers.Core.Log:Run("Quest ID : " .. ...) end
  
  PeaceMaker_Faction = function() local Faction, _ = UnitFactionGroup('player') return Faction end 
  PeaceMaker_MapID = function() return lb.GetMapId() end
  PeaceMaker_MacroText = function(...) return lb.Unlock(RunMacroText, ...) end
  PeaceMaker_DelayMacroText = function(text) return PeaceMaker.Helpers.Quest.QuestMisc:DelayMacroText(text) end 

  PeaceMaker_InteractNpcNearBy = function(id) return PeaceMaker.Helpers.Quest.QuestMisc:InteractNpcNearby(id) end
  PeaceMaker_InteractNpcNearbyAndGossip = function(npcid, option) return PeaceMaker.Helpers.Quest.QuestMisc:InteractNpcNearbyAndGossip(npcid, option) end
  PeaceMaker_InteractNpcNearbyAndGossipAndChangeState = function(npcid, option, state) return PeaceMaker.Helpers.Quest.QuestMisc:InteractNpcNearbyAndGossipAndChangeState(npcid, option, state) end
  PeaceMaker_InteractNpcNearbyAndCompleteQuest = function(id) return PeaceMaker.Helpers.Quest.QuestMisc:InteractNpcNearbyAndCompleteQuest(id) end
  PeaceMaker_InteractNpcNearbyAndAcceptQuest = function(id, questid) return PeaceMaker.Helpers.Quest.QuestMisc:InteractNpcNearbyAndAcceptQuest(id, questid) end

  PeaceMaker_ClickMoveToNpcAndInteract = function(x, y, z, npcid, option) return PeaceMaker.Helpers.Quest.QuestMisc:ClickMoveToNpcAndInteract(x, y, z, npcid, option) end
  PeaceMaker_ClickMoveToAcceptQuest = function(x, y, z, questid, npcid) return PeaceMaker.Helpers.Quest.QuestMisc:ClickMoveToAcceptQuest(x, y, z, questid, npcid) end

  PeaceMaker_MoveToInteractAndWait = function(x, y, z, id, second, type) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToInteractAndWait(x, y, z, id, second, type) end
  PeaceMaker_MoveToNpcAndInteract = function(x, y, z, npcid, option) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToNpcAndInteract(x, y, z, npcid, option) end
  PeaceMaker_MoveToObjectAndInteract = function(x, y, z, objid, distance) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToObjectAndInteract(x, y, z, objid, distance) end
  PeaceMaker_MoveToAndWait = function(x,y,z,second,distance) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToAndWait(x, y, z, second, distance) end
  PeaceMaker_MoveToAndClickMoveToAndWait = function(x, y, z, cx, cy, cz, second) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToAndClickMoveToAndWait(x, y, z, cx, cy, cz, second) end
  PeaceMaker_MoveToAndTurnInAcceptQuestReward = function(x, y, z, npcid, reward, index) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToAndTurnInAcceptQuestReward(x, y, z, npcid, reward, index) end
  PeaceMaker_MoveToMerchantAndBuyItem = function(x, y, z, npcid, itemid, quantity) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToMerchantAndBuyItem(x, y, z, npcid, itemid, quantity) end
  PeaceMaker_ClickToMoveAndInteractNpc = function(x, y, z, npcid, option) return PeaceMaker.Helpers.Quest.QuestMisc:ClickToMoveAndInteractNpc(x, y, z, npcid, option) end

  PeaceMaker_SearchNpcAndInteract = function(npcid, option) return PeaceMaker.Helpers.Quest.QuestMisc:SearchNpcAndInteract(npcid, option) end
  PeaceMaker_SearchNpcAndInteractAndDelay = function(npcid, delay, option) return PeaceMaker.Helpers.Quest.QuestMisc:SearchNpcAndInteractAndDelay(npcid, delay, option) end
  PeaceMaker_SearchNpcAndCompleteQuest = function(questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:SearchNpcAndCompleteQuest(questid, npcid, reward) end
  PeaceMaker_SearchNpcAndAcceptQuest = function(questid, npcid) return PeaceMaker.Helpers.Quest.QuestMisc:SearchNpcAndAcceptQuest(questid, npcid) end

  PeaceMaker_HasQuest = function(questid) return PeaceMaker.Helpers.Quest.QuestMisc:HasQuest(questid) end
  PeaceMaker_AcceptQuest = function(x, y, z, questid, npcid, type) return PeaceMaker.Helpers.Quest.QuestMisc:AcceptQuest(x, y, z, questid, npcid, type) end 
  PeaceMaker_AcceptQuestGossip = function(x, y, z, questid, npcid, type) return PeaceMaker.Helpers.Quest.QuestMisc:AcceptQuestGossip(x, y, z, questid, npcid, type) end
  PeaceMaker_AcceptChainQuest = function(questList, npcList, hotspotList) return PeaceMaker.Helpers.Quest.QuestMisc:AcceptChainQuest(questList, npcList, hotspotList) end
  PeaceMaker_TurnInAcceptQuestReward = function(questid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:TurnInAcceptQuestReward(questid, reward) end
  PeaceMaker_CompleteQuest = function(x, y, z, questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteQuest(x, y, z, questid, npcid, reward) end
  PeaceMaker_CompleteQuestObject = function(x, y, z, questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteQuest(x, y, z, questid, npcid, reward) end
  PeaceMaker_CompleteQuestGossip = function(x, y, z, questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteQuestGossip(x, y, z, questid, npcid, reward) end
  PeaceMaker_CompleteQuestObjectGossip = function(x, y, z, questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteQuest(x, y, z, questid, npcid, reward) end
  PeaceMaker_CompleteActiveQuest = function(x, y, z, questid, npcid, reward) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteActiveQuest(x, y, z, questid, npcid, reward) end
  PeaceMaker_CompleteQuestLog = function(questid) return PeaceMaker.Helpers.Quest.QuestMisc:CompleteQuestLog(questid) end
  PeaceMaker_CheckChainQuest = function(questlist) return PeaceMaker.Helpers.Quest.QuestMisc:CheckChainQuest(questlist) end
  PeaceMaker_IsQuestComplete = function(questid) return PeaceMaker.Helpers.Quest.QuestMisc:IsQuestComplete(questid) end
  PeaceMaker_IsQuestCompleted = function(questid) return PeaceMaker.Helpers.Quest.QuestMisc:IsQuestCompleted(questid) end
  PeaceMaker_IsObjectivePartFulfilled = function(questid, part) return PeaceMaker.Helpers.Quest.QuestMisc:IsObjectivePartFulfilled(questid, part) end
  PeaceMaker_IsObjectiveCompleted = function(questid, part) return PeaceMaker.Helpers.Quest.QuestMisc:IsObjectiveCompleted(questid, part) end
  PeaceMaker_MoveToNextStep = function(step) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToNextStep(step) end

  PeaceMaker_CastSpell = function(spell) return PeaceMaker.Helpers.Quest.QuestMisc:CastSpell(spell) end
  PeaceMaker_CheckBuff = function(buff, target) return PeaceMaker.Helpers.Quest.QuestMisc:CheckBuff(buff, target) end
  PeaceMaker_CheckNpcFlags = function(id, name) return PeaceMaker.Helpers.Quest.QuestMisc:CheckNpcFlags(id, name) end

  PeaceMaker_MoveToUseItemOnNPC = function(x, y, z, itemid, npc) return PeaceMaker.Helpers.Quest.QuestCustomLogic:MoveToUseItemOnNPC(x, y, z, itemid, npc) end

  PeaceMaker_Kill = function(hotspot, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestGrind:Kill(hotspot, npcid, type, distance) end
  PeaceMaker_KillAndCheckBuffAndUseItem = function(hotspot, npcid, type, distance, itemid, spell) return PeaceMaker.Helpers.Quest.QuestGrind:KillAndCheckBuffAndUseItem(hotspot, npcid, type, distance, itemid, spell) end
  PeaceMaker_KillAroundPos = function(x, y, z, radius, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestGrind:KillAroundPos(x, y, z, radius, npcid, type, distance) end
  PeaceMaker_KillAroundPosAndInteract = function(x, y, z, radius, npcid, objid, types, distance) return PeaceMaker.Helpers.Quest.QuestGrind:KillAroundPosAndInteract(x, y, z, radius, npcid, objid, types, distance) end
  PeaceMaker_Gather = function(hotspot, objid) return PeaceMaker.Helpers.Quest.QuestGather:Gather(hotspot, objid) end
  PeaceMaker_Escourt = function(npcid, distance) return PeaceMaker.Helpers.Quest.QuestEscort:Escort(npcid, distance) end
  PeaceMaker_Interact = function(hotspot, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestInteract:Interact(hotspot, npcid, type, distance) end
  PeaceMaker_InteractFloatObject = function(hotspot, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestInteract:InteractFloatObject(hotspot, npcid, type, distance) end
  PeaceMaker_InteractTarget = function(hotspot, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestInteract:InteractTarget(hotspot, npcid, type, distance) end
  PeaceMaker_InteractAroundPos = function(x, y, z, radius, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestInteract:InteractAroundPos(x, y, z, radius, npcid, type, distance) end
  PeaceMaker_InteractNpcAndKill = function(x, y, z, radius, npcid, distance) return PeaceMaker.Helpers.Quest.QuestInteract:InteractNpcAndKill(x, y, z, radius, npcid, distance) end
  PeaceMaker_InteractAndDelay = function(hotspot, npcid, type, delay, distance) return PeaceMaker.Helpers.Quest.QuestInteract:InteractAndDelay(hotspot, npcid, type, delay, distance) end
  PeaceMaker_UseItem = function(hotspot, npcid, itemid, distance) return PeaceMaker.Helpers.Quest.QuestUseItem:UseItem(hotspot, npcid, itemid, distance) end
  PeaceMaker_UseItemAction = function(hotspot, npcid, action, distance, buff) return PeaceMaker.Helpers.Quest.QuestUseItem:UseItemAction(hotspot, npcid, action, distance, buff) end
  PeaceMaker_KillAndUseItemOnCorpse = function(hotspot, npcid, itemid, distance, buff, buffType) return PeaceMaker.Helpers.Quest.QuestUseItem:KillAndUseItemOnCorpse(hotspot, npcid, itemid, distance, buff, buffType) end
  PeaceMaker_UseItemOnSelf = function(itemid) return PeaceMaker.Helpers.Quest.QuestUseItem:UseItemOnSelf(itemid) end
  PeaceMaker_UseItemOnLocation = function(hotspot, itemid, second, distance) return PeaceMaker.Helpers.Quest.QuestUseItem:UseItemOnLocation(hotspot, itemid, second, distance) end
  PeaceMaker_AimAndShoot = function(button, id) return PeaceMaker.Helpers.Quest.QuestCustomLogic:VechileAimAndShoot(button, id) end
  PeaceMaker_TargetUnitAndAttack = function(id) return PeaceMaker.Helpers.Quest.QuestCustomLogic:TargetUnitAndAttack(id) end
  PeaceMaker_TargetUnitAndEmo = function(id, emoticon) return PeaceMaker.Helpers.Quest.QuestCustomLogic:TargetUnitAndEmo(id, emoticon) end
  PeaceMaker_TargetNearestNpcID = function(id) return PeaceMaker.Helpers.Quest.QuestMisc:TargetNearestNpcID(id) end

  PeaceMaker_GetNpcDistance = function(npcid) return PeaceMaker.Helpers.Quest.QuestMisc:GetNpcDistance(npcid) end
  PeaceMaker_GetDistance2D = function(x, y) return PeaceMaker.Helpers.Quest.QuestMisc:GetDistance2D(x, y) end
  PeaceMaker_GetDistance3D = function(x, y, z) return lb.GetDistance3D(x, y, z) end

  PeaceMaker_FaceUnit = function(npcid) return PeaceMaker.Helpers.Quest.QuestMisc:FaceUnit(npcid) end

  PeaceMaker_DisableMount = function() return PeaceMaker.Helpers.Quest.QuestMisc:DisableMount() end
  PeaceMaker_EnableMount = function() return PeaceMaker.Helpers.Quest.QuestMisc:EnableMount() end

  PeaceMaker_DisableInternalCombat = function() return PeaceMaker.Helpers.Quest.QuestMisc:DisableInternalCombat() end
  PeaceMaker_EnableInternalCombat = function() return PeaceMaker.Helpers.Quest.QuestMisc:EnableInternalCombat() end

  PeaceMaker_EnableNavigationUnstuck = function() return PeaceMaker.Helpers.Quest.QuestMisc:EnableUnstuck() end
  PeaceMaker_DisableNavigationUnstuck = function() return PeaceMaker.Helpers.Quest.QuestMisc:DisableUnstuck() end

  PeaceMaker_SellAllItem = function(rarity) return PeaceMaker.Helpers.Quest.QuestMisc:SellAllItem(rarity) end

  PeaceMaker_LoadNextProfile = function(profilename) return PeaceMaker.Helpers.Quest.QuestMisc:LoadNextProfile(profilename) end

  PeaceMaker_HardCodedFlyingBombQuest = function() return PeaceMaker.Helpers.Quest.QuestCustomLogic:HardCodedFlyingBombQuest() end
  PeaceMaker_HardCodedCannonTank = function() return PeaceMaker.Helpers.Quest.QuestCustomLogic:HardCodedCannonTank() end
  PeaceMaker_HardCodedMissionProbable = function() return PeaceMaker.Helpers.Quest.QuestCustomLogic:HardCodedMissionProbable() end

  PeaceMaker_QuestDungeon = function(hotspot, npcid, type, distance) return PeaceMaker.Helpers.Quest.QuestDungeon:Run(hotspot, npcid, type, distance) end
  PeaceMaker_JoinDungeon = function(category, joinType, dungeonList, hiddenCollapseList) return PeaceMaker.Helpers.Quest.QuestMisc:JoinDungeon(category, joinType, dungeonList, hiddenCollapseList) end
  PeaceMaker_LearnRidingSkill = function(x, y, z, npcid, ridingskill) return PeaceMaker.Helpers.Quest.QuestMisc:LearnRidingSkill(x, y, z, npcid, ridingskill) end

  PeaceMaker_SaveHome = function(x, y, z, npcid, option, homename) return PeaceMaker.Helpers.Quest.QuestMisc:SaveHome(x, y, z, npcid, option, homename) end
  
  PeaceMaker_MoveToInteractBoardAndSelectChoice = function(x, y, z, objid, option, distance) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToInteractBoardAndSelectChoice(x, y, z, objid, option, distance) end
  PeaceMaker_SelectBoardChoice = function(option) return PeaceMaker.Helpers.Quest.QuestMisc:SelectBoardChoice(option) end

  PeaceMaker_MoveToList = function(hotspot) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToList(hotspot) end

  PeaceMaker_EnableCombatLootQuest = function() return PeaceMaker.Helpers.Quest.QuestMisc:EnableCombatLootQuest() end
  PeaceMaker_DisableCombatLootQuest = function() return PeaceMaker.Helpers.Quest.QuestMisc:DisableCombatLootQuest() end

  PeaceMaker_CheckAreaID = function() return PeaceMaker.Helpers.Quest.QuestMisc:CheckAreaID() end
  PeaceMaker_CheckZoneName = function() return GetSubZoneText() end
  PeaceMaker_CheckObjectExists = function(id) return PeaceMaker.Helpers.Quest.QuestMisc:CheckObjectExists(id) end

  PeaceMaker_ScenarioStepQuestIsComplete = function(num) return PeaceMaker.Helpers.Quest.QuestMisc:ScenarioStepQuestIsComplete(num) end

  PeaceMaker_MoveToInteractFlightPathAndPlace = function(x, y, z, npcid, mapname) return PeaceMaker.Helpers.Quest.QuestMisc:MoveToInteractFlightPathAndPlace(x, y, z, npcid, mapname) end
  PeaceMaker_Wait = function(sec) return PeaceMaker.Helpers.Quest.QuestMisc:Wait(sec) end
  PeaceMaker_PlayerLevel = function(lvl) return UnitLevel('player') end

end

local function Core()

  local Quest, SettingsIndex = PeaceMaker.Helpers.Quest.QuestMisc:ParseProfile()
  local QuestSettings = PeaceMaker.Helpers.Quest.QuestMisc:ParseProfileSettings(SettingsIndex)
  local hasEnemy = PeaceMaker.Helpers.Core.Combat:SearchEnemy(PeaceMaker.Settings.profile.Questing.CombatTargetDistance)
  local gotLoot = PeaceMaker.Helpers.Core.Looting:SearchLoot(PeaceMaker.Settings.profile.Questing.LootRange)
  local gotPlayer, playerName = PeaceMaker.Helpers.Core.Safety:CheckPlayerAround(PeaceMaker.Settings.profile.Questing.AFKDistance) 

  if AFKTimer > PeaceMaker.Time then
    if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
    return
  end

  if PeaceMaker.Player.Dead then
    QuestCurrentState = QuestState.Dead
    PeaceMaker.Helpers.Core.Corpse:Run()
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if gotPlayer
    and PeaceMaker.Time > AFKTimer
    and lb.GetMapId() ~= 0 
    and not IsInInstance()
  then 
    QuestCurrentState = QuestState.Safety
    AFKTimer = PeaceMaker.Time + PeaceMaker.Settings.profile.Questing.AFKTimer
    Log:Run("Player Name : " .. playerName)
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if QuestSettings
    and QuestSettings.AutoLoot
    and (not PeaceMaker.Player.Combat or EnableCombatLootQuest) 
    and PeaceMaker.Helpers.Quest.QuestMisc:GetFreeBagSlots() > QuestSettings.BagSlot
    and not IsMounted()
    and gotLoot
  then
    QuestCurrentState = QuestState.Loot
    PeaceMaker.Helpers.Core.Looting:Run(gotLoot)
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if PeaceMaker.Player.Combat
    and not IsMounted() 
    and hasEnemy 
    and lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, hasEnemy.GUID)
    and not DisableCombat
  then
    QuestCurrentState = QuestState.Combat
    if PeaceMaker.Helpers.Rotation.Core.Engine and not PeaceMaker.Helpers.Rotation.Core.Engine.IsRunning() then
      PeaceMaker.Helpers.Rotation.Core.Engine.Run() 
    end
    PeaceMaker.Helpers.Core.Combat:CheckTargetAttackUs()
    PeaceMaker.Helpers.Core.Combat:Run(hasEnemy)
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if QuestSettings 
    and QuestSettings.UseMount
    and not PeaceMaker.Player.Combat 
    and PeaceMaker.Helpers.Core.Mount:HasMount()
    and not PeaceMaker.Helpers.Core.Mount:CheckMountBlackListPos(PeaceMaker.Player)
    and not PeaceMaker.Helpers.Core.Combat:GetUnitsNearPlayer(PeaceMaker.Settings.profile.Questing.MountWhenEnemyDistance)
    and not IsMounted()
    and not IsIndoors()
    and not UnitInVehicle("player")
    and not DisableMountQuest
  then
    QuestCurrentState = QuestState.Mount
    PeaceMaker.Helpers.Core.Mount:Run(QuestSettings.MountID)
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if QuestSettings
    and QuestSettings.UseVendor
    and
    (
      (PeaceMaker.Player:Durability() <= QuestSettings.Durability or PeaceMaker.Helpers.Quest.QuestMisc:GetFreeBagSlots() <= QuestSettings.BagSlot)
      or 
      ((QuestSettings.FoodAmount > 0 and PeaceMaker.Player:CheckFoodCount()) or (QuestSettings.DrinkAmount > 0 and PeaceMaker.Player:CheckDrinkCount()))
      or
      PeaceMaker.VendorState
    )
  then  
    QuestCurrentState = QuestState.Vendor
    PeaceMaker.Helpers.Quest.Vendor:Run(QuestSettings.RepairNpcPos, QuestSettings.RepairNpcID, QuestSettings.FoodNpcPos, QuestSettings.FoodNpcID, QuestSettings.FoodID, QuestSettings.DrinkID, QuestSettings.FoodAmount, QuestSettings.DrinkAmount, QuestSettings.Durability, QuestSettings.BagSlot)
    Log:Run("State : " .. QuestCurrentState)
    return
  end

  if Quest then
    QuestCurrentState = QuestState.Quest
    _G[Quest]()
    return
  end

end

function Quest:Run()
  if not LoadAPI then LoadQuestAPI() LoadAPI = true return end
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end