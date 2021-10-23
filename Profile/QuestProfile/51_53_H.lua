QuestOrder = {
  [1] = { Quest_Name = "EternityUntilWalk", Quest_Settings = 2 },
  [2] = { Quest_Name = "WalkUntilLight", Quest_Settings = 1 },
  [3] = { Quest_Name = "LightForge", Quest_Settings = 2 },
  [4] = { Quest_Name = "WorkUntilTemple", Quest_Settings = 2 },
  [5] = { Quest_Name = "TempleUntilWayward", Quest_Settings = 2 },
  [6] = { Quest_Name = "WaywardUntilEnemy", Quest_Settings = 1 },
  [7] = { Quest_Name = "EnemyUntilChasing", Quest_Settings = 3 },
  [8] = { Quest_Name = "ChasingUntilService", Quest_Settings = 1 },
  [9] = { Quest_Name = "ServiceUntilCourage", Quest_Settings = 3 },
  [10] = { Quest_Name = "CourageUntilFollow", Quest_Settings = 2 },
  [11] = { Quest_Name = "FollowUntilMal", Quest_Settings = 1 },
  [12] = { Quest_Name = "LoadMalProfile", Quest_Settings = 1 }
}

function EternityUntilWalk()

  if not PeaceMaker_HasQuest(59774) and not PeaceMaker_IsQuestCompleted(59774) then
    PeaceMaker_AcceptQuest(-4261.67, -3922.91, 6561.32, 59774, 166227)
    return
  end

  if PeaceMaker_HasQuest(59774) and not PeaceMaker_IsQuestCompleted(59774) then
    if not PeaceMaker_IsObjectiveCompleted(59774, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4261.234, -3922.979, 6561.321, 166227, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(59774, 2) then
      PeaceMaker_MoveToAndWait(-4340.5, -4228.85, 6555.8, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(59774) then
    PeaceMaker_CompleteQuest(-4343.63, -4228.15, 6555.8, 59774, 165107)
    return
  end

  if not PeaceMaker_HasQuest(57102) and not PeaceMaker_IsQuestCompleted(57102) then
    PeaceMaker_AcceptQuest(-4343.79, -4227.68, 6555.8, 57102, 165107)
    return
  end

  if PeaceMaker_HasQuest(57102) and not PeaceMaker_IsQuestCompleted(57102) then
    if not PeaceMaker_IsObjectiveCompleted(57102, 1) then
      PeaceMaker_MoveToObjectAndInteract(-4349.223, -4256.7, 6555.756, 349508, 3)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57102, 2) then
      if PeaceMaker_CheckObjectExists(349508) then
        PeaceMaker_MoveToObjectAndInteract(-4349.223, -4256.7, 6555.756, 349508, 3)
      else
        PeaceMaker_InteractAroundPos(-4343.49, -4258.59, 6555.76, 150, { 166164, 156398, 166163 }, "ObjectUnit", 3)
      end
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57102) then
    PeaceMaker_CompleteQuest(-4341.44, -4230.28, 6555.8, 57102, 158281)
    return
  end

  if not PeaceMaker_HasQuest(57584) and not PeaceMaker_IsQuestCompleted(57584) then
    PeaceMaker_AcceptQuest(-4341.44, -4230.28, 6555.8, 57584, 158281)
    return
  end

  if PeaceMaker_HasQuest(57584) and not PeaceMaker_IsQuestCompleted(57584) then
    if not PeaceMaker_IsObjectiveCompleted(57584, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4341.44, -4230.28, 6555.8, 158281, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57584, 2) then
      PeaceMaker_MoveToObjectAndInteract(-4263.23, -4212.73, 6550.9, 349887, 2)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57584, 3) then
      if PeaceMaker_GetDistance3D(-4271.45, -4318.74, 6553.15) > 3 then
        PeaceMaker_MoveToAndWait(-4271.45, -4318.74, 6553.15, 1)
      else
        if ExtraActionButton1:IsVisible() then
          PeaceMaker_MacroText("/click ExtraActionButton1")
        end
      end
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57584, 4) then
      PeaceMaker_MoveToObjectAndInteract(-4430.58, -4257.24, 6556.16, 335697, 2)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57584, 5) then
      PeaceMaker_MoveToObjectAndInteract(-4406.65, -4170.62, 6552.82, 335698, 2)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57584) then
    PeaceMaker_CompleteQuest(-4343.92, -4228.05, 6555.8, 57584, 165107)
    return
  end

  if not PeaceMaker_HasQuest(60735) and not PeaceMaker_IsQuestCompleted(60735) then
    PeaceMaker_AcceptQuest(-4343.88, -4227.78, 6555.8, 60735, 165107)
    return
  end

  if PeaceMaker_HasQuest(60735) and not PeaceMaker_IsQuestCompleted(60735) then
    if not PeaceMaker_IsObjectiveCompleted(60735, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4343.88, -4227.78, 6555.8, 165107, 1)
      return
    end
    
    if not PeaceMaker_IsObjectiveCompleted(60735, 2) then
      return
    end
  end
  
  if PeaceMaker_IsQuestComplete(60735) then
    PeaceMaker_CompleteQuest(-4345.94, -4243.64, 6555.81, 60735, 166306)
    return
  end

  PeaceMaker_MoveToNextStep()

end

