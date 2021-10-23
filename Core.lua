PeaceMaker = LibStub("AceAddon-3.0"):NewAddon("PeaceMaker", "AceConsole-3.0")

local PeaceMaker = PeaceMaker
local IsAllowed = 0

RecordIndex = 1
HotSpotPathIndex = 1

PeaceMaker.Tables = {}
PeaceMaker.Enums = {}
PeaceMaker.Functions = {}
PeaceMaker.UI = {}
PeaceMaker.Settings = {}
PeaceMaker.SpellBook = {}
PeaceMaker.Helpers = {}
PeaceMaker.Helpers.Rotation = {}
PeaceMaker.Helpers.Dungeon = {}
PeaceMaker.Helpers.Grinding = {}
PeaceMaker.Helpers.Gathering = {}
PeaceMaker.Helpers.Crafting = {}
PeaceMaker.Helpers.Quest = {}
PeaceMaker.Helpers.Core = {}
PeaceMaker.Rotation = {}
PeaceMaker.Player = {}
PeaceMaker.Pulse = 0

PeaceMaker.Mode = "Grind"
PeaceMaker.Pause = 0
PeaceMaker.PulseDelay = 0
PeaceMaker.DelayUse = 0
PeaceMaker.MailItemCount = 0
PeaceMaker.VendorStep = 0
PeaceMaker.DelayMount = 0
PeaceMaker.FailedMining = 0
PeaceMaker.MailTime = false
PeaceMaker.UseKeyGetPosition = false
PeaceMaker.GatherSucceed = false

local lastdebugmsg = ''
local lastdebugtime = 0
local function debugmsg(message)
  if (lastdebugmsg ~= message or PeaceMaker.Time > lastdebugtime) then
    lastdebugmsg = message
    lastdebugtime = PeaceMaker.Time + 5
    print(string.format("%s: %s", "|cff42a5f5[Debug]|r", message))
  end
end

