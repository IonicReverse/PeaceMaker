QuestOrder = {
  [1] = { Quest_Name = "WelcomeToOrgrimmar", Quest_Settings = 1 },
  [2] = { Quest_Name = "FindingYourWay", Quest_Settings = 1 },
  [3] = { Quest_Name = "LicenseToRide", Quest_Settings = 1 },
  [4] = { Quest_Name = "WhatsYourSpecialty", Quest_Settings = 1 },
  [5] = { Quest_Name = "HomeIsWhereTheHearthIs", Quest_Settings = 1 },
  [6] = { Quest_Name = "AnUrgentMeeting", Quest_Settings = 1 },
  [7] = { Quest_Name = "SaveHome", Quest_Settings = 1 } ,
  [8] = { Quest_Name = "MissionStatement", Quest_Settings = 1 },
  [9] = { Quest_Name = "BackToOgri", Quest_Settings = 1 },
  [10] = { Quest_Name = "DarkPortal", Quest_Settings = 2 },
  [11] = { Quest_Name = "AzerothLastStand", Quest_Settings = 3 },
  [12] = { Quest_Name = "Onslaught", Quest_Settings = 3 },
  [13] = { Quest_Name = "ThePortalPower", Quest_Settings = 3 },
  [14] = { Quest_Name = "TheCostOfWar", Quest_Settings = 3 },
  [15] = { Quest_Name = "BlazeVengenanceBled", Quest_Settings = 3 },
  [16] = { Quest_Name = "BlazeVengenanceBled2", Quest_Settings = 3 },
  [17] = { Quest_Name = "AltarAltercation", Quest_Settings = 3 },
  [18] = { Quest_Name = "KargatharGround", Quest_Settings = 3 },
  [19] = { Quest_Name = "PotentialAlly", Quest_Settings = 3 },
  [20] = { Quest_Name = "KillYourHundred", Quest_Settings = 3 },
  [21] = { Quest_Name = "ShadowClanAndMasterShadow", Quest_Settings = 3 },
  [22] = { Quest_Name = "ShadowClanAndMasterShadow2", Quest_Settings = 3 },
  [23] = { Quest_Name = "ShadowClanAndMasterShadow3", Quest_Settings = 3 },
  [24] = { Quest_Name = "KeliposTheBreaker", Quest_Settings = 3 },
  [25] = { Quest_Name = "PrepareBattle", Quest_Settings = 3 },
  [26] = { Quest_Name = "BattleForge", Quest_Settings = 3 },
  [27] = { Quest_Name = "GannarFrostGunPowderShadow", Quest_Settings = 3 },
  [28] = { Quest_Name = "GannarFrostGunPowderShadow2", Quest_Settings = 3 },
  [29] = { Quest_Name = "PolishingTheIron", Quest_Settings = 3 },
  [30] = { Quest_Name = "ProdigalFrostWolf", Quest_Settings = 3 },
  [31] = { Quest_Name = "TripToTheTank", Quest_Settings = 3 },
  [32] = { Quest_Name = "TasteOfIron", Quest_Settings = 3 },
  [33] = { Quest_Name = "HomeStretch", Quest_Settings = 3 }
}

function WelcomeToOrgrimmar()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_HasQuest(60343) and not PeaceMaker_IsQuestCompleted(60343) then
      PeaceMaker_AcceptQuestGossip(1464.310, -4419.778, 25.454, 60343, 168431)
      return
    end
    if PeaceMaker_IsQuestComplete(60343) and PeaceMaker_HasQuest(60343) then
      PeaceMaker_CompleteQuest(1499.830, -4408.641, 23.591, 60343, 168441)
      return
    end
    if PeaceMaker_IsQuestCompleted(60343) then
      PeaceMaker_MoveToNextStep()
      return
    end
  else
    if PeaceMaker_IsQuestCompleted(60343) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function FindingYourWay()

  if PeaceMaker_MapID() == 1 then

    if not PeaceMaker_HasQuest(60344) and not PeaceMaker_IsQuestCompleted(60344) then
      PeaceMaker_AcceptQuest(1496.796, -4409.917, 23.774, 60344, 168441)
      return
    end

    if PeaceMaker_HasQuest(60344) and not PeaceMaker_IsObjectiveCompleted(60344, 1) then
      PeaceMaker_MoveToNpcAndInteract(1510.167, -4419.118, 22.599, 168459, 15)
      return
    end
	
    if PeaceMaker_HasQuest(60344) and not PeaceMaker_IsObjectiveCompleted(60344, 2) then
      PeaceMaker_MoveToNpcAndInteract(1507.889, -4415.116, 22.742, 168441, 1)
      return
    end
	
    if PeaceMaker_HasQuest(60344) and not PeaceMaker_IsObjectiveCompleted(60344, 3) then
      PeaceMaker_Escourt(168462, 4)
      return
    end
	
	  if PeaceMaker_HasQuest(60344) and PeaceMaker_IsQuestComplete(60344) then
		  PeaceMaker_CompleteQuest(2106.762, -4574.908, 49.253, 60344, 168540)
    end

    if PeaceMaker_IsQuestCompleted(60344) then
      PeaceMaker_MoveToNextStep()
    end
    
  else

    if PeaceMaker_IsQuestCompleted(60344) then
      PeaceMaker_MoveToNextStep()
    end

  end
