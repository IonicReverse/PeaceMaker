local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Destroy = {}

local Misc = PeaceMaker.Helpers.Core.Misc
local Destroy = PeaceMaker.Helpers.Core.Destroy
local DestroyTimer = 0

local function DestroyList()
  for BagID = 0, 5 do
    for BagSlot = 1, GetContainerNumSlots(BagID) do
      local itemID = select(10,GetContainerItemInfo(BagID, BagSlot))
      if itemID and itemID ~= 6948 then
        local itemClassID = select(12, GetItemInfo(itemID))
        local itemRarity = select(3, GetItemInfo(itemID))
        local itemLevel = select(4, GetItemInfo(itemID))
        local itemSellPrice = select(11, GetItemInfo(itemID))
        if Misc:CompareList(itemID, PeaceMaker.Settings.profile.General.DestroyItem) then
          PickupContainerItem(BagID, BagSlot)
          lb.Unlock(DeleteCursorItem)
        end
      end
    end
  end
  DestroyTimer = PeaceMaker.Time + 30
end

function Destroy:Run()
  if PeaceMaker.Time > DestroyTimer then
    DestroyList()
  end
end