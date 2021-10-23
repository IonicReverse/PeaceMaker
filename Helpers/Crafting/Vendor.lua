local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Crafting.Vendor = {}

local Vendors = PeaceMaker.Helpers.Crafting.Vendor
local Log = PeaceMaker.Helpers.Core.Log
local Misc = PeaceMaker.Helpers.Core.Misc

local VendorPathIndex = 1

local Vendor = {
  IsMounted = false,
  Interact = false,
  InteractSendMailFrame = false,
  IsGossip = false,
  IsRestock = false,
  IsSelling = false,
  IsMailing = false,
  BuyDelay = 0,
  SellDelay = 0
}

local function Restock(Itemid, Amount)

  if Vendor.BuyDelay > PeaceMaker.Time then return end

  local maxAmount = Amount
  local currentAmount = GetItemCount(Itemid)
  if currentAmount >= maxAmount then return end
  for i=1, GetMerchantNumItems() do
    local merchantitem_name = select(1, GetMerchantItemInfo(i));        
    if merchantitem_name == GetItemInfo(Itemid) then
      if currentAmount < maxAmount then
        local buyrepeat = 1
        local remainder = 0
        local buyamount = maxAmount - currentAmount
        local itemstack = GetMerchantItemMaxStack(i)
        buyrepeat = floor(buyamount/itemstack)
        remainder = mod(buyamount, itemstack)
        for n=1, buyrepeat do
          BuyMerchantItem(i,itemstack)
          Vendor.BuyDelay = PeaceMaker.Time + 1
          return
        end
        if remainder > 0 then
          BuyMerchantItem(i,remainder)
          Vendor.BuyDelay = PeaceMaker.Time + 1
          return
        end
      end
    end
  end

  return
end

local function SellList()
  if Vendor.SellDelay > PeaceMaker.Time then return end
  for BagID = 0, 5 do
    for BagSlot = 1, GetContainerNumSlots(BagID) do
      local itemID = select(10,GetContainerItemInfo(BagID, BagSlot))
      if itemID and itemID ~= 6948 then
        local itemClassID = select(12, GetItemInfo(itemID))
        local itemRarity = select(3, GetItemInfo(itemID))
        local itemLevel = select(4, GetItemInfo(itemID))
        local itemSellPrice = select(11, GetItemInfo(itemID))
        if itemRarity <= 3 and itemSellPrice > 0 then
          if not Misc:CompareList(itemID, PeaceMaker.Settings.profile.Crafting.WhiteListItem) then
            UseContainerItem(BagID, BagSlot)
            Vendor.SellDelay = PeaceMaker.Time + 0.05
            break
          end
        end
      end
    end
  end
end

local function CountWhiteList()
  local Count = 0
  for BagID = 0, 5 do
    for BagSlot = 1, GetContainerNumSlots(BagID) do
      local itemID = select(10,GetContainerItemInfo(BagID, BagSlot))
      if itemID and itemID ~= 6948 then
        local itemClassID = select(12, GetItemInfo(itemID))
        local itemRarity = select(3, GetItemInfo(itemID))
        local itemLevel = select(4, GetItemInfo(itemID))
        local itemSellPrice = select(11, GetItemInfo(itemID))
        if itemSellPrice > 0 then
          if Misc:CompareList(itemID, PeaceMaker.Settings.profile.Crafting.WhiteListItem) then
            Count = Count + 1
          end
        end
      end
    end
  end
  return Count
end

local function AutoSelectVendorGossip()
  for i = 1, #C_GossipInfo.GetOptions() do
    local type, name, status, rewards = C_GossipInfo.GetOptions()[i]
    if type == "vendor" then
      return i
    end
  end
end

local function CheckNearbyRepairVendor(RepairX, RepairY, RepairZ, Range)
  local px, py, pz = lb.ObjectPosition('player')
  if lb.GetDistance3D(px, py, pz, RepairX, RepairY, RepairZ) < Range then
    return true
  end
  return false
end

local function CheckMailList(Mailitemlist, name)
  if string.len(Mailitemlist) > 0 then
    local ItemList = SplitStrTable(Mailitemlist, ";")
    for _, i in pairs (ItemList) do
      if string.find(name, i) then
        return true
      end
    end
  end
  return false
end