function WalkUntilLight()

  local hotspot = {
    [1] = { x = -4482.52, y = -4911.59, z = 6540.9, radius = 100 }
  }

  local hotspot2 = { 
    [1] = { x = -4334.49, y = -5093.52, z = 6558.33, radius = 150 },
    [2] = { x = -4241.12, y = -5093.98, z = 6580.52, radius = 150 }
  }

  local mob = { 157277, 157274 }
  local obj = { 336680 }

  if not PeaceMaker_HasQuest(57261) and not PeaceMaker_IsQuestCompleted(57261) then
    PeaceMaker_AcceptQuest(-4345.94, -4243.64, 6555.81, 57261, 166306)
    return
  end

  if PeaceMaker_HasQuest(57261) and not PeaceMaker_IsQuestCompleted(57261) then
    if not PeaceMaker_IsObjectiveCompleted(57261, 1) then
      PeaceMaker_MoveToAndWait(-4374.36, -4509.37, 6564.3, 2)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57261, 2) then
      if PeaceMaker_GetDistance3D(-4374.17, -4509.77, 6564.23) > 3 then
        PeaceMaker_MoveToAndWait(-4374.17, -4509.77, 6564.23, 2)
      else
        if ExtraActionButton1:IsVisible() then
          lb.Unlock(RunMacroText, "/click ExtraActionButton1")
        end
      end
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57261, 3) then
      PeaceMaker_MoveToAndWait(-4101.62, -4643.31, 6536, 2)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57261) then
    PeaceMaker_CompleteQuest(-4089.97, -4635.27, 6536, 57261, 165107)
    return
  end

  if not PeaceMaker_HasQuest(57677) and not PeaceMaker_IsQuestCompleted(57677) then
    PeaceMaker_AcceptQuestGossip(-4089.97, -4635.27, 6536, 57677, 165107)
    return
  end  

  if not PeaceMaker_HasQuest(57676) and not PeaceMaker_IsQuestCompleted(57676) then
    PeaceMaker_AcceptQuestGossip(-4089.97, -4635.27, 6536, 57676, 165107)
    return
  end  

  if PeaceMaker_HasQuest(57676) and not PeaceMaker_IsQuestCompleted(57676) then
    if not PeaceMaker_IsObjectiveCompleted(57676, 1) then
      PeaceMaker_KillAroundPos(-4022.29, -4514.51, 6525.75, 100, {158628, 158629}, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(57677) and not PeaceMaker_IsQuestCompleted(57677) then
    if not PeaceMaker_IsObjectiveCompleted(57677, 1) then
      PeaceMaker_MoveToAndWait(-4055.04, -4331.05, 6506.36, 2)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57677, 2) then
      PeaceMaker_KillAroundPos(-4055.04, -4331.05, 6506.36, 100, 158630, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57677) then
    PeaceMaker_CompleteQuest(-4086.74, -4632.66, 6536, 57677, 165112)
    return
  end

  if PeaceMaker_IsQuestComplete(57676) then
    PeaceMaker_CompleteQuest(-4090.56, -4635.29, 6536, 57676, 165107)
    return
  end

  if not PeaceMaker_HasQuest(57709) and not PeaceMaker_IsQuestCompleted(57709) then
    PeaceMaker_AcceptQuest(-4090.56, -4635.29, 6536, 57709, 165107)
    return
  end 

  if not PeaceMaker_HasQuest(60466) and not PeaceMaker_IsQuestCompleted(60466) then
    PeaceMaker_AcceptQuest(-4130.13, -4613.95, 6534.16, 60466, 160598)
    return
  end 

  if PeaceMaker_HasQuest(60466) and not PeaceMaker_IsQuestCompleted(60466) then
    if not PeaceMaker_IsObjectiveCompleted(60466, 1) then
      PeaceMaker_MoveToMerchantAndBuyItem(-4106.51, -4628.38, 6536, 160601, 178891, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(60466, 2) then
      PeaceMaker_KillAroundPos(-3987.98, -4791.55, 6590.73, 100, {168442, 157761}, "Normal")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(60466, 3) then
      PeaceMaker_KillAroundPos(-3987.98, -4791.55, 6590.73, 100, {168442, 157761}, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60466) then
    PeaceMaker_CompleteQuest(-4130.34, -4614.18, 6534.16, 60466, 160598)
    return
  end

  if not PeaceMaker_HasQuest(62714) and not PeaceMaker_IsQuestCompleted(62714) then
    PeaceMaker_AcceptQuest(-4130.34, -4614.18, 6534.16, 62714, 160598)
    return
  end

  if PeaceMaker_HasQuest(57709) and not PeaceMaker_IsQuestCompleted(57709) then
    if not PeaceMaker_IsObjectiveCompleted(57709, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4156.22, -4619.49, 6534.16, 158686, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57709) then
    PeaceMaker_CompleteQuest(-4496.21, -5164.25, 6548.37, 57709, 158807)
    return
  end

  if not PeaceMaker_HasQuest(57710) and not PeaceMaker_IsQuestCompleted(57710) then
    PeaceMaker_AcceptQuest(-4496.21, -5164.25, 6548.37, 57710, 158807)
    return
  end

  if PeaceMaker_HasQuest(57710) and not PeaceMaker_IsQuestCompleted(57710) then
    if not PeaceMaker_IsObjectiveCompleted(57710, 1) then
      PeaceMaker_MoveToObjectAndInteract(-4475.077, -5225.866, 6551.691, 339231, 3)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57710, 2) then
      PeaceMaker_KillAroundPosAndInteract(-4484.61, -5198.89, 6551.28, 100, { 158999 , 161308, 159023, 158991 } , 337094, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57710) then
    PeaceMaker_CompleteQuest(-4490.15, -5182.41, 6547.98, 57710, 158807)
    return
  end

  if not PeaceMaker_HasQuest(57711) and not PeaceMaker_IsQuestCompleted(57711) then
    PeaceMaker_AcceptQuest(-4490.14, -5182.61, 6547.98, 57711, 158807)
    return
  end

  if PeaceMaker_IsQuestComplete(57711) then
    PeaceMaker_CompleteQuest(-4534.38, -4932.7, 6527.54, 57711, 166577)
    return
  end

  if not PeaceMaker_HasQuest(57267) and not PeaceMaker_IsQuestCompleted(57267) then
    PeaceMaker_AcceptQuestGossip(-4534.38, -4932.7, 6527.54, 57267, 166577)
    return
  end

  if not PeaceMaker_HasQuest(57263) and not PeaceMaker_IsQuestCompleted(57263) then
    PeaceMaker_AcceptQuestGossip(-4534.38, -4932.7, 6527.54, 57263, 166577)
    return
  end

  if not PeaceMaker_HasQuest(57265) and not PeaceMaker_IsQuestCompleted(57265) then
    PeaceMaker_AcceptQuest(-4542.22, -4933.33, 6527.54, 57265, 158807)
    return
  end

  if not PeaceMaker_HasQuest(57712) and not PeaceMaker_IsQuestCompleted(57712) then
    PeaceMaker_AcceptQuest(-4571.7, -5114.42, 6535.92, 57712, 157138)
    return
  end

  if PeaceMaker_HasQuest(57265) and not PeaceMaker_IsQuestCompleted(57265) then
    if not PeaceMaker_IsObjectiveCompleted(57265, 1) then
      PeaceMaker_MoveToObjectAndInteract(-4393.12, -5086.08, 6545.22, 349702, 5)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57265, 2) then
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57265, 3) then
      PeaceMaker_MoveToObjectAndInteract(-4389.71, -5086.81, 6545.22, 349706, 3)
      return
    end
  end

  if PeaceMaker_HasQuest(57712) and not PeaceMaker_IsQuestCompleted(57712) then
    if not PeaceMaker_IsObjectiveCompleted(57712, 2) then
      PeaceMaker_MoveToNpcAndInteract(-4543.3, -5161.54, 6542.55, 159277, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57712, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4524.92, -4951.5, 6527.26, 159278, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57712, 3) then
      PeaceMaker_Kill(hotspot, mob, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(57263) and not PeaceMaker_IsQuestCompleted(57263) then
    if not PeaceMaker_IsObjectiveCompleted(57263, 1) then
      PeaceMaker_Kill(hotspot, mob, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(57267) and not PeaceMaker_IsQuestCompleted(57267) then
    if not PeaceMaker_IsObjectiveCompleted(57267, 1) then
      PeaceMaker_Gather(hotspot2, obj)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(62714) then
    PeaceMaker_CompleteQuest(-4150.05, -5013.01, 6542.67, 62714, 174900)
    return
  end

  if not PeaceMaker_HasQuest(62715) and not PeaceMaker_IsQuestCompleted(62715) then
    PeaceMaker_AcceptQuest(-4150.05, -5013.01, 6542.67, 62715, 174900)
    return
  end

  if PeaceMaker_IsQuestComplete(57267) then
    PeaceMaker_CompleteActiveQuest(-4534.38, -4932.7, 6527.54, 57267, 166577)
    return
  end

  if PeaceMaker_IsQuestComplete(57263) then
    PeaceMaker_CompleteActiveQuest(-4534.38, -4932.7, 6527.54, 57263, 166577)
    return
  end

  if PeaceMaker_IsQuestComplete(57265) then
    PeaceMaker_CompleteQuest(-4542.22, -4933.33, 6527.54, 57265, 158807)
    return
  end

  if PeaceMaker_IsQuestComplete(57712) then
    PeaceMaker_CompleteQuest(-4571.7, -5114.42, 6535.92, 57712, 157138)
    return
  end

  PeaceMaker_MoveToNextStep()

end

function LightForge()
  
  if not PeaceMaker_HasQuest(59920) and not PeaceMaker_IsQuestCompleted(59920) then
    PeaceMaker_AcceptQuest(-4542.5, -4933.94, 6527.54, 59920, 158807)
    return
  end

  if PeaceMaker_HasQuest(59920) and not PeaceMaker_IsQuestCompleted(59920) then
    if not PeaceMaker_IsObjectiveCompleted(59920, 1) then
      if not PeaceMaker_CheckBuff("Carry Raw Materials", 'player') then
        PeaceMaker_MoveToObjectAndInteract(-4538.82, -4931.65, 6527.54, 349869, 3)
      else
        PeaceMaker_MoveToObjectAndInteract(-4573.87, -4942.55, 6529.81, 338216, 3)
      end
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(59920, 2) then
      PeaceMaker_InteractAroundPos(-4571, -4939.49, 6530.12, 100, 166744, "ObjectUnit")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(59920, 3) then
      PeaceMaker_InteractAroundPos(-4571, -4939.49, 6530.12, 100, {349875, 349872, 349873, 349874}, "Object", 5)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(59920) then
    PeaceMaker_Wait(10)
    PeaceMaker_CompleteQuest(-4574.22, -4951.52, 6529.5, 59920, 158807)
    return
  end

  PeaceMaker_MoveToNextStep()
  
end

function WorkUntilTemple()

  local hotspot1 = { 
    [1] = { x = -4791.26, y = -5376.61, z = 6505.64, radius = 20}
  }

  local hotspot2 = {
    [1] = { x = -4753.11, y = -5365.23, z = 6505.63, radius = 20}
  }

  local hotspot3 = {
    [1] = { x = -4813.38, y = -5331.07, z = 6505.52, radius = 20}
  }

  local obj = { 338504 }

  if not PeaceMaker_HasQuest(57713) and not PeaceMaker_IsQuestCompleted(57713) then
    PeaceMaker_AcceptQuest(-4574.22, -4951.52, 6529.5, 57713, 158807)
    return
  end

  if PeaceMaker_HasQuest(57713) and not PeaceMaker_IsQuestCompleted(57713) then
    if not PeaceMaker_IsObjectiveCompleted(57713, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4568.71, -4936.81, 6530.12, 166742, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57713, 2) then
      PeaceMaker_MoveToNpcAndInteract(-4573.6, -4942.42, 6529.81, 159396, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57713, 3) then
      PeaceMaker_MoveToNpcAndInteract(-4577.09, -4938.68, 6530.12, 159391, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57713, 4) then
      if not CountInteract then CountInteract = 0 end
      if CountInteract < 5 then
        PeaceMaker_MoveToNpcAndInteract(-4573.6, -4942.42, 6529.81, 159396, 1)
        CountInteract = CountInteract + 1
      else
        PeaceMaker_MoveToNpcAndInteract(-4577.09, -4938.68, 6530.12, 159391, 1)
        C_Timer.After(1, function() if CountInteract >= 5 then CountInteract = 0 end end)
      end
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57713, 5) then
      PeaceMaker_MoveToNpcAndInteract(-4566.88, -4943.36, 6529.5, 159444, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57713) then
    PeaceMaker_Wait(10)
    PeaceMaker_CompleteQuest(-4574.22, -4951.52, 6529.5, 57713, 158807)
    return
  end

  if not PeaceMaker_HasQuest(57908) and not PeaceMaker_IsQuestCompleted(57908) then
    PeaceMaker_AcceptQuest(-4574.22, -4951.52, 6529.5, 57908, 158807)
    return
  end

  if PeaceMaker_IsQuestComplete(57908) then
    PeaceMaker_CompleteQuest(-4464.83, -4870.22, 6544.67, 57908, 158862)
    return
  end

  if not PeaceMaker_HasQuest(57288) and not PeaceMaker_IsQuestCompleted(57288) then
    PeaceMaker_AcceptQuest(-4464.83, -4870.22, 6544.67, 57288, 158862)
    return
  end

  if not PeaceMaker_HasQuest(57909) and not PeaceMaker_IsQuestCompleted(57909) then
    PeaceMaker_AcceptQuest(-4463.15, -4871.35, 6544.67, 57909, 158861)
    return
  end

  if PeaceMaker_HasQuest(57909) and not PeaceMaker_IsQuestCompleted(57909) then
    if not PeaceMaker_IsObjectiveCompleted(57909, 1) then
      PeaceMaker_InteractNpcAndKill(-4496.33, -4793.77, 6543.53, 100, {159505, 159504})
      return
    end
  end

  if PeaceMaker_HasQuest(57288) and not PeaceMaker_IsQuestCompleted(57288) then
    if not PeaceMaker_IsObjectiveCompleted(57288, 1) then
      PeaceMaker_KillAroundPos(-4512.37, -4792.6, 6543.7, 100, 158867, "Boss")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57288, 3) then
      PeaceMaker_KillAroundPos(-4442.02, -4761.21, 6543.53, 100, 158870, "Boss")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57288, 2) then
      PeaceMaker_KillAroundPos(-4367.21, -4790.05, 6543.56, 100, 158869, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57909) then
    PeaceMaker_CompleteQuest(-4457.66, -4866.57, 6544.67, 57909, 158861)
    return
  end

  if PeaceMaker_IsQuestComplete(57288) then
    PeaceMaker_CompleteQuest(-4461.4, -4863.46, 6544.67, 57288, 158862)
    return
  end

  if not PeaceMaker_HasQuest(57714) and not PeaceMaker_IsQuestCompleted(57714) then
    PeaceMaker_AcceptQuest(-4461.19, -4863.76, 6544.67, 57714, 158862)
    return
  end

  if PeaceMaker_HasQuest(57714) and not PeaceMaker_IsQuestCompleted(57714) then
    if not PeaceMaker_IsObjectiveCompleted(57714, 1) then
      PeaceMaker_KillAroundPos(-4444.58, -4842.53, 6541.89, 100, 158891, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57714) then
    PeaceMaker_CompleteQuest(-4461.14, -4863.82, 6544.67, 57714, 158862)
    return
  end

  if not PeaceMaker_HasQuest(57291) and not PeaceMaker_IsQuestCompleted(57291) then
    PeaceMaker_AcceptQuest(-4459.11, -4865.01, 6544.67, 57291, 158807)
    return
  end

  if PeaceMaker_HasQuest(57291) and not PeaceMaker_IsQuestCompleted(57291) then
    if not PeaceMaker_IsObjectiveCompleted(57291, 1) then
      PeaceMaker_MoveToAndWait(-4707.11, -5162.42, 6529.18, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57291) then
    PeaceMaker_CompleteQuest(-4712.04, -5236.74, 6518.72, 57291, 159583)
    return
  end

  if not PeaceMaker_HasQuest(57266) and not PeaceMaker_IsQuestCompleted(57266) then
    PeaceMaker_AcceptQuest(-4711.87, -5236.55, 6518.72, 57266, 159583)
    return
  end

  if PeaceMaker_HasQuest(57266) and not PeaceMaker_IsQuestCompleted(57266) then
    if not PeaceMaker_IsObjectiveCompleted(57266, 1) then
      PeaceMaker_MoveToObjectAndInteract(-4674.094, -5296.226, 6518.706, 338487, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57266, 3) then
      PeaceMaker_MoveToObjectAndInteract(-4655.747, -5292.5, 6520.265, 338502, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57266, 2) then
      if PeaceMaker_GetDistance3D(-4661.68, -5269.56, 6518.51) > 3 then
        PeaceMaker_MoveToAndWait(-4661.68, -5269.56, 6518.51, 3)
      else
        if ExtraActionButton1:IsVisible() then
          lb.Unlock(RunMacroText, "/click ExtraActionButton1")
        end
      end
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57266, 4) then
      PeaceMaker_MoveToNpcAndInteract(-4712.32, -5236.75, 6518.72, 159583, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57266, 5) then
      if PeaceMaker_IsObjectivePartFulfilled(57266, 5) == 0 then 
        PeaceMaker_InteractAndDelay(hotspot1, obj, "Object", 10, 4)
        return
      end
      if PeaceMaker_IsObjectivePartFulfilled(57266, 5) == 1 then 
        PeaceMaker_InteractAndDelay(hotspot2, obj, "Object", 10, 4)
        return
      end
      if PeaceMaker_IsObjectivePartFulfilled(57266, 5) == 2 then 
        PeaceMaker_InteractAndDelay(hotspot3, obj, "Object", 10, 4)
        return
      end
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57266, 6) then
      PeaceMaker_KillAroundPos(-4804.1, -5335.92, 6504.97, 100, 159665, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57266) then
    PeaceMaker_CompleteQuest(-4705.21, -5131.6, 6527.19, 57266, 158862)
    return
  end

  if not PeaceMaker_HasQuest(60222) and not PeaceMaker_IsQuestCompleted(60222) then
    PeaceMaker_AcceptQuest(-4705.21, -5131.6, 6527.19, 57266, 158862)
    return
  end

  if PeaceMaker_HasQuest(60222) and not PeaceMaker_IsQuestCompleted(60222) then
    if not PeaceMaker_IsObjectiveCompleted(60222, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4730.18, -4989.98, 6532.72, 156217, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(60222, 2) then
      if PeaceMaker_GetDistance3D(-4735.78, -4989.12, 6533.9) > 3 then
        PeaceMaker_MoveToAndWait(-4735.78, -4989.12, 6533.9, 3)
      else
        if ExtraActionButton1:IsVisible() then
          lb.Unlock(RunMacroText, "/click ExtraActionButton1")
        end
      end
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60222) then
    PeaceMaker_CompleteQuest(-4730.67, -4988.53, 6532.51, 60222, 156217)
    return
  end

  if not PeaceMaker_HasQuest(58174) and not PeaceMaker_IsQuestCompleted(58174) then
    PeaceMaker_AcceptQuest(-4742.77, -4988.73, 6532.74, 58174, 158862)
    return
  end

  if PeaceMaker_IsQuestComplete(58174) then
    PeaceMaker_CompleteQuest(-4101.46, -4640.22, 6536, 58174, 158471)
    return
  end

  if not PeaceMaker_HasQuest(57270) and not PeaceMaker_IsQuestCompleted(57270) then
    PeaceMaker_AcceptQuest(-4098.79, -4645.87, 6536, 57270, 157673)
    return
  end

  if not PeaceMaker_HasQuest(62718) and not PeaceMaker_IsQuestCompleted(62718) then
    PeaceMaker_AcceptQuest(-4117.97, -4671.96, 6533.14, 62718, 362489, "Object")
    return
  end

  PeaceMaker_MoveToNextStep()