end

function LicenseToRide()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(60345) and not PeaceMaker_HasQuest(60345) then
      PeaceMaker_AcceptQuest(2106.762, -4574.908, 49.253, 60345, 168540)
    end
	
	  if PeaceMaker_HasQuest(60345) and not PeaceMaker_IsObjectiveCompleted(60345,1) then
		  PeaceMaker_LearnRidingSkill(2085.360, -4572.860, 49.253, 4752, "Apprentice Riding") 
    end
	
	  if PeaceMaker_HasQuest(60345) and PeaceMaker_IsQuestComplete(60345) then
		  PeaceMaker_CompleteQuest(2106.762, -4574.908, 49.253, 60345, 168540)
    end
    
    if PeaceMaker_IsQuestCompleted(60345) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60345) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WhatsYourSpecialty()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(60350) and not PeaceMaker_HasQuest(60350) then
      PeaceMaker_AcceptQuest(2106.762, -4574.908, 49.253, 60350, 168545)
    end
    
    if PeaceMaker_HasQuest(60350) and not PeaceMaker_IsObjectiveCompleted(60350,1) then
      PeaceMaker_MoveToNpcAndInteract(1936.750, -4779.249, 39.196, 168597, 1)
      return
    end
	
    if PeaceMaker_HasQuest(60350) and not PeaceMaker_IsObjectiveCompleted(60350,2) then
      SetSpecialization(2)
      PeaceMaker.Pause = PeaceMaker.Time + 15
      return
    end
	
    if PeaceMaker_HasQuest(60350) and PeaceMaker_IsQuestComplete(60350) then
      PeaceMaker_CompleteActiveQuest(1936.750, -4779.249, 39.196, 60350, 168597, 1)
    end

    if PeaceMaker_IsQuestCompleted(60350) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60350) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function HomeIsWhereTheHearthIs()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(60359) and not PeaceMaker_HasQuest(60359) then
      PeaceMaker_AcceptQuest(1936.750, -4779.249, 39.196, 60359, 168545)
    end
  
    if PeaceMaker_HasQuest(60359) and not PeaceMaker_IsObjectiveCompleted(60359,1) then
      PeaceMaker_MoveToNpcAndInteract(1907.300, -4746.573, 38.530, 46642, 1)
      return
    end

    if PeaceMaker_HasQuest(60359) and PeaceMaker_IsQuestComplete(60359) then
      PeaceMaker_CompleteActiveQuest(1907.300, -4746.573, 38.530 , 60359, 46642, 1)
    end
  
    if PeaceMaker_IsQuestCompleted(60359) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60359) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function AnUrgentMeeting()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(60360) and not PeaceMaker_HasQuest(60360) then
	    PeaceMaker_AcceptQuest(1912.248, -4739.069, 38.936, 60360, 168771)
    end
	
    if PeaceMaker_HasQuest(60360) and not PeaceMaker_IsObjectiveCompleted(60360,1) then
      PeaceMaker_MoveToNpcAndInteract(1912.521, -4750.370, 38.919, 168441, 1)
      return
    end
	
    if PeaceMaker_HasQuest(60360) and PeaceMaker_IsObjectiveCompleted(60360,1) and not PeaceMaker_IsObjectiveCompleted(60360,2) then
      PeaceMaker_MoveToAndWait(1658.896, -4345.821, 26.356, 1, 4)
    end
    
    if PeaceMaker_HasQuest(60360) and PeaceMaker_IsQuestComplete(60360) then
      PeaceMaker_CompleteQuest(1658.896, -4345.821, 26.356, 60360, 168431)
    end
	
    if PeaceMaker_IsQuestCompleted(60360) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60360) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SaveHome()
	if PeaceMaker_MapID() == 1 then
		if GetBindLocation() ~= "The Broken Tusk" then
			PeaceMaker_SaveHome(1572.969, -4437.995, 16.055, 6929, 1, "The Broken Tusk")
		else
			PeaceMaker_MoveToNextStep()
    end
  else
    PeaceMaker_MoveToNextStep()
	end
end

