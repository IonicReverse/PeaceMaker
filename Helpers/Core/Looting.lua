local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Looting = {}

local Navigation = PeaceMaker.Helpers.Core.Navigation
local Misc = PeaceMaker.Helpers.Core.Misc
local Looting = PeaceMaker.Helpers.Core.Looting
local Log = PeaceMaker.Helpers.Core.Log
local doingAction = false
local BlackListLootT = {}

local function BlackListLoot(GUID)
  table.insert(BlackListLootT, GUID)
end

local function CheckLootBlackList(GUID)
  for _, i in pairs(BlackListLootT) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Looting:SearchLoot(Distance)

  if Distance == nil then Distance = 50 end
  
  local Table = {}
  local Lootable = PeaceMaker.UnitLootable
  for _, Unit in pairs(Lootable) do
    if not CheckLootBlackList(Unit.GUID)
      and Misc:CheckTargetList(Unit.GUID)
      and Unit.Distance <= Distance
    then
      table.insert(Table, Unit)
    end
  end

  if #Table > 1 then
    table.sort(
      Table,
      function(x, y)
        if x.Distance and y.Distance then
          return x.Distance < y.Distance
        end
      end
    )
  end

  for _, Unit in ipairs(Table) do
    if Unit then
      return Unit
    end
  end

  return false
end

function Looting:Run(gotLoot)

  if CurrentLoot and (lb.ObjectDynamicFlags(CurrentLoot.GUID) ~= 4 or PeaceMaker.Time > CurrentLoot.LootTimer) then
    BlackListLoot(CurrentLoot.GUID) CurrentLoot = nil return
  end

  if CurrentLoot == nil then
    if gotLoot then 
      Log:Run("Loot : " .. gotLoot.GUID)
      gotLoot.LootTimer = PeaceMaker.Time + 10
      CurrentLoot = gotLoot
    end
    return
  end

  if CurrentLoot then

    local Distance = lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, CurrentLoot.PosX, CurrentLoot.PosY, CurrentLoot.PosZ)

    local CombatReach = lb.UnitCombatReach(CurrentLoot.GUID) + lb.UnitCombatReach('player') + 0.5

    if Distance then
      if Distance >= CombatReach then
        if lb.NavMgr_IsReachable(CurrentLoot.PosX, CurrentLoot.PosY, CurrentLoot.PosZ) then
          Navigation:MoveTo(CurrentLoot.PosX, CurrentLoot.PosY, CurrentLoot.PosZ, CombatReach)
        else
          BlackListLoot(CurrentLoot.GUID)
        end
      else
        if IsMounted() then Dismount() end
        if GetUnitSpeed('player') > 0 then PeaceMaker.Navigator.Stop() end
        if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
          Misc:Interact(CurrentLoot.GUID)
          doingAction = true
          C_Timer.After(0.5, function() doingAction = false end)
        end
      end
    end
  end

  return

end
