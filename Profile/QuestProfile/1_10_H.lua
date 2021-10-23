QuestOrder = {
  [1] = { Quest_Name = "MurlocManic", Quest_Settings = 2 },
  [2] = { Quest_Name = "EmergencyFirstAid", Quest_Settings = 2 },
  [3] = { Quest_Name = "FindingLostExp", Quest_Settings = 2 },
  [4] = { Quest_Name = "CookingMeat", Quest_Settings = 2 },
  [5] = { Quest_Name = "CombatTactics", Quest_Settings = 2 },
  [6] = { Quest_Name = "NorthBound", Quest_Settings = 2 },
  [7] = { Quest_Name = "TamingAndQuailBoar", Quest_Settings = 2 },
  [8] = { Quest_Name = "TamingAndQuailBoar2", Quest_Settings = 2 },
  [9] = { Quest_Name = "TheChopper", Quest_Settings = 2 },
  [10] = { Quest_Name = "Resizing", Quest_Settings = 2 },
  [11] = { Quest_Name = "TheRedeather", Quest_Settings = 2 },
  [12] = { Quest_Name = "StockUpOnSupplies", Quest_Settings = 2 },
  [13] = { Quest_Name = "WestWardBound", Quest_Settings = 2 },
  [14] = { Quest_Name = "LurkInThePit", Quest_Settings = 2 },
  [15] = { Quest_Name = "PaladinService", Quest_Settings = 2 },
  [16] = { Quest_Name = "DivineShield", Quest_Settings = 2 },
  [17] = { Quest_Name = "FreeTheLight", Quest_Settings = 2 },
  [18] = { Quest_Name = "HarpyProblem", Quest_Settings = 2 },
  [19] = { Quest_Name = "HarpyCullingTotemResuceHerbert", Quest_Settings = 2 },
  [20] = { Quest_Name = "HarpyCulingAndPurgeTotem", Quest_Settings = 2 },
  [21] = { Quest_Name = "MessageToBase", Quest_Settings = 2 },
  [22] = { Quest_Name = "TheDarkMaulCitadel", Quest_Settings = 2 },
  [23] = { Quest_Name = "RightBeneathTheEye", Quest_Settings = 2 },
  [24] = { Quest_Name = "LikeOgreSlayCatapultControl", Quest_Settings = 2 },
  [25] = { Quest_Name = "LikeOgreSlayCatapultControl2", Quest_Settings = 2 },
  [26] = { Quest_Name = "DarkCitadelDungeon", Quest_Settings = 2 },
  [27] = { Quest_Name = "EndOfTheBeginning", Quest_Settings = 2 }
}