function MissionStatement()
  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(60361) and not PeaceMaker_HasQuest(60361) then
	    PeaceMaker_AcceptQuest(1658.896, -4345.821, 26.356, 60361, 168431)
    end
	
    if PeaceMaker_HasQuest(60361) and not PeaceMaker_IsObjectiveCompleted(60361,2) then
      PeaceMaker_MoveToNpcAndInteract(1660.898, -4350.080, 26.352, 168808, 1)
      return
    end
	  
    if PeaceMaker_HasQuest(60361) and not PeaceMaker_IsObjectiveCompleted(60361,3) then
      PeaceMaker_MoveToNpcAndInteract(1658.896, -4345.821, 26.356, 168431, 1)
      return
    end
	
    if PeaceMaker_HasQuest(60361) and not PeaceMaker_IsObjectiveCompleted(60361,4) then
      PeaceMaker_MoveToInteractAndWait(1592.44, -4396.34, 17.04, 174453, 5, "Unit")
    end

    if PeaceMaker_IsQuestCompleted(60361) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 1642 then
      if PeaceMaker_HasQuest(60361) and PeaceMaker_IsQuestComplete(60361) then
        PeaceMaker_CompleteQuest(-2162.58, 804.01, 5.93, 60361, 121210)
      end
    end
    if PeaceMaker_IsQuestCompleted(60361) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BackToOgri()
  if not PeaceMaker_IsQuestCompleted(34398) and not PeaceMaker_HasQuest(34398) then
    if PeaceMaker_MapID() ~= 1 then
      lb.Unlock(UseItemByName, 6948)
      PeaceMaker.Pause = PeaceMaker.Time + 5
    else
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34398) or PeaceMaker_HasQuest(34398) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function DarkPortal()

  local hotspot = {  
    [1] = {  y=-3619.532,x=-11654.732,radius=100,z=18.485 },
    [2] = {  y=-3454.224,x=-11531.124,radius=100,z=8.795 },
    [3] = {  y=-3413.542,x=-11478.412,radius=100,z=8.828 },
    [4] = {  y=-3343.844,x=-11460.374,radius=100,z=9.465 },
    [5] = {  y=-3277.162,x=-11414.604,radius=100,z=9.948 },
    [6] = {  y=-3236.172,x=-11382.133,radius=100,z=9.982 },
    [7] = {  y=-3186.569,x=-11367.507,radius=100,z=10.653 },
    [8] = {  y=-3120.474,x=-11348.243,radius=100,z=-1.518 },
    [9] = {  y=-3085.293,x=-11350.921,radius=100,z=0.476 },
    [10] = {  y=-3084.579,x=-11420.034,radius=100,z=2.177 },
    [11] = {  y=-3112.361,x=-11460.521,radius=100,z=5.407 },
    [12] = {  y=-3131.837,x=-11504.326,radius=100,z=6.465 },
    [13] = {  y=-3154.877,x=-11587.489,radius=100,z=3.97 },
    [14] = {  y=-3168.185,x=-11652.63,radius=100,z=-3.223 },
    [15] = {  y=-3180.676,x=-11771.154,radius=100,z=-28.149 },
    [16] = {  y=-3205.04,x=-11810.13,radius=100,z=-29.26 }
  } 

  if PeaceMaker_MapID() == 1 then
    if not PeaceMaker_IsQuestCompleted(34398) and not PeaceMaker_HasQuest(34398) then
	    PeaceMaker_MoveToInteractBoardAndSelectChoice(1599.84, -4369.95, 21.2, 281340, 2, 6)
    end
    if PeaceMaker_HasQuest(34398) then
      if not PeaceMaker_IsObjectiveCompleted(34398,1) then
        PeaceMaker_MoveToNpcAndInteract(1428.28, -4477.5, -4.55, 149626, 1)
        return
      end
    end
    if PeaceMaker_IsQuestCompleted(34398) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 0 then 
      if PeaceMaker_HasQuest(34398) then
        if not PeaceMaker_IsObjectiveCompleted(34398, 2) then
          if PeaceMaker_GetDistance3D(-11810.3, -3205.64, -29.27) < 10 then
            PeaceMaker_MoveToNpcAndInteract(-11810.13, -3205.04, -29.26, 78423, 1)
          else
            PeaceMaker_MoveToList(hotspot)
          end
          return
        end
      end
    end
    if PeaceMaker_MapID() == 1265 then
      if PeaceMaker_IsQuestComplete(34398) then
        PeaceMaker_CompleteQuest(4066.66, -2373.93, 94.84, 34398, 78558)
      end
    end
    if PeaceMaker_IsQuestCompleted(34398) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function AzerothLastStand()
  
  local hotspot = {
    [1] = {  y=-2290.42,x=4061.01,radius=70,z=64.92 }
  }

  local mob = { 78883 }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(35933) and not PeaceMaker_HasQuest(35933) then
      PeaceMaker_AcceptQuest(4067.181, -2375.65, 94.88167, 35933, 78558)
    end
    if PeaceMaker_HasQuest(35933) then
      if not PeaceMaker_IsObjectiveCompleted(35933, 1) then
        PeaceMaker_EnableCombatLootQuest()
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
    end
    if PeaceMaker_IsQuestComplete(35933) then
      PeaceMaker_DisableCombatLootQuest()
      PeaceMaker_CompleteQuestLog(35933)
    end
    if PeaceMaker_IsQuestCompleted(35933) then
      PeaceMaker_DisableCombatLootQuest()
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(35933) then
      PeaceMaker_DisableCombatLootQuest()
      PeaceMaker_MoveToNextStep()
    end
  end

