local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.Vendor = {}

local QuestVendor = PeaceMaker.Helpers.Quest.Vendor
local Misc = PeaceMaker.Helpers.Core.Misc
local Log = PeaceMaker.Helpers.Core.Log

local Vendor = {
  IsMounted = false,
  Interact = false,
  InteractSendMailFrame = false,
  IsGossip = false,
  IsSelling = false,
  IsFoodRestock = false,
  IsDrinkRestock = false,
  IsMailing = false,
  IsReached = false,
  BuyDelay = 0,
  SellDelay = 0
}

local function Restock(Mode, Itemid, Amount)

  if Mode == 0 then
    if Vendor.BuyDelay > PeaceMaker.Time then return end
    local maxAmount = Amount
    local currentAmount = GetItemCount(Itemid)
    if currentAmount >= maxAmount then Vendor.IsFoodRestock = true return end
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
        else
          Vendor.IsFoodRestock = true
          return
        end
      end
    end
  end

  if Mode == 1 then
    if Vendor.BuyDelay > PeaceMaker.Time then return end
    local maxAmount = Amount
    local currentAmount = GetItemCount(Itemid)
    if currentAmount >= maxAmount then Vendor.IsDrinkRestock = true return end
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
        else
          Vendor.IsDrinkRestock = true
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
        if itemRarity < 4 and itemSellPrice > 0 then
          if not Misc:CompareList(itemID, PeaceMaker.Settings.profile.Questing.WhiteListItem) then
            UseContainerItem(BagID, BagSlot)
            Vendor.SellDelay = PeaceMaker.Time + 0.2
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
          if Misc then
            if Misc:CompareList(itemID, PeaceMaker.Settings.profile.Questing.WhiteListItem) then
              Count = Count + 1
            end
          end
        end
        if (itemSellPrice == 0 or itemRarity >= 4) then
          Count = Count + 1
        end
      end
    end
  end
  return Count
end

local function AutoSelectVendorGossip()
  for i = 1, #C_GossipInfo.GetOptions() do
    if C_GossipInfo.GetOptions()[i].type == "vendor" then
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