local function CheckMailItem()
  for bag = 0,4,1 do
    for slot = 1, GetContainerNumSlots(bag), 1 do
      local name = GetContainerItemLink(bag, slot)
      if name 
        and CheckMailItem(name)
      then
        return true
      end 
    end 
  end
  return false
end

local function SearchMailBox()
  local GameObjects = PeaceMaker.GameObjects
  for _, Obj in pairs(GameObjects) do
    if Obj ~= nil then
      if Obj.Name == "Mailbox"
        and Obj.Distance <= 10
      then
        return Obj.GUID
      end
    end
  end
  return nil
end


local function Core()

  local px, py, pz = lb.ObjectPosition('player')

  local VendorX, VendorY, VendorZ
  local VendorNpcID
  local IngredientID
  local IngredientAmount
  local UseMail
  local MailPosX, MailPosY, MailPosZ
  local BagSlot 
  local CountWhiteListItem

  if PeaceMaker.Mode == "Craft" then
    VendorX, VendorY, VendorZ = Misc:SplitStr(PeaceMaker.CraftVendorNpcPos)
    VendorNpcID = PeaceMaker.CraftVendorNpcID
    IngredientID = PeaceMaker.CraftIngredientID
    IngredientAmount = PeaceMaker.CraftIngredientAmount
    UseMail = PeaceMaker.Settings.profile.Crafting.UseMail
    MailPosX, MailPosY, MailPosZ = Misc:SplitStr(PeaceMaker.CraftMailPos)
    BagSlot = PeaceMaker.Settings.profile.Crafting.BagSlot
    CountWhiteListItem = CountWhiteList()
  end
  
  if PeaceMaker.VendorStep == 0 then
    if not PeaceMaker.VendorState then PeaceMaker.VendorState = true end
    if (Misc:GetMaxBagSlots() - Misc:GetFreeBagSlots()) >= (CountWhiteListItem + 5) then
      if lb.GetDistance3D(px, py, pz, VendorX, VendorY, VendorZ) > 3 then
        if not PeaceMaker.Player.Moving then
          PeaceMaker.Helpers.Core.Navigation:MoveTo(VendorX, VendorY, VendorZ, 2)
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(VendorNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if GossipFrame:IsVisible() then
          C_GossipInfo.SelectOption(AutoSelectVendorGossip())
          Vendor.IsGossip = true
          C_Timer.After(2, function() Vendor.IsGossip = false GossipFrameCloseButton:Click() end)
        end

        if MerchantFrame:IsVisible() then
          if CanMerchantRepair() then
            RepairAllItems()
          end
          SellList()
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 1
    end
  end

  if PeaceMaker.VendorStep == 1 then
    if (IngredientID ~= 0 and IngredientAmount ~= 0) and GetItemCount(IngredientID) < IngredientAmount then
      if lb.GetDistance3D(px, py, pz, VendorX, VendorY, VendorZ) > 3 then
        if not PeaceMaker.Player.Moving then
          PeaceMaker.Helpers.Core.Navigation:MoveTo(VendorX, VendorY, VendorZ, 2)
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(VendorNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if MerchantFrame:IsVisible() then
          Restock(IngredientID, IngredientAmount)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 2
    end
  end

  if PeaceMaker.VendorStep == 2 then
    if UseMail then
      if lb.GetDistance3D(px, py, pz, MailPosX, MailPosY, MailPosZ) > 3 then
        if not PeaceMaker.Player.Moving then
          PeaceMaker.Helpers.Core.Navigation:MoveTo(MailPosX, MailPosY, MailPosZ, 2)
        end
      else
        if not InboxFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(SearchMailBox())
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if InboxFrame:IsVisible() and not SendMailFrame:IsVisible() and not Vendor.InteractSendMailFrame then
          MailFrameTab2:Click()
          Vendor.InteractSendMailFrame = true
          C_Timer.After(2, function() Vendor.InteractSendMailFrame = false end)
        end

        if SendMailFrame:IsVisible() then
          MailItem(MailItemList, MailTo, MailToTitle)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 3
    end
  end

  if PeaceMaker.VendorStep == 3 then
    Vendor.Interact = false
    Vendor.InteractSendMailFrame = false
    Vendor.IsGossip = false
    PeaceMaker.VendorStep = 0
    PeaceMaker.VendorState = false
    Log:Run("Last Step : " .. tostring(PeaceMaker.VendorStep))
    return
  end

end

function Vendors:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end
