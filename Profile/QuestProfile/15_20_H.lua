QuestOrder = {
  [1] = { Quest_Name = "HomeOfTheFrostWolf", Quest_Settings = 3 },
  [2] = { Quest_Name = "SongAndFire", Quest_Settings = 3 },
  [3] = { Quest_Name = "WolveAndWarriors", Quest_Settings = 3 },
  [4] = { Quest_Name = "ForTheHorde", Quest_Settings = 3 },
  [5] = { Quest_Name = "BackToWorkGronning", Quest_Settings = 3 },
  [6] = { Quest_Name = "BackToWorkGronning2", Quest_Settings = 3 },
  [7] = { Quest_Name = "DenOfSkog", Quest_Settings = 3 },
  [8] = { Quest_Name = "EstablishYourGarrison", Quest_Settings = 3 },
  [9] = { Quest_Name = "WhatGoWhatNeedOgreLive", Quest_Settings = 3 },
  [10] = { Quest_Name = "WhatGoWhatNeedOgreLive2", Quest_Settings = 3 },
  [11] = { Quest_Name = "BuildYourBarrack", Quest_Settings = 3 },
  [12] = { Quest_Name = "WeNeedAnArmy", Quest_Settings = 3 },
  [13] = { Quest_Name = "LandProvideAndWindChange", Quest_Settings = 3 },
  [14] = { Quest_Name = "LandProvideAndWindChange2", Quest_Settings = 3 },
  [15] = { Quest_Name = "MissionProb", Quest_Settings = 3 },
  [16] = { Quest_Name = "DenOfWolves", Quest_Settings = 3 },
  [17] = { Quest_Name = "RallyTheFrost", Quest_Settings = 3 },
  [18] = { Quest_Name = "RallyTheFrost2", Quest_Settings = 3 },
  [19] = { Quest_Name = "GormaulTower", Quest_Settings = 3 },
  [20] = { Quest_Name = "TheseColourDon", Quest_Settings = 3 },
  [21] = { Quest_Name = "DeedsLeftUndone", Quest_Settings = 3 },
  [22] = { Quest_Name = "GreatBallOfFire", Quest_Settings = 3 },
  [23] = { Quest_Name = "TheButcher", Quest_Settings = 3 },
  [24] = { Quest_Name = "SlaughterArmed", Quest_Settings = 3 },
  [25] = { Quest_Name = "SlaughterArmed2", Quest_Settings = 3 },
  [26] = { Quest_Name = "LastSteps", Quest_Settings = 3 },
  [27] = { Quest_Name = "MovingIn", Quest_Settings = 3 },
  [28] = { Quest_Name = "SaveWolfMoppingSlaverySlaying", Quest_Settings = 3 },
  [29] = { Quest_Name = "SaveWolfMoppingSlaverySlaying2", Quest_Settings = 3 },
  [30] = { Quest_Name = "SaveWolfMoppingSlaverySlaying3", Quest_Settings = 3 },
  [31] = { Quest_Name = "SlaveMasterDemise", Quest_Settings = 3 },
  [32] = { Quest_Name = "TurnInSlayMop", Quest_Settings = 3 },
  [33] = { Quest_Name = "WarlordTheCure", Quest_Settings = 3 },
  [34] = { Quest_Name = "WarlordTheCure2", Quest_Settings = 3 },
  [35] = { Quest_Name = "TheFallOfWarlod", Quest_Settings = 3 },
  [36] = { Quest_Name = "SaveTheWolf", Quest_Settings = 3 },
  [37] = { Quest_Name = "SaveTheWolf2", Quest_Settings = 3 },
  [38] = { Quest_Name = "TheFarseer", Quest_Settings = 3 },
  [39] = { Quest_Name = "PoolVision", Quest_Settings = 3 },
  [40] = { Quest_Name = "BladeSpireCitadel", Quest_Settings = 3 },
  [41] = { Quest_Name = "GanarUntilWrath", Quest_Settings = 3 },
  [42] = { Quest_Name = "EldestUntilBigger", Quest_Settings = 3 }
}

function HomeOfTheFrostWolf()
  if PeaceMaker_IsQuestComplete(33868) then
    PeaceMaker_CompleteQuest(5539.63, 5012.19, 12.86, 33868, 76411)
  end
  if PeaceMaker_IsQuestCompleted(33868) then
    PeaceMaker_MoveToNextStep()
  end
end