function MurlocManic()

  local hotspot1 = {  
    [1] = {  y=-2551.162,x=-354.782,radius=100,z=6.581 }
  } 

  local mob1 = { 150228 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59929) and not PeaceMaker_HasQuest(59929) then
      PeaceMaker_AcceptQuest(-437.188, -2610.781, 0.525, 59929, 166782)
    end
    if PeaceMaker_HasQuest(59929) then
      if not PeaceMaker_IsObjectiveCompleted(59929, 1) then
        PeaceMaker_Kill(hotspot1, mob1, "Normal", 80)
      end
      if PeaceMaker_IsQuestComplete(59929) then
        PeaceMaker_CompleteQuest(-434.351, -2608.984, 0.460, 59929, 166782)
      end
    end
    if PeaceMaker_IsQuestCompleted(59929) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59929) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function EmergencyFirstAid()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59930) and not PeaceMaker_HasQuest(59930) then
      PeaceMaker_AcceptQuest(-437.188, -2610.781, 0.525, 59930, 166782)
    end
    if PeaceMaker_HasQuest(59930) then
      if not PeaceMaker_IsObjectiveCompleted(59930, 1) then
        PeaceMaker_MoveToUseItemOnNPC(-421.028, -2600.969, 0.494, 168410, 166796)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59930, 2) then
        PeaceMaker_MoveToUseItemOnNPC(-446.532, -2605.397, 0.534, 168410, 166786)
        return
      end
      if not PeaceMaker_IsObjectiveCompleted(59930, 3) then
        PeaceMaker_MoveToUseItemOnNPC(-429.418, -2594.526, 0.103, 168410, 166791)
        return
      end
      if PeaceMaker_IsQuestComplete(59930) then
        PeaceMaker_CompleteQuest(-434.351, -2608.984, 0.460, 59930, 166782)
      end
    end
    if PeaceMaker_IsQuestCompleted(59930) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59930) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function FindingLostExp()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59931) and not PeaceMaker_HasQuest(59931) then
      PeaceMaker_AcceptQuest(-437.188, -2610.781, 0.525, 59931, 166782)
    end
    if PeaceMaker_HasQuest(59931) then
      if not PeaceMaker_IsObjectiveCompleted(59931, 1) then
        PeaceMaker_MoveToAndWait(-250.562, -2490.452, 17.676, 1)
      end
    end
    if PeaceMaker_IsQuestComplete(59931) then
      PeaceMaker_CompleteQuest(-246.262, -2490.177, 18.036, 59931, 166854)
    end
    if PeaceMaker_IsQuestCompleted(59931) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59931) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function CookingMeat()
  
  local hotspot1 = {  
    [1] = {  y=-2438.997,x=-231.387,radius=60,z=17.707 },
    [2] = {  y=-2504.872,x=-201.278,radius=100,z=21.281 }
  } 

  local mob1 = { 161131, 161133, 161130 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59932) and not PeaceMaker_HasQuest(59932) then
      PeaceMaker_AcceptQuest(-249.647, -2492.695, 18.027, 59932, 166906)
    end
    if PeaceMaker_HasQuest(59932) then
      if not PeaceMaker_IsObjectiveCompleted(59932, 1) then
        PeaceMaker_Kill(hotspot1, mob1, "Normal")
      end
      if PeaceMaker_IsObjectiveCompleted(59932, 1) and not PeaceMaker_IsObjectiveCompleted(59932, 2) then
        PeaceMaker_MoveToObjectAndInteract(-248.043, -2488.226, 17.904, 349962)
      end
    end
    if PeaceMaker_IsQuestComplete(59932) then
      PeaceMaker_CompleteQuest(-245.410, -2492.089, 18.240, 59932, 166854)
    end
    if PeaceMaker_IsQuestCompleted(59932) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59932) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function CombatTactics()

  local hotspot1 = {  
    [1] = {  y=-2471.110,x=-194.093,radius=60,z=17.952 }
  } 

  local mob1 = { 166918 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59933) and not PeaceMaker_HasQuest(59933) then
      PeaceMaker_AcceptQuest(-249.647, -2492.695, 18.027, 59933, 166906)
    end
    if PeaceMaker_HasQuest(59933) then
      if not PeaceMaker_IsObjectiveCompleted(59933, 1) then
        PeaceMaker_Kill(hotspot1, mob1, "Normal")
      end
    end
    if PeaceMaker_IsQuestComplete(59933) then
      PeaceMaker_CompleteQuest(-250.208, -2491.954, 17.791, 59933, 166906)
    end
    if PeaceMaker_IsQuestCompleted(59933) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59933) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function NorthBound()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59935) and not PeaceMaker_HasQuest(59935) then
      PeaceMaker_AcceptQuest(-245.871, -2490.040, 18.100, 59935, 175030)
    end
    if PeaceMaker_IsQuestComplete(59935) then
      PeaceMaker_CompleteQuest(-141.160, -2636.719, 48.328, 59935, 166996)
    end
    if PeaceMaker_IsQuestCompleted(59935) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59935) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TamingAndQuailBoar()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59938) and not PeaceMaker_HasQuest(59938) then
      PeaceMaker_AcceptQuestGossip(-141.493, -2639.488, 48.698, 59938, 166996)
    end
    if PeaceMaker_HasQuest(59938) then
      if not PeaceMaker_IsQuestCompleted(59939) and not PeaceMaker_HasQuest(59939) then
        PeaceMaker_AcceptQuestGossip(-141.493, -2639.488, 48.698, 59939, 166996)
      end
    end
    if (PeaceMaker_HasQuest(59938) and PeaceMaker_HasQuest(59939)) 
      or (PeaceMaker_IsQuestCompleted(59938) and PeaceMaker_IsQuestCompleted(59939))
      or (PeaceMaker_HasQuest(59938) and PeaceMaker_IsQuestCompleted(59939))
      or (PeaceMaker_HasQuest(59939) and PeaceMaker_IsQuestCompleted(59938)) 
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(59938) and PeaceMaker_HasQuest(59939)) 
      or (PeaceMaker_IsQuestCompleted(59938) and PeaceMaker_IsQuestCompleted(59939))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TamingAndQuailBoar2()

  local hotspot1 = {  
    [1] = {  y=-2625.3,x=-43.42,radius=100,z=53.692 },
    [2] = {  y=-2604.911,x=-1.207,radius=100,z=54.749 },
  }

  local hotspot2 = {
    [1] = {  y=-2527.904,x=29.051,radius=100,z=70.955 },
  }

  local mob1 = { 150238, 150237 }
  local mob2 = { 151091 }

  if PeaceMaker_MapID() == 2175 then
    if PeaceMaker_HasQuest(59939) then
      if not PeaceMaker_IsQuestComplete(59939) then
        PeaceMaker_Kill(hotspot1, mob1, "Normal")
        return
      end
    end
    if PeaceMaker_HasQuest(59938) and PeaceMaker_IsQuestComplete(59939) and not PeaceMaker_IsQuestComplete(59938) then
      PeaceMaker_Kill(hotspot2, mob2, "Boss")
      return
    end
    if PeaceMaker_IsQuestComplete(59939) then
      PeaceMaker_CompleteQuest(99.483, -2420.865, 90.294, 59939, 167020)
      return
    end
    if PeaceMaker_IsQuestComplete(59938) then
      PeaceMaker_CompleteQuest(99.758, -2417.999, 90.417, 59938, 167019)
      return
    end
    if PeaceMaker_IsQuestCompleted(59938) and PeaceMaker_IsQuestCompleted(59939) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59938) and PeaceMaker_IsQuestCompleted(59939) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function TheChopper()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59940) and not PeaceMaker_HasQuest(59940) then
      PeaceMaker_AcceptQuest(99.192, -2418.361, 90.426, 59940, 167019)
    end
    if PeaceMaker_HasQuest(59940) and not PeaceMaker_IsQuestComplete(59940) then
      if not PeaceMaker_IsObjectiveCompleted(59940, 1) then
        PeaceMaker_MoveToInteractAndWait(108.485, -2415.443, 90.211, 167027, 5, "Unit")
      end
    end
    if PeaceMaker_IsQuestComplete(59940) then
      if not UnitInVehicle("player") then
        PeaceMaker_CompleteQuest(99.192, -2418.361, 90.426, 59940, 167019)
      end
    end
    if PeaceMaker_IsQuestCompleted(59940) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59940) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function Resizing()

  local hotspot1 = {  
    [1] = {  y=-2443.079,x=128.648,radius=60,z=94.964 }
  } 

  local mob1 = { 156716 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59941) and not PeaceMaker_HasQuest(59941) then
      PeaceMaker_AcceptQuest(99.192, -2418.361, 90.426, 59941, 167019)
    end
    if PeaceMaker_HasQuest(59941) and not PeaceMaker_IsQuestComplete(59941) then
      PeaceMaker_UseItem(hotspot1, mob1, 178051, 12)
    end
    if PeaceMaker_IsQuestComplete(59941) then
      PeaceMaker_CompleteQuest(102.613, -2420.632, 90.118, 59941, 167021)
    end
    if PeaceMaker_IsQuestCompleted(59941) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59941) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function TheRedeather()
  
  local hotspot = {
    [1] = {  y=-2262.152,x=240.887,radius=80,z=83.381 }
  }

  local mob = { 162817 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59942) and not PeaceMaker_HasQuest(59942) then
      PeaceMaker_AcceptQuest(102.613, -2420.632, 90.118, 59942, 167019)
    end
    if PeaceMaker_HasQuest(59942) and not PeaceMaker_IsQuestComplete(59942) then
      if not PeaceMaker_IsObjectiveCompleted(59942, 1) then
        PeaceMaker_MoveToInteractAndWait(108.485, -2415.443, 90.211, 167142, 5, "Unit")
      end
      if PeaceMaker_IsObjectiveCompleted(59942, 1) and not PeaceMaker_IsObjectiveCompleted(59942, 2) then
        PeaceMaker_HardCodedFlyingBombQuest()
      end
      if PeaceMaker_IsObjectiveCompleted(59942, 1) and PeaceMaker_IsObjectiveCompleted(59942, 2) and not PeaceMaker_IsObjectiveCompleted(59942, 3)  then
        PeaceMaker_Kill(hotspot, mob, "Boss")
      end
    end
    if PeaceMaker_IsQuestComplete(59942) then
      PeaceMaker_CompleteQuest(230.066, -2294.636, 80.896, 59942, 167128)
    end
    if PeaceMaker_IsQuestCompleted(59942) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59942) then
      PeaceMaker_MoveToNextStep()
    end
  end

