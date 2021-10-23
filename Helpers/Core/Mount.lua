local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Mount = {}
local Log = PeaceMaker.Helpers.Core.Log
local Mount = PeaceMaker.Helpers.Core.Mount
local Misc = PeaceMaker.Helpers.Core.Misc
local MountState = false

local BlackListAreaCoordinate = {
  [1] = { -11810.3, -3205.74, -29.28 },
  [2] = { 4054.66, -2024.13, 73.38 },
  [3] = { -4537.25, -4936.94, 6527.54 },
  [4] = { -4570.06, -4941.47, 6529.5 }
}

function Mount:Timer()
  if PeaceMaker.Player.Class then return 2 else return 4 end
end

function Mount:CheckMountBlackListPos(Player)
  if BlackListAreaCoordinate then
    for i = 1, #BlackListAreaCoordinate do
      local nodeX, nodeY, nodeZ = unpack(BlackListAreaCoordinate[i])
      local dist = lb.GetDistance3D(Player.PosX, Player.PosY, Player.PosZ, nodeX, nodeY, nodeZ)
      if dist and dist < 30 then
        return true
      end
    end
  end
  return false
end


function Mount:CanBeMount()
  if PeaceMaker.Player.Class == 11 then
    return true
  else
    if PeaceMaker.Player.Class ~= 11 then
      if not PeaceMaker.Player.Combat then
        return true
      end
    end
  end
  return false
end

function Mount:CheckDruidTravelForm()
  if IsUsableSpell(783) then 
    return true
  end
  return false
end

function Mount:CheckMountedMount()
  if PeaceMaker.Player.Class == 11 and (GetShapeshiftForm() == 0 or (GetShapeshiftForm() ~= 3 and GetShapeshiftForm() ~= 4)) then
    return true
  else
    if PeaceMaker.Player.Class == 2 then
      if not IsMounted() and not Misc:CheckBuff("Divine Steed") then
        return true
      end
    end
    if PeaceMaker.Player.Class ~= 11 and PeaceMaker.Player.Class ~= 2 then
      if not IsMounted() then
        return true
      end
    end
  end
  return false
end

function Mount:HasMount()
  local mountIDs = C_MountJournal.GetMountIDs()
  for i, mountID in ipairs(mountIDs) do
    local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
    if (isCollected and hideOnChar ~= true) then
      return true
    end
  end
  return false
end

function Mount:ListOfMount()
  local Table = {}
  local mountIDs = C_MountJournal.GetMountIDs()
  for i, mountID in ipairs(mountIDs) do
    local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected, id = C_MountJournal.GetMountInfoByID(mountID)
    if (isCollected and hideOnChar ~= true) then
      table.insert(Table, id)
    end
  end
  return Table
end

function Mount:UseMount(MountID)
  if PeaceMaker.Player.Class == 11 then
    if self:CheckDruidTravelForm() then
      if GetShapeshiftFormID() ~= 3 then
        Log:Run("Casting Mount")
        Misc:CastSpellByID(783)
      end
    end
  else
    if (not MountID or MountID == 0) then
      local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, isFiltered, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(1)
      C_MountJournal.SummonByID(mountID)
    else
      if MountID then
        local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(MountID)
        if (isCollected and hideOnChar ~= true) then
          Log:Run("Casting Mount")
          C_MountJournal.SummonByID(MountID)
        else
          if not (isCollected and hideOnChar ~= true) then
            Log:Run("No Mount! Cast Default Mount")
            local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, isFiltered, isCollected, mountID = C_MountJournal.GetDisplayedMountInfo(1)
            C_MountJournal.SummonByID(mountID)
          end
        end
      end
    end
  end
end

function Mount:Run(MountID)
  local Mounted = tonumber(MountID)
  if MountState then return end
  if PeaceMaker.Player.Casting then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
  if self:CheckMountedMount()
    and self:HasMount()
  then
    Log:Run("Mounting")
    --PeaceMaker.Navigator.Stop()
    Mount:UseMount(Mounted)
    MountState = true
    C_Timer.After(self:Timer(), function()
      MountState = false
      if self:CheckMountedMount() then
        Log:Run("Mount Failed! Mount Again")
      end
    end)
  end
end