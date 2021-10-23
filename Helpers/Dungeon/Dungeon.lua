local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Dungeon.Runner = {}
local Runner = PeaceMaker.Helpers.Dungeon.Runner

function Runner:Run()
  if PeaceMaker.DungeonName == "Iron_Dock" then
    if PeaceMaker.Helpers.Dungeon.IronDock then
      PeaceMaker.Helpers.Dungeon.IronDock.Run(IsAllowed)
      PeaceMaker.Settings.profile.Dungeon.LastDungeon = "iron"
    end
  end
  if PeaceMaker.DungeonName == "Blood_Maul" then
    if PeaceMaker.Helpers.Dungeon.BloodMaul then
      PeaceMaker.Helpers.Dungeon.BloodMaul.Run(IsAllowed)
      PeaceMaker.Settings.profile.Dungeon.LastDungeon = "blood"
    end
  end
end
