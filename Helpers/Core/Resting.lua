local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Resting = {}

local Resting = PeaceMaker.Helpers.Core.Resting
local Misc = PeaceMaker.Helpers.Core.Misc
local RestingState = false
local PauseRest = 0

local function HasFoodBuff()
  for i=1,40 do
    local name = UnitBuff("player", i)
    if name and name == GetSpellInfo(433) then
      return true
    end
  end
  return false
end

local function HasDrinkBuff()
  for i=1,40 do
    local name = UnitBuff("player", i)
    if name and name == GetSpellInfo(430) then
      return true
    end
  end
  return false
end

local function DrinkClassRest()
  if PeaceMaker.Player.Class == 8
    or PeaceMaker.Player.Class == 9 
    or PeaceMaker.Player.Class == 5
    or PeaceMaker.Player.Class == 2
    or PeaceMaker.Player.Class == 11
    or PeaceMaker.Player.Class == 7
    or PeaceMaker.Player.Class == 3
  then
    return true
  end
  return false
end

function Resting:Run()

  if PauseRest > PeaceMaker.Time then return end
  if PeaceMaker.Player.Casting then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Helpers.Core.Navigation:StopMoving() return end

  local FoodID
  local FoodPercent
  local WaterID
  local WaterPercent

  if PeaceMaker.Mode == "Grind" then
    FoodID = PeaceMaker.Settings.profile.Grinding.FoodID
    FoodPercent = PeaceMaker.Settings.profile.Grinding.FoodPercent
    WaterID = PeaceMaker.Settings.profile.Grinding.WaterID 
    WaterPercent = PeaceMaker.Settings.profile.Grinding.WaterPercent 
  end

  if PeaceMaker.Mode == "TagGrind" then
    FoodID = PeaceMaker.Settings.profile.TagGrinding.FoodID
    FoodPercent = PeaceMaker.Settings.profile.TagGrinding.FoodPercent
    WaterID = PeaceMaker.Settings.profile.TagGrinding.WaterID 
    WaterPercent = PeaceMaker.Settings.profile.TagGrinding.WaterPercent 
  end

  if PeaceMaker.Mode == "Gather" then
    FoodID = PeaceMaker.Settings.profile.Gathering.FoodID
    FoodPercent = PeaceMaker.Settings.profile.Gathering.FoodPercent
    WaterID = PeaceMaker.Settings.profile.Gathering.WaterID 
    WaterPercent = PeaceMaker.Settings.profile.Gathering.WaterPercent 
  end

  if not HasFoodBuff() or (DrinkClassRest() and not HasWaterBuff()) or PeaceMaker.Player.HP == 100 then lb.Unlock(RunMacroText, "/stand") PeaceMaker.RestingState = false end
  if HasFoodBuff() or (DrinkClassRest() and HasWaterBuff()) then PeaceMaker.RestingState = true end

  if PeaceMaker.Player.HP < FoodPercent
    and FoodID ~= 0
    and not HasFoodBuff()
  then
    lb.Unlock(UseItemByName, tonumber(FoodID))
    PauseRest = PeaceMaker.Time + 0.5
    return
  end

  if PeaceMaker.Player.PowerPct < WaterPercent
    and WaterID ~= 0
    and DrinkClassRest()
    and not HasWaterBuff()
  then
    lb.Unlock(UseItemByName, tonumber(WaterID))
    PauseRest = PeaceMaker.Time + 0.5
    return
  end

  return

end

function Resting:SpellRun()
  if PauseRest > PeaceMaker.Time then return end
  if PeaceMaker.Player.Casting then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Helpers.Core.Navigation:StopMoving() return end
  if PeaceMaker.Player.Class == 2 then
    if PeaceMaker.Player.HP <= PeaceMaker.Settings.profile.TagGrinding.RestSpellHP then
      Misc:CastSpellByID("Flash of Light", "player")
      return
    end
  end
  if PeaceMaker.Player.Class == 10 then
    if PeaceMaker.Player.HP <= PeaceMaker.Settings.profile.TagGrinding.RestSpellHP then
      Misc:CastSpellByID("Vivify", "player")
      return
    end
  end
end