function SongAndFire()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33815) and not PeaceMaker_HasQuest(33815) then
      PeaceMaker_AcceptQuest(5539.63, 5012.19, 12.86, 33815, 76411)
    end
    if PeaceMaker_HasQuest(33815) then
      if not PeaceMaker_IsObjectiveCompleted(33815, 1) then
        PeaceMaker_MoveToAndWait(5435.35, 4949.61, 64.68, 5)
        return
      end
      if PeaceMaker_IsQuestComplete(33815) then
        PeaceMaker_CompleteQuest(5436.736, 4952.756, 64.57199, 33815, 78272)
      end
    end
    if PeaceMaker_IsQuestCompleted(33815) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33815) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WolveAndWarriors()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(34402) and not PeaceMaker_HasQuest(34402) then
      PeaceMaker_AcceptQuest(5436.736, 4952.756, 64.57199, 34402, 78272)
    end
    if PeaceMaker_HasQuest(34402) then
      if PeaceMaker_IsQuestComplete(34402) then
        PeaceMaker_CompleteQuest(5613.917, 4528.342, 119.9844, 34402, 70859)
      end
    end
    if PeaceMaker_IsQuestCompleted(34402) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34402) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ForTheHorde()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(34364) and not PeaceMaker_HasQuest(34364) then
      PeaceMaker_AcceptQuest(5436.736, 4952.756, 64.57199, 34402, 78272)
    end
    if PeaceMaker_HasQuest(34364) then
      if not PeaceMaker_IsObjectiveCompleted(34364, 1) then
        PeaceMaker_InteractAroundPos(5625.663, 4530.441, 119.3687, 100, 229057, "Object", 3)
      end
      if PeaceMaker_IsQuestComplete(34364) then
        PeaceMaker_CompleteQuest(5625.032, 4529.757, 119.5313, 34364, 78466)
      end
    end
    if PeaceMaker_IsQuestCompleted(34364) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34364) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BackToWorkGronning()
  local questList = { 34375, 34592 }
  local npcList = { 78466, 78466}
  local hotspotList = { 
    [1] = { 5629.014, 4525.724, 118.971 },
    [2] = { 5629.014, 4525.724, 118.971 }
  }
  if PeaceMaker_MapID() == 1116 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function BackToWorkGronning2()

  local hotspot1 = {  
    [1] = {  y=4571.766,x=5565.298,radius=100,z=138.2261 },
    [2] = {  y=4464.908,x=5517.683,radius=100,z=143.9467 },
    [3] = {  y=4455.56,x=5614.236,radius=100,z=138.3586 }
  }

  local hotspot2 = {
    [1] = {  y=4455.56,x=5614.236,radius=100,z=138.3586 },
    [2] = {  y=4585.587,x=5706.182,radius=100,z=143.1093 },
    [3] = {  y=4466.538,x=5504.516,radius=100,z=143.1833 },
    [4] = {  y=4500.787,x=5728.302,radius=100,z=131.7374 }
  }

  local obj = { 230527 }
  local mob = { 79529 }

  if PeaceMaker_MapID() == 1116 then
    if PeaceMaker_HasQuest(34375) then
      if not PeaceMaker_IsQuestComplete(34375) then
        PeaceMaker_Interact(hotspot1, obj, "Object", 3)
        return
      end
    end
    if PeaceMaker_HasQuest(34592) and PeaceMaker_IsQuestComplete(34375) and not PeaceMaker_IsQuestComplete(34592) then
      PeaceMaker_Kill(hotspot2, mob, "Normal")
      return
    end
    if PeaceMaker_IsQuestComplete(34375) then
      PeaceMaker_CompleteQuest(5629.014, 4525.724, 118.971, 34375, 78466)
      return
    end
    if PeaceMaker_IsQuestComplete(34592) then
      PeaceMaker_CompleteQuest(5629.014, 4525.724, 118.971, 34592, 78466)
      return
    end
    if PeaceMaker_IsQuestCompleted(34592) and PeaceMaker_IsQuestCompleted(34375) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34592) and PeaceMaker_IsQuestCompleted(34375) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function DenOfSkog()
  local hotspot = {  
    [1] = {  y=4543.041,x=5424.869,radius=100,z=139.1242 }
  }
  local mob = { 79903 }
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(34765) and not PeaceMaker_HasQuest(34765) then
      PeaceMaker_AcceptQuest(5629.014, 4525.724, 118.971, 34765, 78466)
    end
    if PeaceMaker_HasQuest(34765) then
      if not PeaceMaker_IsObjectiveCompleted(34765, 1) then
        PeaceMaker_Kill(hotspot, mob, "Boss")
      end
      if PeaceMaker_IsQuestComplete(34765) then
        PeaceMaker_CompleteQuest(5629.014, 4525.724, 118.971, 34765, 78466)
      end
    end
    if PeaceMaker_IsQuestCompleted(34765) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34765) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function EstablishYourGarrison()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(34378) and not PeaceMaker_HasQuest(34378) then
      PeaceMaker_AcceptQuest(5629.014, 4525.724, 118.971, 34378, 78466)
    end
    if PeaceMaker_HasQuest(34378) then
      if not PeaceMaker_IsObjectiveCompleted(34378, 1) then
        PeaceMaker_MoveToObjectAndInteract(5568.02, 4636.92, 146.62, 233664, 3)
      end
    end
    if PeaceMaker_IsQuestCompleted(34378) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 1152 then
      if PeaceMaker_IsQuestComplete(34378) then
        PeaceMaker_CompleteQuest(5564.74, 4517.15, 132.02, 34378, 78466)
      end
    end
    if PeaceMaker_IsQuestCompleted(34378) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WhatGoWhatNeedOgreLive()
  local questList = { 34824, 34822, 34823 }
  local npcList = { 78466, 78466, 78487}
  local hotspotList = { 
    [1] = { 5564.74, 4517.15, 132.02 },
    [2] = { 5564.74, 4517.15, 132.02 },
    [3] = { 5573.69, 4525.59, 130.18 }
  }
  if PeaceMaker_MapID() == 1152 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function WhatGoWhatNeedOgreLive2()

  local hotspot1 = {  
    [1] = {  y=4887.746,x=5730.924,radius=100,z=29.31822 },
    [2] = {  y=5019.595,x=5711.073,radius=100,z=38.67435 }
  }

  local hotspot2 = {
    [1] = {  y=4955.965,x=5870.323,radius=100,z=26.2709 }
  }

  local obj = { 230879, 230880, 230881 }
  local mob = { 80167 }

  if PeaceMaker_MapID() == 1152 then

    if PeaceMaker_HasQuest(34824) and not PeaceMaker_IsQuestCompleted(34824) then
      if not PeaceMaker_IsObjectiveCompleted(34824, 1) then
        PeaceMaker_MoveToNpcAndInteract(5576.162, 4597.182, 136.5887, 80225, 1)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34824, 2) then
        PeaceMaker_MoveToObjectAndInteract(5565.679, 4499.009, 132.0261, 237191, 3)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(34824, 3) then
        PeaceMaker_MoveToNpcAndInteract(5737.327, 4538.995, 137.9499, 86775, 1)
        return
      end
    end

    if PeaceMaker_HasQuest(34822) and PeaceMaker_IsQuestComplete(34824) and not PeaceMaker_IsQuestComplete(34822) then
      PeaceMaker_MoveToAndWait(5877.66, 4480.68, 118.23, 3)
      return
    end

    if PeaceMaker_HasQuest(34823) and PeaceMaker_IsQuestComplete(34822) and not PeaceMaker_IsQuestComplete(34823) then
      PeaceMaker_MoveToAndWait(5877.66, 4480.68, 118.23, 3)
      return
    end

    if PeaceMaker_IsQuestComplete(34824) then
      PeaceMaker_CompleteQuest(5565.45, 4517.11, 131.96, 34824, 78466)
      return
    end

    if PeaceMaker_IsQuestComplete(34822) then
      PeaceMaker_CompleteQuest(5565.45, 4517.11, 131.96, 34822, 78466)
      return
    end

    if PeaceMaker_IsQuestComplete(34823) then
      PeaceMaker_CompleteQuest(5573.6, 4524.93, 130.27, 34823, 78487)
      return
    end

    if PeaceMaker_IsQuestCompleted(34824) and PeaceMaker_IsQuestCompleted(34822) and PeaceMaker_IsQuestCompleted(34823) then
      PeaceMaker_MoveToNextStep()
    end

  else

    if PeaceMaker_MapID() == 1116 then
      if PeaceMaker_HasQuest(34822) and PeaceMaker_IsQuestComplete(34824) and not PeaceMaker_IsQuestComplete(34822) then
        PeaceMaker_Interact(hotspot1, obj, "Object", 3)
        return
      end

      if PeaceMaker_HasQuest(34823) and PeaceMaker_IsQuestComplete(34822) and not PeaceMaker_IsQuestComplete(34823) then
        PeaceMaker_Kill(hotspot2, mob, "Normal")
        return
      end
      if PeaceMaker_IsQuestComplete(34824) then
        PeaceMaker_MoveToAndWait(5833.7, 4473.44, 118.12, 3)
        return
      end
  
      if PeaceMaker_IsQuestComplete(34823) then
        PeaceMaker_MoveToAndWait(5833.7, 4473.44, 118.12, 3)
        return
      end
  
      if PeaceMaker_IsQuestComplete(34822) then
        PeaceMaker_MoveToAndWait(5833.7, 4473.44, 118.12, 3)
        return
      end
    end

    if PeaceMaker_IsQuestCompleted(34824) and PeaceMaker_IsQuestCompleted(34822) and PeaceMaker_IsQuestCompleted(34823) then
      PeaceMaker_MoveToNextStep()
    end

  end

end