end

function StockUpOnSupplies()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59950) and not PeaceMaker_HasQuest(59950) then
      PeaceMaker_AcceptQuest(187.798, -2283.200, 81.829, 59950, 167212)
    end
    if PeaceMaker_HasQuest(59950) then
      if not PeaceMaker_IsObjectiveCompleted(59950, 1) then
        if not MerchantFrame:IsVisible() then
          PeaceMaker_MoveToNpcAndInteract(179.673, -2291.758, 81.846, 167213)
        else
          if PeaceMaker.Time > PeaceMaker.Pause then
            PeaceMaker_SellAllItem(2)
            BuyMerchantItem(1)
            PeaceMaker.Pause = PeaceMaker.Time + 1
          end
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59950) then
      PeaceMaker_CompleteQuest(187.267, -2284.189, 81.819, 59950, 167212)
    end
    if PeaceMaker_IsQuestCompleted(59950) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59950) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function WestWardBound()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59948) and not PeaceMaker_HasQuest(59948) then
      PeaceMaker_AcceptQuest(160.599, -2307.405, 84.034, 59948, 167221)
    end
    if PeaceMaker_IsQuestComplete(59948) then
      PeaceMaker_CompleteQuest(92.706, -2249.404, 94.770, 59948, 167225)
    end
    if PeaceMaker_IsQuestCompleted(59948) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59948) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LurkInThePit()

  local hotspot = {  
    [1] = {  y=-2280.642,x=87.406,radius=100,z=58.16 },
    [2] = {  y=-2218.273,x=106.046,radius=100,z=31.465 },
    [3] = {  y=-2191.891,x=63,radius=100,z=23.375 },
    [4] = {  y=-2196.544,x=34.749,radius=100,z=17.731 },
    [5] = {  y=-2265.943,x=49.402,radius=100,z=0.216 }
    --[5] = {  y=-2195.300,x=35.346,radius=100,z=17.963 },
  } 

  local hotspot1 = {
    [1] = {  y=-2158.119,x=84.607,radius=100,z=-29.770 }
  }

  local obj = { 350796 }
  local mob = { 156900 }

  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59949) and not PeaceMaker_HasQuest(59949) then
      PeaceMaker_AcceptQuest(92.016, -2246.911, 94.414, 59949, 167225)
    end
    if PeaceMaker_HasQuest(59949) then
      if not PeaceMaker_IsObjectiveCompleted(59949, 1) then
        PeaceMaker_Interact(hotspot, obj, "Object", 5)
      end
      if PeaceMaker_IsObjectiveCompleted(59949, 1) and not PeaceMaker_IsObjectiveCompleted(59949, 2) then
        PeaceMaker_Kill(hotspot1, mob, "Boss")
      end
      if PeaceMaker_IsObjectiveCompleted(59949, 1) and PeaceMaker_IsObjectiveCompleted(59949, 2) and not PeaceMaker_IsObjectiveCompleted(59949, 3) then
        if not InteractDruidHouse and not lb.UnitHasMovementFlag("player", 1024) then
          PeaceMaker_MoveToNpcAndInteract(73.405, -2134.268, -30.134, 167254)
          InteractDruidHouse = true
          C_Timer.After(4, function() InteractDruidHouse = false end)
        end
      end
    end
    if PeaceMaker_IsQuestComplete(59949) then
      PeaceMaker_CompleteQuest(186.361, -2284.253, 81.849, 59949, 167212)
    end
    if PeaceMaker_IsQuestCompleted(59949) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59949) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function PaladinService()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59958) and not PeaceMaker_HasQuest(59958) then
      PeaceMaker_AcceptQuest(183.418, -2278.021, 81.932, 59958, 167216)
    end
    if PeaceMaker_HasQuest(59958) then
      if not PeaceMaker_IsObjectiveCompleted(59958, 1) then
        PeaceMaker_MoveToNpcAndInteract(257.307, -2464.847, 119.684, 167179)
      end
    end
    if PeaceMaker_IsQuestComplete(59958) then
      PeaceMaker_CompleteQuest(257.307, -2464.847, 119.684, 59958, 167179)
    end
    if PeaceMaker_IsQuestCompleted(59958) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59958) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function DivineShield()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(60174) and not PeaceMaker_HasQuest(60174) then
      PeaceMaker_AcceptQuest(257.307, -2464.847, 119.684, 60174, 167179)
    end
    if PeaceMaker_HasQuest(60174) then
      if not PeaceMaker_IsObjectiveCompleted(60174, 1) then
        if PeaceMaker_GetDistance2D(254.687, -2458.031) < 4 then
          lb.Unlock(CastSpellByName, "Divine Shield")
        else
          PeaceMaker_MoveToAndWait(254.687, -2458.031, 119.633)
        end
      end
      if PeaceMaker_IsObjectiveCompleted(60174, 1) and not PeaceMaker_IsObjectiveCompleted(60174, 2) then
        PeaceMaker_MoveToObjectAndInteract(244.405, -2449.057, 118.099, 351423, 5)
      end
    end
    if PeaceMaker_IsQuestComplete(60174) then
      PeaceMaker_CompleteQuest(257.307, -2464.847, 119.684, 60174, 167179)
    end
    if PeaceMaker_IsQuestCompleted(60174) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(60174) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function FreeTheLight()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(54933) and not PeaceMaker_HasQuest(54933) then
      PeaceMaker_AcceptQuest(301.391, -2486.314, 115.183, 54933, 157114)
    end
    if PeaceMaker_HasQuest(54933) then
      if not PeaceMaker_IsObjectiveCompleted(54933, 1) then
        PeaceMaker_MoveToObjectAndInteract(312.539, -2462.458, 116.525, 326716, 3)
      end
      if PeaceMaker_IsObjectiveCompleted(54933, 1) and not PeaceMaker_IsObjectiveCompleted(54933, 2) then
        PeaceMaker_MoveToObjectAndInteract(323.448, -2495.652, 116.571, 326717, 3)
      end
      if PeaceMaker_IsObjectiveCompleted(54933, 1) and PeaceMaker_IsObjectiveCompleted(54933, 2) and not PeaceMaker_IsObjectiveCompleted(54933, 3) then
        PeaceMaker_MoveToObjectAndInteract(291.083, -2511.909, 116.382, 326718, 3)
      end
      if PeaceMaker_IsObjectiveCompleted(54933, 1) and PeaceMaker_IsObjectiveCompleted(54933, 2) and PeaceMaker_IsObjectiveCompleted(54933, 3) and not PeaceMaker_IsObjectiveCompleted(54933, 4) then
        PeaceMaker_MoveToObjectAndInteract(279.667, -2475.907, 116.128, 326719, 3)
      end
    end
    if PeaceMaker_IsQuestComplete(54933) then
      PeaceMaker_CompleteQuest(301.391, -2486.314, 115.183, 54933, 157114)
    end
    if PeaceMaker_IsQuestCompleted(54933) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(54933) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function HarpyProblem()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59943) and not PeaceMaker_HasQuest(59943) then
      PeaceMaker_AcceptQuest(257.260, -2337.651, 80.980, 55196, 167219)
    end
    if PeaceMaker_IsQuestComplete(59943) then
      PeaceMaker_CompleteQuest(391.212, -2443.717, 125.106, 59943, 167291)
    end
    if PeaceMaker_IsQuestCompleted(59943) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59943) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function HarpyCullingTotemResuceHerbert()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59945) and not PeaceMaker_HasQuest(59945) then
      PeaceMaker_AcceptQuest(391.212, -2443.717, 125.106, 59945, 167291)
      return
    end
    if not PeaceMaker_IsQuestCompleted(59946) and not PeaceMaker_HasQuest(59946) then
      PeaceMaker_AcceptQuest(391.212, -2443.717, 125.106, 59946, 167291)
      return
    end
    if not PeaceMaker_IsQuestCompleted(59944) and not PeaceMaker_HasQuest(59944) then
      PeaceMaker_AcceptQuest(392.469, -2440.226, 125.389, 59944, 167290)
      return
    end
    if (PeaceMaker_HasQuest(59944) and PeaceMaker_HasQuest(59945) and PeaceMaker_HasQuest(59946)) 
      or (PeaceMaker_IsQuestCompleted(59944) and PeaceMaker_IsQuestCompleted(59945) and PeaceMaker_IsQuestCompleted(59946))
      or (PeaceMaker_HasQuest(59944) and PeaceMaker_IsQuestCompleted(59945))
      or (PeaceMaker_HasQuest(59945) and PeaceMaker_IsQuestCompleted(59944)) 
      or (PeaceMaker_HasQuest(59946) and PeaceMaker_IsQuestCompleted(59944) and PeaceMaker_IsQuestCompleted(59945))
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(59944) and PeaceMaker_HasQuest(59945) and PeaceMaker_HasQuest(59946)) 
      or (PeaceMaker_IsQuestCompleted(59944) and PeaceMaker_IsQuestCompleted(59945) and PeaceMaker_IsQuestCompleted(59946))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function HarpyCulingAndPurgeTotem()
  
  local hotspot1 = {  
    [1] = {  y=-2501.342,x=457.26,radius=100,z=145.103 },
    [2] = {  y=-2563.815,x=506.6,radius=100,z=157.9 },
    [3] = {  y=-2530.703,x=535.702,radius=100,z=154.54 }
  } 

  local hotspot2 = {  
    [1] = {  y=-2480.944,x=432.591,radius=100,z=140.839 },
    [2] = {  y=-2506.07,x=459.434,radius=100,z=146.141 },
    [3] = {  y=-2570.88,x=493.359,radius=100,z=155.94 },
    [4] = {  y=-2526.377,x=540.586,radius=100,z=154.187 },
    [5] = {  y=-2452.13,x=488.988,radius=100,z=151.208 }
  } 

  local mob1 = { 152843, 152998, 152571}
  local obj = { 350803 }

  if PeaceMaker_HasQuest(59945) and not PeaceMaker_IsQuestComplete(59945) then
    PeaceMaker_Kill(hotspot1, mob1, "Normal")
    return
  end

  if PeaceMaker_HasQuest(59946) and PeaceMaker_IsQuestComplete(59945) and not PeaceMaker_IsQuestComplete(59946) then
    PeaceMaker_Interact(hotspot2, obj, "Object", 5)
    return
  end

  if PeaceMaker_IsQuestComplete(59945) and PeaceMaker_IsQuestComplete(59946) and not PeaceMaker_IsQuestComplete(59944) then
    PeaceMaker_MoveToNpcAndInteract(496.026, -2354.072, 160.407, 167298)
    return
  end

  if PeaceMaker_IsQuestComplete(59945) then
    PeaceMaker_CompleteQuest(391.212, -2443.717, 125.106, 59945, 167291)
    return
  end

  if PeaceMaker_IsQuestComplete(59946) then
    PeaceMaker_CompleteQuest(391.212, -2443.717, 125.106, 59946, 167291)
    return
  end

  if PeaceMaker_IsQuestComplete(59944) then
    PeaceMaker_CompleteQuest(392.469, -2440.226, 125.389, 59944, 167182)
    return
  end

  if PeaceMaker_IsQuestCompleted(59945) and PeaceMaker_IsQuestCompleted(59946) and PeaceMaker_IsQuestCompleted(59944) then
    PeaceMaker_MoveToNextStep()
  end