end

function TempleUntilWayward()

  local hotspot = { 
    [1] = { x = -4007.09, y = -5250.73, z = 6531.74, radius = 100},
    [2] = { x = -4095.32, y = -5318.63, z = 6516.42, radius = 100},
    [3] = { x = -4115.35, y = -5423.58, z = 6500.64, radius = 100}
  }

  local npc = { 157242, 168853 }

  if PeaceMaker_IsQuestComplete(57270) then
    PeaceMaker_CompleteQuest(-4135.09, -5028.78, 6542.7, 57270, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57977) and not PeaceMaker_IsQuestCompleted(57977) then
    PeaceMaker_AcceptQuest(-4135.09, -5028.78, 6542.7, 57977, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57264) and not PeaceMaker_IsQuestCompleted(57264) then
    PeaceMaker_AcceptQuest(-4172.76, -5203.05, 6535.51, 57264, 157673)
    return
  end

  if PeaceMaker_HasQuest(57977) and not PeaceMaker_IsQuestCompleted(57977) then
    if IsMounted() then Dismount() end
    if not PeaceMaker_IsObjectiveCompleted(57977, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4039.2, -5246.27, 6532.16, 159840, 1)
      return
    end
  end

  if PeaceMaker_HasQuest(57264) and not PeaceMaker_IsQuestCompleted(57264) then
    if not PeaceMaker_IsObjectiveCompleted(57264, 1) then
      PeaceMaker_Interact(hotspot, npc, "ObjectUnit")
      return
    end
  end

  if PeaceMaker_HasQuest(57977) and not PeaceMaker_IsQuestCompleted(57977) then
    if not PeaceMaker_IsObjectiveCompleted(57977, 2) then
      if not InteractAngel then
        if PeaceMaker_GetDistance3D(-4235.61, -5285.47, 6514.97) > 3 then
          PeaceMaker_MoveToAndWait(-4235.61, -5285.47, 6514.97)
        else
          PeaceMaker_InteractNpcNearbyAndGossipAndChangeState(160636, 1, "InteractAngel")
        end
      else
        PeaceMaker_InteractAroundPos(-4229.02, -5292.94, 6514.97, 100, {160698, 160694, 160695, 160696}, "ManualOMUnit")
      end
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57977, 3) then
      PeaceMaker_MoveToNpcAndInteract(-4137.45, -5422.42, 6500.64, 159841, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57264) then
    PeaceMaker_CompleteActiveQuest(-4330.39, -5382.34, 6514.78, 57264, 159762)
    return
  end

  if PeaceMaker_IsQuestComplete(57977) then
    PeaceMaker_CompleteActiveQuest(-4330.39, -5382.34, 6514.78, 57977, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57716) and not PeaceMaker_IsQuestCompleted(57716) then
    PeaceMaker_AcceptQuest(-4330.39, -5382.34, 6514.78, 57716, 159762)
    return
  end

  if PeaceMaker_HasQuest(57716) and not PeaceMaker_IsQuestCompleted(57716) then
    if not PeaceMaker_IsObjectiveCompleted(57716, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3934.77, -5418.77, 6540.44, 159896, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57716, 2) then
      PeaceMaker_Escourt(159897, 10)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57716) then
    PeaceMaker_CompleteActiveQuest(-4330.39, -5382.34, 6514.78, 57716, 159762)
    return
  end

  PeaceMaker_MoveToNextStep()