function BuildYourBarrack()
  if PeaceMaker_MapID() == 1152 then
    if not PeaceMaker_IsQuestCompleted(34461) and not PeaceMaker_HasQuest(34461) then
      PeaceMaker_AcceptQuest(5565.08, 4517.16, 131.99, 34461, 78466)
    end
    if PeaceMaker_HasQuest(34461) then
      if not PeaceMaker_IsObjectiveCompleted(34461, 1) then
        PeaceMaker_MoveToObjectAndInteract(5580.3, 4466.74, 130.85, 231012, 2.5)
        return
      end

      if not PeaceMaker_IsObjectiveCompleted(34461, 2) then
        PeaceMaker_UseItemOnSelf(111956)
        return
      end

      if not PeaceMaker_IsObjectiveCompleted(34461, 3) then
        if not GarrisonBuildingFrame or (GarrisonBuildingFrame and not GarrisonBuildingFrame:IsVisible()) then
          PeaceMaker_MoveToNpcAndInteract(5564.38, 4519.32, 131.83, 80600, 1)
        else
          PeaceMaker_MacroText("/run C_Garrison.PlaceBuilding(23, 26)")
        end
        return
      end

      if not PeaceMaker_IsObjectiveCompleted(34461, 5) then
        PeaceMaker_MoveToObjectAndInteract(5587.68, 4477.73, 130.76, 231217, 3)
        return
      end

      if PeaceMaker_IsQuestComplete(34461) then
        PeaceMaker_CompleteQuest(5589.756, 4479.972, 130.0145, 34461, 78466)
      end
    end
    if PeaceMaker_IsQuestCompleted(34461) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34461) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WeNeedAnArmy()
  if PeaceMaker_MapID() == 1152 then
    if not PeaceMaker_IsQuestCompleted(34861) and not PeaceMaker_HasQuest(34861) then
      PeaceMaker_AcceptQuest(5587.79, 4482.28, 130.06, 34861, 78466)
    end
    if PeaceMaker_HasQuest(34861) then
      if PeaceMaker_IsQuestComplete(34861) then
        PeaceMaker_CompleteQuest(5557.5, 4505.76, 132.68, 34861, 79740)
      end
    end
    if PeaceMaker_IsQuestCompleted(34861) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34861) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LandProvideAndWindChange()
  if PeaceMaker_MapID() == 1152 then
    if not PeaceMaker_IsQuestCompleted(34462) and not PeaceMaker_HasQuest(34462) then
      PeaceMaker_AcceptQuest(5557.5, 4505.76, 132.68, 34462, 79740)
    end
    if PeaceMaker_HasQuest(34462) then
      if not PeaceMaker_IsQuestCompleted(34960) and not PeaceMaker_HasQuest(34960) then
        PeaceMaker_MoveToAndWait(5686.12, 4246.74, 75.19, 3)
      end
    end
    if (PeaceMaker_HasQuest(34462) and PeaceMaker_HasQuest(34960)) 
      or (PeaceMaker_IsQuestCompleted(34462) and PeaceMaker_IsQuestCompleted(34960))
      or (PeaceMaker_HasQuest(34462) and PeaceMaker_IsQuestCompleted(34960))
      or (PeaceMaker_HasQuest(34960) and PeaceMaker_IsQuestCompleted(34462)) 
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 1116 then
      if not PeaceMaker_IsQuestCompleted(34960) and not PeaceMaker_HasQuest(34960) then
        PeaceMaker_AcceptQuest(5523.285, 4191.386, 58.1792, 34960, 231100, "Object")
      end
    end
    if (PeaceMaker_HasQuest(34462) and PeaceMaker_HasQuest(34960)) 
      or (PeaceMaker_IsQuestCompleted(34462) and PeaceMaker_IsQuestCompleted(34960))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LandProvideAndWindChange2()

  local hotspot = {
    [1] = {  y=4161.833,x=5403.646,radius=100,z=58.11107 }
  }

  local obj = { 231096, 231097, 231098 }

  if PeaceMaker_MapID() == 1116 then

    if PeaceMaker_HasQuest(34960) and not PeaceMaker_IsQuestComplete(34960) then
      PeaceMaker_Interact(hotspot, obj, "Object", 3)
      return
    end

    if PeaceMaker_HasQuest(34462) and PeaceMaker_IsQuestComplete(34960) and not PeaceMaker_IsQuestComplete(34462) then
      PeaceMaker_InteractAroundPos(5710.485, 4003.895, 66.43501, 100, 80577, "Unit", 5)
      return
    end

    if PeaceMaker_IsQuestComplete(34960) then
      PeaceMaker_MoveToAndWait(5699.29, 4319.03, 96.26, 3)
      return
    end

    if PeaceMaker_IsQuestComplete(34462) then
      PeaceMaker_MoveToAndWait(5699.29, 4319.03, 96.26, 3)
      return
    end

    if PeaceMaker_IsQuestCompleted(34960) and PeaceMaker_IsQuestCompleted(34462) then
      PeaceMaker_MoveToNextStep()
    end
  else

    if PeaceMaker_MapID() == 1152 then
      if PeaceMaker_IsQuestComplete(34960) then
        PeaceMaker_CompleteQuest(5564.57, 4517.23, 132.02, 34960, 78466)
        return
      end
      if PeaceMaker_IsQuestComplete(34462) then
        PeaceMaker_CompleteQuest(5556.65, 4507.17, 132.68, 34462, 79740)
        return
      end
    end

    if PeaceMaker_IsQuestCompleted(34960) and PeaceMaker_IsQuestCompleted(34462) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function MissionProb()
  if PeaceMaker_MapID() == 1152 then
    if not PeaceMaker_IsQuestCompleted(34775) and not PeaceMaker_HasQuest(34775) then
      PeaceMaker_AcceptQuest(5556.65, 4507.17, 132.68, 34775, 79740)
    end
    if PeaceMaker_HasQuest(34775) then
      if not PeaceMaker_IsObjectiveCompleted(34775, 1) then
        if PeaceMaker_GetDistance3D(5558.79, 4505.98, 132.68) > 3 then 
          PeaceMaker_MoveToAndWait(5558.79, 4505.98, 132.68, 1)
        else
          if not GarrisonMissionFrame or (GarrisonMissionFrame and not GarrisonMissionFrame:IsVisible()) then
            PeaceMaker_InteractNpcNearBy(80432)
          else
            PeaceMaker_HardCodedMissionProbable()
          end 
        end
        return
      end
      if PeaceMaker_IsQuestComplete(34775) then
        PeaceMaker_CompleteQuest(5560.338, 4508.412, 132.6962, 34775, 79740)
      end
    end
    if PeaceMaker_IsQuestCompleted(34775) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34775) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function DenOfWolves()
  if PeaceMaker_MapID() == 1152 then
    if not PeaceMaker_IsQuestCompleted(34379) and not PeaceMaker_HasQuest(34379) then
      PeaceMaker_AcceptQuest(5581.74, 4536.26, 133.86, 34379, 76411)
    end
    if PeaceMaker_HasQuest(34379) and not PeaceMaker_IsQuestCompleted(34379) then
      if not PeaceMaker_IsObjectiveCompleted(34379, 1) then
        if not UnitInVehicle("player") then
          PeaceMaker_MoveToInteractAndWait(5582.01, 4555.16, 135.65, 78320, 3, "Unit")
        end
      end
    end
    if PeaceMaker_IsQuestCompleted(34379) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 1116 then
      if PeaceMaker_IsQuestComplete(34379) and not PeaceMaker_IsQuestCompleted(34379) then
        if not UnitInVehicle("player") then
          PeaceMaker_CompleteQuest(5911.71, 6237.82, 52.16, 34379, 70860)
        end
      end
    end
    if PeaceMaker_IsQuestCompleted(34379) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function RallyTheFrost()
  local questList = { 34380, 33816 }
  local npcList = { 70860, 80456 }
  local hotspotList = { 
    [1] = { 5912.299, 6234.854, 51.47817 },
    [2] = { 5912.629, 6224.741, 49.51729 }
  }
  if PeaceMaker_MapID() == 1116 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function RallyTheFrost2()
  if PeaceMaker_MapID() == 1116 then
    if PeaceMaker_HasQuest(33816) and not PeaceMaker_IsQuestCompleted(33816) then
      if not PeaceMaker_IsQuestComplete(33816) then
        PeaceMaker_MoveToAndWait(5965.33, 6427.56, 62.75, 1)
        return
      end
    end
    if PeaceMaker_HasQuest(34380) and PeaceMaker_IsQuestComplete(33816) and not PeaceMaker_IsQuestCompleted(34380) then
      if not PeaceMaker_IsQuestComplete(34380) then
        PeaceMaker_MoveToNpcAndInteract(5825.22, 6322.28, 89.74, 78971, 1)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(33816) then
      PeaceMaker_CompleteQuest(5913.33, 6220.2, 49.2, 33816, 80456)
      return
    end
    if PeaceMaker_IsQuestComplete(34380) then
      PeaceMaker_CompleteQuest(5911.684, 6227.206, 49.8963, 34380, 76557)
      return
    end
    if PeaceMaker_IsQuestCompleted(34380) and PeaceMaker_IsQuestCompleted(33816) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(34380) and PeaceMaker_IsQuestCompleted(33816) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function GormaulTower()
  
  local hotspot = {
    [1] = {  y=6293.213,x=6458.332,radius=100,z=228.0956 },
    [2] = {  x=6522.8,y=6247.35,z=225.56,radius = 100}
  }

  local hotspot1 = {
    [1] = {  y=6293.213,x=6458.332,radius=100,z=228.0956 },
  }

  local hotspot2 = {
    [1] = {  y=6355.95,x=6430.37,radius=100,z=226.99 },
  }

  local mob = { 73373, 73371, 75240, 75241, 73472 }
  local mob1 = { 78173 }
  local mob2 = { 76208 }

  if PeaceMaker_MapID() == 1116 then

    if not PeaceMaker_IsQuestCompleted(33784) and not PeaceMaker_HasQuest(33784) then
      PeaceMaker_AcceptQuest(5911.684, 6227.206, 49.89631, 33784, 76557)
    end

    if PeaceMaker_HasQuest(33784) then

      if not PeaceMaker_IsQuestCompleted(33784) then

        if not PeaceMaker_IsObjectiveCompleted(33784, 1) then
          if PeaceMaker_ForceVendorFinish then
            --PeaceMaker_MoveToNpcAndInteract(5911.52, 6237.58, 52.2, 33784, 70860)
            PeaceMaker_MoveToAndWait(6477.26, 6203.02, 221.45, 3)
          end
          if (not MerchantFrame or (MerchantFrame and not MerchantFrame:IsVisible())) and not PeaceMaker_ForceVendorFinish then
            PeaceMaker_MoveToNpcAndInteract(5866.717, 6236.752, 49.167, 79448, 1)
          else
            PeaceMaker_SellAllItem(4)
            C_Timer.After(8, function() PeaceMaker_ForceVendorFinish = true end)
            PeaceMaker.Pause = PeaceMaker.Time + 10
          end
          return
        end

        if not PeaceMaker_IsObjectiveCompleted(33784, 3) then
          PeaceMaker_Kill(hotspot, mob, "Boss")
          return
        end

        if not PeaceMaker_IsObjectiveCompleted(33784, 4) then
          PeaceMaker_Kill(hotspot1, mob1, "Normal")
          return
        end

        if not PeaceMaker_IsObjectiveCompleted(33784, 5) then
          PeaceMaker_Kill(hotspot2, mob2, "Boss")
          return
        end
      end 

      if PeaceMaker_IsQuestComplete(33784) then
        PeaceMaker_CompleteQuest(6450.07, 6298.98, 228.04, 33784, 76240)
        return
      end
    end

    if PeaceMaker_IsQuestCompleted(33784) then
      PeaceMaker_MoveToNextStep()
    end

  else

    if PeaceMaker_IsQuestCompleted(33784) then
      PeaceMaker_MoveToNextStep()
    end

  end

