local PeaceMaker = PeaceMaker
local PeaceMaker = PeaceMaker.Classes.LocalPlayer

function PeaceMaker:GetEnemy(Yards)
  if (not self.Target or self.Target.Dead) and self.Combat then
    for _, Unit in ipairs(PeaceMaker.Enemies) do
      return Unit
    end
  end
  return false
end

function PeaceMaker:AutoTargetEnemy(Yards)
  if self.Combat and (not self.Target or self.Target.Dead) then
    for _, Unit in ipairs(PeaceMaker.Enemies) do
      if Unit.Distance <= Yards then
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        PeaceMaker.Player.Target = Unit
        return true 
      end
    end
  end
  return false
end

function PeaceMaker:AutoTargetEnemyBasedOnID(ID, Yards)
  if self.Combat and (not self.Target or self.Target.Dead) then
    for _, Unit in ipairs(PeaceMaker.Enemies) do
      if lb.ObjectId(Unit.GUID) == ID and Unit.Distance <= Yards then
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        PeaceMaker.Player.Target = Unit
        return true 
      end
    end
  end
  return false
end

function PeaceMaker:AutoTargetAny(Yards)
  if not self.Target or (self.Target and self.Target.Dead) then
    for _, Unit in ipairs(PeaceMaker.Attackable) do
      if Unit.Distance <= Yards 
        and not Unit.Dead
        and not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID) 
      then
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        PeaceMaker.Player.Target = Unit
        return true
      end
    end
  end
  return false
end

function PeaceMaker:GetEnemies(Yards)
  
  local Table = {}
  local Count = 0
  
  if Yards then
    if self.Target 
      and self.Target.ValidEnemy
      and self.Target.Distance <= Yards 
    then
      table.insert(Table, self.Target)
      Count = 1
    end
  else
    if self.Target 
      and self.Target.ValidEnemy
      and self.Target.Distance <= Yards 
    then
      table.insert(Table, self.Target)
      Count = 1
    end
  end
  
  for _, v in ipairs(PeaceMaker.Enemies) do
    if Yards then
      if v.Distance <= Yards then
        table.insert(Table, v)
        Count = Count + 1
      end
    else
      if v.Distance <= Yards then
        table.insert(Table, v)
        Count = Count + 1
      end
    end
  end

  return Table, Count
end