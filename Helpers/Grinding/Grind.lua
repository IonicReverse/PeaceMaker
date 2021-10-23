local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Grinding.Grind = {}

local Grind = PeaceMaker.Helpers.Grinding.Grind
local Misc = PeaceMaker.Helpers.Core.Misc
local Log = PeaceMaker.Helpers.Core.Log

local ClearBlackList = 0
local PauseCheck = 0
local SwitchCheck = 0
local RandomJump = 0
local RandomTabTarget = 0
local Timeout1 = GetTime() + math.random(60, 120)
local Timeout2 = 0

local GrindState = {
  Idle = "Idle",
  Dead = "Dead",
  Alive = "Alive",
  Combat = "Combat",
  CombatPull = "CombatPull",
  Summon = "Summon",
  Rest = "Rest",
  RestSpell = "RestSpell",
  Loot = "Loot",
  Skin = "Skin",
  Safety = "Safety",
  Switch = "Switch",
  Gather = "Gather",
  Mount = "Mount",
  Vendor = "Vendor",
  Grind = "Grind",
  Roaming = "Roaming",
}

local CurrentState = GrindState.Idle

-- Check/Define State

local function CheckDefineStateSingle()

  local hasEnemy = PeaceMaker.Helpers.Core.Combat:SearchEnemy()
  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchAttackable()

  local gotLoot = PeaceMaker.Helpers.Core.Looting:SearchLoot(PeaceMaker.Settings.profile.Grinding.LootRange)
  local gotSkin = PeaceMaker.Helpers.Core.Skinning:SearchSkin(PeaceMaker.Settings.profile.Grinding.SkinRange)
  local gotHerb = PeaceMaker.Helpers.Grinding.Gather:HerbSearch()
  local gotMine = PeaceMaker.Helpers.Grinding.Gather:MineSearch()

  local AFKPlayerDistance = PeaceMaker.Settings.profile.Grinding.AFKPlayerDistance

  if PeaceMaker.Time > Timeout1 and Timeout1 > Timeout2 then Timeout2 = PeaceMaker.Time + math.random(60, 200) end
  if PeaceMaker.Time > Timeout2 and Timeout2 > Timeout1 then Timeout1 = PeaceMaker.Time + math.random(60, 120) end

  if PeaceMaker.Player.Dead then
    CurrentState = GrindState.Dead
    PeaceMaker.Helpers.Core.Corpse:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.UseRandomJump
    and PeaceMaker.Time > RandomJump
    and CurrentState ~= GrindState.Rest
    and CurrentState ~= GrindState.Loot
    and CurrentState ~= GrindState.Skin
    and CurrentState ~= GrindState.Combat
    and PeaceMaker.Player.Moving
    and Timeout1 > PeaceMaker.Time
  then
    lb.Unlock(JumpOrAscendStart)
    C_Timer.After(0.5, function() lb.Unlock(AscendStop) end)
    RandomJump = PeaceMaker.Time + math.random(0.5, 10)
  end

  if PeaceMaker.Settings.profile.Grinding.UseRandomTabTarget
    and PeaceMaker.Time > RandomTabTarget
    and CurrentState == GrindState.Combat
  then
    lb.Unlock(TargetNearestEnemy)
    RandomTabTarget = PeaceMaker.Time + math.random(10, 20)
  end

  if not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Swimming
    and not PeaceMaker.Player.Combat
    and not IsMounted()
    and (PeaceMaker.Settings.profile.Grinding.FoodID ~= 0 and PeaceMaker.Player.HP < PeaceMaker.Settings.profile.Grinding.FoodPercent 
      or PeaceMaker.Settings.profile.Grinding.DrinkID ~= 0 and PeaceMaker.Player.PowerPct < PeaceMaker.Settings.profile.Grinding.DrinkPercent
      or PeaceMaker.RestingState)
  then
    CurrentState = GrindState.Rest
    PeaceMaker.Helpers.Core.Resting:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.UsePet
    and not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Combat
    and not PeaceMaker.Player.Pet
  then
    CurrentState = GrindState.Summon
    PeaceMaker.Helpers.Core.Summon:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Player.Combat
    and not PeaceMaker.Settings.profile.Grinding.SkipCombatOnTransport 
    and not IsMounted() 
    and hasEnemy 
  then
    CurrentState = GrindState.Combat
    if PeaceMaker.Helpers.Rotation.Core.Engine and not PeaceMaker.Helpers.Rotation.Core.Engine.IsRunning() then
      PeaceMaker.Helpers.Rotation.Core.Engine.Run() 
    end
    PeaceMaker.Helpers.Core.Combat:Run(hasEnemy)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.AutoLoot
    and not PeaceMaker.Player.Combat 
    and Misc:GetFreeBagSlots() > PeaceMaker.Settings.profile.Grinding.BagSlot
    and not IsMounted()
    and gotLoot
  then
    CurrentState = GrindState.Loot
    PeaceMaker.Helpers.Core.Looting:Run(gotLoot)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.AutoSkinning
    and not PeaceMaker.Player.Combat
    and Misc:GetFreeBagSlots() > PeaceMaker.Settings.profile.Grinding.BagSlot
    and not IsMounted()
    and gotSkin
  then
    CurrentState = GrindState.Skin
    PeaceMaker.Helpers.Core.Skinning:Run(gotSkin)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.UseVendor
    and PeaceMaker.Settings.profile.Grinding.UseMammothVendor
    and Misc:CheckMountAvailable(284)
    and (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Grinding.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.Grinding.BagSlot)
      or
      PeaceMaker.VendorState
    )
  then
    CurrentState = GrindState.Vendor
    PeaceMaker.Helpers.Grinding.Vendor:MammothRun()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.UseMount
    and not PeaceMaker.Player.Combat 
    and PeaceMaker.Helpers.Core.Mount:HasMount()
    and not IsMounted()
    and not IsIndoors()
    and not PeaceMaker.Helpers.Core.Mount:CheckMountBlackListPos(PeaceMaker.Player)
  then
    CurrentState = GrindState.Mount
    PeaceMaker.Helpers.Core.Mount:Run(PeaceMaker.Settings.profile.Grinding.MountID)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.Grinding.UseVendor
    and not PeaceMaker.Settings.profile.Grinding.UseMammothVendor
    and
    (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Grinding.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.Grinding.BagSlot)
      or 
      ((PeaceMaker.Settings.profile.Grinding.FoodAmount > 0 and Misc:CheckFoodCount()) or (PeaceMaker.Settings.profile.Grinding.DrinkAmount > 0 and Misc:CheckDrinkCount()))
      or 
      PeaceMaker.VendorState
    )
  then  
    CurrentState = GrindState.Vendor
    PeaceMaker.Helpers.Grinding.Vendor:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if ((PeaceMaker.Settings.profile.Grinding.Herbing and gotHerb) 
    or
      (PeaceMaker.Settings.profile.Grinding.Mining and gotMine))
  then
    CurrentState = GrindState.Gather
    PeaceMaker.Helpers.Grinding.Gather:Run(gotHerb, gotMine)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.General.UseSafetyFeature
    and not PeaceMaker.Player.Combat
    and PeaceMaker.Helpers.Core.Navigation:NearGrindHotSpot()
    and PeaceMaker.Helpers.Core.Safety:CheckPlayerAround(AFKPlayerDistance)
    and PeaceMaker.Time > PauseCheck
  then
    CurrentState = GrindState.Safety
    PeaceMaker.Helpers.Core.Safety:Run(AFKPlayerDistance)
    Log:Run("State : " .. CurrentState)
    PauseCheck = PeaceMaker.Time + PeaceMaker.Settings.profile.Grinding.SwitchSpotTimer
    return
  end

  if hasCombatEnemy 
    and 
    (
      not PeaceMaker.Player.Combat
    or 
      PeaceMaker.Player.Combat 
      and PeaceMaker.Player.Target
      and (lb.UnitTagHandler(UnitIsTapDenied, PeaceMaker.Player.Target.GUID) or not lb.UnitTagHandler(UnitAffectingCombat, PeaceMaker.Player.Target.GUID))
    )
    and not PeaceMaker.Player.Casting
  then
    CurrentState = GrindState.Grind
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    Log:Run("State : " .. CurrentState)
    return
  end

  if not hasCombatEnemy 
    and 
    (
      not PeaceMaker.Player.Combat
    or
      PeaceMaker.Player.Combat
      and PeaceMaker.Player.Target
      and (lb.UnitTagHandler(UnitIsTapDenied, PeaceMaker.Player.Target.GUID) or not lb.UnitTagHandler(UnitAffectingCombat, PeaceMaker.Player.Target.GUID))
    )
  then
    CurrentState = GrindState.Roaming
    PeaceMaker.Helpers.Core.Navigation:GrindRoam()
    Log:Run("State : " .. CurrentState)
    return
  end