end

function WaywardUntilEnemy()

  if not PeaceMaker_HasQuest(57717) and not PeaceMaker_IsQuestCompleted(57717) then
    PeaceMaker_AcceptQuest(-4330.39, -5382.34, 6514.78, 57717, 159762)
    return
  end

  if PeaceMaker_HasQuest(57717) and not PeaceMaker_IsQuestCompleted(57717) then
    if not PeaceMaker_IsObjectiveCompleted(57717, 1) then
      DisableMountQuest = true
      if not PeaceMaker.Player.Combat then 
        PeaceMaker_MoveToNpcAndInteract(-4333.12, -5433.69, 6511.26, 159906, 1)
      end
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57717, 2) then
      PeaceMaker_MoveToNpcAndInteract(-4324.26, -5422.97, 6511.11, 159900, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57717, 3) then
      PeaceMaker_MoveToNpcAndInteract(-4333.12, -5433.69, 6511.26, 159906, 1)
      return
    end
  end

  
  if PeaceMaker_IsQuestComplete(57717) or PeaceMaker_IsQuestCompleted(57717) then
    if DisableMountQuest then DisableMountQuest = false end
  end

  if PeaceMaker_IsQuestComplete(57717) then
    PeaceMaker_CompleteQuest(-4288.43, -5376.25, 6514.8, 57717, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57717) and not PeaceMaker_IsQuestCompleted(57717) then
    PeaceMaker_AcceptQuestGossip(-4288.43, -5376.25, 6514.8, 57717, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57037) and not PeaceMaker_IsQuestCompleted(57037) then
    PeaceMaker_AcceptQuestGossip(-4288.43, -5376.25, 6514.8, 57037, 159762)
    return
  end

  if not PeaceMaker_HasQuest(59147) and not PeaceMaker_IsQuestCompleted(59147) then
    PeaceMaker_AcceptQuestGossip(-4288.43, -5376.25, 6514.8, 59147, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57444) and not PeaceMaker_IsQuestCompleted(57444) then
    PeaceMaker_AcceptQuest(-4236.31, -5286.02, 6514.97, 57444, 160647)
    return
  end

  local hotspot = { 
    [1] = { x = -4248.97, y = -5335.08, z = 6512.82, radius = 100},
    [2] = { x = -4103.07, y = -5311.92, z = 6516.42, radius = 100}
  }

  local hotspot2 = { 
    [1] = { x = -4174.96, y = -5259.25, z = 6512.89, radius = 100}, 
    [2] = { x = -4024.16, y = -5245.03, z = 6530.88, radius = 100},
    [3] = { x = -4224.2, y = -5454.96, z = 6500.64, radius = 100 } 
  }

  local hotspot3 = { 
    [1] = { x = -4129.19, y = -5438.57, z = 6500.51, radius = 150 },
    [2] = { x = -4229.6, y = -5460.31, z = 6500.5, radius = 150 }
  }

  local mob = { 157599, 157560, 157557 }
  local obj = { 343603 }

  if PeaceMaker_HasQuest(57444) and not PeaceMaker_IsQuestCompleted(57444) then
    if not PeaceMaker_IsObjectiveCompleted(57444, 1) then
      PeaceMaker_UseItemAction(hotspot2, { 157660 } , "/click ExtraActionButton1", 30, "Introspection")
      return
    end
  end

  if PeaceMaker_HasQuest(59147) and not PeaceMaker_IsQuestCompleted(59147) then
    if not PeaceMaker_IsObjectiveCompleted(59147, 1) then
      PeaceMaker_Kill(hotspot, mob, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(57037) and not PeaceMaker_IsQuestCompleted(57037) then
    if not PeaceMaker_IsObjectiveCompleted(57037, 1) then
      PeaceMaker_MoveToObjectAndInteract(-4023.3, -5245.95, 6530.88, 334847, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57037, 2) then
      PeaceMaker_MoveToObjectAndInteract(-4128.76, -5438.7, 6499.6, 334849, 3)
      return
    end
  end

  if not PeaceMaker_HasQuest(57719) and not PeaceMaker_IsQuestCompleted(57719) then
    PeaceMaker_AcceptQuest(-4140.94, -5425.5, 6500.64, 57719, 344726, "Object")
    return
  end

  if PeaceMaker_HasQuest(57719) and not PeaceMaker_IsQuestCompleted(57719) then
    if not PeaceMaker_IsObjectiveCompleted(57719, 1) then
      PeaceMaker_Interact(hotspot3, obj, "Object", 4)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57444) then
    PeaceMaker_CompleteQuest(-4171.04, -5498.17, 6501.85, 57444, 160647)
    return
  end

  if PeaceMaker_IsQuestComplete(59147) then
    PeaceMaker_CompleteActiveQuest(-4168.43, -5506.97, 6501.85, 59147, 159762)
    return
  end

  if PeaceMaker_IsQuestComplete(57037) then
    PeaceMaker_CompleteActiveQuest(-4168.43, -5506.97, 6501.85, 57037, 159762)
    return
  end

  if PeaceMaker_IsQuestComplete(57719) then
    PeaceMaker_CompleteQuest(-4168.43, -5506.97, 6501.85, 57719, 159762)
    return
  end

  if not PeaceMaker_HasQuest(57446) and not PeaceMaker_IsQuestCompleted(57446) then
    PeaceMaker_AcceptQuest(-4168.43, -5506.97, 6501.85, 57446, 159762)
    return
  end

  if PeaceMaker_HasQuest(57446) and not PeaceMaker_IsQuestCompleted(57446) then
    if not PeaceMaker_IsObjectiveCompleted(57446, 1) then
      PeaceMaker_MoveToAndWait(-4072.73, -5668.06, 6527, 2)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57446, 2) then
      PeaceMaker_MoveToNpcAndInteract(-4066.23, -5654.37, 6526.31, 164378, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57446, 3) then
      if not PeaceMaker.Player.Casting then 
        PeaceMaker_MacroText("/click OverrideActionBarButton1")
      end
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57446, 4) then
      if not UnitInVehicle("player") then
        PeaceMaker_CompleteQuest(-4039.81, -5703.46, 6731.04, 57446, 157673)
      end
      return
    end
  end

  PeaceMaker_MoveToNextStep()
