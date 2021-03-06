local PeaceMaker = PeaceMaker
local Buff = PeaceMaker.Classes.Buff
local Debuff = PeaceMaker.Classes.Debuff

function Buff:New(SpellID, BaseDuration)
  self.SpellID = SpellID
  self.SpellName = GetSpellInfo(self.SpellID)
  self.BaseDuration = BaseDuration
end

function Debuff:New(SpellID, BaseDuration)
  self.SpellName = GetSpellInfo(self.SpellID)
  self.BaseDuration = BaseDuration
end

function Buff:Exist(Unit, OnlyPlayer)
  if OnlyPlayer == nil then OnlyPlayer = false end
  Unit = Unit or PeaceMaker.Player
  return self:Query(Unit, OnlyPlayer) ~= nil
end

function Debuff:Exist(Unit, OnlyPlayer)
  if OnlyPlayer == nil then OnlyPlayer = true end
  Unit = Unit or PeaceMaker.Player.Target
  return self:Query(Unit, OnlyPlayer) ~= nil
end

function Buff:HighestKnown()
  for i = #self.Ranks, 1, -1 do
    if IsSpellKnown(self.Ranks[i]) then
      return i            
    end
  end
  return 0
end

function Debuff:HighestKnown()
  for i = #self.Ranks, 1, -1 do
    local thisRank = self.Ranks[i]
    if IsSpellKnown(self.Ranks[i]) then
      return i            
    end
  end
  return 0
end

function Buff:Remain(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = false
  end
  Unit = Unit or PeaceMaker.Player
  local EndTime = select(6, self:Query(Unit, OnlyPlayer))
  if EndTime then
    if EndTime == 0 or self:Rank(Unit, OnlyPlayer) > self:HighestKnown() then
      return 999
    elseif self:Rank(Unit, OnlyPlayer) < self:HighestKnown() then
      return 0
    end
    return (EndTime - PeaceMaker.Time)
  end
  return 0
end

function Debuff:Remain(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = true
  end
  Unit = Unit or PeaceMaker.Player.Target
  local EndTime = select(6, self:Query(Unit, OnlyPlayer))
  if EndTime then
    if EndTime == 0 or self:Rank(Unit, OnlyPlayer) > self:HighestKnown()  then
        return 999
    elseif self:Rank(Unit, OnlyPlayer) < self:HighestKnown() then
        return 0
    end
    return (EndTime - PeaceMaker.Time)
  end
  return 0
end

function Buff:Duration(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = false
  end
  Unit = Unit or PeaceMaker.Player
  local Duration = select(5, self:Query(Unit, OnlyPlayer))
  if Duration then
    return Duration
  end
  return 0
end

function Debuff:Duration(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = true
  end
  Unit = Unit or PeaceMaker.Player.Target
  local Duration = select(5, self:Query(Unit, OnlyPlayer))
  if Duration then
    return Duration
  end
  return 0
end

function Buff:Elapsed(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = false
  end
  Unit = Unit or PeaceMaker.Player
  local EndTime = select(6, self:Query(Unit, OnlyPlayer))
  local Duration = select(5, self:Query(Unit, OnlyPlayer))
  if EndTime and Duration then
    if EndTime == 0 then
        return 999
    end
    return PeaceMaker.Time - (EndTime - Duration)
  end
  return 0
end

function Debuff:Elapsed(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = true
  end
  Unit = Unit or PeaceMaker.Player.Target
  local EndTime = select(6, self:Query(Unit, OnlyPlayer))
  local Duration = select(5, self:Query(Unit, OnlyPlayer))
  if EndTime and Duration then
    if EndTime == 0 then
        return 999
    end
    return PeaceMaker.Time - (EndTime - Duration)
  end
  return 0
end

function Buff:Refresh(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = false
  end
  Unit = Unit or PeaceMaker.Player
  local Remain = self:Remain(Unit, OnlyPlayer)
  if Remain > 0 then
    local Duration = self.BaseDuration or self:Duration()
    return Remain < (Duration * 0.3)
  end
  return true
end

function Debuff:Refresh(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = true
  end
  Unit = Unit or PeaceMaker.Player.Target
  local Remain = self:Remain(Unit, OnlyPlayer)
  if Remain > 0 then
    local Duration = self.BaseDuration or self:Duration()
    return Remain < (Duration * 0.3)
  end
  return true
end

function Buff:Stacks(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
    OnlyPlayer = false
  end
  Unit = Unit or PeaceMaker.Player
  local Stacks = select(3, self:Query(Unit, OnlyPlayer))
  if Stacks then
    return Stacks
  end
  return 0
end

function Debuff:Stacks(Unit, OnlyPlayer)
  if OnlyPlayer == nil then
      OnlyPlayer = true
  end
  Unit = Unit or PeaceMaker.Player.Target
  local Stacks = select(3, self:Query(Unit, OnlyPlayer))
  if Stacks then
    return Stacks
  end
  return 0
end

function Buff:Count(Table)
  local Count = 0
  Table = Table or PeaceMaker.Player:GetFriends(40)
  for _, Unit in pairs(Table) do
    if self:Exist(Unit) then
      Count = Count + 1
    end
  end
  return Count
end

function Debuff:Count(Table)
  local Count = 0
  Table = Table or PeaceMaker.Player:GetAttackable(40)
  for _, Unit in pairs(Table) do
    if self:Exist(Unit) then
      Count = Count + 1
    end
  end
  return Count
end

function Buff:Lowest(Table)
  Table = Table or PeaceMaker.Player:GetFriends(40)
  local LowestSec, LowestUnit
  for _, Unit in ipairs(Table) do
    if not LowestSec or self:Remain(Unit) < LowestSec then
      LowestSec = self:Remain(Unit)
      LowestUnit = Unit
    end
  end
  return LowestUnit
end

function Debuff:Lowest(Table, TTD)
  TTD = TTD or 0
  Table = Table or PeaceMaker.Player:GetEnemies(40)
  local LowestSec, LowestUnit
  for _, Unit in ipairs(Table) do
    if Unit.TTD >= TTD and (not LowestSec or self:Remain(Unit) < LowestSec) then
      LowestSec = self:Remain(Unit)
      LowestUnit = Unit
    end
  end
  return LowestUnit
end