local PeaceMaker = PeaceMaker
PeaceMaker:RegisterChatCommand("pc", "ChatCommand")

local function SplitInput(Input)
  local Table = {}
  --Input = strupper(Input)
  for i in string.gmatch(Input, '%S+') do
    table.insert(Table, i)
  end
  return Table
end

local lastdebugmsg = ''
local lastdebugtime = 0
local function debugmsg(message)
  if PeaceMaker.Settings.profile.General.EnableLog then
    if (lastdebugmsg ~= message or PeaceMaker.Time > lastdebugtime) then
      lastdebugmsg = message
      lastdebugtime = PeaceMaker.Time + 5
      print(string.format("%s: %s", "|cff42a5f5[Debug]|r", message))
    end
  end
end

local function GetNearbyWayPoint(WayPointTable)
  local tmp = {}
  if (WayPointTable ~= nil) then
    for i = 1, #WayPointTable do
      local px,py,pz = lb.ObjectPosition('player')
      local nx,ny,nz = WayPointTable[i].x, WayPointTable[i].y, WayPointTable[i].z
      local Dist = lb.GetDistance3D(px,py,pz,nx,ny,nz)
      table.insert(tmp, {Index = i, Distance = Dist})
    end
    if #tmp > 1 then
      table.sort(
        tmp,
        function(x, y)
          return x.Distance < y.Distance
        end
      )
    end
    WPIndex = tmp[1].Index
  end
end