end

function EnemyUntilChasing()
  
  if not PeaceMaker_HasQuest(57269) and not PeaceMaker_IsQuestCompleted(57269) then
    PeaceMaker_AcceptQuest(-4039.81, -5703.46, 6731.04, 57269, 157673)
    return
  end

  if PeaceMaker_HasQuest(57269) and not PeaceMaker_IsQuestCompleted(57269) then
    if not PeaceMaker_IsObjectiveCompleted(57269, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4039.81, -5703.46, 6731.04, 157673, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57269, 2) then
      PeaceMaker_KillAroundPos(-4032.69, -5714.98, 6730.45, 100, 168299, "Boss")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(57269, 3) then
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57269) then
    PeaceMaker_CompleteQuest(-4022.54, -5730.93, 6728.47, 57269, 157687)
    return
  end

  if not PeaceMaker_HasQuest(57447) and not PeaceMaker_IsQuestCompleted(57447) then
    PeaceMaker_AcceptQuest(-4022.54, -5730.93, 6728.47, 57447, 157687)
    return
  end

  if PeaceMaker_HasQuest(57447) and not PeaceMaker_IsQuestCompleted(57447) then
    if not PeaceMaker_IsObjectiveCompleted(57447, 1) then
      PeaceMaker_MoveToNpcAndInteract(-4022.54, -5730.93, 6728.47, 157687, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57447) then
    if PeaceMaker_GetDistance3D(-4135.54, -5019.02, 6542.69) <= 10 then
      PeaceMaker_CompleteQuest(-4137.5, -5010.26, 6542.7, 57447, 156238)
    end
    return
  end

  if not PeaceMaker_HasQuest(58976) and not PeaceMaker_IsQuestCompleted(58976) then
    PeaceMaker_AcceptQuest(-4137.5, -5010.26, 6542.7, 58976, 156238)
    return
  end

  PeaceMaker_MoveToNextStep()
end