end

function MessageToBase()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59947) and not PeaceMaker_HasQuest(59947) then
      PeaceMaker_AcceptQuest(392.324, -2441.212, 125.376, 59947, 167290)
    end
    if PeaceMaker_IsQuestComplete(59947) then
      PeaceMaker_CompleteQuest(186.832, -2284.057, 81.844, 59947, 167212)
    end
    if PeaceMaker_IsQuestCompleted(59947) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59947) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function TheDarkMaulCitadel()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59975) and not PeaceMaker_HasQuest(59975) then
      PeaceMaker_AcceptQuest(187.013, -2282.858, 81.847, 59975, 167212)
    end
    if PeaceMaker_IsQuestComplete(59975) then
      PeaceMaker_CompleteQuest(320.133, -2174.330, 106.174, 59975, 167596)
    end
    if PeaceMaker_IsQuestCompleted(59975) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59975) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function RightBeneathTheEye()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59978) and not PeaceMaker_HasQuest(59978) then
      PeaceMaker_AcceptQuest(320.205, -2174.609, 106.162, 59978, 167596)
    end
    if PeaceMaker_HasQuest(59978) and not PeaceMaker_IsQuestComplete(59978) then
      if not PeaceMaker_IsObjectiveCompleted(59978, 1) then
        PeaceMaker_MoveToNpcAndInteract(317.083, -2173.408, 105.906, 167598)
      end
      if PeaceMaker_IsObjectiveCompleted(59978, 1) and not PeaceMaker_IsObjectiveCompleted(59978, 2) then
        PeaceMaker_MoveToAndWait(434.744, -2061.084, 132.940, 1)
      end
      if PeaceMaker_IsObjectiveCompleted(59978, 1) and PeaceMaker_IsObjectiveCompleted(59978, 2) and not PeaceMaker_IsObjectiveCompleted(59978, 3) then
        PeaceMaker_MoveToAndWait(578.407, -2064.823, 159.545, 1)
      end
      if PeaceMaker_IsObjectiveCompleted(59978, 1) and PeaceMaker_IsObjectiveCompleted(59978, 2) and PeaceMaker_IsObjectiveCompleted(59978, 3) and not PeaceMaker_IsObjectiveCompleted(59978, 4) then
        PeaceMaker_TargetUnitAndEmo(153580, "/wave")
      end
      if PeaceMaker_IsObjectiveCompleted(59978, 1) 
        and PeaceMaker_IsObjectiveCompleted(59978, 2) 
        and PeaceMaker_IsObjectiveCompleted(59978, 3) 
        and PeaceMaker_IsObjectiveCompleted(59978, 4)
        and not PeaceMaker_IsObjectiveCompleted(59978, 5)
      then
        PeaceMaker_MoveToAndWait(706.169, -1876.314, 186.882, 1)
      end
    end
    if PeaceMaker_IsQuestComplete(59978) then
      PeaceMaker_CompleteQuest(702.284, -1879.990, 186.508, 59978, 167633)
    end
    if PeaceMaker_IsQuestCompleted(59978) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_IsQuestCompleted(59978) then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LikeOgreSlayCatapultControl()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59979) and not PeaceMaker_HasQuest(59979) then
      PeaceMaker_AcceptQuest(700.251, -1881.132, 186.508, 59979, 167632)
    end
    if PeaceMaker_HasQuest(59979) then
      if not PeaceMaker_IsQuestCompleted(59981) and not PeaceMaker_HasQuest(59981) then
        PeaceMaker_AcceptQuest(700.251, -1881.132, 186.508, 59981, 167633)
      end
    end
    if PeaceMaker_HasQuest(59981) then
      if not PeaceMaker_IsQuestCompleted(59980) and not PeaceMaker_HasQuest(59980) then
        PeaceMaker_AcceptQuest(701.401, -1882.922, 186.508, 59980, 167631)
      end
    end
    if (PeaceMaker_HasQuest(59979) and PeaceMaker_HasQuest(59981) and PeaceMaker_HasQuest(59980)) 
      or (PeaceMaker_IsQuestCompleted(59979) and PeaceMaker_IsQuestCompleted(59981) and PeaceMaker_IsQuestCompleted(59980))
      or (PeaceMaker_HasQuest(59979) and PeaceMaker_IsQuestCompleted(59981))
      or (PeaceMaker_HasQuest(59981) and PeaceMaker_IsQuestCompleted(59979)) 
      or (PeaceMaker_HasQuest(59980) and PeaceMaker_IsQuestCompleted(59981) and PeaceMaker_IsQuestCompleted(59979))
    then
      PeaceMaker_MoveToNextStep()
    end
  else
    if (PeaceMaker_HasQuest(59979) and PeaceMaker_HasQuest(59981) and PeaceMaker_HasQuest(59980)) 
      or (PeaceMaker_IsQuestCompleted(59979) and PeaceMaker_IsQuestCompleted(59981) and PeaceMaker_IsQuestCompleted(59980))
    then
      PeaceMaker_MoveToNextStep()
    end
  end
