QuestOrder = {
  [1] = { Quest_Name = "ShadowlandsAChillingSummons", Quest_Settings = 2 },
  [2] = { Quest_Name = "ThroughtSky", Quest_Settings = 2 },
  [3] = { Quest_Name = "AFactBladeAndMawsworn", Quest_Settings = 2 },
  [4] = { Quest_Name = "AFactBaldeAndMawsworn2", Quest_Settings = 2 },
  [5] = { Quest_Name = "RuinerEnd", Quest_Settings = 2 },
  [6] = { Quest_Name = "FearToTread", Quest_Settings = 2 },
  [7] = { Quest_Name = "BlackEndWing", Quest_Settings = 2 },
  [8] = { Quest_Name = "AFlightFromDark", Quest_Settings = 2 },
  [9] = { Quest_Name = "AMomentRespite", Quest_Settings = 2 },
  [10] = { Quest_Name = "FieldSeance", Quest_Settings = 2 },
  [11] = { Quest_Name = "SpeakToTheDead", Quest_Settings = 2 },
  [12] = { Quest_Name = "SoulInHand", Quest_Settings = 2 },
  [13] = { Quest_Name = "LionCage", Quest_Settings = 2 },
  [14] = { Quest_Name = "AfflictorsUndeservedFate", Quest_Settings = 2 },
  [15] = { Quest_Name = "MouthOfMadness", Quest_Settings = 2 },
  [16] = { Quest_Name = "DownTheRiver", Quest_Settings = 2 },
  [17] = { Quest_Name = "BeyondFlesh", Quest_Settings = 2 },
  [18] = { Quest_Name = "DrawOutTheDark", Quest_Settings = 2 },
  [19] = { Quest_Name = "PathOfSaliv", Quest_Settings = 2 },
  [20] = { Quest_Name = "StandAsOne", Quest_Settings = 2 },
  [21] = { Quest_Name = "StrangerInTheEven", Quest_Settings = 2 },
  [22] = { Quest_Name = "NoPlaceForLiving", Quest_Settings = 2 },
  [23] = { Quest_Name = "AudienceWithArbiter", Quest_Settings = 2 },
  [24] = { Quest_Name = "TetherToHome", Quest_Settings = 2 },
  [25] = { Quest_Name = "ADoorWayToVeil", Quest_Settings = 2 },
  [26] = { Quest_Name = "EternalCity", Quest_Settings = 2 },
  [27] = { Quest_Name = "UnderstandingShadow", Quest_Settings = 2 },
  [28] = { Quest_Name = "PathToBastion", Quest_Settings = 2 },
  [29] = { Quest_Name = "SeekTheAscended", Quest_Settings = 2 },
  [30] = { Quest_Name = "LoadBastionProfile", Quest_Settings = 2 }
}

function ShadowlandsAChillingSummons()
  if PeaceMaker_HasQuest(61874) then
    if not PeaceMaker_IsQuestComplete(61874) then
      if not PeaceMaker_IsObjectiveCompleted(61874, 1) then
        PeaceMaker_MoveToNpcAndInteract(1594.525, -4382.636, 19.517, 171791)
      end
      if PeaceMaker_IsObjectiveCompleted(61874, 1) and not PeaceMaker_IsObjectiveCompleted(61874, 2) then
        PeaceMaker_MoveToInteractAndWait(1591.307, -4348.762, 21.118, 355461, 3)
      end 
      if PeaceMaker_IsObjectiveCompleted(61874, 1) 
        and PeaceMaker_IsObjectiveCompleted(61874, 2)
        and not PeaceMaker_IsObjectiveCompleted(61874, 3) 
      then
        PeaceMaker_MoveToAndClickMoveToAndWait(-555.161, 2211.215, 539.340, -548.972, 2211.22, 539.277, 5)
      end
    else
      PeaceMaker_CompleteQuest(500.712, -2127.219, 840.857, 61874, 169076, 1)
    end
  else
    if PeaceMaker_IsQuestCompleted(61874) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ThroughtSky()
  if PeaceMaker_MapID() == 2147 then
    if not PeaceMaker_IsQuestCompleted(59751) and not PeaceMaker_HasQuest(59751) then
      PeaceMaker_AcceptQuest(500.353, -2126.184, 840.857, 59751, 169076)
    end
    if PeaceMaker_HasQuest(59751) then
      if not DisableNaviUnstuck then PeaceMaker_EnableNavigationUnstuck() end
      if PeaceMaker_IsObjectiveCompleted(59751, 1) and not PeaceMaker_IsObjectiveCompleted(59751, 2) then
        if not PeaceMaker_CheckBuff("Carrying Shard", 'player') then
          PeaceMaker_MoveToNpcAndInteract(504.314, -2124.293, 840.857, 169095)
        else
          PeaceMaker_MoveToInteractAndWait(517.404, -2138.474, 840.857, 352592)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(59751, 2) and not PeaceMaker_IsObjectiveCompleted(59751, 3) then
        if not PeaceMaker_CheckBuff("Carrying Shard", 'player') then
          PeaceMaker_MoveToNpcAndInteract(504.314, -2124.293, 840.857, 169098)
        else
          PeaceMaker_MoveToInteractAndWait(489.795, -2138.586, 840.857, 352593)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(59751, 3) and not PeaceMaker_IsObjectiveCompleted(59751, 4) then
        if not PeaceMaker_CheckBuff("Carrying Shard", 'player') then
          PeaceMaker_MoveToNpcAndInteract(504.375, -2124.199, 840.857, 169100)
        else
          PeaceMaker_MoveToInteractAndWait(488.361, -2109.520, 840.857, 352594)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(59751, 4) and not PeaceMaker_IsObjectiveCompleted(59751, 5) then
        if not PeaceMaker_CheckBuff("Carrying Shard", 'player') then
          PeaceMaker_MoveToNpcAndInteract(504.314, -2124.293, 840.857, 169101)
        else
          PeaceMaker_MoveToInteractAndWait(518.715, -2109.281, 840.857, 352595)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(59751, 5) and not PeaceMaker_IsObjectiveCompleted(59751, 6) then
        PeaceMaker_MoveToNpcAndInteract(504.314, -2124.293, 840.857, 169109)
        PeaceMaker.Pause = PeaceMaker.Time + 10
      end
    end
  else
    if PeaceMaker_IsQuestCompleted(59751) then
      PeaceMaker_DisableNavigationUnstuck()
      PeaceMaker_MoveToNextStep()
    else
      if PeaceMaker_MapID() == 2364 then
        if PeaceMaker_IsQuestComplete(59751) then
          PeaceMaker_CompleteQuest(4153.736, 7867.320, 4969.465, 59751, 165918, 1)
        end
      end
    end
  end
