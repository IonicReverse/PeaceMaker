local PeaceMaker = PeaceMaker
local PeaceMaker_Item = PeaceMaker.Classes.Item
PeaceMaker.Tables.ItemInfo = {}

function PeaceMaker_Item:New(ItemID)
  self.ItemID = ItemID
  self.ItemName = GetItemInfo(ItemID)
  if not self.ItemName then
    PeaceMaker.Tables.ItemInfo[ItemID] = self
  end
  self.SpellName, self.SpellID = GetItemSpell(ItemID)
end

function PeaceMaker_Item:Update()
  self.ItemName = GetItemInfo(self.ItemID)
  self.SpellName, self.SpellID = GetItemSpell(self.ItemID)
end

function PeaceMaker_Item:Useable()
  return IsUsableItem(self.ItemName)
end

function PeaceMaker_Item:Use(Unit)
  Unit = Unit or PeaceMaker.Player
  if self.SpellID and self:Useable() then
    lb.Unlock(UseItemByName, self.ItemName, 'player')
    return true
  end
  return false
end