local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Gathering.Gathering = {}

local Gather = PeaceMaker.Helpers.Gathering.Gathering
local Misc = PeaceMaker.Helpers.Core.Misc
local Log = PeaceMaker.Helpers.Core.Log

local ClearBlackList = 0
local RandomJump = 0
local RandomTabTarget = 0
local Timeout1 = GetTime() + math.random(60, 120)
local Timeout2 = 0

local GatherState = {
  Idle = "Idle",
  Dead = "Dead",
  Alive = "Alive",
  Combat = "Combat",
  Rest = "Rest",
  Loot = "Loot",
  Gather = "Gather",
  Mount = "Mount",
  Vendor = "Vendor",
  Roaming = "Roaming",
}

local CurrentState = GatherState.Idle

local function Core()

  local hasCombatEnemy =  PeaceMaker.Helpers.Core.Combat:SearchEnemy(PeaceMaker.Settings.profile.Gathering.CombatTargetDistance)

  local gotHerb = PeaceMaker.Helpers.Gathering.Gather:HerbSearch()
  local gotMine = PeaceMaker.Helpers.Gathering.Gather:MineSearch()
  local gotLoot = PeaceMaker.Helpers.Core.Looting:SearchLoot(PeaceMaker.Settings.profile.Gathering.LootRange)

  if PeaceMaker.Time > Timeout1 and Timeout1 > Timeout2 then Timeout2 = PeaceMaker.Time + math.random(60, 200) end
  if PeaceMaker.Time > Timeout2 and Timeout2 > Timeout1 then Timeout1 = PeaceMaker.Time + math.random(60, 120) end

  if PeaceMaker.Settings.profile.General.RotationName then
    if PeaceMaker.Helpers.Rotation.Core.Engine and not PeaceMaker.Helpers.Rotation.Core.Engine.IsRunning() then
      PeaceMaker.Helpers.Rotation.Core.Engine.Run() 
    end
  end

  if PeaceMaker.Time > ClearBlackList then
    Misc:ClearNodeBlackList()
    ClearBlackList = PeaceMaker.Time + 120
  end

  if PeaceMaker.Player.Dead then
    CurrentState = GatherState.Dead
    PeaceMaker.Helpers.Core.Corpse:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Gathering.UseRandomJump
    and PeaceMaker.Time > RandomJump
    and CurrentState == GatherState.Roaming 
    and PeaceMaker.Player.Moving
    and Timeout1 > PeaceMaker.Time
  then
    lb.Unlock(JumpOrAscendStart)
    C_Timer.After(0.5, function() lb.Unlock(AscendStop) end)
    RandomJump = PeaceMaker.Time + math.random(0.5, 10)
  end

  if PeaceMaker.Settings.profile.Gathering.UseRandomTabTarget
    and PeaceMaker.Time > RandomTabTarget
    and CurrentState == GatherState.Combat
  then
    lb.Unlock(TargetNearestEnemy)
    RandomTabTarget = PeaceMaker.Time + math.random(60, 120)
  end

  if not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Swimming
    and not PeaceMaker.Player.Combat
    and not IsMounted()
    and (PeaceMaker.Settings.profile.Gathering.FoodID ~= 0 and PeaceMaker.Player.HP < PeaceMaker.Settings.profile.Gathering.FoodPercent 
      or PeaceMaker.Settings.profile.Gathering.DrinkID ~= 0 and PeaceMaker.Player.PowerPct < PeaceMaker.Settings.profile.Gathering.DrinkPercent
      or PeaceMaker.RestingState)
  then
    CurrentState = GatherState.Rest
    PeaceMaker.Helpers.Core.Resting:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if not PeaceMaker.Player.Combat 
    and PeaceMaker.Settings.profile.Gathering.AutoLoot
    and Misc:GetFreeBagSlots() > PeaceMaker.Settings.profile.Gathering.BagSlot
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and gotLoot
  then
    CurrentState = GatherState.Loot
    PeaceMaker.Helpers.Core.Looting:Run(gotLoot)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Player.Combat
    and not PeaceMaker.Settings.profile.Gathering.SkipCombat
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and hasCombatEnemy 
  then
    CurrentState = GatherState.Combat
    PeaceMaker.Helpers.Core.Combat:CheckTargetAttackUs()
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Gathering.UseVendor
    and PeaceMaker.Settings.profile.Gathering.UseMammothVendor
    and Misc:CheckMountAvailable(284)
    and (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Gathering.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.Gathering.BagSlot)
      or
      PeaceMaker.VendorState
    )
  then
    CurrentState = GatherState.Vendor
    PeaceMaker.Helpers.Gathering.Vendor:MammothRun()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Gathering.UseMount
    and not PeaceMaker.Player.Dead
    and PeaceMaker.Helpers.Core.Mount:HasMount()
    and not PeaceMaker.Helpers.Gathering.Gather:CheckNodeNearby(15)
    and PeaceMaker.Helpers.Core.Mount:CanBeMount()
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and not IsIndoors()
    and not PeaceMaker.Helpers.Core.Mount:CheckMountBlackListPos(PeaceMaker.Player)
    and PeaceMaker.Time > PeaceMaker.DelayMount
  then
    CurrentState = GatherState.Mount
    PeaceMaker.Helpers.Core.Mount:Run(PeaceMaker.Settings.profile.Gathering.MountID)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Gathering.UseVendor
    and not PeaceMaker.Settings.profile.Gathering.UseMammothVendor
    and
    (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Gathering.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.Gathering.BagSlot)
      or
      PeaceMaker.VendorState
    )
  then  
    CurrentState = GatherState.Vendor
    PeaceMaker.Helpers.Gathering.Vendor:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if ((PeaceMaker.Settings.profile.Gathering.UseHerbing and gotHerb) 
    or
      (PeaceMaker.Settings.profile.Gathering.UseMining and gotMine))
  then
    CurrentState = GatherState.Gather
    PeaceMaker.Helpers.Gathering.Gather:Run(gotHerb, gotMine)
    Log:Run("State : " .. CurrentState)
    return
  end

  if ((not gotHerb and PeaceMaker.Settings.profile.Gathering.UseHerbing) or (not gotMine and PeaceMaker.Settings.profile.Gathering.UseMining)) then 
    CurrentState = GatherState.Roaming
    PeaceMaker.Helpers.Core.Navigation:GatherRoam()
    Log:Run("State : " .. CurrentState)
    return
  end
    
end

function Gather:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end