local PeaceMaker = PeaceMaker
local EventFrame = CreateFrame("Frame")

EventFrame:RegisterEvent("LOOT_OPENED")
EventFrame:RegisterEvent("LOOT_READY")
EventFrame:RegisterEvent("LOOT_CLOSED")
EventFrame:RegisterEvent("LOOT_BIND_CONFIRM")
EventFrame:RegisterEvent("MERCHANT_SHOW")
EventFrame:RegisterEvent("MERCHANT_CLOSED")
EventFrame:RegisterEvent("GOSSIP_SHOW")
EventFrame:RegisterEvent("GOSSIP_CLOSED")
EventFrame:RegisterEvent("UI_ERROR_MESSAGE")
EventFrame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")
EventFrame:RegisterEvent("PLAYER_DEAD")
EventFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("CINEMATIC_START")
EventFrame:RegisterEvent("UNIT_SPELLCAST_START")
EventFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
EventFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
EventFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

local cdMoveStrafe = GetTime()
local isMoveLeft = true

local function CheckEnemyAtkPlayer()
  local Count = 0
  for _, guid in pairs(lb.GetObjects(30, 5)) do
    if guid then
      local Target = lb.UnitTarget(guid)
      if (Target == UnitGUID('player')) then
        Count = Count + 1
      end
    end
  end
  return Count
end

local function Handler(self, event, ...)
  
  if lb then

    if event == "PLAYER_LEAVE_COMBAT" then
      if CheckEnemyAtkPlayer() <= 1 then
        PeaceMaker.Pause = PeaceMaker.Time + 0.5
        PeaceMaker.Settings.profile.General.Pulse = PeaceMaker.Settings.profile.General.Pulse + 1
        C_Timer.After(PeaceMaker.Settings.profile.General.Pulse, function() 
          PeaceMaker.Settings.profile.General.Pulse = PeaceMaker.Settings.profile.General.Pulse - 1 
        end)
      end
    end

    if event == "LOOT_READY" then
      PeaceMaker.Player.Looting = true
      for i = GetNumLootItems(), 1, -1 do
        LootSlot(i)
        ConfirmLootSlot(i)
      end
      CurrentLoot = nil
      CloseLoot()
    end

    if event == "LOOT_CLOSED" then
      if PeaceMaker.Player then
        PeaceMaker.Player.Looting = false
      end
      CurrentLoot = nil
    end

    if event == "LOOT_BIND_CONFIRM" then
      StaticPopup1Button1:Click()
    end
    
    if event == "MERCHANT_SHOW" then
      if PeaceMaker.Helpers.Dungeon.BloodMaul then
        PeaceMaker.Helpers.Dungeon.BloodMaul.MerchantOpen = true
      end
      if PeaceMaker.Helpers.Dungeon.IronDock then
        PeaceMaker.Helpers.Dungeon.IronDock.MerchantOpen = true
      end
    end

    if event == "MERCHANT_CLOSED" then
      if PeaceMaker.Helpers.Dungeon.BloodMaul then
        PeaceMaker.Helpers.Dungeon.BloodMaul.MerchantOpen = false
      end
      if PeaceMaker.Helpers.Dungeon.IronDock then
        PeaceMaker.Helpers.Dungeon.IronDock.MerchantOpen = false
      end
    end

    if event == "MAIL_SEND_INFO_UPDATE" then
      PeaceMaker.MailItemCount = PeaceMaker.MailItemCount + 1
      PeaceMaker.DelayUse = PeaceMaker.Time + 1
      if not PeaceMaker.MailTime then PeaceMaker.MailTime = PeaceMaker.Time + 5 end
    end

    if event == "MAIL_SEND_SUCCESS" then
      PeaceMaker.MailItemCount = 0
      PeaceMaker.MailTime = false
    end

    if event == "UI_ERROR_MESSAGE" then
      
      local _, msg = ...

      -- if msg == "Target needs to be in front of you." or msg == "You are facing the wrong way!" then
      --   if PeaceMaker then
      --     if (PeaceMaker.Mode == "Grind" or PeaceMaker.Mode == "TagGrind" or PeaceMaker.Mode == "Gather" or PeaceMaker.Mode == "Quest") then
      --       if not GrindStateIsRunning then
      --         lb.Unlock(JumpOrAscendStart)
      --         C_Timer.After(0.5, function() lb.Unlock(AscendStop) end)
      --         if PeaceMaker.Player.Target then PeaceMaker.Helpers.Core.Misc:FaceUnit(PeaceMaker.Player.Target.GUID) end
      --         -- if PeaceMaker.Player.Target and PeaceMaker.Helpers.Core.Misc:IsFacing(PeaceMaker.Player.Target.GUID, PeaceMaker.Player.GUID) then
      --         --   if GetTime() - cdMoveStrafe > 3 then
      --         --     PeaceMaker.Helpers.Core.Misc:FaceUnit(PeaceMaker.Player.Target.GUID)
      --         --     if isMoveLeft then
      --         --       lb.Unlock(StrafeLeftStart)
      --         --       C_Timer.After(0.25, function()
      --         --         lb.Unlock(StrafeLeftStop)
      --         --       end)
      --         --       isMoveLeft = false
      --         --       cdMoveStrafe = GetTime()
      --         --     elseif not isMoveLeft then
      --         --       lb.Unlock(StrafeRightStart)
      --         --       C_Timer.After(0.25, function()
      --         --         lb.Unlock(StrafeRightStop)
      --         --       end)
      --         --       isMoveLeft = true
      --         --       cdMoveStrafe = GetTime()
      --         --     end
      --         --   end
      --         -- end
      --       end
      --     end
      --   end
      -- end

      if msg == "Target not in line of sight" then
        lb.Unlock(ClearTarget)
      end

      -- if msg == "You dont have permission to loot that corpse." then
      --   if CurrentLoot then PeaceMaker.Helpers.Core.Misc:BlackListLoot(CurrentLoot.GUID) end
      -- end

      -- if msg == "Creature is not skinnable" then
      --   if CurrentSkin then PeaceMaker.Helpers.Core.Misc:BlackListSkin(CurrentSkin.GUID) end
      -- end

      if msg == "No valid targets." or msg == "Invalid target" then
        NoValidTargetError = true
        C_Timer.After(0.5, function() NoValidTargetError = false end)
      end
      
    end

    if event == "PLAYER_DEAD" then
      if PeaceMaker.Navigator then 
        PeaceMaker.Navigator.Stop() 
      end
      PeaceMaker.Pause = PeaceMaker.Time + 1
    end

    if event == "PLAYER_ENTERING_WORLD" then
      if PeaceMaker then
        if PeaceMaker.Navigator then
          PeaceMaker.Navigator.Stop()
        end
      end
    end

    if event == "CINEMATIC_START" then
      C_Timer.After(1, CinematicFrame_CancelCinematic)
      C_Timer.After(3, CinematicFrame_CancelCinematic)
    end

    if event == "UNIT_SPELLCAST_STOP" then
      local Target, GUID, spellID = ...
      if spellID == 309835 then
        PeaceMaker.FailedMining = PeaceMaker.FailedMining + 1
      end
    end
    
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
      local Target, GUID, spellID = ...
      if (spellID == 309835 or spellID == 309780) then
        PeaceMaker.GatherSucceed = true
        PeaceMaker.Pause = PeaceMaker.Time + 0.3
      end
    end

  end

end

EventFrame:SetScript("OnEvent", Handler)