function ChasingUntilService()
  
  if PeaceMaker_HasQuest(58976) and not PeaceMaker_IsQuestCompleted(58976) then
    if not PeaceMaker_IsObjectiveCompleted(58976, 1) then
      PeaceMaker_MoveToAndWait(-3711.42, -5072.75, 6573.06, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58976) then
    PeaceMaker_CompleteQuest(-3713.78, -5070.93, 6573.36, 58976, 167034)
    return
  end

  if not PeaceMaker_HasQuest(58771) and not PeaceMaker_IsQuestCompleted(58771) then
    PeaceMaker_AcceptQuestGossip(-3713.78, -5070.93, 6573.36, 58771, 167034)
    return
  end

  if not PeaceMaker_HasQuest(58799) and not PeaceMaker_IsQuestCompleted(58799) then
    PeaceMaker_AcceptQuestGossip(-3713.78, -5070.93, 6573.36, 58799, 167034)
    return
  end

  local hotspot = { 
    [1] = { x = -3655.6, y = -5135.67, z = 6567.49, radius = 150},
    [2] = { x = -3621.74, y = -5253.17, z = 6572.15, radius = 150}  
  }

  local obj = { 350065, 350064 }

  if PeaceMaker_HasQuest(58771) and not PeaceMaker_IsQuestCompleted(58771) then
    if not PeaceMaker_IsObjectiveCompleted(58771, 1) then
      PeaceMaker_Interact(hotspot, obj, "Object")
      return
    end
  end

  if PeaceMaker_HasQuest(58799) and not PeaceMaker_IsQuestCompleted(58799) then
    if not PeaceMaker_IsObjectiveCompleted(58799, 1) then
      PeaceMaker_KillAroundPos(-3672.64, -5183.55, 6569.41, 100, {171189, 166869, 166867, 166866}, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58771) then
    PeaceMaker_CompleteActiveQuest(-3605.07, -5232.65, 6572.15, 58771, 167034)
    return
  end

  if PeaceMaker_IsQuestComplete(58799) then
    PeaceMaker_CompleteActiveQuest(-3605.07, -5232.65, 6572.15, 58799, 167034)
    return
  end

  if not PeaceMaker_HasQuest(58800) and not PeaceMaker_IsQuestCompleted(58800) then
    PeaceMaker_AcceptQuest(-3605.07, -5232.65, 6572.15, 58800, 167034)
    return
  end

  if PeaceMaker_HasQuest(58800) and not PeaceMaker_IsQuestCompleted(58800) then
    if not PeaceMaker_IsObjectiveCompleted(58800, 1) then
      if PeaceMaker_GetDistance2D(-3604.54, -5229.55) > 2 then
        PeaceMaker_MoveToAndWait(-3604.54, -5229.55, 6572.15, 1)
      else
        if ExtraActionButton1:IsVisible() then
          PeaceMaker_MacroText("/click ExtraActionButton1")
        end
      end
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58800) then
    PeaceMaker_CompleteActiveQuest(-3611.14, -5257.91, 6572.15, 58800, 167034)
    return
  end

  if not PeaceMaker_HasQuest(58977) and not PeaceMaker_IsQuestCompleted(58977) then
    PeaceMaker_AcceptQuest(-3611.14, -5257.91, 6572.15, 58977, 167034)
    return
  end

  if PeaceMaker_HasQuest(58977) and not PeaceMaker_IsQuestCompleted(58977) then
    if not PeaceMaker_IsObjectiveCompleted(58977, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3611.14, -5257.91, 6572.15, 167034, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58977, 2) then
      PeaceMaker_KillAroundPos(-3617.05, -5257.74, 6572.15, 100, 162492, "Normal")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58977, 3) then
      PeaceMaker_MoveToNpcAndInteract(-3604.87, -5263.37, 6572.98, 167551, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58977) then
    PeaceMaker_Wait(15)
    PeaceMaker_CompleteActiveQuest(-3606.89, -5255.8, 6572.15, 58977, 167038)
    return
  end

  if not PeaceMaker_HasQuest(58978) and not PeaceMaker_IsQuestCompleted(58978) then
    PeaceMaker_AcceptQuest(-3606.89, -5255.8, 6572.15, 58978, 167038)
    return
  end

  if PeaceMaker_HasQuest(58978) and not PeaceMaker_IsQuestCompleted(58978) then
    if not PeaceMaker_IsObjectiveCompleted(58978, 1) then
      PeaceMaker_MoveToObjectAndInteract(-3730.42, -5295.62, 6560.05, 352079, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58978, 2) then
      PeaceMaker_MoveToObjectAndInteract(-3650.52, -5351.62, 6542.42, 352078, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58978, 3) then
      PeaceMaker_MoveToObjectAndInteract(-3513.81, -5392.27, 6538.46, 352077, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58978, 4) then
      PeaceMaker_MoveToObjectAndInteract(-3279.38, -5233.03, 6521.29, 352090, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58978) then
    PeaceMaker_CompleteQuest(-3324.24, -5238.43, 6520.62, 58978, 167034)
    return
  end

  if not PeaceMaker_HasQuest(58979) and not PeaceMaker_IsQuestCompleted(58979) then
    PeaceMaker_AcceptQuest(-3324.24, -5238.43, 6520.62, 58979, 167034)
    return
  end

  if PeaceMaker_HasQuest(58979) and not PeaceMaker_IsQuestCompleted(58979) then
    if not PeaceMaker_IsObjectiveCompleted(58979, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3324.24, -5238.43, 6520.62, 167034, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(58979, 2) then
      PeaceMaker_KillAroundPos(-3306.88, -5235.51, 6520.64, 100, 167036, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58979) then
    PeaceMaker_CompleteQuest(-3319.24, -5239.01, 6520.62, 58979, 167035)
    return
  end

  if not PeaceMaker_HasQuest(58980) and not PeaceMaker_IsQuestCompleted(58980) then
    PeaceMaker_AcceptQuest(-3319.24, -5239.01, 6520.62, 58980, 167035)
    return
  end

  if PeaceMaker_HasQuest(58980) and not PeaceMaker_IsQuestCompleted(58980) then
    if not PeaceMaker_IsObjectiveCompleted(58980, 1) then
      PeaceMaker_KillAroundPos(-3455.04, -5408.93, 6500.93, 30, 166873, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58980, 2) then
      PeaceMaker_MoveToObjectAndInteract(-3448.592, -5416.734, 6500.834, 350888, 4)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58980, 3) then
      PeaceMaker_KillAroundPos(-3620.1, -5455.79, 6504.68, 30, 166873, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58980, 4) then
      PeaceMaker_MoveToObjectAndInteract(-3613.54, -5461.48, 6504.68, 350889, 4)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58980) then
    PeaceMaker_CompleteQuest(-3765.46, -5345.31, 6499.72, 58980, 167035)
    return
  end

  if not PeaceMaker_HasQuest(58843) and not PeaceMaker_IsQuestCompleted(58843) then
    PeaceMaker_AcceptQuest(-3765.46, -5345.31, 6499.72, 58843, 167035)
    return
  end

  if PeaceMaker_HasQuest(58843) and not PeaceMaker_IsQuestCompleted(58843) then
    if not PeaceMaker_IsObjectiveCompleted(58843, 1) then
      PeaceMaker_InteractAroundPos(-3760.53, -5350.55, 6499.72, 100, {167373, 167374}, "ObjectUnit")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58843, 2) then
      PeaceMaker_MoveToNpcAndInteract(-3912.28, -5284.53, 6489.9, 167498, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58843, 3) then
      PeaceMaker_KillAroundPos(-3839.11, -5279.03, 6489.9, 100, 167508, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58843, 4) then
      PeaceMaker_MoveToAndWait(-3866.38, -5171.12, 6476.25, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58843) then
    PeaceMaker_CompleteQuest(-3870.13, -5164.94, 6476.15, 58843, 167504)
    return
  end

  if not PeaceMaker_HasQuest(60180) and not PeaceMaker_IsQuestCompleted(60180) then
    PeaceMaker_AcceptQuest(-3870.13, -5164.94, 6476.15, 60180, 167504)
    return
  end

  if PeaceMaker_HasQuest(60180) and not PeaceMaker_IsQuestCompleted(60180) then
    if not PeaceMaker_IsObjectiveCompleted(60180, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3892.35, -5134.98, 6476.15, 167514, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60180) then
    PeaceMaker_CompleteQuest(-3870.13, -5164.94, 6476.15, 60180, 167504)
    return
  end

  if not PeaceMaker_HasQuest(60013) and not PeaceMaker_IsQuestCompleted(60013) then
    PeaceMaker_AcceptQuest(-3870.13, -5164.94, 6476.15, 60013, 167504)
    return
  end

  if PeaceMaker_HasQuest(60013) and not PeaceMaker_IsQuestCompleted(60013) then
    if not PeaceMaker_IsObjectiveCompleted(60013, 1) then
      PeaceMaker_MoveToObjectAndInteract(-3848.52, -5268.8, 6490.35, 350979, 3)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60013) then
    PeaceMaker_CompleteQuest(-3720.03, -5050.39, 6575.16, 60013, 167038)
    return
  end

  if not PeaceMaker_HasQuest(59196) and not PeaceMaker_IsQuestCompleted(59196) then
    PeaceMaker_AcceptQuest(-3720.03, -5050.39, 6575.16, 59196, 167038)
    return
  end

  if not PeaceMaker_HasQuest(59674) and not PeaceMaker_IsQuestCompleted(59674) then
    PeaceMaker_AcceptQuest(-3274.22, -5251.74, 6590.1, 59674, 158765)
    return
  end

  if PeaceMaker_IsQuestComplete(59674) then
    PeaceMaker_CompleteQuest(-2692.41, -5073.24, 6609.28, 59674, 158765)
    return
  end

  if not PeaceMaker_HasQuest(57932) and not PeaceMaker_IsQuestCompleted(57932) then
    PeaceMaker_AcceptQuest(-2696.21, -5074.69, 6609.27, 57932, 159609)
    return
  end

  if not PeaceMaker_HasQuest(57931) and not PeaceMaker_IsQuestCompleted(57931) then
    PeaceMaker_AcceptQuest(-2692.72, -5074.25, 6609.26, 57931, 158765)
    return
  end

  if not PeaceMaker_HasQuest(58037) and not PeaceMaker_IsQuestCompleted(58037) then
    PeaceMaker_AcceptQuest(-2605.8, -5239.11, 6636.57, 58037, 157696)
    return
  end

  local hotspot2 = { 
    [1] = { x = -2612.62, y = -5232.33, z = 6636.11, radius = 100},
    [2] = { x = -2671.33, y = -5274.07, z = 6634.01, radius = 100}
  }

  local obj = { 158767 }

  if PeaceMaker_HasQuest(58037) and not PeaceMaker_IsQuestCompleted(58037) then
    if not PeaceMaker_IsObjectiveCompleted(58037, 1) then
      PeaceMaker_Interact(hotspot2, obj, "ObjectUnit", 4)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58037) then
    PeaceMaker_CompleteQuest(-2605.8, -5239.11, 6636.57, 58037, 157696)
    return
  end

  if not PeaceMaker_HasQuest(58039) and not PeaceMaker_IsQuestCompleted(58039) then
    PeaceMaker_AcceptQuest(-2605.8, -5239.11, 6636.57, 58039, 157696)
    return
  end

  if not PeaceMaker_HasQuest(58038) and not PeaceMaker_IsQuestCompleted(58038) then
    PeaceMaker_AcceptQuest(-2605.8, -5239.11, 6636.57, 58038, 157696)
    return
  end

  if PeaceMaker_HasQuest(57931) and not PeaceMaker_IsQuestCompleted(57931) then
    if not PeaceMaker_IsObjectiveCompleted(57931, 1) then
      PeaceMaker_MoveToNpcAndInteract(-2798.56, -5078.93, 6562.32, 159641, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(57931, 2) then
      PeaceMaker_MoveToAndWait(-2728.93, -5111.03, 6610.02, 2)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57931) then
    PeaceMaker_CompleteQuest(-2692.76, -5075.02, 6609.26, 57931, 158765)
    return
  end

  local hotspot3 = { 
    [1] = { x = -2825.4, y = -5113.27, z = 6563.7, radius = 100},
    [2] = { x = -2952.04, y = -5326.22, z = 6580.54, radius = 100}
  }

  local mob2 = { 159298 }

  if PeaceMaker_HasQuest(57932) and not PeaceMaker_IsQuestCompleted(57932) then
    if not PeaceMaker_IsObjectiveCompleted(57932, 1) then
      PeaceMaker_UseItem(hotspot3, mob2, 173691, 15)
      return
    end
  end

  if PeaceMaker_HasQuest(58038) and not PeaceMaker_IsQuestCompleted(58038) then
    if not PeaceMaker_IsObjectiveCompleted(58038, 1) then
      PeaceMaker_Kill(hotspot3, mob2, "Normal")
      return
    end
  end

  if PeaceMaker_HasQuest(58039) and not PeaceMaker_IsQuestCompleted(58039) then
    if not PeaceMaker_IsObjectiveCompleted(58039, 1) then
      PeaceMaker_InteractAroundPos(-2825.53, -5115.76, 6563.57, 100, 160189, "ObjectUnit", 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(58039, 2) then
      PeaceMaker_MoveToAndWait(-2610.99, -5235.69, 6636.41, 2)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(58038) then
    PeaceMaker_CompleteQuest(-2605.8, -5239.11, 6636.57, 58038, 157696)
    return
  end

  if PeaceMaker_IsQuestComplete(58039) then
    PeaceMaker_CompleteQuest(-2605.8, -5239.11, 6636.57, 58039, 157696)
    return
  end

  if PeaceMaker_IsQuestComplete(57932) then
    PeaceMaker_CompleteQuest(-2695.7, -5075.37, 6609.26, 57932, 159609)
    return
  end

  if PeaceMaker_HasQuest(59196) and not PeaceMaker_IsQuestCompleted(59196) then
    if not PeaceMaker_IsObjectiveCompleted(59196, 1) then
      PeaceMaker_MoveToObjectAndInteract(-3208.62, -5154.98, 6593.56, 348515, 3)
      return
    end
  end

  PeaceMaker_MoveToNextStep()

end

function ServiceUntilCourage()

  if PeaceMaker_IsQuestComplete(59196) then
    PeaceMaker_CompleteQuest(-2997.81, -4947.36, 6706.54, 59196, 165042)
    return
  end

  if PeaceMaker_IsQuestComplete(62718) then
    PeaceMaker_CompleteQuest(-2991.1, -4943.89, 6706.5, 62718, 165045)
    return
  end

  if not PeaceMaker_HasQuest(59426) and not PeaceMaker_IsQuestCompleted(59426) then
    PeaceMaker_AcceptQuest(-2991.1, -4943.89, 6706.5, 59426, 165045)
    return
  end

  if not PeaceMaker_HasQuest(59554) and not PeaceMaker_IsQuestCompleted(59554) then
    PeaceMaker_AcceptQuest(-2983.34, -4883.44, 6706.5, 59554, 348558, "Object")
    return
  end

  if PeaceMaker_HasQuest(59426) and not PeaceMaker_IsQuestCompleted(59426) then
    if not PeaceMaker_IsObjectiveCompleted(59426, 1) then
      PeaceMaker_MoveToNpcAndInteract(-2959.02, -4938.41, 6706.58, 167796, 1)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(59426) then
    PeaceMaker_CompleteQuest(-2991.1, -4943.89, 6706.5, 59426, 165045)
    return
  end

  if not PeaceMaker_HasQuest(59197) and not PeaceMaker_IsQuestCompleted(59197) then
    PeaceMaker_AcceptQuest(-2991.1, -4943.89, 6706.5, 59197, 165045)
    return
  end

  if PeaceMaker_HasQuest(59197) and not PeaceMaker_IsQuestCompleted(59197) then
    if not PeaceMaker_IsObjectiveCompleted(59197, 1) then
      if not PeaceMaker.Player.Casting then
        PeaceMaker_CastSpell(324739)
      end
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59197, 2) then
      PeaceMaker_InteractNpcNearbyAndGossip(166663, 2)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59197, 3) then
      PeaceMaker_MoveToObjectAndInteract(-2943.25, -4970.4, 6706.63, 351720, 5.8)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(59197) then
    PeaceMaker_Wait(20)
    PeaceMaker_CompleteQuest(-2891.71, -4946.38, 6706.7, 59197, 165048)
    return
  end
  
  if not PeaceMaker_HasQuest(59198) and not PeaceMaker_IsQuestCompleted(59198) then
    PeaceMaker_AcceptQuest(-2891.71, -4946.38, 6706.7, 59198, 165048)
    return
  end

  if PeaceMaker_HasQuest(59198) and not PeaceMaker_IsQuestCompleted(59198) then
    if not PeaceMaker_IsObjectiveCompleted(59198, 1) then
      PeaceMaker_MoveToNpcAndInteract(-2891.71, -4946.38, 6706.7, 165048, 1)
      return
    end
  end

  if PeaceMaker_CheckAreaID() == 1707 then

    if PeaceMaker_IsQuestComplete(59198) then
      PeaceMaker_CompleteQuest(-1596.79, -5856.15, 6858.7, 59198, 160037)
      return
    end

    if not PeaceMaker_HasQuest(59199) and not PeaceMaker_IsQuestCompleted(59199) then
      PeaceMaker_AcceptQuest(-1596.79, -5856.15, 6858.7, 59199, 160037)
      return
    end

    if PeaceMaker_HasQuest(59199) and not PeaceMaker_IsQuestCompleted(59199) then
      if not PeaceMaker_IsObjectiveCompleted(59199, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1596.79, -5856.15, 6858.7, 160037, 1)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(59199) then
      PeaceMaker_CompleteQuest(-1596.79, -5856.15, 6858.7, 59199, 160037)
      return
    end

    if not PeaceMaker_HasQuest(59200) and not PeaceMaker_IsQuestCompleted(59200) then
      PeaceMaker_AcceptQuest(-1596.79, -5856.15, 6858.7, 59200, 160037)
      return
    end

    if PeaceMaker_HasQuest(59200) and not PeaceMaker_IsQuestCompleted(59200) then
      if not PeaceMaker_IsObjectiveCompleted(59200, 1) then
        PeaceMaker_MoveToObjectAndInteract(-1815.33, -5825.73, 6853.35, 351732, 2)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59200, 2) then
        PeaceMaker_MoveToObjectAndInteract(-1873.71, -5883.81, 6853.35, 351733, 2)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59200, 3) then
        PeaceMaker_MoveToObjectAndInteract(-1879.27, -5889.43, 6853.37, 351736, 2)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59200, 4) then
        PeaceMaker_MoveToObjectAndInteract(-1797.67, -5838.66, 6853.35, 351735, 2)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59200, 5) then
        PeaceMaker_MoveToObjectAndInteract(-1860.74, -5902.5, 6853.37, 351734, 2)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(59200) then
      PeaceMaker_CompleteQuest(-1596.79, -5856.15, 6858.7, 59200, 160037)
      return
    end

    if not PeaceMaker_HasQuest(60005) and not PeaceMaker_IsQuestCompleted(60005) then
      PeaceMaker_AcceptQuest(-1596.79, -5856.15, 6858.7, 60005, 160037)
      return
    end

    if PeaceMaker_HasQuest(60005) and not PeaceMaker_IsQuestCompleted(60005) then
      if not PeaceMaker_IsObjectiveCompleted(60005, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1639.23, -5814.09, 6851.7, 159421, 2)
        return
      end
    end

  end

  if PeaceMaker_CheckAreaID() == 1533 then
    if PeaceMaker_IsQuestComplete(60005) then
      PeaceMaker_CompleteQuest(-3315.31, -4206.28, 6597.56, 60005, 167873)
      return
    end
  end

  if PeaceMaker_IsQuestCompleted(60005) then
    PeaceMaker_MoveToNextStep()
  end