local function Core(RepairNpcPos, RepairNpcID, FoodNpcPos, FoodNpcID, FoodID, DrinkID, FoodAmount, DrinkAmount, Durability, BagSlot)

  local px, py, pz = lb.ObjectPosition('player')

  local RepairVendorX, RepairVendorY, RepairVendorZ = unpack(RepairNpcPos)
  local RepairNpcID = RepairNpcID
  local FoodVendorX, FoodVendorY, FoodVendorZ = unpack(FoodNpcPos)
  local FoodNpcID = FoodNpcID
  local FoodID = FoodID
  local DrinkID = DrinkID
  local FoodAmount = FoodAmount
  local DrinkAmount = DrinkAmount
  local Durability = Durability
  local BagSlot = BagSlot
  local CountWhiteListItem = CountWhiteList()

  if PeaceMaker.VendorStep == 0 then

    if not PeaceMaker.VendorState then PeaceMaker.VendorState = true end

    if PeaceMaker.Helpers.Core.Mount:HasMount() 
      and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
      and not PeaceMaker.Player.Combat
    then 
      PeaceMaker.Helpers.Core.Mount:Run(MountID) 
      return 
    end

    if PeaceMaker.Player:Durability() <= Durability then
      if lb.GetDistance3D(px, py, pz, RepairVendorX, RepairVendorY, RepairVendorZ) > 3 then
        if PeaceMaker.VendorWPRoute ~= nil and #PeaceMaker.VendorWPRoute > 0 then
          local Vx, Vy, Vz = PeaceMaker.VendorWPRoute[VendorPathIndex].x, PeaceMaker.VendorWPRoute[VendorPathIndex].y, PeaceMaker.VendorWPRoute[VendorPathIndex].z
          if lb.GetDistance3D(px, py, pz, Vx, Vy, Vz) <= 2 then
            VendorPathIndex = VendorPathIndex + 1
            if VendorPathIndex > #PeaceMaker.VendorWPRoute then
              VendorPathIndex = 1
            end
          else
            if not PeaceMaker.Player.Moving then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(Vx, Vy, Vz, 2)
            end
          end
        else
          if not PeaceMaker.Player.Moving then
            PeaceMaker.Helpers.Core.Navigation:MoveTo(RepairVendorX, RepairVendorY, RepairVendorZ, 2)
          end
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(RepairNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if GossipFrame:IsVisible() then
          if not PeaceMaker.GrindVendorGossip then C_GossipInfo.SelectOption(AutoSelectVendorGossip()) else C_GossipInfo.SelectOption(PeaceMaker.GrindVendorGossip) end
          Vendor.IsGossip = true
          C_Timer.After(2, function() Vendor.IsGossip = false GossipFrameCloseButton:Click() end)
        end

        if MerchantFrame:IsVisible() then
          if CanMerchantRepair() then
            RepairAllItems()
          end
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 1
    end
  end

  if PeaceMaker.VendorStep == 1 then
    if (Misc:GetMaxBagSlots() - Misc:GetFreeBagSlots()) > (CountWhiteListItem + 1) then
      if lb.GetDistance3D(px, py, pz, RepairVendorX, RepairVendorY, RepairVendorZ) > 3 then
        if PeaceMaker.VendorWPRoute ~= nil and #PeaceMaker.VendorWPRoute > 0 then
          local Vx, Vy, Vz = PeaceMaker.VendorWPRoute[VendorPathIndex].x, PeaceMaker.VendorWPRoute[VendorPathIndex].y, PeaceMaker.VendorWPRoute[VendorPathIndex].z
          if lb.GetDistance3D(px, py, pz, Vx, Vy, Vz) <= 2 then
            VendorPathIndex = VendorPathIndex + 1
            if VendorPathIndex > #PeaceMaker.VendorWPRoute then
              VendorPathIndex = 1
            end
          else
            if not PeaceMaker.Player.Moving then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(Vx, Vy, Vz, 2)
            end
          end
        else
          if not PeaceMaker.Player.Moving then
            PeaceMaker.Helpers.Core.Navigation:MoveTo(RepairVendorX, RepairVendorY, RepairVendorZ, 2)
          end
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(RepairNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if GossipFrame:IsVisible() then
          if not PeaceMaker.GrindVendorGossip then C_GossipInfo.SelectOption(AutoSelectVendorGossip()) else C_GossipInfo.SelectOption(PeaceMaker.GrindVendorGossip) end
          Vendor.IsGossip = true
          C_Timer.After(2, function() Vendor.IsGossip = false GossipFrameCloseButton:Click() end)
        end

        if MerchantFrame:IsVisible() then
          SellList()
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 2
    end
  end

  if PeaceMaker.VendorStep == 2 then
    if FoodAmount > 0 and FoodID ~= 0 and not Vendor.IsFoodRestock then
      if lb.GetDistance3D(px, py, pz, FoodVendorX, FoodVendorY, FoodVendorZ) > 3 then
        if PeaceMaker.VendorWPRoute ~= nil and #PeaceMaker.VendorWPRoute > 0 and not Vendor.IsReached then
          local Vx, Vy, Vz = PeaceMaker.VendorWPRoute[VendorPathIndex].x, PeaceMaker.VendorWPRoute[VendorPathIndex].y, PeaceMaker.VendorWPRoute[VendorPathIndex].z
          if lb.GetDistance3D(px, py, pz, Vx, Vy, Vz) <= 2 then
            VendorPathIndex = VendorPathIndex + 1
            if VendorPathIndex > #PeaceMaker.VendorWPRoute then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(FoodVendorX, FoodVendorY, FoodVendorZ, 2)
              Vendor.IsReached = true
              VendorPathIndex = 1
            end
          else
            if not PeaceMaker.Player.Moving then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(Vx, Vy, Vz, 2)
            end
          end
        else
          if not PeaceMaker.Player.Moving then
            PeaceMaker.Helpers.Core.Navigation:MoveTo(FoodVendorX, FoodVendorY, FoodVendorZ, 2)
          end
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(FoodNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if GossipFrame:IsVisible() then
          C_GossipInfo.SelectOption(AutoSelectVendorGossip())
          Vendor.IsGossip = true
          C_Timer.After(2, function() Vendor.IsGossip = false GossipFrameCloseButton:Click() end)
        end

        if MerchantFrame:IsVisible() then
          Restock(0, FoodID, FoodAmount)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 3
    end
  end

  if PeaceMaker.VendorStep == 3 then
    if DrinkAmount > 0 and DrinkID ~= 0 and not Vendor.IsDrinkRestock then
      if lb.GetDistance3D(px, py, pz, FoodVendorX, FoodVendorY, FoodVendorZ) > 3 then
        if PeaceMaker.VendorWPRoute ~= nil and #PeaceMaker.VendorWPRoute > 0 and not Vendor.IsReached then
          local Vx, Vy, Vz = PeaceMaker.VendorWPRoute[VendorPathIndex].x, PeaceMaker.VendorWPRoute[VendorPathIndex].y, PeaceMaker.VendorWPRoute[VendorPathIndex].z
          if lb.GetDistance3D(px, py, pz, Vx, Vy, Vz) <= 2 then
            VendorPathIndex = VendorPathIndex + 1
            if VendorPathIndex > #PeaceMaker.VendorWPRoute then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(FoodVendorX, FoodVendorY, FoodVendorZ, 2)
              Vendor.IsReached = true
              VendorPathIndex = 1
            end
          else
            if not PeaceMaker.Player.Moving then
              PeaceMaker.Helpers.Core.Navigation:MoveTo(Vx, Vy, Vz, 2)
            end
          end
        else
          if not PeaceMaker.Player.Moving then
            PeaceMaker.Helpers.Core.Navigation:MoveTo(FoodVendorX, FoodVendorY, FoodVendorZ, 2)
          end
        end
      else
        if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
          Misc:InteractUnit(FoodNpcID)
          Vendor.Interact = true
          C_Timer.After(1, function() Vendor.Interact = false end)
        end

        if GossipFrame:IsVisible() then
          C_GossipInfo.SelectOption(AutoSelectVendorGossip()) 
          Vendor.IsGossip = true
          C_Timer.After(2, function() Vendor.IsGossip = false GossipFrameCloseButton:Click() end)
        end

        if MerchantFrame:IsVisible() then
          Restock(1, DrinkID, DrinkAmount)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 4
    end
  end

  -- if PeaceMaker.VendorStep == 4 then
  --   if UseMail and CheckMailItem() then
  --     if lb.GetDistance3D(px, py, pz, MailPosX, MailPosY, MailPosZ) > 3 then
  --       if not PeaceMaker.Player.Moving then
  --         PeaceMaker.Helpers.Core.Navigation:MoveTo(MailPosX, MailPosY, MailPosZ, 2)
  --       end
  --     else
  --       if not InboxFrame:IsVisible() and not Vendor.Interact then
  --         Misc:InteractUnit(SearchMailBox())
  --         Vendor.Interact = true
  --         C_Timer.After(1, function() Vendor.Interact = false end)
  --       end

  --       if InboxFrame:IsVisible() and not SendMailFrame:IsVisible() and not Vendor.InteractSendMailFrame then
  --         MailFrameTab2:Click()
  --         Vendor.InteractSendMailFrame = true
  --         C_Timer.After(2, function() Vendor.InteractSendMailFrame = false end)
  --       end

  --       if SendMailFrame:IsVisible() then
  --         MailItem(MailItemList, MailTo, MailToTitle)
  --       end
  --     end
  --   else
  --     Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
  --     PeaceMaker.VendorStep = 5
  --   end
  -- end

  if PeaceMaker.VendorStep == 4 then
    Vendor.Interact = false
    Vendor.InteractSendMailFrame = false
    Vendor.IsGossip = false
    Vendor.IsFoodRestock = false
    Vendor.IsDrinkRestock = false
    Vendor.IsReached = false
    PeaceMaker.VendorStep = 0
    PeaceMaker.VendorState = false
    Log:Run("Last Step : " .. tostring(PeaceMaker.VendorStep))
    return
  end

end

function QuestVendor:Run(RepairNpcPos, RepairNpcID, FoodNpcPos, FoodNpcID, FoodID, DrinkID, FoodAmount, DrinkAmount, Durability, BagSlot)
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core(RepairNpcPos, RepairNpcID, FoodNpcPos, FoodNpcID, FoodID, DrinkID, FoodAmount, DrinkAmount, Durability, BagSlot)
  end
end