end

function AFactBladeAndMawsworn()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59752) and not PeaceMaker_HasQuest(59752) then
      PeaceMaker_AcceptQuest(4153.736, 7867.320, 4969.465, 59752, 165918)
    end
    if PeaceMaker_HasQuest(59752) then
      if not PeaceMaker_IsQuestCompleted(59907) and not PeaceMaker_HasQuest(59907) then
        PeaceMaker_AcceptQuest(4153.736, 7867.320, 4969.465, 59907, 166709)
      end
    end
    if (PeaceMaker_HasQuest(59752) and PeaceMaker_HasQuest(59907)) 
      or (PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_IsQuestCompleted(59907))
      or (PeaceMaker_HasQuest(59752) and PeaceMaker_IsQuestCompleted(59907))
      or (PeaceMaker_HasQuest(59907) and PeaceMaker_IsQuestCompleted(59752)) 
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(59752) and PeaceMaker_HasQuest(59907)) 
      or (PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_IsQuestCompleted(59907))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function AFactBaldeAndMawsworn2()

  local hotspot1 = {  
    [1] = {  y=7834.212,x=4181.715,radius=100,z=4960.244 },
    [2] = {  y=7799.416,x=4202.906,radius=100,z=4952.253 },
    [3] = {  y=7744.085,x=4277.552,radius=100,z=4928.604 }
  }

  local mob1 = { 165992 }
  local mob2 = { 166963 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_HasQuest(59752) and not PeaceMaker_IsQuestComplete(59752) then
      PeaceMaker_Interact(hotspot1, mob2, "Unit")
    end
    if PeaceMaker_IsQuestComplete(59752) then
      PeaceMaker_InteractNpcNearbyAndCompleteQuest(166709)
    end
    if PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_HasQuest(59907) and not PeaceMaker_IsQuestComplete(59907) then
      PeaceMaker_Kill(hotspot1, mob1)
    end
    if PeaceMaker_IsQuestComplete(59907) then
      PeaceMaker_InteractNpcNearbyAndCompleteQuest(166709)
    end
    if PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_IsQuestCompleted(59907) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59752) and PeaceMaker_IsQuestCompleted(59907) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function RuinerEnd()

  local hotspot1 = {  
    [1] = {  y=7850.384,x=4458.661,radius=100,z=4904.568 }
  } 

  local mob1 = { 166714 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59753) and not PeaceMaker_HasQuest(59753) then
      PeaceMaker_AcceptQuest(4300.371, 7716.692, 4928.487, 59753, 170624)
    end
    if PeaceMaker_HasQuest(59753) and not PeaceMaker_IsObjectiveCompleted(59753, 1) then
      PeaceMaker_Kill(hotspot1, mob1, "Boss")
    end
    if PeaceMaker_HasQuest(59753) and PeaceMaker_IsObjectiveCompleted(59753, 1) and not PeaceMaker_IsObjectiveCompleted(59753, 2) then
      PeaceMaker_MoveToAndWait(4575.717, 7777.429, 4876.830, 1)
    end
    if PeaceMaker_IsQuestComplete(59753) then
      PeaceMaker_MoveToAndTurnInAcceptQuestReward(4575.153, 7776.780, 4876.969, 165918, 1, 1)
    end
    if PeaceMaker_IsQuestCompleted(59753) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59753) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function FearToTread()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59914) and not PeaceMaker_HasQuest(59914) then
      PeaceMaker_AcceptQuest(4572.299, 7775.854, 4877.637, 59914, 165918)
    end
    if PeaceMaker_HasQuest(59914) and not PeaceMaker_IsObjectiveCompleted(59914, 1) then
      PeaceMaker_MoveToAndWait(4553.040, 7746.655, 4877.232, 1)
    end
    if PeaceMaker_HasQuest(59914) and PeaceMaker_IsObjectiveCompleted(59914, 1) and not PeaceMaker_IsObjectiveCompleted(59914, 2) then
      PeaceMaker_MoveToAndWait(4669.089, 7797.056, 4842.380, 1)
    end
    if PeaceMaker_HasQuest(59914) and PeaceMaker_IsObjectiveCompleted(59914, 2) and not PeaceMaker_IsObjectiveCompleted(59914, 3) then
      PeaceMaker_MoveToAndWait(4735.164, 7761.232, 4840.156, 1)
    end
    if PeaceMaker_HasQuest(59914) and PeaceMaker_IsObjectiveCompleted(59914, 3) and not PeaceMaker_IsObjectiveCompleted(59914, 4) then
      PeaceMaker_MoveToAndWait(4822.616, 7744.122, 4843.743, 1)
    end
    if PeaceMaker_IsQuestComplete(59914) then
      PeaceMaker_MoveToAndTurnInAcceptQuestReward(4824.009, 7743.361, 4843.254, 166980, 1, 1)
    end
    if PeaceMaker_IsQuestCompleted(59914) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59914) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BlackEndWing()
  
  local hotspot1 = {  
    [1] = {  y=7762.534,x=4808.753,radius=80,z=4840.301 }
  } 

  local mob1 = { 177071 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59754) and not PeaceMaker_HasQuest(59754) then
      PeaceMaker_AcceptQuest(4824.009, 7743.361, 4843.254, 59754, 166980)
    end
    if not PeaceMaker_IsQuestComplete(59754) and not PeaceMaker_IsQuestCompleted(59754) then
      if PeaceMaker_HasQuest(59754) and not PeaceMaker_IsObjectiveCompleted(59754, 1) then
        PeaceMaker_Escourt(166980, 8)
      end
      if PeaceMaker_HasQuest(59754) and PeaceMaker_IsObjectiveCompleted(59754, 1) and not PeaceMaker_IsObjectiveCompleted(59754, 2) then
        PeaceMaker_Kill(hotspot1, mob1, "Boss")
      end
    end
    if PeaceMaker_IsQuestComplete(59754) then
      --PeaceMaker_MoveToAndTurnInAcceptQuestReward(4860.146, 7705.961, 4828.951, 166980, 1, 1)
      PeaceMaker_InteractNpcNearbyAndCompleteQuest(166980)
    end
    if PeaceMaker_IsQuestCompleted(59754) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59754) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function AFlightFromDark()

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59755) and not PeaceMaker_HasQuest(59755) then
      PeaceMaker_InteractNpcNearbyAndAcceptQuest(166980, 59755)
    end
    if not PeaceMaker_IsQuestComplete(59755) and not PeaceMaker_IsQuestCompleted(59755) then
      if PeaceMaker_HasQuest(59755) and not PeaceMaker_IsObjectiveCompleted(59755, 1) and PeaceMaker_CheckNpcFlags(166980, "Lady Jaina Proudmoore") == 3 then
        PeaceMaker_ClickToMoveAndInteractNpc(4859.270, 7707.886, 4828.517, 166980, 1)
      end
      if PeaceMaker_HasQuest(59755) and not PeaceMaker_IsObjectiveCompleted(59755, 1) and PeaceMaker_CheckNpcFlags(167154, "Lady Jaina Proudmoore") == 2 then
        PeaceMaker_Escourt(167154, 10)
      end
    end
    if PeaceMaker_IsQuestComplete(59755) then
      PeaceMaker_MoveToAndTurnInAcceptQuestReward(4733.147, 7654.050, 4772.560, 166980, 1, 1)
    end
    if PeaceMaker_IsQuestCompleted(59755) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59755) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function AMomentRespite()

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59756) and not PeaceMaker_HasQuest(59756) then
      PeaceMaker_AcceptQuest(4733.147, 7654.050, 4772.560, 59756, 166980)
    end
    if not PeaceMaker_IsQuestComplete(59756) and not PeaceMaker_IsQuestCompleted(59756) then
      if PeaceMaker_HasQuest(59756) then
        if not PeaceMaker_IsObjectiveCompleted(59756, 1) then
          PeaceMaker_MoveToNpcAndInteract(4733.147, 7654.050, 4772.560, 166980)
        end
        if PeaceMaker_IsObjectiveCompleted(59756, 1) and not PeaceMaker_IsObjectiveCompleted(59756, 2) then
          PeaceMaker_MoveToNpcAndInteract(4732.036, 7638.048, 4771.921, 166980)
        end
        if PeaceMaker_IsObjectiveCompleted(59756, 2) and not PeaceMaker_IsObjectiveCompleted(59756, 3) then
          PeaceMaker_MoveToNpcAndInteract(4739.135, 7636.599, 4772.251, 166980)
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59756) then
      PeaceMaker_MoveToAndTurnInAcceptQuestReward(4733.161, 7654.011, 4772.556, 166980, 1, 1)
    end
    if PeaceMaker_IsQuestCompleted(59756) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59756) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function FieldSeance()

  local hotspot1 = {  
    [1] = {  y=7539.227,x=4831.257,radius=100,z=4798.064 }
  } 

  local mob1 = { 165909 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59757) and not PeaceMaker_HasQuest(59757) then
      PeaceMaker_AcceptQuest(4738.396, 7650.677, 4772.062, 59757, 165918)
    end
    if not PeaceMaker_IsQuestComplete(59757) and not PeaceMaker_IsQuestCompleted(59757) then
      if PeaceMaker_HasQuest(59757) then
        if not PeaceMaker_IsObjectiveCompleted(59757, 1) then
          PeaceMaker_DisableInternalCombat()
          PeaceMaker_KillAndCheckBuffAndUseItem(hotspot1, mob1, "Normal", 100, 178495, "Weakened")
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59757) then
      PeaceMaker_InteractNpcNearbyAndCompleteQuest(166709)
    end
    if PeaceMaker_IsQuestCompleted(59757) then
      PeaceMaker_EnableInternalCombat()
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59757) then
      PeaceMaker_EnableInternalCombat()
      PeaceMaker_MoveToNextStep()
    end
  end