local function Init()

  --debugmsg("PeaceMaker Addon -- Made By Xetro --")

  PeaceMaker.InitSettings()
  PeaceMaker.UI.Init()
  PeaceMaker.Player = PeaceMaker.Classes.LocalPlayer(UnitGUID('player'))

  --PeaceMaker.PulseDelay = GetTime() + 4

  PeaceMaker.Settings.profile.Questing.QuestStep = 1

  PeaceMaker.ProfilePathGrindHotSpot = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GrindHotSpot\\"
  PeaceMaker.ProfilePathGrindSettings = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GrindSettings\\"
  PeaceMaker.ProfileList = lb.GetFiles(PeaceMaker.ProfilePathGrindSettings .. "*.lua")

  PeaceMaker.ProfilePathTagGrindHotSpot = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GrindTagHotSpot\\"
  PeaceMaker.ProfilePathTagGrindSettings = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GrindTagSettings\\"
  PeaceMaker.ProfileTagGrindList = lb.GetFiles(PeaceMaker.ProfilePathTagGrindSettings .. "*.lua")

  PeaceMaker.ProfilePathGatherHotSpot = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GatherHotSpot\\"
  PeaceMaker.ProfilePathGatherSettings = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\GatherSettings\\"
  PeaceMaker.ProfileGatherList = lb.GetFiles(PeaceMaker.ProfilePathGatherSettings .. "*.lua")

  PeaceMaker.ProfileQuestOrder = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\QuestProfile\\"
  PeaceMaker.ProfileQuestSettings = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\QuestSettings\\"
  PeaceMaker.ProfileQuestList = lb.GetFiles(PeaceMaker.ProfileQuestSettings .. "*.lua")

  PeaceMaker.ProfilePathCrafting = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Profile\\CraftProfile\\"
  PeaceMaker.ProfileCraftList = lb.GetFiles(PeaceMaker.ProfilePathCrafting .. "*.lua")

  PeaceMaker.RotationList = lb.GetFiles(lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Helpers\\Rotation\\List\\" .. "*.lua")

  --lb.Unlock(MoveForwardStart)
  --C_Timer.After(0.5, function() lb.Unlock(MoveForwardStop) end)

  if PeaceMaker.Settings.profile.General.AutoStart then
    PeaceMaker.IsRunning = true
    PeaceMaker.UIOptions.args.GeneralTab.args.Start.name = "STOP"
    --debugmsg("Auto Start")
    if PeaceMaker.Settings.profile.General.AutoEquip then lb.Unlock(RunMacroText, "/ag start") end
    if PeaceMaker.Settings.profile.General.Mode == "Grind" or PeaceMaker.Settings.profile.General.Mode == "TagGrind" then
      if PeaceMaker.Settings.profile.Grinding.LastProfile ~= '' then
        --debugmsg("Load Last Profile: " .. PeaceMaker.Settings.profile.Grinding.LastProfile)
        if PeaceMaker.Settings.profile.General.Mode == "Grind" then
          lb.Unlock(RunMacroText, "/pc start grind")
          lb.Unlock(RunMacroText, "/pc grind load " ..  PeaceMaker.Settings.profile.Grinding.LastProfile)
        else
          if UnitAffectingCombat('player') then EnableTagGrindCombat = true end
          lb.Unlock(RunMacroText, "/pc start taggrind")
          lb.Unlock(RunMacroText, "/pc grindtag load " ..  PeaceMaker.Settings.profile.Grinding.LastProfile)
        end
      end
    elseif PeaceMaker.Settings.profile.General.Mode == "Gather" then
      lb.Unlock(RunMacroText, "/pc start gather")
      if PeaceMaker.Settings.profile.Gathering.LastProfile ~= '' then
        --debugmsg("Load Last Gather Profile: " .. PeaceMaker.Settings.profile.Gathering.LastProfile)
        lb.Unlock(RunMacroText, "/pc gather load " .. PeaceMaker.Settings.profile.Gathering.LastProfile)
      end
    elseif PeaceMaker.Settings.profile.General.Mode == "Craft" then
      lb.Unlock(RunMacroText, "/pc start craft")
      if PeaceMaker.Settings.profile.Crafting.LastProfile then
        lb.Unlock(RunMacroText, "/pc craft load " .. string.gsub(PeaceMaker.Settings.profile.Crafting.LastProfile, ".lua", ""))
      end
    elseif PeaceMaker.Settings.profile.General.Mode == "Quest" then
      lb.Unlock(RunMacroText, "/pc start quest")
      if PeaceMaker.Settings.profile.Questing.LastProfile then
        lb.Unlock(RunMacroText, "/pc quest load " .. string.gsub(PeaceMaker.Settings.profile.Questing.LastProfile, ".lua", ""))
      end
    else
      if PeaceMaker.Settings.profile.General.Mode == "Dungeon" then
        if PeaceMaker.Settings.profile.Dungeon.LastDungeon ~= '' then
          --debugmsg("Load Last Dungeon Profile: " .. PeaceMaker.Settings.profile.Dungeon.LastDungeon)
          lb.Unlock(RunMacroText, "/pc start " ..  PeaceMaker.Settings.profile.Dungeon.LastDungeon)
        end
      end
    end
  end

  Intialized = true
  PeaceMaker.UI.Show()

end


local frame = CreateFrame("Frame", "PeaceMaker", UIParent)
frame.TimeSinceLastUpdate = 0
frame:SetScript(
  "OnUpdate",
  function(self, elapsed)
    
    if lb and lb.GetMapId() then
      
      self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed

      -- Pulse
      PeaceMaker.Time = GetTime()
      
      if not Intialized then Init() return end

      if PeaceMaker.IsRunning and Intialized == true then

        if self.TimeSinceLastUpdate >= PeaceMaker.Settings.profile.General.Pulse then 

          self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - PeaceMaker.Settings.profile.General.Pulse

          -- Visual
          PeaceMaker.Helpers.Core.Visual:Run()

          -- AFK
          PeaceMaker.Helpers.Core.AFK:Run()

          -- Auto Reload
          PeaceMaker.Helpers.Core.Reloaded:Run()

          -- Navigation
          PeaceMaker.Helpers.Core.Navigation:Run()

          -- Object Manager
          PeaceMaker.UpdateOM()

          -- Rotation
          PeaceMaker.Helpers.Rotation.Core:Run()

          -- Check Item And Destroy
          if PeaceMaker.Settings.profile.General.DestroyItem then
            PeaceMaker.Helpers.Core.Destroy:Run()
          end

          -- Dungeon
          if PeaceMaker.Mode == "Dungeon" then
            if PeaceMaker.Navigator then
              PeaceMaker.Helpers.Dungeon.Runner:Run()
            end
          end

          if (PeaceMaker.Mode == "Grind" or PeaceMaker.Mode == "TagGrind") then
            if PeaceMaker.Navigator then
              PeaceMaker.Helpers.Grinding.Grind:Run()
            end
          end

          if PeaceMaker.Mode == "Gather" then
            if PeaceMaker.Navigator then
              PeaceMaker.Helpers.Gathering.Gathering:Run()
            end
          end

          if PeaceMaker.Mode == "Craft" then
            if PeaceMaker.Navigator then
              PeaceMaker.Helpers.Crafting.Crafting:Run()
            end
          end

          if PeaceMaker.Mode == "Quest" then
            if PeaceMaker.Navigator then
              PeaceMaker.Helpers.Quest.Questing:Run()
            end
          end

          if PeaceMaker.UseKeyGetPosition then
            if lb.GetKeyState(0x11) and lb.GetKeyState(0x52) then
              lb.Unlock(RunMacroText, "/pc record")
            end
          end
        end

      end

    end
  end
)