end

function CourageUntilFollow()

  if not PeaceMaker_HasQuest(60006) and not PeaceMaker_IsQuestCompleted(60006) then
    PeaceMaker_AcceptQuest(-3315.48, -4205.88, 6597.56, 60006, 167873)
    return
  end

  if PeaceMaker_HasQuest(60006) and not PeaceMaker_IsQuestCompleted(60006) then
    if not PeaceMaker_IsObjectiveCompleted(60006, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3315.48, -4205.88, 6597.56, 167873, 1)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(60006, 2) then
      PeaceMaker_KillAroundPos(-3316.17, -4196.67, 6597.56, 100, {167922, 167919}, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60006) then
    PeaceMaker_CompleteQuest(-3316.72, -4127.52, 6599.41, 60006, 167873)
    return
  end

  if not PeaceMaker_HasQuest(60008) and not PeaceMaker_IsQuestCompleted(60008) then
    PeaceMaker_AcceptQuest(-3316.72, -4127.52, 6599.41, 60008, 167164)
    return
  end

  if not PeaceMaker_HasQuest(60007) and not PeaceMaker_IsQuestCompleted(60007) then
    PeaceMaker_AcceptQuest(-3329.7, -4136.17, 6599.41, 60007, 167135)
    return
  end

  if not PeaceMaker_HasQuest(60009) and not PeaceMaker_IsQuestCompleted(60009) then
    PeaceMaker_AcceptQuest(-3278.73, -4173.73, 6597.56, 60009, 167269)
    return
  end

  local hotspot = { 
    [1] = { x = -3204.63, y = -4161.87, z = 6589.83, radius = 150 },
    [2] = { x = -3086.67, y = -4073.54, z = 6581.3, radius = 150 },
    [3] = { x = -3167.77, y = -4019.87, z = 6573.54, radius = 150 }
  }
  
  local hotspot2 = {
    [1] = { x = -3221.3, y = -4152.23, z = 6589.83, radius = 100}, 
    [2] = { x = -3112.92, y = -4076.23, z = 6582.12, radius = 100},
    [3] = { x = -3189.59, y = -4031.38, z = 6573.54, radius = 100}
  }

  local mob = { 166930, 166931, 167080, 166942, 166925, 166928, 167033, 167151 }
  local obj = { 349973, 350773 }

  if PeaceMaker_HasQuest(60009) and not PeaceMaker_IsQuestCompleted(60009) then
    if not PeaceMaker_IsObjectiveCompleted(60009, 1) then
      PeaceMaker_Interact(hotspot, obj, "Object", 8)
      return
    end
  end

  if PeaceMaker_HasQuest(60007) and not PeaceMaker_IsQuestCompleted(60007) then
    if not PeaceMaker_IsObjectiveCompleted(60007, 1) then
      PeaceMaker_MoveToObjectAndInteract(-3186.42, -4140.36, 6590.3, 349976, 2)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(60007, 2) then
      PeaceMaker_MoveToObjectAndInteract(-3202.03, -4066.67, 6577.08, 349975, 3)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(60007, 3) then
      PeaceMaker_MoveToObjectAndInteract(-3039.32, -4053.79, 6588.4, 349974, 3)
      return
    end
  end

  if PeaceMaker_HasQuest(60008) and not PeaceMaker_IsQuestCompleted(60008) then
    if not PeaceMaker_IsObjectiveCompleted(60008, 1) then
      PeaceMaker_Kill(hotspot2, mob, "Normal")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60009) then
    PeaceMaker_CompleteQuest(-3278.99, -4173.31, 6597.56, 60009, 167269)
    return
  end

  if PeaceMaker_IsQuestComplete(60007) then
    PeaceMaker_CompleteQuest(-3329.75, -4136.06, 6599.41, 60007, 167135)
    return
  end
  
  if PeaceMaker_IsQuestComplete(60008) then
    PeaceMaker_InteractNpcNearbyAndCompleteQuest(167165)
    return
  end

  if not PeaceMaker_HasQuest(60053) and not PeaceMaker_IsQuestCompleted(60053) then
    PeaceMaker_AcceptQuest(-3329.75, -4136.06, 6599.41, 60009, 167135)
    return
  end

  if not PeaceMaker_HasQuest(60053) and not PeaceMaker_IsQuestCompleted(60053) then
    PeaceMaker_AcceptQuest(-3329.75, -4136.06, 6599.41, 60009, 167135)
    return
  end

  if not PeaceMaker_HasQuest(60052) and not PeaceMaker_IsQuestCompleted(60052) then
    PeaceMaker_InteractNpcNearbyAndAcceptQuest(167165, 60052)
    return
  end

  local hotspot4 = { [1] = { x = -3535.47, y = -4004.22, z = 6577.41, radius = 100} }

  local obj = { 166935, 166937, 166941, 166926 }

  if PeaceMaker_HasQuest(60052) and not PeaceMaker_IsQuestCompleted(60052) then
    if not PeaceMaker_IsObjectiveCompleted(60052, 1) then
      PeaceMaker_KillAndUseItemOnCorpse(hotspot4, obj, 178140, 4, "Sundered Soul", 2)
      return
    end
  end

  local hotspot3 = { 
    [1] = { x = -3458.43, y = -4149.6, z = 6585.29, radius = 100 },
    [2] = { x = -3412.72, y = -4098.53, z = 6584.12, radius = 100 },
    [3] = { x = -3438, y = -4020.3, z = 6576.7, radius = 100 },
    [4] = { x = -3486.79, y = -4071.17, z = 6583.98, radius = 100}
  }

  local obj2 = { 350805, 350806, 350808, 350815, 350817 }
  
  if PeaceMaker_HasQuest(60053) and not PeaceMaker_IsQuestCompleted(60053) then
    PeaceMaker_DisableMount()
    if not PeaceMaker_IsObjectiveCompleted(60053, 1) then
      PeaceMaker_InteractFloatObject(hotspot3, obj2, "Object", 5)
      return
    end
  end
  
  if PeaceMaker_IsQuestComplete(60053) then
    PeaceMaker_CompleteQuest(-3315.65, -4074.77, 6568.63, 60052, 167428)
    return
  end
  
  if PeaceMaker_IsQuestComplete(60052) then
    PeaceMaker_EnableMount()
    PeaceMaker_CompleteQuest(-3317.86, -4052.32, 6565.11, 60053, 167423)
    return
  end

  if not PeaceMaker_HasQuest(60054) and not PeaceMaker_IsQuestCompleted(60054) then
    PeaceMaker_AcceptQuest(-3317.86, -4052.32, 6565.11, 60054, 167423)
    return
  end

  if PeaceMaker_HasQuest(60054) and not PeaceMaker_IsQuestCompleted(60054) then
    if not PeaceMaker_IsObjectiveCompleted(60054, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3317.86, -4052.32, 6565.11, 167423, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(60054, 2) then
      PeaceMaker_KillAroundPos(-3318.05, -4051.07, 6565.11, 100, {167426, 167431, 167432, 167433}, "Boss")
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(60054, 3) then
      if not UnitInVehicle("player") then
        PeaceMaker_MoveToNpcAndInteract(-3319.49, -4076.57, 6568.63, 167121, 1)
      else
        PeaceMaker_MacroText("/click OverrideActionBarButton2")
      end
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60054) then
    PeaceMaker_CompleteQuest(-3318.11, -4016.87, 6565.1, 60054, 167460)
    return
  end

  if not PeaceMaker_HasQuest(60055) and not PeaceMaker_IsQuestCompleted(60055) then
    PeaceMaker_AcceptQuest(-3318.11, -4016.87, 6565.1, 60055, 167460)
    return
  end

  if PeaceMaker_HasQuest(60055) and not PeaceMaker_IsQuestCompleted(60055) then
    if not PeaceMaker_IsObjectiveCompleted(60055, 1) then
      PeaceMaker_MoveToNpcAndInteract(-3318.11, -4016.87, 6565.1, 167460, 1)
      return
    end

    if not PeaceMaker_IsObjectiveCompleted(60055, 2) then
      if not UnitInVehicle("player") then
        PeaceMaker_KillAroundPos(-3315.58, -3714.54, 6600.58, 100, 167484, "Boss")
      end
      return
    end

    if PeaceMaker_IsObjectiveCompleted(60055, 2) and not PeaceMaker_IsObjectiveCompleted(60055, 3) then
      PeaceMaker_MoveToNpcAndInteract(-3312.28, -3729.56, 6600.68, 167559, 1)
      return
    end

    if PeaceMaker_IsQuestComplete(60055) then
      PeaceMaker_CompleteQuest(-3312.1, -4149.03, 6599.41, 60055, 167583)
      return
    end
    return
  end

  PeaceMaker_MoveToNextStep()