end

function LikeOgreSlayCatapultControl2()
  
  local hotspot1 = {  
    [1] = {  y=-2090.043,x=619.44,radius=50,z=158.908 },
    [2] = {  y=-2039.509,x=542.361,radius=50,z=149.907 },
    [3] = {  y=-2030.221,x=476.925,radius=50,z=143.008 },
    [4] = {  y=-1946.865,x=537.404,radius=50,z=168.815 },
    [5] = {  y=-1978.485,x=596.252,radius=50,z=170.764 }
  } 

  local hotspot2 = {  
    [1] = {  y=-2029.393,x=481.127,radius=100,z=143.018 },
    [2] = {  y=-2075.737,x=559.455,radius=100,z=158.44 },
    [3] = {  y=-2098.938,x=623.537,radius=100,z=158.715 }
  } 

  local hotspot3 = {
    [1] = {  y=-1870.275,x=707.840,radius=100,z=186.882 },
  }

  local hotspotb1 = {
    [1] = {  y=-2014.151,x=617.656,radius=100,z=173.675 },
  }

  local hotspotb2 = {
    [1] = {  y=-2110.855,x=642.337,radius=100,z=159.299 },
  }

  local hotspotb3 = {
    [1] = {  y=-1984.690,x=505.544,radius=100,z=144.612 },
  }

  local mob1 = { 153239, 153242 }
  local obj = { 351477 }
  local obj2 = { 351476 }
  local boss1 = { 153582 }
  local boss2 = { 153583 }
  local boss3 = { 153581 }

  if PeaceMaker_HasQuest(59979) and not PeaceMaker_IsQuestComplete(59979) then
    PeaceMaker_Kill(hotspot1, mob1, "Normal")
    return
  end

  if PeaceMaker_HasQuest(59980) and PeaceMaker_IsQuestComplete(59979) and not PeaceMaker_IsQuestComplete(59980) then
    PeaceMaker_Interact(hotspot2, obj, "Object", 11)
    return
  end

  if PeaceMaker_IsQuestComplete(59980) and PeaceMaker_IsQuestComplete(59979) and not PeaceMaker_IsQuestComplete(59981) then
    if not PeaceMaker_IsObjectiveCompleted(59981, 2) then
      PeaceMaker_Kill(hotspotb1, boss1, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59981, 1) then
      PeaceMaker_Kill(hotspotb2, boss2, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59981, 3) then
      PeaceMaker_Kill(hotspotb3, boss3, "Boss")
      return
    end
    if not PeaceMaker_IsObjectiveCompleted(59981, 4) then
      PeaceMaker_Interact(hotspot3, obj2, "Object", 4)
      return
    end
    return
  end

  if PeaceMaker_IsQuestComplete(59979) then
    PeaceMaker_CompleteQuest(700.251, -1881.132, 186.508, 59979, 167632)
    return
  end

  if PeaceMaker_IsQuestComplete(59980) then
    PeaceMaker_CompleteQuest(701.401, -1882.922, 186.508, 59980, 167631)
    return
  end

  if PeaceMaker_IsQuestComplete(59981) then
    PeaceMaker_CompleteQuest(707.931, -1870.236, 186.882, 59981, 167183)
    return
  end

  if PeaceMaker_IsQuestCompleted(59979) and PeaceMaker_IsQuestCompleted(59980) and PeaceMaker_IsQuestCompleted(59981) then
    PeaceMaker_MoveToNextStep()
  end

