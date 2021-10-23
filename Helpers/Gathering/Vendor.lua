local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Gathering.Vendor = {}

local Vendors = PeaceMaker.Helpers.Gathering.Vendor
local Log = PeaceMaker.Helpers.Core.Log
local Misc = PeaceMaker.Helpers.Core.Misc

local VendorPathIndex = 1

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
          if not Misc:CompareList(itemID, PeaceMaker.Settings.profile.Gathering.WhiteListItem) then
            UseContainerItem(BagID, BagSlot)
            Vendor.SellDelay = PeaceMaker.Time + 0.1
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
          if Misc:CompareList(itemID, PeaceMaker.Settings.profile.Gathering.WhiteListItem) then
            Count = Count + 1
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

local function CheckNearbyRepairVendor(Range)
  local px, py, pz = lb.ObjectPosition('player')
  local RepairVendorX, RepairVendorY, RepairVendorZ = Misc:SplitStr(PeaceMaker.Settings.profile.Gathering.RepairNpcPos)
  if lb.GetDistance3D(px, py, pz, RepairVendorX, RepairVendorY, RepairVendorZ) < Range then
    return true
  end
  return false
end

local function CheckMailList(name)
  if string.len(PeaceMaker.Settings.profile.Gathering.MailItemList) > 0 then
    local ItemList = SplitStrTable(PeaceMaker.Settings.profile.Gathering.MailItemList, ";")
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

local function MailItem(To, Title)

  for bag = 0,4,1 do
    for slot = 1, GetContainerNumSlots(bag), 1 do
      local name = GetContainerItemLink(bag, slot)
      if name 
        and CheckMailList(name)
        and PeaceMaker.Time > PeaceMaker.DelayUse
      then
        lb.Unlock(UseContainerItem, bag, slot)
        PeaceMaker.DelayUse = 0
      end 
    end 
  end

  if PeaceMaker.MailItemCount >= 1 
    and PeaceMaker.MailTime 
    and PeaceMaker.Time > PeaceMaker.MailTime 
  then
    if PeaceMaker.Settings.profile.Gathering.MailToGold then
      local Money = GetMoney()
      if Money and Money > 5000000 then
        local Send_Money = (GetMoney() - 1000000)
        lb.Unlock(SetSendMailMoney, Send_Money)
      end
    end
    SendMail(PeaceMaker.Settings.profile.Gathering.MailTo, PeaceMaker.Settings.profile.Gathering.MailToTitle)
    PeaceMaker.Pause = PeaceMaker.Time + 1
    return
  end

end

local function Core()

  local px, py, pz = lb.ObjectPosition('player')
  local RepairVendorX, RepairVendorY, RepairVendorZ = Misc:SplitStr(PeaceMaker.Settings.profile.Gathering.RepairNpcPos)
  local RepairNpcID = tonumber(PeaceMaker.Settings.profile.Gathering.RepairNpcID)
  local FoodVendorX, FoodVendorY, FoodVendorZ = Misc:SplitStr(PeaceMaker.Settings.profile.Gathering.FoodNpcPos)
  local FoodNpcID = tonumber(PeaceMaker.Settings.profile.Gathering.FoodNpcID)
  local FoodAmount = tonumber(PeaceMaker.Settings.profile.Gathering.FoodAmount)
  local DrinkAmount = tonumber(PeaceMaker.Settings.profile.Gathering.DrinkAmount)
  local UseMail = PeaceMaker.Settings.profile.Gathering.UseMail
  local MailPosX, MailPosY, MailPosZ = Misc:SplitStr(PeaceMaker.Settings.profile.Gathering.MailLoc)
  local CountWhiteListItem = CountWhiteList()

  if PeaceMaker.VendorStep == 0 then
    if not PeaceMaker.VendorState then PeaceMaker.VendorState = true end
    if PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Gathering.Durability then
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
          if not PeaceMaker.GatherVendorGossip then C_GossipInfo.SelectOption(AutoSelectVendorGossip()) else C_GossipInfo.SelectOption(PeaceMaker.GatherVendorGossip) end
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
          if not PeaceMaker.GatherVendorGossip then C_GossipInfo.SelectOption(AutoSelectVendorGossip()) else C_GossipInfo.SelectOption(PeaceMaker.GatherVendorGossip) end
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
    if FoodAmount > 0 and PeaceMaker.Settings.profile.Gathering.FoodID ~= 0 and not Vendor.IsFoodRestock then
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
          Restock(0, PeaceMaker.Settings.profile.Gathering.FoodID, FoodAmount)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 3
    end
  end

  if PeaceMaker.VendorStep == 3 then
    if DrinkAmount > 0 and PeaceMaker.Settings.profile.Gathering.DrinkID ~= 0 and not Vendor.IsDrinkRestock then
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
          Restock(1, PeaceMaker.Settings.profile.Gathering.DrinkID, DrinkAmount)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 4
    end
  end

  if PeaceMaker.VendorStep == 4 then
    if UseMail and CheckMailItem() then
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
          MailItem(MailTo, MailToTitle)
        end
      end
    else
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
      PeaceMaker.VendorStep = 5
    end
  end

  if PeaceMaker.VendorStep == 5 then
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