end

function Onslaught()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34392) and not PeaceMaker_HasQuest(34392) then
      PeaceMaker_AcceptQuest(4066.73, -2374, 94.84, 34392, 78558)
    end
    if PeaceMaker_HasQuest(34392) then
      if not PeaceMaker_IsObjectiveCompleted(34392, 1) then
        PeaceMaker_MoveToObjectAndInteract(4167.36, -2285.5, 59.87, 233056, 3)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34392, 2) then
        PeaceMaker_MoveToObjectAndInteract(3964.78, -2287.32, 59.88, 233057, 3)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34392) then
      PeaceMaker_CompleteQuest(4065.393, -2372.308, 94.599, 34392, 78558)
    end
    if PeaceMaker_IsQuestCompleted(34392) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34392) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ThePortalPower()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34393) and not PeaceMaker_HasQuest(34393) then
      PeaceMaker_AcceptQuest(4065.393, -2372.308, 94.599, 34393, 78558)
    end
    if PeaceMaker_HasQuest(34393) then
      if not PeaceMaker_IsObjectiveCompleted(34393, 1) then
        PeaceMaker_MoveToAndWait(4036.01, -2376.86, 79.65, 4)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34393, 2) then
        PeaceMaker_InteractAroundPos(4092.469, -2400.512, 69.85594, 100, 229598, "Object", 8)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34393, 3) then
        PeaceMaker_InteractAroundPos(4068.449, -2428.044, 69.85651, 100, 229599, "Object", 8)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34393, 4) then
        PeaceMaker_InteractAroundPos(4041.562, -2404.974, 69.86411, 100, 229600, "Object", 8)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34393, 5) then
        PeaceMaker_MoveToObjectAndInteract(4066.816, -2397.541, 77.988, 233104)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34393) then
      PeaceMaker_CompleteQuest(4066.49, -2372.1, 94.6, 34393, 78558)
    end
    if PeaceMaker_IsQuestCompleted(34393) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34393) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TheCostOfWar()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34420) and not PeaceMaker_HasQuest(34420) then
      PeaceMaker_AcceptQuest(4065.323, -2374.915, 94.60196, 34420, 78558)
    end
    if PeaceMaker_IsQuestComplete(34420) then
      PeaceMaker_CompleteQuest(3936.42, -2505.65, 69.76, 34420, 78559)
    end
    if PeaceMaker_IsQuestCompleted(34420) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34420) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BlazeVengenanceBled()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34422) and not PeaceMaker_HasQuest(34422) then
      PeaceMaker_AcceptQuest(3939.66, -2507.657, 69.39494, 34422, 78559)
    end
    if PeaceMaker_HasQuest(34422) then
      if not PeaceMaker_IsQuestCompleted(35241) and not PeaceMaker_HasQuest(35241) then
        PeaceMaker_AcceptQuest(3989.087, -2550.84, 65.90633, 35241, 81761)
      end
    end
    if PeaceMaker_HasQuest(35241) then
      if not PeaceMaker_IsQuestCompleted(34421) and not PeaceMaker_HasQuest(34421) then
        PeaceMaker_AcceptQuest(3988.286, -2551.613, 65.99123, 34421, 78573)
      end
    end
    if (PeaceMaker_HasQuest(34422) and PeaceMaker_HasQuest(35241) and PeaceMaker_HasQuest(34421)) 
      or (PeaceMaker_IsQuestCompleted(34422) and PeaceMaker_IsQuestCompleted(35241) and PeaceMaker_IsQuestCompleted(34421))
      or (PeaceMaker_HasQuest(34422) and PeaceMaker_IsQuestCompleted(35241))
      or (PeaceMaker_HasQuest(35241) and PeaceMaker_IsQuestCompleted(34422)) 
      or (PeaceMaker_HasQuest(34421) and PeaceMaker_IsQuestCompleted(35241) and PeaceMaker_IsQuestCompleted(34422))
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(34422) and PeaceMaker_HasQuest(35241) and PeaceMaker_HasQuest(34421)) 
      or (PeaceMaker_IsQuestCompleted(34422) and PeaceMaker_IsQuestCompleted(35241) and PeaceMaker_IsQuestCompleted(34421))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BlazeVengenanceBled2()

  local hotspot1 = {  
    [1] = {  y=-2633.7,x=3972.378,radius=100,z=54.56622 },
    [2] = {  y=-2525.427,x=3836.037,radius=100,z=65.66304 }
  } 

  local hotspot2 = {  
    [1] = {  y=-2660.632,x=4006.291,radius=100,z=45.94989 },
    [2] = {  y=-2640.185,x=3953.217,radius=100,z=54.61708 },
    [3] = {  y=-2589.914,x=4038.92,radius=100,z=52.08846 }
  }  

  local hotspot3 = {
    [1] = {  y=-2531.578,x=3841.451,radius=100,z=65.29623 },
    [2] = {  y=-2539.166,x=3857.284,radius=100,z=65.29778 },
    [3] = {  y=-2580.704,x=3768.822,radius=100,z=58.17631 },
    [4] = {  y=-2649.907,x=3942.8,radius=100,z=54.78093 },
    [5] = {  y=-2665.983,x=3957.454,radius=100,z=54.9614 },
    [6] = {  y=-2673.221,x=3997.479,radius=100,z=46.06325 },
    [7] = {  y=-2584.739,x=4043.685,radius=100,z=52.087129 }
  }

  local obj = { 229353 }
  local obj1 = { 229352 }
  local mob = { 78507 }

  if PeaceMaker_HasQuest(34421) and not PeaceMaker_IsQuestComplete(34421) then
    if not PeaceMaker_IsObjectiveCompleted(34421, 1) then
      PeaceMaker_Interact(hotspot1, obj, "Object", 4)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(34421, 2) then
      PeaceMaker_Interact(hotspot1, obj1, "Object", 5)
      return
    end
  end

  if PeaceMaker_HasQuest(34422) 
    and (PeaceMaker_IsQuestComplete(34421) and not PeaceMaker_IsQuestComplete(34422)) 
  then
    PeaceMaker_UseItemOnLocation(hotspot3, 113191, 1, 3)
    return
  end

  if PeaceMaker_IsQuestComplete(34422) and PeaceMaker_IsQuestComplete(34421) and not PeaceMaker_IsQuestComplete(35241) then
    PeaceMaker_Kill(hotspot2, mob, "Normal")
    return
  end

  if PeaceMaker_IsQuestComplete(34422) then
    PeaceMaker_CompleteQuest(3840.04, -2777.2, 93.84, 34422, 78559)
    return
  end

  if PeaceMaker_IsQuestComplete(34421) then
    PeaceMaker_CompleteQuest(3840.04, -2777.2, 93.84, 34421, 78559)
    return
  end

  if PeaceMaker_IsQuestComplete(35241) then
    PeaceMaker_CompleteQuest(3844.41, -2786.86, 94.12, 35241, 78553)
    return
  end

  if PeaceMaker_IsQuestCompleted(34422) and PeaceMaker_IsQuestCompleted(34421) and PeaceMaker_IsQuestCompleted(35241) then
    PeaceMaker_MoveToNextStep()
  end

