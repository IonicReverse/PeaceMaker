local PeaceMaker = PeaceMaker
local AceGUI = LibStub("AceGUI-3.0")

local defaults = {

  profile = {

    General = {
      Pulse = 0.5,
      Mode = "",
      AutoStart = false,
      EnableGroundVisual = false,
      UseAutoReload = false,
      UseSafetyFeature = true,
      ReloadedTime = 7200,
      RotationName = "Paladin",
      BlackListHotSpotTimer = 300,
      RessDistance = 20,
      DestroyItem = {175247},
      AFKPlayerBlackList = {},
      AutoEquip = false,
      EnableLog = true,
      UseClickToMove = true
    },

    Dungeon = {
      IronDock_Step = 1,
      BloodMaul_Step = 1,
      VendorDelay = 5,
      LastDungeon = ""
    },

    Grinding = {
      AttackDistance = 3,
      FoodPercent = 50,
      DrinkPercent = 50,
      AutoLoot = true,
      LootRange = 25,
      AutoSkinning = true,
      SkinRange = 25,
      UseVendor = false,
      UseMammothVendor = false,
      UseMount = false,
      UsePet = false,
      UseRandomJump = true,
      UseRandomTabTarget = true,
      UseControlDRotation = false,
      MountID = 0,
      MountWhenEnemyDistance = 30,
      CombatTargetDistance = 30,
      FoodID = 0,
      DrinkID = 0,
      FoodAmount = 0,
      DrinkAmount = 0,
      BagSlot = 3,
      Durability = 20,
      AFKPlayerDistance = 100,
      UseMail = false,
      MailTo = "",
      MailToTitle = "",
      MailItemList = "",
      SwitchSpotTimer = 10,
      WhiteListItem = {},
      LastProfile = "",
    },

    TagGrinding = {
      AttackDistance = 3,
      FoodPercent = 50,
      DrinkPercent = 50,
      AutoLoot = true,
      LootRange = 25,
      AutoSkinning = true,
      SkinRange = 25,
      UseVendor = true,
      UseMammothVendor = false,
      UseMount = true,
      UsePet = false,
      UseRandomJump = true,
      UseRandomTabTarget = true,
      UseControlDRotation = true,
      OverPull = false,
      UseRestSpell = false,
      RestSpellHP = 80,
      MountID = 0,
      MountWhenEnemyDistance = 30,
      PullDistanceLimit = 0,
      StopOverPullWhen = 20,
      OverPullDistance = 30,
      CombatTargetDistance = 30,
      FoodID = 0,
      DrinkID = 0,
      FoodAmount = 0,
      DrinkAmount = 0,
      BagSlot = 10,
      Durability = 20,
      AFKPlayerDistance = 100,
      UseMail = false,
      MailTo = "",
      MailToTitle = "",
      MailItemList = "",
      SwitchSpotTimer = 10,
      WhiteListItem = {168586, 172092, 177062, 172053,172093, 172097, 172089, 109253, 177279, 172096, 172094, 172055, 179315, 168589, 170554, 179314, 168583, 169701, 171315, 171828, 171833, 171829, 171830, 171831, 171832, 171840, 171841, 177061, 85663, 7005, 2901, 6948},
      LastProfile = "",
    },

    Gathering = {
      AttackDistance = 3.5,
      FoodPercent = 50,
      DrinkPercent = 50,
      AutoLoot = true,
      LootRange = 30,
      UseMount = true,
      UseHerbing = true,
      UseMining = true,
      SkipCombat = false,
      UseRandomJump = true,
      UseRandomTabTarget = true,
      CombatTargetDistance = 30,
      MountID = 0,
      FoodID = 0,
      DrinkID = 0,
      FoodAmount = 0,
      DrinkAmount = 0,
      UseVendor = true,
      UseMammothVendor = false,
      BagSlot = 3,
      Durability = 30,
      UseMail = false,
      MailTo = "",
      MailToTitle = "",
      MailItemList = "",
      WhiteListItem = {168586, 172055, 179315, 168589, 170554, 179314, 168583, 169701, 171315, 171828, 171833, 171829, 171830, 171831, 171832, 171840, 171841, 177061, 85663, 2901, 6948},
      LastProfile = ""
    },

    Crafting = {
      UseVendor = true,
      BagSlot = 5,
      WhiteListItem = {177062, 168586, 172092, 172093, 172097, 172089, 109253, 177279, 172096, 172094, 172055, 179315, 168589, 170554, 179314, 168583, 169701, 171315, 171828, 171833, 171829, 171830, 171831, 171832, 171840, 171841, 177061, 85663, 7005, 2901, 6948},
      UseMail = false,
      LastProfile = ""
    },

    Questing = {
      QuestStep = 1,
      AttackDistance = 5,
      CombatTargetDistance = 30,
      MountWhenEnemyDistance = 30,
      LootRange = 30,
      WhiteListItem = {},
      LastProfile = ""
    }

  },

  char = {
    SelectedProfile = select(2, UnitClass("player")):gsub("%s+", "")
  }

}

function PeaceMaker.InitSettings()
  PeaceMaker.Settings = LibStub("AceDB-3.0"):New("PeaceMakerSettings", defaults, "Default")
  PeaceMaker.Settings:SetProfile(PeaceMaker.Settings.char.SelectedProfile)
  PeaceMaker.Settings.RegisterCallback(PeaceMaker, "OnProfileChanged", "HandleProfileChanges")
end

function PeaceMaker:HandleProfileChanges(self, db, profile)
  PeaceMaker.Settings.char.SelectedProfile = profile
end