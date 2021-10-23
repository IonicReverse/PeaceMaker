local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestDungeon = {}

local QuestDungeon = PeaceMaker.Helpers.Quest.QuestDungeon
local QuestMisc = PeaceMaker.Helpers.Quest.QuestMisc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log

function QuestDungeon:Run(hotspot, npcid, type, distance)

  if not PeaceMaker.QuestDungeonHotspot then PeaceMaker.QuestDungeonHotspot = hotspot WPIndex = 1 return end
  if PeaceMaker.QuestDungeonHotspot then if PeaceMaker.QuestDungeonHotspot[1].x ~= hotspot[1].x then PeaceMaker.QuestDungeonHotspot = hotspot WPIndex = 1 return end end

  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchQuestAttackable(npcid, type, distance)

  if hasCombatEnemy then
    Log:Run("State : Quest Dungeon")
    if PeaceMaker.Helpers.Rotation.Core.Engine then PeaceMaker.Helpers.Rotation.Core.Engine.Run() end
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    return
  end

  if not hasCombatEnemy then
    Log:Run("State : Quest Dungeon Roaming")
    Navigation:QuestDungeonRoam()
    return  
  end

end 