end

function SpeakToTheDead()
  
  local hotspot1 = {  
    [1] = {  y=7530.476,x=4882.605,radius=100,z=4799.299 }
  } 

  local mob1 = { 165976 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59758) and not PeaceMaker_HasQuest(59758) then
      PeaceMaker_InteractNpcNearbyAndAcceptQuest(166723, 59758)
    end
    if not PeaceMaker_IsQuestComplete(59758) and not PeaceMaker_IsQuestCompleted(59758) then
      if PeaceMaker_HasQuest(59758) then
        if not PeaceMaker_IsObjectiveCompleted(59758, 1) then
          PeaceMaker_DisableInternalCombat()
          PeaceMaker_KillAndCheckBuffAndUseItem(hotspot1, mob1, "Normal", 80, 184313, "Weakened")
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59758) then
      PeaceMaker_InteractNpcNearbyAndCompleteQuest(166709)
    end
    if PeaceMaker_IsQuestCompleted(59758) then
      PeaceMaker_EnableInternalCombat()
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59758) then
      PeaceMaker_EnableInternalCombat()
      PeaceMaker_MoveToNextStep()
    end
  end

end

function SoulInHand()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59915) and not PeaceMaker_HasQuest(59915) then
      if PeaceMaker_GetNpcDistance(166709) > 20 then
        PeaceMaker_AcceptQuest(4706.805, 7660.574, 4772.525, 59915, 166723)
      else
        PeaceMaker_InteractNpcNearbyAndAcceptQuest(166709, 59915)
      end
    end
    if PeaceMaker_IsQuestComplete(59915) then
      PeaceMaker_MoveToAndTurnInAcceptQuestReward(4733.165, 7654.041, 4772.557, 166980, 1, 1)
    end
    if PeaceMaker_IsQuestCompleted(59915) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59915) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LionCage()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59759) and not PeaceMaker_HasQuest(59759) then
      PeaceMaker_AcceptQuest(4733.165, 7654.041, 4772.558, 59759, 166980)
    end
    if not PeaceMaker_IsQuestComplete(59759) and not PeaceMaker_IsQuestCompleted(59759) then
      if PeaceMaker_HasQuest(59759) then
        if not PeaceMaker_IsObjectiveCompleted(59759, 1) then
          PeaceMaker_MoveToAndClickMoveToAndWait(5253.125, 7526.684, 4790.625, 5252.708, 7522.701, 4790.954, 5)
        end
        if PeaceMaker_IsObjectiveCompleted(59759, 1) and not PeaceMaker_IsObjectiveCompleted(59759, 2) then
          PeaceMaker_MoveToAndWait(5319.528, 7600.059, 4895.867, 2)
        end
        if PeaceMaker_IsObjectiveCompleted(59759, 2) and not PeaceMaker_IsObjectiveCompleted(59759, 3) then
          PeaceMaker_MoveToNpcAndInteract(5319.600, 7596.542, 4895.866, 166980)
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59759) then
      PeaceMaker_CompleteQuest(5363.224, 7629.812, 4897.561, 59759, 167833, 1)
    end
    if PeaceMaker_IsQuestCompleted(59759) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59759) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function AfflictorsUndeservedFate()

  local hotspot1 =  {  
    [1] = {  y=7488.301,x=5406.922,radius=60,z=4826.821 },
  } 

  local hotspot2 =  {  
    [1] = {  y=7458.067,x=5267.109,radius=60,z=4784.869 },
    [2] = {  y=7618.729,x=5255.931,radius=60,z=4777.016 },
    [3] =  {  y=7424.125,x=5324.605,radius=60,z=4786.206 }
  } 

  local hotspot3 = {
    [1] = {  y=7630.542,x=5364.052,radius=30,z=4897.562 },
  }

  local mob1 = { 167704, 175269, 167942 }
  local mob2 = { 167834 }

  local obj1 = { 351761 }
  local obj2 = { 351754, 351722 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59760) and not PeaceMaker_HasQuest(59760) then
      PeaceMaker_AcceptQuest(5363.224, 7629.812, 4897.561, 59760, 167833)
    end
    if not PeaceMaker_IsQuestCompleted(59761) and not PeaceMaker_HasQuest(59761) then
      PeaceMaker_AcceptQuest(5363.224, 7629.812, 4897.561, 59761, 167833)
    end
    if PeaceMaker_HasQuest(59761) and not PeaceMaker_IsQuestComplete(59761) then
      if GetItemCount(178553) <= 1 then
        PeaceMaker_Kill(hotspot2, mob1)
      else
        PeaceMaker_Interact(hotspot2, obj1, "Object", 8)
      end
    end
    if PeaceMaker_IsQuestComplete(59761) and PeaceMaker_HasQuest(59760) and not PeaceMaker_IsQuestComplete(59760) then
      if not PeaceMaker_IsObjectiveCompleted(59760, 1) then
        PeaceMaker_Kill(hotspot1, mob2, "Boss")
      end
      if PeaceMaker_IsObjectiveCompleted(59760, 1) and not PeaceMaker_IsObjectiveCompleted(59760, 2) then
        PeaceMaker_Interact(hotspot3, obj2, "Object", 3)
      end
    end
    if PeaceMaker_IsQuestComplete(59761) and PeaceMaker_IsQuestComplete(59760) then
      PeaceMaker_CompleteQuest(5363.224, 7629.812, 4897.561, 59761, 167833, 1)
    end
    if PeaceMaker_IsQuestCompleted(59760) and PeaceMaker_IsQuestComplete(59761) then
      PeaceMaker_CompleteQuest(5363.224, 7629.812, 4897.561, 59761, 167833, 1)
    end
    if PeaceMaker_IsQuestCompleted(59761) and PeaceMaker_IsQuestComplete(59760) then
      PeaceMaker_CompleteQuest(5363.224, 7629.812, 4897.561, 59760, 167833, 1)
    end
    if PeaceMaker_IsQuestCompleted(59760) and PeaceMaker_IsQuestCompleted(59761) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59760) and PeaceMaker_IsQuestCompleted(59761) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function MouthOfMadness()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59776) and not PeaceMaker_HasQuest(59776) then
      PeaceMaker_AcceptQuest(5363.224, 7629.812, 4897.561, 59776, 167833)
    end
    if PeaceMaker_HasQuest(59776) then
      if not PeaceMaker_IsObjectiveCompleted(59776, 1) then
        PeaceMaker_MoveToInteractAndWait(5351.405, 7619.337, 4897.449, 352491, 10)
      end
      if PeaceMaker_IsObjectiveCompleted(59776, 1) and not PeaceMaker_IsObjectiveCompleted(59776, 2) then
        PeaceMaker_MoveToNpcAndInteract(4706.805, 7660.574, 4772.525, 165918)
      end
    end
    if PeaceMaker_IsQuestComplete(59776) then
      PeaceMaker_CompleteQuest(4706.805, 7660.574, 4772.525, 59776, 165918, 1)
    end
    if PeaceMaker_IsQuestCompleted(59776) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59776) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function DownTheRiver()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59762) and not PeaceMaker_HasQuest(59762) then
      PeaceMaker_AcceptQuest(4710.853, 7661.528, 4772.805, 59762, 166980)
    end
    if PeaceMaker_HasQuest(59762) then
      if not PeaceMaker_IsObjectiveCompleted(59762, 1) then
        PeaceMaker_MoveToAndWait(4724.604, 7424.994, 4817.711, 3)
      end 
      if PeaceMaker_IsObjectiveCompleted(59762, 1) and not PeaceMaker_IsObjectiveCompleted(59762, 2) then
        PeaceMaker_MoveToAndWait(4574.096, 7429.990, 4790.059, 1)
      end
    end
    if PeaceMaker_IsQuestComplete(59762) then
      PeaceMaker_CompleteQuest(4561.744, 7433.881, 4791.251, 59762, 166980, 1)
    end
    if PeaceMaker_IsQuestCompleted(59762) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59762) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function BeyondFlesh()
  
  local hotspot1 =  {  
    [1] = {  y=7354.380,x=4585.239,radius=100,z=4795.013 },
  } 

  local hotspot2 = {
    [1] = {  y=7354.380,x=4585.239,radius=100,z=4795.013 },
    [2] = {  y=7407.627,x=4486.198,radius=100,z=4799.453 }
  }

  local mob1 = { 169687 }
  local obj1 = { 352985 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59765) and not PeaceMaker_HasQuest(59765) then
      PeaceMaker_AcceptQuest(4524.148, 7445.407, 4794.091, 59765, 166981)
    end
    if PeaceMaker_HasQuest(59765) and not PeaceMaker_IsQuestCompleted(59766) and not PeaceMaker_HasQuest(59766) then
      PeaceMaker_InteractNpcNearbyAndAcceptQuest(167824, 59766)
    end
    if PeaceMaker_HasQuest(59766) and not PeaceMaker_IsQuestComplete(59766) then
      PeaceMaker_Interact(hotspot1, obj1, "Object", 3)
    end
    if PeaceMaker_IsQuestComplete(59766) and PeaceMaker_HasQuest(59765) and not PeaceMaker_IsQuestComplete(59765) then
      PeaceMaker_Kill(hotspot2, mob1, "Normal")
    end
    if PeaceMaker_IsQuestComplete(59765) and PeaceMaker_IsQuestComplete(59766) then
      PeaceMaker_CompleteQuest(4524.622, 7447.174, 4794.223, 59765, 167824, 1)
    end
    if PeaceMaker_IsQuestCompleted(59765) and PeaceMaker_IsQuestComplete(59766) then
      PeaceMaker_CompleteQuest(4524.622, 7447.174, 4794.223, 59766, 167824, 1)
    end
    if PeaceMaker_IsQuestCompleted(59766) and PeaceMaker_IsQuestComplete(59765) then
      PeaceMaker_CompleteQuest(4524.622, 7447.174, 4794.223, 59765, 167824, 1)
    end
    if PeaceMaker_IsQuestCompleted(59766) and PeaceMaker_IsQuestCompleted(59765) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59766) and PeaceMaker_IsQuestCompleted(59765) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function DrawOutTheDark()
  
  local hotspot1 =  {  
    [1] = {  y=7442.709,x=4522.711,radius=100,z=4793.986 },
  } 

  local mob1 = { 169759 }
  local obj1 = { 353170 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(60644) and not PeaceMaker_HasQuest(60644) then
      PeaceMaker_AcceptQuest(4521.514, 7447.900, 4794.396, 60644, 167824)
    end
    if PeaceMaker_HasQuest(60644) then
      if not PeaceMaker_IsObjectiveCompleted(60644, 1) then
        PeaceMaker_Interact(hotspot1, obj1, "Object", 3)
      end 
      if PeaceMaker_IsObjectiveCompleted(60644, 1) and not PeaceMaker_IsObjectiveCompleted(60644, 2) then
        PeaceMaker_Kill(hotspot1, mob1, "Boss")
      end
    end
    if PeaceMaker_IsQuestComplete(60644) then
      PeaceMaker_CompleteQuest(4521.943, 7447.468, 4794.290, 60644, 168162, 1)
    end
    if PeaceMaker_IsQuestCompleted(60644) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60644) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function PathOfSaliv()
  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59767) and not PeaceMaker_HasQuest(59767) then
      PeaceMaker_AcceptQuest(4518.241, 7446.752, 4794.137, 59767, 166980)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59767, 1) then
      PeaceMaker_MoveToNpcAndInteract(4507.574, 7348.963, 4809.163, 166980)
    end  
    if PeaceMaker_IsObjectiveCompleted(59767, 1) and not PeaceMaker_IsObjectiveCompleted(59767, 2) then
      PeaceMaker_Escourt(168346, 8)
    end  
    if PeaceMaker_IsQuestComplete(59767) then
      PeaceMaker_CompleteQuest(4568.905, 6907.982, 4867.247, 59767, 167833, 1)
    end
    if PeaceMaker_IsQuestCompleted(59767) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59767) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function StandAsOne()

  local hotspot1 = {
    [1] = {  y=6908.615,x=4569.498,radius=100,z=4867.246 },
  }

  local obj1 = { 168478 }
  local mob1 = { 168588, 168585 }

  if PeaceMaker_MapID() == 2364 then
    if not PeaceMaker_IsQuestCompleted(59770) and not PeaceMaker_HasQuest(59770) then
      PeaceMaker_AcceptQuest(4568.905, 6907.982, 4867.247, 59770, 167833)
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59770, 1) then
      --PeaceMaker_Interact(hotspot1, obj1, "Object", 5)
      PeaceMaker_MoveToNpcAndInteract(4569.062, 6911.986, 4868.292, 168478)
    end  
    if PeaceMaker_IsObjectiveCompleted(59770, 1) and not PeaceMaker_IsObjectiveCompleted(59770, 2) then
      PeaceMaker_Kill(hotspot1, mob1, "Boss")
    end  
    if PeaceMaker_IsQuestComplete(59770) then
      PeaceMaker_CompleteQuest(4569.652, 6912.133, 4868.479, 59770, 168478, 1)
    end
    if PeaceMaker_IsQuestCompleted(59770) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59770) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function StrangerInTheEven()
  if PeaceMaker_MapID() == 2222 then
    if PeaceMaker_HasQuest(60129) then
      if not PeaceMaker_IsObjectiveCompleted(60129, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1830.698, 1514.203, 5274.417, 168252)
      end
      if PeaceMaker_IsObjectiveCompleted(60129, 1) and not PeaceMaker_IsObjectiveCompleted(60129, 2) then
        PeaceMaker_MoveToAndWait(-1921.697, 1382.125, 5266.910, 1)
      end
      if PeaceMaker_IsObjectiveCompleted(60129, 1) and PeaceMaker_IsObjectiveCompleted(60129, 2) and not PeaceMaker_IsObjectiveCompleted(60129, 3) then
        PeaceMaker_MoveToNpcAndInteract(-1922.101, 1382.592, 5266.910, 167425)
      end
      if PeaceMaker_IsQuestComplete(60129) then
        PeaceMaker_CompleteQuest(-1922.101, 1382.592, 5266.910, 60129, 167425, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60129) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60129) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function NoPlaceForLiving()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60148) and not PeaceMaker_HasQuest(60148) then
      PeaceMaker_AcceptQuest(-1922.101, 1382.592, 5266.910, 60148, 167425)
    end
    if PeaceMaker_HasQuest(60148) then
      if not PeaceMaker_IsObjectiveCompleted(60148, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1922.101, 1382.592, 5266.910, 167425)
      end
      if PeaceMaker_IsObjectiveCompleted(60148, 1) and not PeaceMaker_IsObjectiveCompleted(60148, 2) then
        PeaceMaker_MoveToNpcAndInteract(-1918.774, 1375.149, 5267.085, 167486)
      end
      if PeaceMaker_IsQuestComplete(60148) then
        PeaceMaker_CompleteQuest(-1918.81, 1375.37, 5267.08, 60148, 167486, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60148) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60148) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function AudienceWithArbiter()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60149) and not PeaceMaker_HasQuest(60149) then
      PeaceMaker_AcceptQuest(-1918.774, 1375.149, 5267.085, 60149, 167486)
    end
    if PeaceMaker_HasQuest(60149) then
      if not PeaceMaker_IsObjectiveCompleted(60149, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1918.774, 1375.149, 5267.085, 167486)
      end
      if PeaceMaker_IsObjectiveCompleted(60149, 1) and not PeaceMaker_IsObjectiveCompleted(60149, 2) then
        if PeaceMaker_GetDistance2D(-1833.580, 1359.560) < 10 then
          PeaceMaker_MoveToNpcAndInteract(-1836.672, 1356.076, 5963.310, 173615)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(60149, 1) and PeaceMaker_IsObjectiveCompleted(60149, 2) and not PeaceMaker_IsObjectiveCompleted(60149, 3) then
        PeaceMaker.Pause = PeaceMaker.Time + 30
      end
      if not PeaceMaker_IsQuestComplete(60149) then
        if PeaceMaker_IsObjectiveCompleted(60149, 1) and PeaceMaker_IsObjectiveCompleted(60149, 2) and PeaceMaker_IsObjectiveCompleted(60149, 3) then
          PeaceMaker_MoveToNpcAndInteract(-1836.672, 1356.076, 5963.310, 173615)
          PeaceMaker.Pause = PeaceMaker.Time + 10
        end
      end
      if PeaceMaker_IsQuestComplete(60149) then
        PeaceMaker_CompleteQuest(-1922.101, 1382.592, 5266.910, 60149, 167425, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60149) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60149) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TetherToHome()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60150) and not PeaceMaker_HasQuest(60150) then
      PeaceMaker_AcceptQuest(-1922.101, 1382.592, 5266.910, 60150, 167425)
    end
    if PeaceMaker_HasQuest(60150) then
      if not PeaceMaker_IsObjectiveCompleted(60150, 1) then
        PeaceMaker_MoveToObjectAndInteract(-1932.737, 1384.819, 5269.162, 355835)
      end
      if PeaceMaker_IsQuestComplete(60150) then
        PeaceMaker_CompleteQuest(-1912.839, 1379.556, 5266.910, 60150, 164079, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60150) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60150) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function ADoorWayToVeil()
  if not PeaceMaker_IsQuestCompleted(60151) and not PeaceMaker_HasQuest(60151) then
    PeaceMaker_AcceptQuest(-1912.839, 1379.556, 5266.910, 60151, 164079)
  end
  if PeaceMaker_HasQuest(60151) then
    if not PeaceMaker_IsObjectiveCompleted(60151, 1) then
      PeaceMaker_MoveToNpcAndInteract(-1908.290, 1381.684, 5266.870, 172378)
    end
    if PeaceMaker_IsObjectiveCompleted(60151, 1) and not PeaceMaker_IsObjectiveCompleted(60151, 2) then
      PeaceMaker_MoveToAndWait(-1836.731, 1531.799, 5274.157, 1)
    end
    if PeaceMaker_IsObjectiveCompleted(60151, 1) and PeaceMaker_IsObjectiveCompleted(60151, 2) and not PeaceMaker_IsObjectiveCompleted(60151, 3) then
      PeaceMaker_MoveToNpcAndInteract(-1835.244, 1530.326, 5274.156, 167682)
    end
    if PeaceMaker_IsObjectiveCompleted(60151, 1) 
      and PeaceMaker_IsObjectiveCompleted(60151, 2) 
      and PeaceMaker_IsObjectiveCompleted(60151, 3) 
      and not PeaceMaker_IsObjectiveCompleted(60151, 4) 
      and not NextSequence
    then
      if PeaceMaker_MapID() == 2222 then
        PeaceMaker_MoveToInteractAndWait(-1855.278, 1538.270, 5274.988, 353822, 15)
        NextSequence = true
      end
      if PeaceMaker_MapID() == 1 then
        PeaceMaker_MoveToInteractAndWait(1465.513, -4518.636, 20.135, 355229, 15)
        NextSequence = true
      end
    end
    if NextSequence then
      if PeaceMaker_MapID() == 1 then
        PeaceMaker_MoveToInteractAndWait(1465.513, -4518.636, 20.135, 355229, 15)
      end
      if PeaceMaker_MapID() == 2222 then
        PeaceMaker_MoveToAndWait(-1922.207, 1380.304, 5266.910, 3)
      end
    end
    if PeaceMaker_IsQuestComplete(60151) then
      PeaceMaker_CompleteQuest(-1922.934, 1379.113, 5266.910, 60151, 167424, 1)
    end
  end
  if PeaceMaker_IsQuestCompleted(60151) then
    if NextSequence then NextSequence = false end
    PeaceMaker_MoveToNextStep()
  end