function PeaceMaker:ChatCommand(Input)
  if not Input or Input:trim() == "" then
    PeaceMaker.UI.Show()
  else
    local Commands = SplitInput(Input)
    if Commands[1] == "start" then
      PeaceMaker.IsRunning = true
      if Commands[2] == "dungeon" then
        PeaceMaker.Settings.profile.General.Mode = "Dungeon"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        if Commands[3] == "iron" then
          PeaceMaker.DungeonName = "Iron_Dock"
        elseif Commands[3] == "BLOOD" then
          PeaceMaker.DungeonName = "Blood_Maul"
        end
        debugmsg("Dungeon Mode")
      elseif Commands[2] == "grind" then
        PeaceMaker.Settings.profile.General.Mode = "Grind"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        debugmsg("Grind Mode")
      elseif Commands[2] == "taggrind" then
        PeaceMaker.Settings.profile.General.Mode = "TagGrind"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        debugmsg("Tag Grind Mode")
      elseif Commands[2] == "gather" then
        PeaceMaker.Settings.profile.General.Mode = "Gather"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        debugmsg("Gather Mode")
      elseif Commands[2] == "quest" then
        PeaceMaker.Settings.profile.General.Mode = "Quest"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        debugmsg("Quest Mode")
      elseif Commands[2] == "craft" then
        PeaceMaker.Settings.profile.General.Mode = "Craft"
        PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
        debugmsg("Craft Mode")
      end
    elseif Commands[1] == "grind" and Commands[2] == "load" then
      local Profile = PeaceMaker.ProfilePathGrindSettings .. Commands[3] .. ".lua"
      PeaceMaker.Settings.profile.Grinding.LastProfile = Commands[3]
      local ContentReaded = lb.ReadFile(Profile)
      lb.RunString(ContentReaded)
      PeaceMaker.MinLevel = MinLevel
      PeaceMaker.MaxLevel = MaxLevel
      PeaceMaker.BlackList = BlackList
      PeaceMaker.WhiteList = WhiteList
      PeaceMaker.Settings.profile.Grinding.RepairNpcID = tostring(RepairNpcID)
      PeaceMaker.Settings.profile.Grinding.RepairNpcPos = RepairNpcPos
      PeaceMaker.Settings.profile.Grinding.FoodNpcID = tostring(FoodNpcID)
      PeaceMaker.Settings.profile.Grinding.FoodNpcPos = FoodNpcPos
      PeaceMaker.Settings.profile.Grinding.FoodID = FoodID
      PeaceMaker.Settings.profile.Grinding.DrinkID = DrinkID
      PeaceMaker.Settings.profile.Grinding.FoodAmount = FoodAmount
      PeaceMaker.Settings.profile.Grinding.DrinkAmount = DrinkAmount
      PeaceMaker.VendorWPRoute = VendorWPRoute
      PeaceMaker.GrindBlackListPos = GrindBlackListPos
      PeaceMaker.GatherBlackListPos = GatherBlackListPos 
      PeaceMaker.GrindMapID = GrindMapID 
      PeaceMaker.BlackListHotSpotTimer = GetTime() + PeaceMaker.Settings.profile.General.BlackListHotSpotTimer 
      local HotSpotReader = PeaceMaker.ProfilePathGrindHotSpot .. Commands[3] .. ".lua"
      local HotSpotReaded = lb.ReadFile(HotSpotReader)
      lb.RunString(HotSpotReaded)
      PeaceMaker.GrindHotSpot = HotSpot
      debugmsg("Grind Profile Loaded : " .. PeaceMaker.Settings.profile.Grinding.LastProfile)
      GetNearbyWayPoint(HotSpot)
    elseif Commands[1] == "grindtag" and Commands[2] == "load" then
      local GrindTagProfile = PeaceMaker.ProfilePathTagGrindSettings .. Commands[3] .. ".lua"
      PeaceMaker.Settings.profile.Grinding.LastProfile = Commands[3]
      local GrindTagContentReaded = lb.ReadFile(GrindTagProfile)
      lb.RunString(GrindTagContentReaded)
      PeaceMaker.MinLevel = MinLevel
      PeaceMaker.MaxLevel = MaxLevel
      PeaceMaker.BlackList = BlackList
      PeaceMaker.WhiteList = WhiteList
      PeaceMaker.Settings.profile.TagGrinding.RepairNpcID = tostring(RepairNpcID)
      PeaceMaker.Settings.profile.TagGrinding.RepairNpcPos = RepairNpcPos
      PeaceMaker.Settings.profile.TagGrinding.FoodNpcID = tostring(FoodNpcID)
      PeaceMaker.Settings.profile.TagGrinding.FoodNpcPos = FoodNpcPos
      PeaceMaker.Settings.profile.TagGrinding.FoodID = FoodID
      PeaceMaker.Settings.profile.TagGrinding.DrinkID = DrinkID
      PeaceMaker.Settings.profile.TagGrinding.FoodAmount = FoodAmount
      PeaceMaker.Settings.profile.TagGrinding.DrinkAmount = DrinkAmount
      PeaceMaker.VendorWPRoute = VendorWPRoute
      PeaceMaker.GrindMinimumEnemy = GrindMinimumEnemy
      PeaceMaker.GrindSpeedSpellList = GrindSpeedSpellList
      PeaceMaker.GrindSafetySwitchProfile  = GrindSafetySwitchProfile 
      PeaceMaker.GrindBlackListPos = GrindBlackListPos
      PeaceMaker.GatherBlackListPos = GatherBlackListPos 
      PeaceMaker.GrindHPFightBack = GrindHPFightBack
      PeaceMaker.GrindSpellList = GrindSpellList
      PeaceMaker.GrindTagCount = GrindTagCount
      PeaceMaker.BlackListHotSpotTimer = GetTime() + PeaceMaker.Settings.profile.General.BlackListHotSpotTimer 
      local HotSpotTagReader = PeaceMaker.ProfilePathTagGrindHotSpot .. Commands[3] .. ".lua"
      local HotSpotTagReaded = lb.ReadFile(HotSpotTagReader)
      lb.RunString(HotSpotTagReaded)
      PeaceMaker.GrindHotSpot = HotSpot
      debugmsg("Grind Tag Profile Loaded : " .. PeaceMaker.Settings.profile.Grinding.LastProfile)
      GetNearbyWayPoint(HotSpot)
    elseif Commands[1] == "gather" and "load" then
      local GatherProfile = PeaceMaker.ProfilePathGatherSettings .. Commands[3] .. ".lua"
      PeaceMaker.Settings.profile.Gathering.LastProfile = Commands[3]
      local GatherContentReaded = lb.ReadFile(GatherProfile)
      lb.RunString(GatherContentReaded)
      PeaceMaker.GatherMinLevel = GatherMinLevel
      PeaceMaker.GatherMaxLevel = GatherMaxLevel
      PeaceMaker.GatherVendorGossip = GatherVendorGossip
      PeaceMaker.Settings.profile.Gathering.RepairNpcID = GatherVendorID
      PeaceMaker.Settings.profile.Gathering.RepairNpcPos = GatherVendorPos
      PeaceMaker.GatherBlackListPos = GatherBlackListPos 
      local GatherHotSpotReader = PeaceMaker.ProfilePathGatherHotSpot .. Commands[3] .. ".lua"
      local GatherHotSpotReaded = lb.ReadFile(GatherHotSpotReader)
      lb.RunString(GatherHotSpotReaded)
      PeaceMaker.GatherHotSpot = HotSpot
      debugmsg("Gather Profile Loaded : " .. PeaceMaker.Settings.profile.Gathering.LastProfile)
      GetNearbyWayPoint(HotSpot)
    elseif Commands[1] == "craft" and "load" then
      local CraftProfile = PeaceMaker.ProfilePathCrafting .. Commands[3] .. ".lua"
      PeaceMaker.Settings.profile.Crafting.LastProfile = Commands[3]
      local CraftContentReaded = lb.ReadFile(CraftProfile)
      lb.RunString(CraftContentReaded)
      PeaceMaker.CraftVendorNpcID = VendorNpcID
      PeaceMaker.CraftVendorNpcPos = VendorNpcPos
      PeaceMaker.CraftMailPos = MailPos
      PeaceMaker.CraftIngredientID = IngredientID 
      PeaceMaker.CraftIngredientAmount = IngredientAmount 
      PeaceMaker.CraftRecipe = CraftRecipe 
      debugmsg("Crafting Profile Loaded : " .. PeaceMaker.Settings.profile.Crafting.LastProfile)
    elseif Commands[1] == "quest" and "load" then
      local QuestProfile = PeaceMaker.ProfileQuestSettings .. Commands[3] .. ".lua"
      PeaceMaker.Settings.profile.Questing.LastProfile = Commands[3]
      local QuestContentReaded = lb.ReadFile(QuestProfile)
      lb.RunString(QuestContentReaded)
      PeaceMaker.QuestSettingsList = QuestSettingsList
      local QuestOrderContentReader = PeaceMaker.ProfileQuestOrder .. Commands[3] .. ".lua"
      local QuestOrderContentReaded = lb.ReadFile(QuestOrderContentReader)
      lb.RunString(QuestOrderContentReaded)
      PeaceMaker.QuestOrder = QuestOrder
      debugmsg("Quest Profile Loaded : " .. PeaceMaker.Settings.profile.Questing.LastProfile)
      PeaceMaker.Settings.profile.Questing.QuestStep = 1
    elseif Commands[1] == "reset" then
      PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 1
      PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 1
      IronPathIndex = 1
      BloodMaulIndex = 1
      RecordIndex = 1
      WPIndex = 1
      debugmsg("Reset Step/Index")
    elseif Commands[1] == "stop" then
      PeaceMaker.IsRunning = false
      PeaceMaker.Dungeon = false
      if PeaceMaker.Navigator then PeaceMaker.Navigator.Stop() end
      debugmsg("Bot Stopped")
    elseif Commands[1] == "record" then
      if PeaceMaker.Time > PeaceMaker.Pause then
        PathX = lb.GetGameDirectory() .. "\\Interface\\Addons\\PeaceMaker\\Path\\Coordinate.lua"
        local X,Y,Z = lb.ObjectPosition('player')
        lb.WriteFile(PathX, "[" .. RecordIndex .. "] = { " .. X .. " , " .. Y .. " , " .. Z .. " } " .. "\n", true)
        debugmsg("RecordIndex[" .. RecordIndex .. "] = X: " .. X .. "," .. "Y: " .. Y .. "," .. "Z: " .. Z) 
        RecordIndex = RecordIndex + 1
        PeaceMaker.Pause = PeaceMaker.Time + 1
      end
    else
      LibStub("AceConfigCmd-3.0").HandleCommand(PeaceMaker, "rc", "PeaceMaker", Input)
    end
  end
end