end

function AltarAltercation()

  local hotspot = {
    [1] = {  y=-2327.893,x=4065.161,radius=100,z=65.50154 }
  }

  local mob = { 78883 }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34423) and not PeaceMaker_HasQuest(34423) then
      PeaceMaker_AcceptQuest(3840.423, -2779.785, 93.8413, 34423, 78559)
    end
    if PeaceMaker_HasQuest(34423) then
      if not PeaceMaker_IsObjectiveCompleted(34423, 1) then
        PeaceMaker_MoveToNpcAndInteract(3839.71, -2786.748, 94.11489, 78556, 1)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34423, 2) then
        PeaceMaker_MoveToAndWait(3964.24, -2898.72, 61.32, 1)
        return
      end
      if PeaceMaker_IsObjectiveCompleted(34423, 1) and PeaceMaker_IsObjectiveCompleted(34423, 2) and not PeaceMaker_IsObjectiveCompleted(34423, 3) then
        PeaceMaker_InteractAroundPos(3987.668, -2927.731, 61.6788, 100, 83670, "Unit", 5)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34423, 4) then
        PeaceMaker_MoveToAndWait(4190.399, -2784.795, 26.78962, 1)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34423) then
      PeaceMaker_CompleteQuest(4190.399, -2784.795, 26.78962, 34423, 78560)
    end
    if PeaceMaker_IsQuestCompleted(34423) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34423) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function KargatharGround()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34425) and not PeaceMaker_HasQuest(34425) then
      PeaceMaker_AcceptQuest(4190.399, -2784.795, 26.78962, 34425, 78560)
    end
    if PeaceMaker_IsQuestComplete(34425) then
      PeaceMaker_CompleteQuest(4229.144, -2812.941, 17.11118, 34425, 78560)
    end
    if PeaceMaker_IsQuestCompleted(34425) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34425) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function PotentialAlly()

  local hotspot = {
    [1] = {  y=-2715.172,x=4301.915,radius=100,z=8.79345 }
  }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34427) and not PeaceMaker_HasQuest(34427) then
      PeaceMaker_AcceptQuest(4229.144, -2812.941, 17.11118, 34427, 78560)
    end 
    if PeaceMaker_HasQuest(34427) then
      if not PeaceMaker_IsObjectiveCompleted(34427, 1) then
        PeaceMaker_UseItemOnLocation(hotspot, 110799, 1, 5)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34427) then
      PeaceMaker_CompleteQuest(4218.308, -2815.531, 16.93877, 34427, 78996)
    end
    if PeaceMaker_IsQuestCompleted(34427) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34427) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function KillYourHundred()

  local hotspot = {
    [1] = {  y=-2832.06,x=4403.3,radius=100,z=4.9 }
  }
  
  local mobs = { 83539, 82057}

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34429) and not PeaceMaker_HasQuest(34429) then
      PeaceMaker_AcceptQuest(4232.07, -2811.06, 17.15, 34425, 78560)
    end
    if PeaceMaker_HasQuest(34429) then
      if not PeaceMaker_IsObjectiveCompleted(34429, 1) then
        PeaceMaker_MoveToAndWait(4379.83, -2826.06, 4.75, 1)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34429, 2) then
        PeaceMaker_Kill(hotspot, mobs, "Normal")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34429, 3) then
        PeaceMaker_MoveToAndWait(4510.17,-2652.79,0.96, 1)
        return
      end
      if PeaceMaker_IsQuestComplete(34429) then
        PeaceMaker_CompleteQuest(4512.05, -2635.83, 1.67, 34429, 78561)
      end
    end
    if PeaceMaker_IsQuestCompleted(34429) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34429) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ShadowClanAndMasterShadow()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34739) and not PeaceMaker_HasQuest(34739) then
      PeaceMaker_AcceptQuest(4525.68, -2637.63, 1.75, 34739, 78553)
    end
    if PeaceMaker_HasQuest(34739) then
      if not PeaceMaker_IsQuestCompleted(34737) and not PeaceMaker_HasQuest(34737) then
        PeaceMaker_AcceptQuest(4526.73, -2640.97, 1.41, 34737, 79661)
      end
    end
    if (PeaceMaker_HasQuest(34739) and PeaceMaker_HasQuest(34737)) 
      or (PeaceMaker_IsQuestCompleted(34739) and PeaceMaker_IsQuestCompleted(34737))
      or (PeaceMaker_HasQuest(34739) and PeaceMaker_IsQuestCompleted(34737))
      or (PeaceMaker_HasQuest(34737) and PeaceMaker_IsQuestCompleted(34739))
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(34739) and PeaceMaker_HasQuest(34737)) 
      or (PeaceMaker_IsQuestCompleted(34739) and PeaceMaker_IsQuestCompleted(34737))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ShadowClanAndMasterShadow2()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34740) and not PeaceMaker_HasQuest(34740) then
      PeaceMaker_AcceptQuest(4613.97, -2470.7, 13.81, 34740, 78994)
    end
    if (PeaceMaker_IsQuestCompleted(34740) or PeaceMaker_HasQuest(34740)) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_IsQuestCompleted(34740) or PeaceMaker_HasQuest(34740)) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ShadowClanAndMasterShadow3()
  
  local hotspot = {  
    [1] = {  y=-2602.623,x=4508.26,radius=100,z=2.978 },
    [2] = {  y=-2506.514,x=4587.709,radius=100,z=28.926 },
    [3] = {  y=-2466.015,x=4445.056,radius=100,z=24.814 }
  } 

  local hotspot1 = {
    [1] = { y=-2506.514,x=4587.709,radius=100,z=28.926 }
  }

  local hotspot2 = {
    [1] = {  y=-2466.015,x=4445.056,radius=100,z=24.814 }
  }

  local mob = { 82373 }
  local boss1 = { 79585 }
  local boss2 = { 79583 }

  if PeaceMaker_HasQuest(34739) and not PeaceMaker_IsQuestComplete(34739) then
    PeaceMaker_Kill(hotspot, mob, "Normal")
    return
  end

  if PeaceMaker_HasQuest(34737) and PeaceMaker_IsQuestComplete(34739) and not PeaceMaker_IsQuestComplete(34737) then
    if not PeaceMaker_IsObjectiveCompleted(34737, 2) then
      PeaceMaker_Kill(hotspot1, boss1, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(34737, 1) then
      PeaceMaker_Kill(hotspot2, boss2, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(34737) then
    PeaceMaker_CompleteQuest(4513.628, -2496.314, 25.72589, 34737, 79675)
    return
  end

  if PeaceMaker_IsQuestComplete(34740) then
    PeaceMaker_CompleteQuest(4513.628, -2496.314, 25.72589, 34740, 78994)
    return
  end

  if PeaceMaker_IsQuestComplete(34739) then
    PeaceMaker_CompleteQuest(4518.099, -2500.32, 25.77648, 34739, 79315)
    return
  end

  if PeaceMaker_IsQuestCompleted(34737) and PeaceMaker_IsQuestCompleted(34740) and PeaceMaker_IsQuestCompleted(34739) then
    PeaceMaker_MoveToNextStep()
  end
  
end

function KeliposTheBreaker()

  local hotspot = {
    [1] = { y=-2434.102,x=4510.731,radius=100,z=24.73248 }
  }

  local mob = { 79702 }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34741) and not PeaceMaker_HasQuest(34741) then
      PeaceMaker_AcceptQuest(4513.934, -2494.786, 25.74615, 34741, 79675)
    end
    if PeaceMaker_HasQuest(34741) then
      if not PeaceMaker_IsObjectiveCompleted(34741, 1) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34741) then
      PeaceMaker_CompleteQuest(4607.539, -2245.774, 15.54667, 34741, 78562)
      return
    end
    if PeaceMaker_IsQuestCompleted(34741) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34741) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function PrepareBattle()

  local hotspot = {  
    [1] = {  y=-2036.33,x=4560.492,radius=100,z=-18.001 },
    [2] = {  y=-2162.881,x=4540.698,radius=100,z=-15.463 },
    [3] = {  y=-1974.05,x=4583.616,radius=100,z=-10.389 }
  } 

  local obj = { 231819, 231820, 231815 }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(35005) and not PeaceMaker_HasQuest(35005) then
      PeaceMaker_AcceptQuest(4626.96, -2259.12, 19.1, 35005, 78553)
    end
    if PeaceMaker_HasQuest(35005) then
      if not PeaceMaker_IsObjectiveCompleted(35005, 1) then
        PeaceMaker_Interact(hotspot, obj, "Object", 4)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(35005) then
      PeaceMaker_CompleteQuest(4626.62, -2258.41, 18.79, 35005, 78553)
      return
    end
    if PeaceMaker_IsQuestCompleted(35005) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(35005) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function BattleForge()
  
  local hotspot = {
    [1] = {  y=-2036.33,x=4560.492,radius=100,z=-18.001 }
  }

  local hotspot2 = {
    [1] = {  y=-2036.33,x=4560.492,radius=100,z=-18.001 },
    [2] = {  y=-2115.012,x=4460.011,radius=100,z=-13.432 }
  }

  local mob = { 80786, 80775, 81294 }
  local mob2 = { 80775, 81294 }

  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34439) and not PeaceMaker_HasQuest(34439) then
      PeaceMaker_AcceptQuest(4614.45, -2246.81, 15.13, 34439, 78430)
    end
    if PeaceMaker_HasQuest(34439) then
      if not PeaceMaker_IsObjectiveCompleted(34439, 1) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34439, 2) then
        PeaceMaker_Kill(hotspot2, mob2, "Normal")
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34439) then
      PeaceMaker_CompleteQuest(4416.46, -2089.12, 2.95, 34439, 78996)
      return
    end
    if PeaceMaker_IsQuestCompleted(34439) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34439) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function GannarFrostGunPowderShadow()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34442) and not PeaceMaker_HasQuest(34442) then
      PeaceMaker_AcceptQuest(4416.791, -2087.079, 2.383846, 34442, 78996)
    end
    if PeaceMaker_HasQuest(34442) then
      if not PeaceMaker_IsQuestCompleted(34987) and not PeaceMaker_HasQuest(34987) then
        PeaceMaker_AcceptQuest(4368.306, -2112.426, 2.561132, 34987, 78569)
      end
    end
    if PeaceMaker_HasQuest(34987) then
      if not PeaceMaker_IsQuestCompleted(34958) and not PeaceMaker_HasQuest(34958) then
        PeaceMaker_AcceptQuest(4365.862, -2111.779, 2.438924, 34958, 78568)
      end
    end
    if (PeaceMaker_HasQuest(34442) and PeaceMaker_HasQuest(34987) and PeaceMaker_HasQuest(34958)) 
      or (PeaceMaker_IsQuestCompleted(34442) and PeaceMaker_IsQuestCompleted(34987) and PeaceMaker_IsQuestCompleted(34958))
      or (PeaceMaker_HasQuest(34442) and PeaceMaker_IsQuestCompleted(34987))
      or (PeaceMaker_HasQuest(34987) and PeaceMaker_IsQuestCompleted(34442)) 
      or (PeaceMaker_HasQuest(34958) and PeaceMaker_IsQuestCompleted(34442) and PeaceMaker_IsQuestCompleted(34987))
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(34442) and PeaceMaker_HasQuest(34987) and PeaceMaker_HasQuest(34958)) 
      or (PeaceMaker_IsQuestCompleted(34442) and PeaceMaker_IsQuestCompleted(34987) and PeaceMaker_IsQuestCompleted(34958))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function GannarFrostGunPowderShadow2()

  local hotspot1 = {  
    [1] = {  y=-2105.81,x=4339.06,radius=100,z=1.43 },
    [2] = {  y=-2088.982,x=4245.646,radius=100,z=2.451 },
    [3] = {  y=-2014.185,x=4302.546,radius=100,z=1.745 }
  } 

  local mob1 = { 80468, 81063 }

  if PeaceMaker_HasQuest(34958) and not PeaceMaker_IsQuestComplete(34958) then
    PeaceMaker_Kill(hotspot1, mob1, "Normal")
    return
  end

  if PeaceMaker_HasQuest(34987) and PeaceMaker_IsQuestComplete(34958) and not PeaceMaker_IsQuestComplete(34987) then
    if not PeaceMaker_IsObjectiveCompleted(34987, 1) then
      PeaceMaker_MoveToObjectAndInteract(4327.56, -2184.93, 6.93, 231119, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(34987, 2) then
      PeaceMaker_MoveToObjectAndInteract(4366.05, -2113.98, 2.43, 231066, 3)
      return  
    end
    return
  end

  if PeaceMaker_IsQuestComplete(34958) then
    PeaceMaker_CompleteQuest(4365.267, -2111.26, 2.402196, 34442, 78568)
    return
  end

  if PeaceMaker_IsQuestComplete(34987) then
    PeaceMaker_CompleteQuest(4365.267, -2111.26, 2.402196, 34987, 78569)
    return
  end

  if PeaceMaker_IsQuestComplete(34442) then
    PeaceMaker_CompleteQuest(4165.39, -2062.2, 2.94, 34442, 79917)
    return
  end

  if PeaceMaker_IsQuestCompleted(34442) and PeaceMaker_IsQuestCompleted(34987) and PeaceMaker_IsQuestCompleted(34958) then
    PeaceMaker_MoveToNextStep()
  end

end

function PolishingTheIron()
  local hotspot = { [1] = {  y=-2157.21,x=4219.07,radius=100,z=-9.76 } }
  local mob = { 80574 }
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34925) and not PeaceMaker_HasQuest(34925) then
      PeaceMaker_AcceptQuest(4165.39, -2062.2, 2.94, 34925, 79917)
    end
    if PeaceMaker_HasQuest(34925) then
      if not PeaceMaker_IsObjectiveCompleted(34925, 1) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
      end
      if PeaceMaker_IsQuestComplete(34925) then
        PeaceMaker_CompleteQuest(4165.39, -2062.2, 2.94, 34925, 79917)
      end
    end
    if PeaceMaker_IsQuestCompleted(34925) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34925) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ProdigalFrostWolf()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34437) and not PeaceMaker_HasQuest(34437) then
      PeaceMaker_AcceptQuest(4165.39, -2062.2, 2.94, 34437, 79917)
    end
    if PeaceMaker_IsQuestComplete(34437) then
      PeaceMaker_CompleteQuest(4415.66, -2089.66, 3.03, 34437, 78996)
    end
    if PeaceMaker_IsQuestCompleted(34437) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34437) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TripToTheTank()
  local hotspot = { [1] = {  y=-1943.098,x=4070.872,radius=100,z=26.72346 } }
  local mob = { 86039 }
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(35747) and not PeaceMaker_HasQuest(35747) then
      PeaceMaker_AcceptQuest(4383.264, -2093.495, 4.193911, 35747, 78563)
    end
    if PeaceMaker_HasQuest(35747) then
      if not PeaceMaker_IsObjectiveCompleted(35747, 1) then
        PeaceMaker_MoveToNpcAndInteract(4364.75, -2114.38, 2.4, 78568, 1)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(35747, 2) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return  
      end
      if not PeaceMaker_IsObjectiveCompleted(35747, 3) then
        PeaceMaker_MoveToAndWait(4065.51, -2020.13, 75.36, 1)
      end
    end
    if PeaceMaker_IsQuestComplete(35747) then
      PeaceMaker_CompleteQuest(4065.947, -2019.51, 75.32055, 35747, 80521)
    end
    if PeaceMaker_IsQuestCompleted(35747) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(35747) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TasteOfIron()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34445) and not PeaceMaker_HasQuest(34445) then
      PeaceMaker_AcceptQuest(4065.947, -2019.51, 75.32055, 34445, 80521)
    end
    if PeaceMaker_HasQuest(34445) then
      if not PeaceMaker_IsObjectiveCompleted(34445, 1) then
        PeaceMaker_MoveToObjectAndInteract(4054.581, -2019.666, 73.16997, 231261, 4)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34445, 2) then
        PeaceMaker_HardCodedCannonTank()
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34445, 3) then
        PeaceMaker_DelayMacroText("/click OverrideActionBarButton6")
        PeaceMaker_MoveToObjectAndInteract(4066.07, -2022.06, 75.42, 232538, 3)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34445) then
      PeaceMaker_CompleteQuest(4065.672, -2020.233, 75.35652, 34445, 80521)
    end
    if PeaceMaker_IsQuestCompleted(34445) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34445) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function HomeStretch()
  if PeaceMaker_MapID() == 1265 then
    if not PeaceMaker_IsQuestCompleted(34446) and not PeaceMaker_HasQuest(34446) then
      PeaceMaker_AcceptQuest(4065.672, -2020.233, 75.35652, 34446, 80521)
    end
    if PeaceMaker_HasQuest(34446) then
      if not PeaceMaker_IsObjectiveCompleted(34446, 1) then
        PeaceMaker_MoveToAndWait(3538.256, -2125.076, 17.23128, 1)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(34446) then
      PeaceMaker_CompleteQuest(3543.95, -2123.935, 17.23128, 34446, 78563)
    end
    if PeaceMaker_IsQuestCompleted(34446) then
      PeaceMaker_LoadNextProfile("15_20_H")
    end
  else
    if PeaceMaker_IsQuestCompleted(34446) then
      PeaceMaker_LoadNextProfile("15_20_H")
    end
  end
end