local function CoreMammoth()

  local RepairVendorID 
  local MountID = 284
  local CountWhiteListItem = CountWhiteList()

  if PeaceMaker.Player.Faction == "Horde" then
    if not RepairVendorID then
      RepairVendorID = 32641
    end
  end
  
  if PeaceMaker.Player.Faction == "Alliance" then
    if not RepairVendorID then
      RepairVendorID = 85821
    end
  end
  
  if PeaceMaker.VendorStep == 0 then

    if not PeaceMaker.VendorState then PeaceMaker.VendorState = true end
    
    if Vendor.IsMounted then return end
    
    if not Misc:CheckMountedMount(MountID) and IsMounted() then
      Dismount()
      return
    end

    if not Misc:CheckMountedMount(MountID) and not IsMounted() then
      if PeaceMaker.Player.Moving then PeaceMaker.Helpers.Core.Navigation:StopMoving() end
      if not PeaceMaker.Player.Moving then
        C_MountJournal.SummonByID(MountID)
        Vendor.IsMounted = true
        C_Timer.After(4, function()
          Vendor.IsMounted = false
          if not IsMounted() then
            Log:Run("Mount Failed! Mount Again")
          end
        end)
      end
    end

    if Misc:CheckMountedMount(MountID) and IsMounted() then
      PeaceMaker.VendorStep = 1
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
    end
  end

  if PeaceMaker.VendorStep == 1 then
    if PeaceMaker.Player:Durability() <= PeaceMaker.Settings.profile.Gathering.Durability then
      if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
        Misc:InteractUnit(RepairVendorID)
        Vendor.Interact = true
        C_Timer.After(1, function() Vendor.Interact = false end)
      end

      if MerchantFrame:IsVisible() then
        if CanMerchantRepair() then
          RepairAllItems()
        end
      end
    else
      PeaceMaker.VendorStep = 2
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
    end
  end

  if PeaceMaker.VendorStep == 2 then
    if (Misc:GetMaxBagSlots() - Misc:GetFreeBagSlots()) > (CountWhiteListItem + 1) then
      if not MerchantFrame:IsVisible() and not GossipFrame:IsVisible() and not Vendor.Interact then
        Misc:InteractUnit(RepairVendorID)
        Vendor.Interact = true
        C_Timer.After(1, function() Vendor.Interact = false end)
      end

      if MerchantFrame:IsVisible() then
        SellList()
      end
    else
      PeaceMaker.VendorStep = 3
      Log:Run("Next Step : " .. tostring(PeaceMaker.VendorStep))
    end
  end

  if PeaceMaker.VendorStep == 3 then
    Vendor.Interact = false
    Vendor.InteractSendMailFrame = false
    Vendor.IsGossip = false
    Vendor.IsFoodRestock = false
    Vendor.IsDrinkRestock = false
    Vendor.IsReached = false
    PeaceMaker.VendorStep = 0
    PeaceMaker.VendorState = false
    return
  end

end

function Vendors:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end

function Vendors:MammothRun()
  if PeaceMaker.Time > PeaceMaker.Pause then
    CoreMammoth()
  end
end