end

function TheseColourDon()

  local hotspot = {  
    [1] = {  y=6209.452,x=6580.101,radius=100,z=230.5385 },
    [2] = {  y=6166.925,x=6673.887,radius=100,z=238.4791 },
    [3] = {  x = 6716.67, y = 6067.84, z = 244.6, radius = 100 }
  } 

  local obj = { 73371, 73373, 75240 }

  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33526) and not PeaceMaker_HasQuest(33526) then
      PeaceMaker_AcceptQuest(6453.622, 6300.132, 227.9792, 33526, 70860)
    end
    if PeaceMaker_HasQuest(33526) and not PeaceMaker_IsQuestCompleted(33526) then
      if not PeaceMaker_IsObjectiveCompleted(33526, 1) then
        PeaceMaker_KillAndUseItemOnCorpse(hotspot, obj, 107279, 2, "Plant Frostwolf Banner")
        return
      end
    end
    if PeaceMaker_IsQuestComplete(33526) then
      PeaceMaker_CompleteQuest(6894.78, 5846.51, 258.65, 33526, 74273)
      return
    end
    if PeaceMaker_IsQuestCompleted(33526) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33526) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function DeedsLeftUndone()

  local hotspot = {  
    [1] = {  y=5844.665,x=6864.71,radius=100,z=258.688 },
    [2] = {  y=5861.861,x=6780.106,radius=100,z=258.6879 },
    [3] = {  y=5794.884,x=6748.134,radius=100,z=258.688 }
  } 

  local obj = { 225681 }

  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33546) and not PeaceMaker_HasQuest(33546) then
      PeaceMaker_AcceptQuest(6892.22, 5848.928, 258.6867, 33546, 74273)
    end
    if PeaceMaker_HasQuest(33546) and not PeaceMaker_IsQuestCompleted(33546) then
      if not PeaceMaker_IsObjectiveCompleted(33546, 1) then
        PeaceMaker_Interact(hotspot, obj, "Object", 3)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33546, 2) then
        PeaceMaker_MoveToNpcAndInteract(6795.31, 5756.12, 258.69, 75167, 1)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(33546) then
      PeaceMaker_CompleteQuest(6653.58, 5914.44, 254.08, 33546, 75177)
      return
    end
    if PeaceMaker_IsQuestCompleted(33546) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33546) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function GreatBallOfFire()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33408) and not PeaceMaker_HasQuest(33408) then
      PeaceMaker_AcceptQuest(6653.58, 5914.44, 254.08, 33408, 75177)
    end
    if PeaceMaker_HasQuest(33408) and not PeaceMaker_IsQuestCompleted(33408) then
      if not PeaceMaker_IsObjectiveCompleted(33408, 1) then
        PeaceMaker_CastSpell(642)
        if PeaceMaker.Player.HP < 40 and PeaceMaker.Player.Class == 2 then PeaceMaker_CastSpell(633) end
        PeaceMaker_MoveToAndWait(6611.14, 5735.416, 318.1961, 1)
        return
      end
    end
    if PeaceMaker_IsQuestComplete(33408) then
      PeaceMaker_CompleteQuest(6628.34, 5665.42, 318.86, 33408, 75186)
      return
    end
    if PeaceMaker_IsQuestCompleted(33408) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33408) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TheButcher()

  local hotspot = {  
    [1] = {  y=5771.417,x=6651.311,radius=100,z=318.8704 }
  } 

  local mob = { 74254 }

  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33410) and not PeaceMaker_HasQuest(33410) then
      PeaceMaker_AcceptQuest(6628.04, 5665.88, 318.88, 33410, 75186)
    end
    if PeaceMaker_HasQuest(33410) and not PeaceMaker_IsQuestCompleted(33410) then
      if not PeaceMaker_IsObjectiveCompleted(33410, 1) then
        PeaceMaker_Kill(hotspot, mob, "Boss")
        return
      end
      if PeaceMaker_IsQuestComplete(33410) then
        PeaceMaker_CompleteQuest(6628.04, 5665.88, 318.88, 33410, 75186)
      end
    end
    if PeaceMaker_IsQuestCompleted(33410) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33410) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SlaughterArmed()
  local questList = { 33622, 33344 }
  local npcList = { 75186, 75186 }
  local hotspotList = { 
    [1] = { 6628.04, 5665.88, 318.88 },
    [2] = { 6628.04, 5665.88, 318.88 }
  }
  if PeaceMaker_MapID() == 1116 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function SlaughterArmed2()

  local hotspot = {  
    [1] = {  y=5770.93,x=6795.86,radius=100,z=325.21 },
    [2] = {  y=5863.2,x=6824.38,radius=100,z=325.21 }
  } 

  local hotspot1 = {  
    [1] = {  y=5770.93,x=6795.86,radius=100,z=325.21 },
    [2] = {  y=5863.2,x=6824.38,radius=100,z=325.21 }
  } 

  local mob = { 76547, 76238 }
  local mob1 = { 75057, 73469, 73470, 73472 }
  
  if PeaceMaker_MapID() == 1116 then
    if PeaceMaker_HasQuest(33344) and not PeaceMaker_IsQuestComplete(33344) then
      PeaceMaker_Interact(hotspot, mob, "Unit", 3)
      return
    end
    
    if PeaceMaker_HasQuest(33622) and PeaceMaker_IsQuestComplete(33344) and PeaceMaker_IsQuestCompleted(33622) then
      PeaceMaker_Kill(hotspot1, mob1, "Normal")
      return
    end

    if PeaceMaker_IsQuestComplete(33622) then
      PeaceMaker_CompleteQuest(6821.32, 5794.23, 325.19, 33622, 75177)
      return
    end

    if PeaceMaker_IsQuestComplete(33344) then
      PeaceMaker_CompleteQuest(6821.32, 5794.23, 325.19, 33344, 75177)
    end

    if PeaceMaker_IsQuestCompleted(33622) and PeaceMaker_IsQuestCompleted(33344) then
      PeaceMaker_MoveToNextStep()
    end
  else  
    if PeaceMaker_IsQuestCompleted(33622) and PeaceMaker_IsQuestCompleted(33344) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LastSteps()

  local hotspot = {  
    [1] = {  y=5837.969,x=6786.949,radius=100,z=410.1527 }
  } 

  local mob = { 74105 }

  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33527) and not PeaceMaker_HasQuest(33527) then
      PeaceMaker_AcceptQuest(6821.32, 5794.23, 325.19, 33527, 75177)
    end
    if PeaceMaker_HasQuest(33527) and not PeaceMaker_IsQuestCompleted(33527) then
      if not PeaceMaker_IsObjectiveCompleted(33527, 1) then
        PeaceMaker_MoveToObjectAndInteract(6822.468, 5793.372, 325.1928, 231902, 3)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33527, 2) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
      if PeaceMaker_IsQuestComplete(33527) then
        PeaceMaker_CompleteQuest(6814.39, 5766.04, 410.15, 33527, 75188)
      end
    end
    if PeaceMaker_IsQuestCompleted(33527) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33527) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function MovingIn()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_IsQuestCompleted(33657) and not PeaceMaker_HasQuest(33657) then
      PeaceMaker_AcceptQuest(6814.39, 5766.04, 410.15, 33657, 75188)
    end
    if PeaceMaker_HasQuest(33657) and not PeaceMaker_IsQuestCompleted(33657) then
      if not UnitInVehicle('player') then
        if not PeaceMaker_IsObjectiveCompleted(33657, 1) then
          PeaceMaker_MoveToInteractAndWait(6816.38, 5765.47, 410.15, 75560, 4, "Unit")
          return
        end
        if PeaceMaker_IsQuestComplete(33657) then
          PeaceMaker_CompleteQuest(6807.18, 5850.44, 260.37, 33657, 70860)
        end
      end
    end
    if PeaceMaker_IsQuestCompleted(33657) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33657) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SaveWolfMoppingSlaverySlaying()
  local questList = { 33468, 33412, 33119, 33898 }
  local npcList = { 70860, 81678, 78222, 76662 }
  local hotspotList = { 
    [1] = { 6807.18, 5850.44, 260.37 },
    [2] = { 6785.62, 5957.61, 257.95 },
    [3] = { 6751.23, 6016.73, 249.56 },
    [4] = { 6672.13, 6030.66, 122.01 }
  }
  if PeaceMaker_MapID() == 1116 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function SaveWolfMoppingSlaverySlaying2()

  local hotspot = {  
    [1] = {  y=5965.208,x=6653.02,radius=100,z=126.7929 },
    [2] = {  y=5859.498,x=6557.425,radius=100,z=143.7344 },
    [3] = {  y=5780.777,x=6532.418,radius=100,z=153.7574 },
    [4] = {  y=5679.835,x=6542.585,radius=100,z=166.7959 }
  } 

  local mob = { 221674 }
  local mob2 = { 72752, 72833, 73698 }

  if PeaceMaker_MapID() == 1116 then

    if PeaceMaker_HasQuest(33119) and not PeaceMaker_IsQuestComplete(33119) and not PeaceMaker_IsQuestCompleted(33119) then
      if not PeaceMaker_IsObjectiveCompleted(33119, 1) then
        PeaceMaker_Interact(hotspot, mob, "Object", 2)
        return
      end 

      if not PeaceMaker_IsObjectiveCompleted(33119, 2) then
        PeaceMaker_MoveToAndWait(6586.48, 5625.27, 167.09, 3)
        return
      end 
    end

    if PeaceMaker_HasQuest(33898) and not PeaceMaker_IsQuestComplete(33119) and not PeaceMaker_IsQuestCompleted(33898) then
      if not PeaceMaker_IsObjectiveCompleted(33898, 1) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end 
    end

    if PeaceMaker_IsQuestComplete(33119) then
      PeaceMaker_CompleteQuest(6583.11, 5624.21, 166.99, 33119, 72890)
    end
    
    if (PeaceMaker_IsQuestCompleted(33119) and PeaceMaker_IsQuestCompleted(33898)) or (PeaceMaker_IsQuestCompleted(33119) and PeaceMaker_IsQuestComplete(33898)) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_IsQuestCompleted(33119) and PeaceMaker_IsQuestCompleted(33898)) or (PeaceMaker_IsQuestCompleted(33119) and PeaceMaker_IsQuestComplete(33898)) then
      PeaceMaker_MoveToNextStep()
    end
  end
  