end

local function CheckDefineStateMulti()

  local hasEnemy = PeaceMaker.Helpers.Core.Combat:SearchTagAttackable()
  local hasCombatEnemy = PeaceMaker.Helpers.Core.Combat:SearchEnemy(PeaceMaker.Settings.profile.TagGrinding.CombatTargetDistance)
  local TagEnemyCount = PeaceMaker.Helpers.Core.Combat:CountTagTarget()

  local gotLoot = PeaceMaker.Helpers.Core.Looting:SearchLoot(PeaceMaker.Settings.profile.TagGrinding.LootRange)
  local gotSkin = PeaceMaker.Helpers.Core.Skinning:SearchSkin(PeaceMaker.Settings.profile.TagGrinding.SkinRange)
  local gotHerb = PeaceMaker.Helpers.Grinding.Gather:HerbSearch()
  local gotMine = PeaceMaker.Helpers.Grinding.Gather:MineSearch()

  local AFKPlayerDistance = PeaceMaker.Settings.profile.TagGrinding.AFKPlayerDistance

  if PeaceMaker.Time > Timeout1 and Timeout1 > Timeout2 then Timeout2 = PeaceMaker.Time + math.random(60, 200) end
  if PeaceMaker.Time > Timeout2 and Timeout2 > Timeout1 then Timeout1 = PeaceMaker.Time + math.random(60, 120) end

  if not PeaceMaker.Player.Combat
    and PeaceMaker.Time > ClearBlackList
  then
    Misc:ClearBlackListTarget()
    ClearBlackList = PeaceMaker.Time + 60
  end

  if (
      (TagEnemyCount >= PeaceMaker.GrindTagCount) 
      or 
      (PeaceMaker.Player.Combat and not hasEnemy)
      or
      (PeaceMaker.Player.Combat and (gotLoot or gotSkin))
      or
      ( PeaceMaker.Settings.profile.TagGrinding.PullDistanceLimit ~= 0
        and hasEnemy
        and hasEnemy.Distance > PeaceMaker.Settings.profile.TagGrinding.PullDistanceLimit
        and TagEnemyCount >= 2
      )
    ) 
    and 
    PeaceMaker.Helpers.Core.Navigation:NearGrindHotSpot()
  then
    if not EnableTagGrindCombat then EnableTagGrindCombat = true end
  else
    if (not PeaceMaker.Player.Combat or TagEnemyCount == 0) then
      EnableTagGrindCombat = false 
    end
  end    
    
  if not PeaceMaker.Player.Combat
    and PeaceMaker.Settings.profile.TagGrinding.UseControlDRotation
    and EnableDRotation
  then
    if EnableDRotation then EnableDRotation = false end
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseRandomJump
    and PeaceMaker.Time > RandomJump
    and CurrentState ~= GrindState.Rest
    and CurrentState ~= GrindState.Loot
    and CurrentState ~= GrindState.Skin
    and CurrentState ~= GrindState.Combat
    and CurrentState ~= GrindState.CombatPull
    and PeaceMaker.Player.Moving
    and Timeout1 > PeaceMaker.Time
  then
    lb.Unlock(JumpOrAscendStart)
    C_Timer.After(0.5, function() lb.Unlock(AscendStop) end)
    RandomJump = PeaceMaker.Time + math.random(0.5, 10)
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseRandomTabTarget
    and PeaceMaker.Time > RandomTabTarget
    and CurrentState == GrindState.Combat
  then
    lb.Unlock(TargetNearestEnemy)
    RandomTabTarget = PeaceMaker.Time + math.random(10, 20)
  end

  if PeaceMaker.Player.Dead then
    CurrentState = GrindState.Dead
    PeaceMaker.Helpers.Core.Corpse:Run()
    if EnableDRotation then EnableDRotation = false end
    if EnableTagGrindCombat then EnableTagGrindCombat = false end
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Player.Class == 11
    and not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Casting
  then
    if GetShapeshiftForm() ~= 1
      and CurrentState == GrindState.Grind
    then
      Misc:CastSpellByID("Bear Form")
      return
    end

    if GetShapeshiftForm() ~= 3
      and (CurrentState == GrindState.Roaming or CurrentState == GrindState.Vendor)
    then
      Misc:CastSpellByID("Travel Form")
      return
    end
  end

  if (PeaceMaker.Settings.profile.TagGrinding.FoodID ~= 0 and PeaceMaker.Player.HP < PeaceMaker.Settings.profile.TagGrinding.FoodPercent 
      or PeaceMaker.Settings.profile.TagGrinding.DrinkID ~= 0 and PeaceMaker.Player.PowerPct < PeaceMaker.Settings.profile.TagGrinding.DrinkPercent
      or PeaceMaker.RestingState)
    and not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Swimming
    and not PeaceMaker.Player.Combat
    and not IsMounted()
  then
    CurrentState = GrindState.Rest
    PeaceMaker.Helpers.Core.Resting:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseRestSpell
    and not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Swimming
    and not PeaceMaker.Player.Combat
    and not IsMounted()
    and PeaceMaker.Player.HP < PeaceMaker.Settings.profile.TagGrinding.RestSpellHP
  then
    CurrentState = GrindState.Rest
    PeaceMaker.Helpers.Core.Resting:SpellRun()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.UsePet
    and not PeaceMaker.Player.Dead
    and not PeaceMaker.Player.Combat
    and not PeaceMaker.Player.Pet
  then
    CurrentState = GrindState.Summon
    PeaceMaker.Helpers.Core.Summon:Run(PeaceMaker.Player.Class)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.AutoLoot
    and not PeaceMaker.Player.Combat 
    and Misc:GetFreeBagSlots() > PeaceMaker.Settings.profile.TagGrinding.BagSlot
    and gotLoot
  then
    CurrentState = GrindState.Loot
    PeaceMaker.Helpers.Core.Looting:Run(gotLoot)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.OverPull
    and EnableTagGrindCombat 
    and PeaceMaker.Player.Combat 
    and hasEnemy 
    and hasEnemy.Distance <= PeaceMaker.Settings.profile.TagGrinding.OverPullDistance
    and PeaceMaker.Player.HP >= PeaceMaker.Settings.profile.TagGrinding.StopOverPullWhen
  then
    CurrentState = GrindState.CombatPull
    PeaceMaker.Helpers.Core.Combat:TagRun(hasEnemy)
    Log:Run("State : " .. CurrentState)
    if not GrindStateIsRunning then GrindStateIsRunning = true end
    return
  end

  if PeaceMaker.Player.Combat
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and (TagEnemyCount >= PeaceMaker.GrindTagCount 
      or (PeaceMaker.GrindHPFightBack ~= 0 and PeaceMaker.Player.HP < PeaceMaker.GrindHPFightBack)
      or EnableTagGrindCombat
    )
  then
    CurrentState = GrindState.Combat
    if PeaceMaker.Helpers.Rotation.Core.Engine and not PeaceMaker.Helpers.Rotation.Core.Engine.IsRunning() then
      PeaceMaker.Helpers.Rotation.Core.Engine.Run() 
    end
    PeaceMaker.Helpers.Core.Combat:CheckTargetAttackUs()
    PeaceMaker.Helpers.Core.Combat:Run(hasCombatEnemy)
    Log:Run("State : " .. CurrentState)
    if GrindStateIsRunning then GrindStateIsRunning = false end
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.AutoSkinning
    and not PeaceMaker.Player.Combat
    and Misc:GetFreeBagSlots() > PeaceMaker.Settings.profile.TagGrinding.BagSlot
    and gotSkin
  then
    CurrentState = GrindState.Skin
    PeaceMaker.Helpers.Core.Skinning:Run(gotSkin)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseVendor
    and PeaceMaker.Settings.profile.TagGrinding.UseMammothVendor
    and Misc:CheckMountAvailable(284)
    and (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.TagGrinding.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.TagGrinding.BagSlot)
      or
      PeaceMaker.VendorState
    )
  then
    CurrentState = GrindState.Vendor
    PeaceMaker.Helpers.Grinding.Vendor:MammothRun()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseMount
    and not PeaceMaker.Helpers.Core.Combat:GetUnitsNearPlayer(PeaceMaker.Settings.profile.TagGrinding.MountWhenEnemyDistance)
    and not PeaceMaker.Player.Combat 
    and not PeaceMaker.Player.Dead
    and PeaceMaker.Helpers.Core.Mount:HasMount()
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and not IsIndoors()
    and not PeaceMaker.Helpers.Core.Mount:CheckMountBlackListPos(PeaceMaker.Player)
    and (CurrentState ~= GrindState.Combat or CurrentState ~= GrindState.Grind)
  then
    CurrentState = GrindState.Mount
    PeaceMaker.Helpers.Core.Mount:Run(PeaceMaker.Settings.profile.TagGrinding.MountID)
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.TagGrinding.UseVendor
    and not PeaceMaker.Settings.profile.TagGrinding.UseMammothVendor
    and
    (
      (PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.TagGrinding.Durability or Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.TagGrinding.BagSlot)
      or 
      ((PeaceMaker.Settings.profile.TagGrinding.FoodAmount > 0 and Misc:CheckFoodCount()) or (PeaceMaker.Settings.profile.TagGrinding.DrinkAmount > 0 and Misc:CheckDrinkCount()))
      or
      PeaceMaker.VendorState
    )
  then  
    CurrentState = GrindState.Vendor
    PeaceMaker.Helpers.Grinding.Vendor:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if PeaceMaker.Settings.profile.General.UseSafetyFeature
    and not PeaceMaker.Player.Combat
    and PeaceMaker.Helpers.Core.Safety:CheckPlayerAround(AFKPlayerDistance)
    and PeaceMaker.Helpers.Core.Navigation:NearGrindHotSpot()
    and PeaceMaker.Time > PauseCheck
    and CurrentState ~= GrindState.Grind
  then
    CurrentState = GrindState.Safety
    PeaceMaker.Helpers.Core.Safety:Run(AFKPlayerDistance)
    Log:Run("State : " .. CurrentState)
    PauseCheck = PeaceMaker.Time + PeaceMaker.Settings.profile.TagGrinding.SwitchSpotTimer
    return
  end
  
  if hasEnemy  
    and
    (
      not PeaceMaker.Player.Combat
    or 
      (PeaceMaker.Player.Combat and TagEnemyCount < PeaceMaker.GrindTagCount)
    )
    and not EnableTagGrindCombat
  then
    CurrentState = GrindState.Grind
    PeaceMaker.Helpers.Core.Combat:TagRun(hasEnemy)
    Log:Run("State : " .. CurrentState)
    if not GrindStateIsRunning then GrindStateIsRunning = true end
    return
  end

  if not hasEnemy then
    CurrentState = GrindState.Roaming
    PeaceMaker.Helpers.Core.Navigation:TagGrindRoam()
    Log:Run("State : " .. CurrentState .. " Index " .. tostring(WPIndex))
    return
  end

end

local function Core()
  if PeaceMaker.Mode == "Grind" then
    CheckDefineStateSingle()
  end
  
  if PeaceMaker.Mode == "TagGrind" then
    CheckDefineStateMulti()
  end
end

function Grind:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end