end

function FollowUntilMal()

  if not PeaceMaker_HasQuest(60056) and not PeaceMaker_IsQuestCompleted(60056) then
    PeaceMaker_AcceptQuest(-3312.1, -4149.03, 6599.41, 60056, 167583)
    return
  end

  if PeaceMaker_HasQuest(60056) and not PeaceMaker_IsQuestCompleted(60056) then
    if not PeaceMaker_IsObjectiveCompleted(60056, 1) then
      if PeaceMaker_CheckZoneName() ~= "Hero's Rest" then
        PeaceMaker_MoveToObjectAndInteract(-3037.55, -4552, 6638.35, 348547, 2)
        return
      else
        PeaceMaker_MoveToInteractFlightPathAndPlace(-2942.34, -4845.24, 6704.12, 159423, "Oribos")
        return
      end
    end

    if not PeaceMaker_IsObjectiveCompleted(60056, 2) then
      if PeaceMaker_CheckAreaID() == 1671 then
        PeaceMaker_MoveToObjectAndInteract(-1872.52, 1284.03, 5447.99, 352746, 1)
        return
      end

      if PeaceMaker_CheckAreaID() == 1670 then
        PeaceMaker_MoveToNpcAndInteract(-1941.31, 1390.74, 5269.73, 159478, 1)
        return
      end
    end

    if PeaceMaker_IsQuestComplete(60056) then
      PeaceMaker_CompleteQuest(-1941.31, 1390.74, 5269.73, 60056, 159478)
      return
    end
    return
  end

  if not PeaceMaker_HasQuest(61096) and not PeaceMaker_IsQuestCompleted(61096) then
    PeaceMaker_AcceptQuest(-1941.31, 1390.74, 5269.73, 61096, 159478)
    return
  end

  if PeaceMaker_HasQuest(61096) and not PeaceMaker_IsQuestCompleted(61096) then
    if not PeaceMaker_IsObjectiveCompleted(61096, 1) then
      PeaceMaker_MoveToObjectAndInteract(-1875.11, 1282.89, 5268.78, 365157, 2)
      return
    end
    if PeaceMaker_IsQuestComplete(61096) then
      PeaceMaker_CompleteQuest(-1772.02, 1209.38, 5450.93, 61096, 171338)
      return
    end
    return
  end

  if not PeaceMaker_HasQuest(61107) and not PeaceMaker_IsQuestCompleted(61107) then
    PeaceMaker_AcceptQuest(-1772.02, 1209.38, 5450.93, 61107, 171338)
    return
  end

  if PeaceMaker_HasQuest(61107) and not PeaceMaker_IsQuestCompleted(61107) then
    if not PeaceMaker_IsObjectiveCompleted(61107, 1) then
      PeaceMaker_MoveToObjectAndInteract(-1769.56, 1217.52, 5450.9, 355013, 2)
      return
    end
  end

  if PeaceMaker_IsQuestComplete(61107) then
    PeaceMaker_CompleteQuest(-1771.95, 1209.2, 5450.93, 61107, 171338)
    return
  end

  if not PeaceMaker_HasQuest(57386) and not PeaceMaker_IsQuestCompleted(57386) then
    PeaceMaker_AcceptQuest(-1772.02, 1209.38, 5450.93, 57386, 171338)
    return
  end

  if PeaceMaker_HasQuest(57386) and not PeaceMaker_IsQuestCompleted(57386) then
    if not PeaceMaker_IsObjectiveCompleted(57386, 1) then
      PeaceMaker_MoveToNpcAndInteract(-1759.65, 1221.3, 5450.93, 175132, 1)
      return
    end

    if PeaceMaker_IsQuestComplete(57386) then
      if PeaceMaker_MapID() == 2370 then
        PeaceMaker_SearchNpcAndCompleteQuest(61107, 164244)
        --PeaceMaker_CompleteQuest(3066.24, -2546, 3293.16, 61107, 164244)
        return
      end
    end
    return
  end

  PeaceMaker_MoveToNextStep()

end

function LoadMalProfile()
  PeaceMaker_LoadNextProfile("53_55_H")
end