end

function SaveWolfMoppingSlaverySlaying3()
  
  local hotspot = {  
    [1] = {  y=5753.974,x=6694.144,radius=100,z=149.8438 },
    [2] = {  y=5774.848,x=6749.252,radius=100,z=146.0568 },
    [3] = {  y=5889.526,x=6734.078,radius=100,z=130.8856 }
  } 

  local hotspot1 = {
    [1] = {  y=5823.988,x=6810.295,radius=100,z=155.736 }
  }

  local mob = { 73698, 76706 }
  local mob2 = { 72873 }

  if PeaceMaker_MapID() == 1116 then

    if not PeaceMaker_HasQuest(33483) and not PeaceMaker_IsQuestCompleted(33483) then
      PeaceMaker_AcceptQuest(6583.291, 5624.532, 166.9945, 33483, 72890)
    end

    if PeaceMaker_HasQuest(33483) and not PeaceMaker_IsQuestCompleted(33483) then
      if not PeaceMaker_IsObjectiveCompleted(33483, 1) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33483, 2) then
        PeaceMaker_Kill(hotspot1, mob2, "Boss")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33483, 3) then
        PeaceMaker_MoveToObjectAndInteract(6583.7, 5624.14, 167.01, 225826, 3)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(33483) then
      PeaceMaker_CompleteQuest(6585.23, 5625.73, 167.03, 33119, 79047)
    end
    
    if PeaceMaker_IsQuestCompleted(33483) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33483) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function SlaveMasterDemise()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33484) and not PeaceMaker_IsQuestCompleted(33484) then
      PeaceMaker_AcceptQuest(6582.67, 5624.79, 166.97, 33484, 79047)
    end

    -- if PeaceMaker_HasQuest(33484) and not PeaceMaker_IsQuestCompleted(33484) then
    --   if not PeaceMaker_IsObjectiveCompleted(33484, 1) then
    --     PeaceMaker_MoveToObjectAndInteract(6585.363, 5628.748, 166.9465, 79047, 3)
    --     return
    --   end
    -- end
    
    if (PeaceMaker_IsQuestCompleted(33484) or PeaceMaker_HasQuest(33484)) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33484) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TurnInSlayMop()
  if PeaceMaker_MapID() == 1116 then
    if PeaceMaker_IsQuestComplete(33898) then
      PeaceMaker_CompleteQuest(6671.73, 6030.32, 122.01, 33898, 76662)
      return
    end
    if PeaceMaker_IsQuestComplete(33412) then
      PeaceMaker_CompleteQuest(7116.35, 6008.1, 133.88, 33412, 74635)
      return
    end
    if PeaceMaker_IsQuestCompleted(33898) and PeaceMaker_IsQuestCompleted(33412) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33898) and PeaceMaker_IsQuestCompleted(33412) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WarlordTheCure()
  local questList = { 33450, 33454 }
  local npcList = { 74635, 74635 }
  local hotspotList = { 
    [1] = { 7116.35, 6008.1, 133.88 },
    [2] = { 7116.35, 6008.1, 133.88 }
  }
  if PeaceMaker_MapID() == 1116 then
    PeaceMaker_AcceptChainQuest(questList, npcList, hotspotList)
    PeaceMaker_CheckChainQuest(questList)
  else
    PeaceMaker_CheckChainQuest(questList)
  end
