local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Skinning = {}

local Skinning = PeaceMaker.Helpers.Core.Skinning
local Misc = PeaceMaker.Helpers.Core.Misc
local Navigation = PeaceMaker.Helpers.Core.Navigation
local doingAction = false
local BlackListSkinT = {}

local hardcodedBLSkin = { 169819, 169836,169838 }

local function BlackListSkin(GUID)
  table.insert(BlackListSkinT, GUID)
end

local function CheckSkinBlackList(GUID)
  for _, i in pairs(BlackListSkinT) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Skinning:SearchSkin(Distance)
  if Distance == nil then Distance = 50 end

  local Table = {}
  local Skinnable = PeaceMaker.UnitSkinable
  for _, Unit in pairs(Skinnable) do
    if not CheckSkinBlackList(Unit.GUID) 
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
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in pairs(Table) do
    if Unit and not Misc:CompareList(Unit.ObjectID, hardcodedBLSkin) then
      return Unit
    end
  end

  return false
end

function Skinning:Run(gotSkin)

  if CurrentSkin and (not lb.UnitHasFlag(Unit.GUID, __LB__.EUnitFlags.Skinnable) 
      or not lb.UnitTagHandler(UnitIsVisible, CurrentSkin.GUID) or PeaceMaker.Time > CurrentSkin.SkinTimer) 
  then
    BlackListSkin(CurrentSkin.GUID)
    Misc:RemoveTarget(CurrentSkin.GUID)
    CurrentSkin = nil
    return
  end

  if CurrentSkin == nil then
    if gotSkin then
      gotSkin.SkinTimer = PeaceMaker.Time + 10
      CurrentSkin = gotSkin
    end
    return
  end

  local CombatReach = lb.UnitCombatReach(CurrentSkin.GUID) + lb.UnitCombatReach('player') + 0.5

  if CurrentSkin then
    local Distance = lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, CurrentSkin.PosX, CurrentSkin.PosY, CurrentSkin.PosZ)
    if Distance then
      if Distance >= CombatReach then
        if lb.NavMgr_IsReachable(CurrentSkin.PosX, CurrentSkin.PosY, CurrentSkin.PosZ) then
          Navigation:MoveTo(CurrentSkin.PosX, CurrentSkin.PosY, CurrentSkin.PosZ, CombatReach)
        else
          BlackListSkin(CurrentSkin.GUID)
        end
      else
        if IsMounted() then Dismount() end
        if not PeaceMaker.Player.Casting and not PeaceMaker.Player.Moving and not doingAction then
          Misc:Interact(gotSkin.GUID)
          doingAction = true
          C_Timer.After(0.8, function() doingAction = false end)
        end
      end
    end
  end

  return
  
end