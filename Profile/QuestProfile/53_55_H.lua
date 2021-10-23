QuestOrder = {
  [1] = { Quest_Name = "WantPeaceUntilLand", Quest_Settings = 1 },
  [2] = { Quest_Name = "LandUntil", Quest_Settings = 2 }
}

function WantPeaceUntilLand()

  local hotspot = { [1] = { x = 2855.58, y = -2554.95, z = 3260.37, radius = 100} }
  
  if not PeaceMaker_HasQuest(57390) and not PeaceMaker_IsQuestCompleted(57390) then
    --PeaceMaker_AcceptQuest(3066.24, -2546, 3293.16, 57390, 164244)
    PeaceMaker_SearchNpcAndAcceptQuest(57390, 164244)
    return
  end

  if PeaceMaker_HasQuest(57390) and not PeaceMaker_IsQuestCompleted(57390) then
    if not PeaceMaker_IsObjectiveCompleted(57390, 1) then
      PeaceMaker_Kill(hotspot, nil, "Any")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(57390) then
    PeaceMaker_CompleteQuest(2956.51, -2544.82, 3273.06, 57390, 164244)
    return
  end

  if not PeaceMaker_HasQuest(60020) and not PeaceMaker_IsQuestCompleted(60020) then
    PeaceMaker_AcceptQuest(2956.51, -2544.82, 3273.06, 60020, 164244)
    return
  end

  if PeaceMaker_HasQuest(60020) and not PeaceMaker_IsQuestCompleted(60020) then
    if not PeaceMaker_IsObjectiveCompleted(60020, 1) then
      PeaceMaker_Kill(hotspot, nil, "AnyElite")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60020) then
    PeaceMaker_CompleteQuest(2956.51, -2544.82, 3273.06, 60020, 164244)
    return
  end

  if not PeaceMaker_HasQuest(60021) and not PeaceMaker_IsQuestCompleted(60021) then
    PeaceMaker_AcceptQuest(2956.51, -2544.82, 3273.06, 60021, 164244)
    return
  end
  
  if PeaceMaker_HasQuest(60021) and not PeaceMaker_IsQuestCompleted(60021) then
    if not PeaceMaker_IsObjectiveCompleted(60021, 1) then
      PeaceMaker_KillAroundPos(2803.85, -2457.11, 3259.28, 100, 166658, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(60021, 2) then
      PeaceMaker_KillAroundPos(2858.27, -2626.2, 3259.78, 100, 166649, "Boss")
      return
    end
  end

  if PeaceMaker_IsQuestComplete(60021) then
    PeaceMaker_CompleteQuest(2956.51, -2544.82, 3273.06, 60021, 164244)
    return
  end

  if not PeaceMaker_HasQuest(57425) and not PeaceMaker_IsQuestCompleted(57425) then
    PeaceMaker_AcceptQuest(2956.51, -2544.82, 3273.06, 57425, 164244)
    return
  end

  if PeaceMaker_HasQuest(57425) and not PeaceMaker_IsQuestCompleted(57425) then
    if not PeaceMaker_IsObjectiveCompleted(57425, 1) then
      PeaceMaker_KillAroundPos(2862.17, -2544.87, 3260.27, 100, 166975, "Boss")
      return
    end
    if PeaceMaker_IsQuestComplete(57425) then
      PeaceMaker_CompleteQuest(2415.42, -2421.23, 3282.34, 57425, 162069)
    end
    return
  end

  PeaceMaker_MoveToNextStep()

end

function LandUntil()

  if not PeaceMaker_HasQuest(57511) and not PeaceMaker_IsQuestCompleted(57511) then
    PeaceMaker_AcceptQuest(2415.42, -2421.23, 3282.34, 57511, 162069)
    return
  end

  if not PeaceMaker_HasQuest(57512) and not PeaceMaker_IsQuestCompleted(57512) then
    PeaceMaker_InteractNpcNearbyAndAcceptQuest(167220, 57512)
    return
  end

end