end

function WarlordTheCure2()

  local hotspot = {  
    [1] = {  y=5880.073,x=7212.741,radius=100,z=119.9016 },
    [2] = {  y=5919.813,x=7114.16,radius=100,z=122.1392 }
  } 

  local mob = { 74672 }
  local mob2 = { 74697 }

  if PeaceMaker_MapID() == 1116 then

    if PeaceMaker_HasQuest(33454) and not PeaceMaker_IsQuestCompleted(33454) then
      if not PeaceMaker_IsObjectiveCompleted(33454, 1) then
        PeaceMaker_InteractTarget(hotspot, mob, "Unit", 2)
        return
      end
    end

    if PeaceMaker_HasQuest(33450) and PeaceMaker_IsQuestComplete(33454) and not PeaceMaker_IsQuestCompleted(33450) then
      if not PeaceMaker_IsObjectiveCompleted(33450, 1) then
        PeaceMaker_KillAroundPos(7244.48, 5857.44, 122.09, 100, 74704, "Normal")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33450, 2) then
        PeaceMaker_KillAroundPos(7305.18, 5785.2, 114.12, 100, 74707, "Normal")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33450, 3) then
        PeaceMaker_KillAroundPos(7206.71, 5773.07, 140.35, 100, 74706, "Normal")
        return
      end
    end

    if PeaceMaker_IsQuestComplete(33450) then
      PeaceMaker_CompleteQuest(7091.58, 6011.78, 133.85, 33450, 74635)
      return
    end

    if PeaceMaker_IsQuestComplete(33454) then
      PeaceMaker_CompleteQuest(7091.58, 6011.78, 133.85, 33454, 74635)
      return
    end
    
    if PeaceMaker_IsQuestCompleted(33450) and PeaceMaker_IsQuestCompleted(33454) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33450) and PeaceMaker_IsQuestCompleted(33454) then
      PeaceMaker_MoveToNextStep()
    end
  end
  
end

