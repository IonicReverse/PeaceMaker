local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Crafting.Crafting = {}

local Log = PeaceMaker.Helpers.Core.Log
local Crafting = PeaceMaker.Helpers.Crafting.Crafting
local Misc = PeaceMaker.Helpers.Core.Misc

local CraftState = {
  Idle = "Idle",
  Craft = "Crafting",
  Vendor = "Vendor"
}

local function Core()

  local IngredientID = PeaceMaker.CraftIngredientID
  local IngredientAmount = PeaceMaker.CraftIngredientAmount

  if PeaceMaker.Settings.profile.Crafting.UseVendor
    and 
    ( 
      Misc:GetFreeBagSlots() <= PeaceMaker.Settings.profile.Crafting.BagSlot
      or 
      (IngredientID and GetItemCount(IngredientID) == 0)
      or
      PeaceMaker.VendorState
    )
  then
    CurrentState = CraftState.Vendor
    PeaceMaker.Helpers.Crafting.Vendor:Run()
    Log:Run("State : " .. CurrentState)
    return
  end

  if Misc:GetFreeBagSlots() >= PeaceMaker.Settings.profile.Crafting.BagSlot then
    CurrentState = CraftState.Craft
    PeaceMaker.Helpers.Crafting.Craft:Run()
    Log:Run("State : " .. CurrentState)
    return
  end
  
end

function Crafting.Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end