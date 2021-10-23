QuestOrder = {
  [1] = { Quest_Name = "WarmingUP", Quest_Settings = 2 },
  [2] = { Quest_Name = "SwitchProfileBasedOnFaction", Quest_Settings = 2 }
}

function WarmingUP()
  if GetCVar("showTutorials") == 1 then SetCVar("showTutorials", 0) return end
  if PeaceMaker_Faction() == "Horde" then
    if PeaceMaker_MapID() == 2175 then
      if not PeaceMaker_IsQuestCompleted(59926) and not PeaceMaker_HasQuest(59926) then
        if PeaceMaker_GetNpcDistance(166573) < 2 then
          lb.Unlock(MoveForwardStop)
          PeaceMaker_InteractNpcNearBy(166573)
        else
          if not PeaceMaker.Player.Moving then 
            lb.SetPlayerAngles(1.60)
            C_Timer.After(0.3, function() lb.Unlock(MoveForwardStart) end) 
          end
        end
      end
      if PeaceMaker_HasQuest(59926) then
        if not PeaceMaker_IsQuestComplete(59926) then
          if not NextMoveAngles then
            if PeaceMaker_GetNpcDistance(166583) < 1.3 then
              lb.SetPlayerAngles(2.6)
              lb.Unlock(MoveForwardStart) 
              NextMoveAngles = true
              return
            else
              if not PeaceMaker.Player.Moving then 
                lb.SetPlayerAngles(1.60)
                lb.Unlock(MoveForwardStart) 
              end
            end
          else
            if NextMoveAngles then
              if PeaceMaker_GetNpcDistance(166583) > 4.05 then
                if GetUnitSpeed("player") > 0 then lb.Unlock(MoveForwardStop) end
                PeaceMaker_TargetNearestNpcID(160737)
              end
            end
          end
        end
        if PeaceMaker_IsQuestComplete(59926) then
          if PeaceMaker_GetNpcDistance(166573) < 3.5 then
            lb.Unlock(MoveForwardStop)
            PeaceMaker_InteractNpcNearbyAndCompleteQuest(166573)
          else
            if not PeaceMaker.Player.Moving then 
              lb.SetPlayerAngles(5)
              lb.Unlock(MoveForwardStart) 
            end
          end
        end
      end
      if PeaceMaker_IsQuestCompleted(59926) then
        PeaceMaker_MoveToNextStep()
      end
    else
      if PeaceMaker_IsQuestCompleted(59926) then
        PeaceMaker_MoveToNextStep()
      end
    end
  end
end

function StandYouGround()
  if PeaceMaker_Faction() == "Horde" then
    if PeaceMaker_MapID() == 2175 then
      if not PeaceMaker_IsQuestCompleted(59927) and not PeaceMaker_HasQuest(59927) then
        if PeaceMaker_GetNpcDistance(166583) < 3 then
          lb.Unlock(MoveForwardStop)
          PeaceMaker_InteractNpcNearBy(166583)
        else
          if not PeaceMaker.Player.Moving then 
            lb.SetPlayerAngles(1.40)
            lb.Unlock(MoveForwardStart) 
          end
        end
      end
      if PeaceMaker_HasQuest(59927) then
        if not PeaceMaker_IsObjectiveCompleted(59927, 1) then
          if PeaceMaker_GetNpcDistance(166815) < 1.35 then
            if GetUnitSpeed("player") > 0 then lb.Unlock(MoveForwardStop) end
            PeaceMaker_TargetNearestNpcID(166815)
          else
            if not PeaceMaker.Player.Moving then 
              lb.SetPlayerAngles(5)
              lb.Unlock(MoveForwardStart) 
            end
          end
        end
        if PeaceMaker_IsQuestComplete(59927) then
          if PeaceMaker_GetNpcDistance(166583) < 3 then
            lb.Unlock(MoveForwardStop)
            PeaceMaker_InteractNpcNearbyAndCompleteQuest(166583)
          else
            if not PeaceMaker.Player.Moving then 
              lb.SetPlayerAngles(1.8)
              lb.Unlock(MoveForwardStart) 
            end
          end
        end
      end
      if PeaceMaker_IsQuestCompleted(59927) then
        PeaceMaker_MoveToNextStep()
      end
    else
      if PeaceMaker_IsQuestCompleted(59927) then
        PeaceMaker_MoveToNextStep()
      end
    end
  end
end

function BraceForImpact()
  if PeaceMaker_Faction() == "Horde" then
    if PeaceMaker_MapID() == 2175 then
      if not PeaceMaker_IsQuestCompleted(59928) and not PeaceMaker_HasQuest(59928) then
        if PeaceMaker_GetNpcDistance(166583) < 3 then
          lb.Unlock(MoveForwardStop)
          PeaceMaker_InteractNpcNearBy(166583)
        else
          if not PeaceMaker.Player.Moving then 
            lb.SetPlayerAngles(1.60)
            lb.Unlock(MoveForwardStart) 
          end
        end
      end
      if PeaceMaker_HasQuest(59928) then
        if PeaceMaker_IsQuestComplete(59928) then
          if PeaceMaker_GetNpcDistance(166827) < 3 then
            lb.Unlock(MoveForwardStop)
            PeaceMaker_InteractNpcNearbyAndCompleteQuest(166827)
          else
            if not PeaceMaker.Player.Moving then 
              lb.SetPlayerAngles(5.1)
              lb.Unlock(MoveForwardStart) 
            end
          end
        end
      end
      if PeaceMaker_IsQuestCompleted(59928) then
        PeaceMaker_MoveToNextStep()
      end
    else
      if PeaceMaker_IsQuestCompleted(59928) then
        PeaceMaker_MoveToNextStep()
      end
    end
  end
end

function SwitchProfileBasedOnFaction()
  if PeaceMaker_IsQuestCompleted(59928) and PeaceMaker_IsQuestCompleted(59927) then
    PeaceMaker_LoadNextProfile("1_10_H")
  end
end