end

function EternalCity()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60152) and not PeaceMaker_HasQuest(60152) then
      PeaceMaker_AcceptQuest(-1922.934, 1379.113, 5266.910, 60152, 167424)
    end
    if PeaceMaker_HasQuest(60152) then
      if not PeaceMaker_IsObjectiveCompleted(60152, 3) then
        PeaceMaker_MoveToNpcAndInteract(-1740.131, 1378.805, 5267.201, 167738)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(60152, 4) then
        PeaceMaker_MoveToNpcAndInteract(-1730.571, 1212.962, 5266.912, 174564)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(60152, 5) then
        PeaceMaker_MoveToNpcAndInteract(-1834.698, 1158.588, 5270.925, 156688, 3)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(60152, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1931.763, 1183.691, 5267.202, 156768)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(60152, 2) then
        PeaceMaker_MoveToNpcAndInteract(-1828.284, 1064.068, 5274.420, 164173)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(60152, 6) then
        PeaceMaker_MoveToNpcAndInteract(-1922.934, 1379.113, 5266.910, 167424)
        return
      end
      if PeaceMaker_IsQuestComplete(60152) then
        PeaceMaker_CompleteQuest(-1923.000, 1381.710, 5266.910, 60152, 167425, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60152) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60152) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function UnderstandingShadow()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60154) and not PeaceMaker_HasQuest(60154) then
      PeaceMaker_AcceptQuest(-1912.839, 1379.556, 5266.910, 60154, 164079)
    end
    if PeaceMaker_HasQuest(60154) then
      if not PeaceMaker_IsObjectiveCompleted(60154, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1920.045, 1375.782, 5267.061, 167486)
      end
      if PeaceMaker_IsObjectiveCompleted(60154, 2) and not PeaceMaker_IsObjectiveCompleted(60154, 3) then
        PeaceMaker_MoveToNpcAndInteract(-1922.557, 1377.707, 5266.910, 167424)
      end
      if PeaceMaker_IsObjectiveCompleted(60154, 3) and not PeaceMaker_IsObjectiveCompleted(60154, 4) then
        PeaceMaker_MoveToAndWait(-1879.289, 1286.545, 5268.775, 5)
      end
      if PeaceMaker_IsObjectiveCompleted(60154, 4) and not PeaceMaker_IsObjectiveCompleted(60154, 5) then
        PeaceMaker_MoveToInteractAndWait(-1880.142, 1282.542, 5268.975, 365157, 5, "Object")
      end
      if PeaceMaker_IsQuestComplete(60154) then
        PeaceMaker_CompleteQuest(-1880.920, 1276.918, 5446.929, 60154, 175829, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60154) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60154) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function PathToBastion()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(60156) and not PeaceMaker_HasQuest(60156) then
      PeaceMaker_AcceptQuest(-1880.920, 1276.918, 5446.929, 60156, 175829)
    end
    if PeaceMaker_HasQuest(60156) then
      if not PeaceMaker_IsObjectiveCompleted(60156, 1) then
        PeaceMaker_MoveToAndWait(-1831.641, 1192.581, 5450.929, 5)
      end
      if PeaceMaker_IsObjectiveCompleted(60156, 1) and not PeaceMaker_IsObjectiveCompleted(60156, 2) then
        PeaceMaker_MoveToObjectAndInteract(-1832.354, 1192.073, 5450.929, 364443)
        return
      end
      if PeaceMaker_IsQuestComplete(60156) then
        PeaceMaker_Wait(10)
        PeaceMaker_CompleteQuest(-1842.569, 1187.274, 5450.931, 60156, 172416, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(60156) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60156) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function SeekTheAscended()
  if PeaceMaker_MapID() == 2222 then
    if not PeaceMaker_IsQuestCompleted(59773) and not PeaceMaker_HasQuest(59773) then
      PeaceMaker_AcceptQuest(-1825.719, 1189.144, 5450.612, 59773, 175133)
    end
    if PeaceMaker_HasQuest(59773) then
      if UnitOnTaxi("player") then return end
      if not PeaceMaker_IsObjectiveCompleted(59773, 1) then
        PeaceMaker_MoveToNpcAndInteract(-1825.719, 1189.144, 5450.612, 175133)
      end
      if PeaceMaker_IsQuestComplete(59773) then
        PeaceMaker_CompleteQuest(-4261.060, -3921.776, 6561.321, 59773, 166227, 1)
      end
    end
    if PeaceMaker_IsQuestCompleted(59773) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59773) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LoadBastionProfile()
  if PeaceMaker_IsQuestCompleted(59773) then
    PeaceMaker_LoadNextProfile("51_53_H")
  end
end