function TheFallOfWarlod()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33467) and not PeaceMaker_IsQuestCompleted(33467) then
      PeaceMaker_AcceptQuest(7091.58, 6011.78, 133.85, 33467, 74635)
    end
    
    if PeaceMaker_HasQuest(33467) then
      if not PeaceMaker_IsObjectiveCompleted(33467, 1) then
        PeaceMaker_MoveToObjectAndInteract(7213.76, 6078.9, 117.45, 227291, 3)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(33467) then
      PeaceMaker_CompleteQuest(6785.66, 5957.56, 257.96, 33467, 81678)
      return
    end

    if PeaceMaker_IsQuestComplete(33484) then
      PeaceMaker_CompleteQuest(6751.1, 6016.81, 249.55, 33484, 78222)
      return
    end

    if PeaceMaker_IsQuestCompleted(33467) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33467) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SaveTheWolf()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33807) and not PeaceMaker_IsQuestCompleted(33807) then
      PeaceMaker_AcceptQuest(5897, 6340.44, 53.66, 33807, 74507)
    end
    if (PeaceMaker_HasQuest(33807) or PeaceMaker_IsQuestCompleted(33807)) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33807) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SaveTheWolf2()

  local hotspot = {  
    [1] = { y=6295.139,x=5807.658,radius=100,z=83.98937 },
    [2] = { y=6346.213,x=5919.034,radius=100,z=53.92973 },
    [3] = { y=6223.872,x=5941.945,radius=100,z=49.16644 }
  } 

  local mob = { 74329, 74514 }
  local obj = { 74544, 74339 }

  if PeaceMaker_MapID() == 1116 then

    if PeaceMaker_HasQuest(33468) and not PeaceMaker_IsQuestCompleted(33468) then
      if not PeaceMaker_IsObjectiveCompleted(33468, 2) then
        PeaceMaker_KillAroundPos(5912.39, 6320.33, 52.87, 100, 74700, "Boss")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33468, 3) then
        PeaceMaker_KillAroundPos(5772.216, 6287.971, 93.66785, 100, 74708, "Boss")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33468, 4) then
        PeaceMaker_KillAroundPos(5933.32, 6130.18, 74.96, 100, 74702, "Boss")
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(33468, 5) then
        PeaceMaker_Kill(hotspot, mob, "Normal")
        return
      end
    end

    if PeaceMaker_HasQuest(33807) and not PeaceMaker_IsQuestCompleted(33807) then
      if not PeaceMaker_IsQuestComplete(33807) then
        PeaceMaker_Interact(hotspot, obj, "Unit", 3)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(33807) then
      PeaceMaker_CompleteQuest(5913.36, 6234.53, 51.38, 33807, 74651)
      return
    end

    if PeaceMaker_IsQuestComplete(33468) then
      PeaceMaker_CompleteQuest(5913.36, 6234.53, 51.38, 33468, 74651)
      return
    end
    
    if PeaceMaker_IsQuestCompleted(33807) and PeaceMaker_IsQuestCompleted(33468) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33807) and PeaceMaker_IsQuestCompleted(33468) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function TheFarseer()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33469) and not PeaceMaker_IsQuestCompleted(33469) then
      PeaceMaker_AcceptQuest(5913.36, 6234.53, 51.38, 33469, 74651)
    end
    if PeaceMaker_HasQuest(33469) and not PeaceMaker_IsQuestCompleted(33469) then
      if not PeaceMaker_IsObjectiveCompleted(33469, 1) then
        PeaceMaker_KillAroundPos(5926.022, 6477.342, 27.85993, 100, 74653, "Boss")
        return
      end
      if PeaceMaker_IsQuestComplete(33469) then
        PeaceMaker_CompleteQuest(5920.239, 6480.475, 29.47891, 33469, 74272)
      end
    end
    if PeaceMaker_IsQuestCompleted(33469) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33469) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function PoolVision()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33470) and not PeaceMaker_IsQuestCompleted(33470) then
      PeaceMaker_AcceptQuest(5920.239, 6480.475, 29.47891, 33470, 74272)
    end
    if PeaceMaker_HasQuest(33470) and not PeaceMaker_IsQuestCompleted(33470) then
      if not PeaceMaker_IsObjectiveCompleted(33470, 1) then
        PeaceMaker_MoveToNpcAndInteract(5920.239, 6480.475, 29.47891, 74272, 1)
        return
      end
      if PeaceMaker_IsQuestComplete(33470) then
        PeaceMaker_CompleteQuest(5920.239, 6480.475, 29.47891, 33469, 74272)
      end
    end
    if PeaceMaker_IsQuestCompleted(33470) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33470) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BladeSpireCitadel()
  if PeaceMaker_MapID() == 1116 then
    if not PeaceMaker_HasQuest(33473) and not PeaceMaker_IsQuestCompleted(33473) then
      PeaceMaker_AcceptQuest(5920.239, 6480.475, 29.47891, 33473, 74272)
    end
    if PeaceMaker_HasQuest(33473) and not PeaceMaker_IsQuestCompleted(33473) then
      if not PeaceMaker_IsObjectiveCompleted(33473, 1) then
        PeaceMaker_MoveToNpcAndInteract(5986.553, 6183.685, 70.07306, 74272, 2)
        return
      end
      if PeaceMaker_IsQuestComplete(33473) then
        PeaceMaker_CompleteQuest(6805.12, 5853.257, 259.4378, 33473, 74272)
      end
    end
    if PeaceMaker_IsQuestCompleted(33473) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(33473) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function GanarUntilWrath()

  local hotspot = {
    [1] = { y=4952.741,x=6972.005,radius=100,z=133.1182 },
    [2] = { y=4970.529,x=7085.94,radius=100,z=132.7614 },
    [3] = { y=5093.365,x=7083.013,radius=100,z=99.78802 },
    [4] = { y=5229.868,x=7107.353,radius=100,z=81.5927 }
  }

  local hotspot2 = {
    [1] = { y=4671.698,x=6934.877,radius=100,z=171.7792 },
    [2] = { y=4602.966,x=6842.216,radius=100,z=175.011 },
    [3] = { y=4495.661,x=6911.226,radius=100,z=176.5709 }
  }

  local mob = { 71647, 71784, 74205 }
  local mob2 = { 220621, 220622, 220623 }

  if not PeaceMaker_HasQuest(32783) and not PeaceMaker_IsQuestCompleted(32783) then
    PeaceMaker_AcceptQuest(6805.12, 5853.257, 259.4378, 32783, 70860)
    return
  end

  if not PeaceMaker_HasQuest(32989) and not PeaceMaker_IsQuestCompleted(32989) then
    PeaceMaker_AcceptQuest(6805.12, 5853.257, 259.4378, 32989, 70860)
    return
  end

  if PeaceMaker_IsQuestComplete(32783) then
    PeaceMaker_CompleteQuest(7219.51, 5620.848, 125.7956, 32783, 70909)
    return
  end

  if not PeaceMaker_HasQuest(32791) and not PeaceMaker_IsQuestCompleted(32791) then
    PeaceMaker_AcceptQuest(7219.51, 5620.848, 125.7956, 32791, 70909)
    return
  end

  if PeaceMaker_HasQuest(32791)`and not PeaceMaker_IsQuestCompleted(32791) then
    if not PeaceMaker_IsObjectiveCompleted(32791, 1) then
      PeaceMaker_MoveToNpcAndInteract(7219.51, 5620.848, 125.7956, 70878, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32791, 2) then
      PeaceMaker_KillAroundPos(7193.782, 5405.48, 66.2515, 100, {70900, 71716, 78645}, "Normal")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32791, 4) then
      PeaceMaker_KillAroundPos(7220.652, 5302.349, 62.38413, 100, {70900, 78644, 78645}, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(32791) then
    PeaceMaker_CompleteQuest(7221.124, 5300.958, 62.38804, 32791, 74000)
    return
  end

  if not PeaceMaker_HasQuest(32792) and not PeaceMaker_IsQuestCompleted(32792) then
    PeaceMaker_AcceptQuest(7221.124, 5300.958, 62.38804, 32792, 74000)
    return
  end

  if not PeaceMaker_HasQuest(32929) and not PeaceMaker_IsQuestCompleted(32929) then
    PeaceMaker_AcceptQuest(7225.797, 5305.864, 62.31234, 32929, 74222)
    return
  end

  if PeaceMaker_HasQuest(32792)`and not PeaceMaker_IsQuestCompleted(32792) then
    if not PeaceMaker_IsObjectiveCompleted(32792, 2) then
      PeaceMaker_KillAroundPos(7104.727, 5187.14, 81.8525, 100, 71669, "Normal")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32792, 1) then
      PeaceMaker_InteractAroundPos(7040.031, 5124.936, 89.71972, 100, 220568, "Object")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32792, 3) then
      PeaceMaker_InteractAroundPos(6886.912, 4933.849, 129.8292, 100, { 220578, 220579 }, "Object")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32792, 4) then
      PeaceMaker_Kill(hotspot, mob, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(32929) then
    PeaceMaker_CompleteQuest(6968.002, 4671.444, 186.8565, 32929, 74223)
    return
  end

  if not PeaceMaker_HasQuest(32804) and not PeaceMaker_IsQuestCompleted(32804) then
    PeaceMaker_AcceptQuest(6968.002, 4671.444, 186.8565, 32804, 74223)
    return
  end

  if PeaceMaker_IsQuestComplete(32792) then
    PeaceMaker_CompleteQuest(6968.002, 4671.444, 186.8565, 32792, 70910)
    return
  end

  if not PeaceMaker_HasQuest(32794) and not PeaceMaker_IsQuestCompleted(32794) then
    PeaceMaker_AcceptQuest(6968.002, 4671.444, 186.8565, 32794, 70910)
    return
  end

  if PeaceMaker_HasQuest(32804)`and not PeaceMaker_IsQuestCompleted(32804) then
    if not PeaceMaker_IsObjectiveCompleted(32804, 1) then
      PeaceMaker_Kill(hotspot2, mob2, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(32794)`and not PeaceMaker_IsQuestCompleted(32794) then
    -- if not PeaceMaker_IsObjectiveCompleted(32794, 1) then
    --   PeaceMaker_Kill(hotspot2, mob2, "Normal")
    --   return
    -- end
  end

  if PeaceMaker_IsQuestComplete(32804) then
    PeaceMaker_CompleteQuest(6969.972, 4667.882, 186.6414, 32804, 74223)
    return
  end

  if PeaceMaker_IsQuestComplete(32794) then
    PeaceMaker_CompleteQuest(6905.212, 4554.696, 68.04826, 32794, 70941)
    return
  end

  PeaceMaker_MoveToNextStep()

end

function EldestUntilBigger()

  if not PeaceMaker_HasQuest(32795) and not PeaceMaker_IsQuestCompleted(32795) then
    PeaceMaker_AcceptQuest(6905.212, 4554.696, 68.04826, 32795, 70941)
    return
  end

  if PeaceMaker_HasQuest(32795)`and not PeaceMaker_IsQuestCompleted(32795) then
    if not PeaceMaker_IsObjectiveCompleted(32795, 1) then
      PeaceMaker_MoveToNpcAndInteract(6903.576, 4555.241, 68.05191, 70941, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(32795, 2) then
      PeaceMaker_KillAroundPos(6863.835, 4546.19, 68.06511, 100, {70863, 70941, 74006}, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(32795) then
    PeaceMaker_CompleteQuest(6918.649, 4561.068, 68.06332, 32795, 70941)
    return
  end

  if not PeaceMaker_HasQuest(32796) and not PeaceMaker_IsQuestCompleted(32796) then
    PeaceMaker_AcceptQuest(6918.649, 4561.068, 68.06332, 32796, 70941)
    return
  end

  if PeaceMaker_IsQuestComplete(32989) then
    PeaceMaker_CompleteQuest(6140.984, 5149.423, 131.5139, 32989, 72274)
    return
  end

  if not PeaceMaker_HasQuest(32990) and not PeaceMaker_IsQuestCompleted(32990) then
    PeaceMaker_AcceptQuest(6140.984, 5149.423, 131.5139, 32990, 72274)
    return
  end
  
  if PeaceMaker_HasQuest(32990)`and not PeaceMaker_IsQuestCompleted(32990) then
    if not PeaceMaker_IsObjectiveCompleted(32990, 1) then
      PeaceMaker_MoveToObjectAndInteract(6123.32, 4978.218, 136.096, 72449, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(32990, 2) then
      PeaceMaker_MoveToObjectAndInteract(6116.865, 4964.471, 137.2572, 72383, 3)
      return
    end
  end

  if not PeaceMaker_HasQuest(33013) and not PeaceMaker_IsQuestCompleted(33013) then
    PeaceMaker_AcceptQuest(6116.865, 4964.471, 137.2572, 33013, 74358)
    return
  end

  if PeaceMaker_HasQuest(32990)`and not PeaceMaker_IsQuestCompleted(32990) then
    if not PeaceMaker_IsObjectiveCompleted(32990, 3) then
      PeaceMaker_MoveToObjectAndInteract(6125.41, 5059.927, 134.0654, 72381, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(32990, 4) then
      PeaceMaker_MoveToObjectAndInteract(6138.918, 5105.398, 131.6728, 72380, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(32990) then
    PeaceMaker_CompleteQuest(6137.964, 5145.937, 131.5974, 32990, 72274)
    return
  end

  if not PeaceMaker_HasQuest(32991) and not PeaceMaker_IsQuestCompleted(32991) then
    PeaceMaker_AcceptQuest(6137.964, 5145.937, 131.5974, 32991 , 72274)
    return
  end

  if PeaceMaker_HasQuest(32991)`and not PeaceMaker_IsQuestCompleted(32991) then
    if not PeaceMaker_IsObjectiveCompleted(32991, 1) then
      PeaceMaker_MoveToObjectAndInteract(6275.804, 5037.123, 48.83661, 72400, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(32991, 2) then
      PeaceMaker_MoveToObjectAndInteract(6453.149, 4995.143, 59.12407, 72399, 3)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(32991, 3) then
      PeaceMaker_MoveToNpcAndInteract(6516.35, 4797.256, 67.18911, 72494, 1)
      return
    end
  end

  if PeaceMaker_HasQuest(33013)`and not PeaceMaker_IsQuestCompleted(33013) then
    if not PeaceMaker_IsObjectiveCompleted(33013, 1) then
      PeaceMaker_MoveToObjectAndInteract(6469.604, 4867.203, 48.96756, 221379, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(33013, 2) then
      PeaceMaker_MoveToObjectAndInteract(6502.44, 4774.682, 67.34713, 221378, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(33013) then
    PeaceMaker_CompleteQuestLog(33013)
    return
  end

  if PeaceMaker_IsQuestComplete(32991) then
    PeaceMaker_CompleteQuest(6420.9, 4595.448, 85.31989, 32991, 72274)
    return
  end

  if not PeaceMaker_HasQuest(32992) and not PeaceMaker_IsQuestCompleted(32992) then
    PeaceMaker_AcceptQuest(6420.9, 4595.448, 85.31989, 32992, 72274)
    return
  end

  if PeaceMaker_IsQuestComplete(32992) then
    PeaceMaker_CompleteQuest(5966.316, 4118.405, 119.579, 32992, 72274)
    return
  end

  if not PeaceMaker_HasQuest(32993) and not PeaceMaker_IsQuestCompleted(32993) then
    PeaceMaker_AcceptQuest(5966.316, 4118.405, 119.579, 32993, 72274)
    return
  end

  if PeaceMaker_IsQuestComplete(32993) then
    PeaceMaker_CompleteQuest(5829.763, 3639.596, 120.8975, 32993, 72373)
    return
  end

  if not PeaceMaker_HasQuest(32992) and not PeaceMaker_IsQuestCompleted(32992) then
    PeaceMaker_AcceptQuest(6420.9, 4595.448, 85.31989, 32992, 72274)
    return
  end

  if not PeaceMaker_HasQuest(32992) and not PeaceMaker_IsQuestCompleted(32992) then
    PeaceMaker_AcceptQuest(6420.9, 4595.448, 85.31989, 32992, 72274)
    return
  end
  
end
