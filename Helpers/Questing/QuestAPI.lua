-- PeaceMaker Quest API --
----------------------

PeaceMaker_MapID 
-- return current mapid

PeaceMaker_InteractNpcNearBy 
-- (npcid) Interact Npc within 10 yards
PeaceMaker_InteractNpcNearbyAndGossip 
-- (npcid, option) Interact Npc within 10 yards and also auto select gossip option if u did not put any option
PeaceMaker_InteractNpcNearbyAndCompleteQuest 
-- (npcid) Interact Npc within 10 yards and also auto complete the quest
PeaceMaker_InteractNpcNearbyAndAcceptQuest 
-- (npcid, questid) Interact Npc within 10 yards and also accept the quest that you input (questid)

PeaceMaker_MoveToInteractAndWait 
-- (x, y, z, id, second, type) Move To object/npc(type)(id) and then it will interact with object/npc and after that it will pause (second)
PeaceMaker_MoveToObjectAndInteract
-- (x, y, z, npcid, option) Move To Npc and interact with object that u define based on id
PeaceMaker_MoveToNpcAndInteract 
-- (x, y, z, npcid, option) Move To Npc and interact and then it will select which option you define (option) if you did not input any option it will always choose 1
PeaceMaker_MoveToAndWait 
-- (x, y, z, second, distance) Move To location and stop at distance that you define (default is 2.5) and it will wait (default is 1) (second)
PeaceMaker_MoveToAndClickMoveToAndWait 
-- (x, y, z, cx, cy, cz, second) Move To location and then it will use Click to move instead of mesh and then it will wait based on the second you define (default is 1)
PeaceMaker_MoveToAndTurnInAcceptQuestReward 
-- (x, y, z, npcid, reward, index) Move To Npc location and it will interact with (npcid) and then it will choose based on which reward you choose (default is 1) and after that it will accept quest (default is 1)

PeaceMaker_HasQuest 
-- (questid) -- Check if quest is exist and not completed
PeaceMaker_AcceptQuest 
-- (x,y,z, questid, npcid) -- Move To Npc and interact with npc (npcid) and accept the quest that you define (questid) this is for questframe
PeaceMaker_AcceptQuestGossip 
-- (x,y,z, questid, npcid) -- Move To Npc and interact with npc (npcid) and accept the quest that you define (questid) this is for gossipframe
PeaceMaker_TurnInAcceptQuestReward 
-- (questid, reward) -- Turn in quest without move to and accept reward
PeaceMaker_CompleteQuest 
-- (x, y, z, questID, npcid, reward) -- Move to Npc and interact with npc and complete the quest that you define and you can also set which reward you want to take (reward) default is 1 this is for questframe
PeaceMaker_CompleteQuestGossip 
-- (x, y, z, questID, npcid, reward) -- Move to Npc and interact with npc and complete the quest that you define and you can also set which reward you want to take (reward) default is 1 this is for gossipframe
PeaceMaker_IsQuestComplete 
-- (questid) -- Check if quest is complete
PeaceMaker_IsQuestCompleted 
-- (questid) -- check if quest is completed
PeaceMaker_IsObjectiveCompleted 
-- (questid, part) -- check if quest objective (part) is completed 
PeaceMaker_MoveToNextStep 
-- (step) -- Move to Next Quest line this is used for when u completed ur current quest it will increase the quest step by 1

PeaceMaker_CheckBuff 
-- (spellname , target) -- This is to check buff for player/target (target)
PeaceMaker_CheckNpcFlags 
-- (id, name) -- This is used to check certain Npc flags this is mainly use for quest escort that require to interact

PeaceMaker_Kill 
-- (hotspot, npcid, type, distance) -- hotspot u need to define ur own hotspot, npcid is the list u want to kill this is in table form {}, for type u can choose between "Normal" and "Boss", distance is how far you want to target
PeaceMaker_KillAndCheckBuffAndUseItem 
-- (hotspot, npcid, type, distance, itemid, spell) -- hotspot u need to define ur own hotspot, npcid is the list u want to kill this is in table form {}, for type u can choose between "Normal" and "Boss", distance is how far you want to target, itemid that you want to use and it will only use if u got the spell debuff on target
PeaceMaker_Gather 
-- (hotspot, objid) -- hotspot u need to define ur own hotspot, npcid is the list u want to gather this is in table form {}
PeaceMaker_Escourt 
-- (npcid, distance) -- npc that you want to follow and follow distance u want to set

PeaceMaker_Interact 
-- (hotspot, npcid, type) -- hotspot u need to define ur own hotspot, npcid is the list u want to interact this is in table form {}, either is "Unit" or "Object"
PeaceMaker_GetDistance2D 
-- (x, y) -- check distance between pos x and pos y

PeaceMaker_EnableInternalCombat
-- Renable it after u disable internal combat
PeaceMaker_DisableInternalCombat
-- Disable Internal Combat for questing botbase this is for some quest like where u need to interact when enemy < x then use item

PeaceMaker_EnableNavigationUnstuck 
-- this is to enable unstuck if u disable it make sure to enable it back
PeaceMaker_DisableNavigationUnstuck 
-- this is to disable unstuck because sometime it will cause issue

PeaceMaker_LoadNextProfile 
-- (profilename) this is to load next profile 