end

function DarkCitadelDungeon()
  if PeaceMaker_MapID() == 2175 then
    if not PeaceMaker_IsQuestCompleted(59984) and not PeaceMaker_HasQuest(59984) then
      PeaceMaker_AcceptQuest(707.931, -1870.236, 186.882, 59984, 167183)
    end
    if PeaceMaker_HasQuest(59984) then
      if not PeaceMaker_IsObjectiveCompleted(59984, 1) and not QueueStatusMinimapButton:IsVisible() then
        PeaceMaker_JoinDungeon(LE_LFG_CATEGORY_LFD, 2043, LFDDungeonList, LFDHiddenByCollapseList)
      else
        local EnterButton = LFGDungeonReadyDialogEnterDungeonButton
        if EnterButton and EnterButton:IsVisible() then lb.Unlock(AcceptProposal) end
      end
    end
    if PeaceMaker_IsQuestComplete(59984) then
      PeaceMaker_CompleteQuest(712.378, -1859.509, 186.882, 59984, 167675)
    end
    if PeaceMaker_IsQuestCompleted(59984) then
      PeaceMaker_MoveToNextStep()
    end
  else
    if PeaceMaker_MapID() == 2236 then

      local hotspot1 = {
        [1] = {  y=-1938.843,x=906.690,radius=100,z=210.943 }
      }

      local hotspot2 = {  
        [1] = {  y=-1778.276,x=828.587,radius=100,z=248.601 }
      } 

      local mobs = { 156821, 156825, 157300, 157328, 156913, 156814, 156501 }

      if not PeaceMaker_IsObjectiveCompleted(59984, 2) then
        PeaceMaker_DisableInternalCombat()
        if not PeaceMaker_ScenarioStepQuestIsComplete(1) then 
          PeaceMaker_QuestDungeon(hotspot1, mobs, "Dungeon", 100)
          return
        end
        if not PeaceMaker_ScenarioStepQuestIsComplete(2) then
          PeaceMaker_QuestDungeon(hotspot2, mobs, "Dungeon", 100)
          return
        end
      end

      if PeaceMaker_IsObjectiveCompleted(59984, 2) and not PeaceMaker_IsObjectiveCompleted(59984, 3) then
        PeaceMaker_EnableInternalCombat()
        PeaceMaker_SearchNpcAndInteract(167663)
      end

    end
    if PeaceMaker_IsQuestCompleted(59984) then
      PeaceMaker_EnableInternalCombat()
      PeaceMaker_MoveToNextStep()
    end
  end
end

function EndOfTheBeginning()
  if PeaceMaker_MapID() == 2175 then
    if StaticPopup1 and StaticPopup1.timeleft and StaticPopup1:IsVisible() then
      PeaceMaker_MacroText("/click StaticPopup1Button1")
    end
    if not PeaceMaker_IsQuestCompleted(59985) and not PeaceMaker_HasQuest(59985) then
      PeaceMaker_AcceptQuest(712.380, -1859.507, 186.882, 59985, 167675)
    end
    if PeaceMaker_HasQuest(59985) then
      PeaceMaker_SearchNpcAndInteractAndDelay(167669, 3)
    end
  else
    if PeaceMaker_MapID() == 1 then
      if PeaceMaker_IsQuestComplete(59985) then
        PeaceMaker_CompleteQuest(1465.514, -4419.750, 25.454, 59985, 168431)
      end
    end
    if PeaceMaker_IsQuestCompleted(59985) then
      PeaceMaker_LoadNextProfile("10_15_H")
    end
  end
end
