local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Combat = {}

local Combat = PeaceMaker.Helpers.Core.Combat
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log
local Misc = PeaceMaker.Helpers.Core.Misc

local BlackListTarget = {}
local doingAction = false
local targetAction = false
local faceAction = false

-- local function UnitIsPlayer(Object)
--   if lb.ObjectType(Object) == 6 then
--     return Object
--   end
--   return false
-- end

function Combat:CheckMobsAroundHotSpot(Unit)

  local minLevel = PeaceMaker.MinLevel
  local maxLevel = PeaceMaker.MaxLevel

  if not minLevel and not maxLevel then return false end

  local Flags = {
    UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "normal",
    badUnit = not self:BadUnit(Unit.GUID),
    MobLevel = lb.UnitTagHandler(UnitLevel, Unit.GUID) >= minLevel and lb.UnitTagHandler(UnitLevel, Unit.GUID) <= maxLevel,
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not lb.UnitTagHandler(UnitIsPlayer, lb.ObjectCreator(Unit.GUID)),
    notBlackList = not Misc:CheckBlackList(Unit.Name)
  }

  for _, info in pairs(Flags) do
    if not info then
      return false
    end
  end

  return true
end

function Combat:CheckTagTargetRequirement(Unit)

  local minLevel = PeaceMaker.MinLevel
  local maxLevel = PeaceMaker.MaxLevel

  if not minLevel and not maxLevel then return false end

  local Flags = {
    UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "normal",
    badUnit = not self:BadUnit(Unit.GUID),
    MobLevel = lb.UnitTagHandler(UnitLevel, Unit.GUID) >= minLevel and lb.UnitTagHandler(UnitLevel, Unit.GUID) <= maxLevel,
    inRange = self:UnitNearHotspot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notTargetOrMe = lb.UnitTarget(Unit.GUID) == "0000000000000000" or (PeaceMaker.Player.GUID and lb.UnitTarget(Unit.GUID) == PeaceMaker.Player.GUID),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    UnitThreat = not lb.UnitTagHandler(UnitThreatSituation, PeaceMaker.Player.GUID, Unit.GUID),
    notPlayerPet = not lb.UnitTagHandler(UnitIsPlayer, lb.ObjectCreator(Unit.GUID)),
    notBlackList = not Misc:CheckBlackList(Unit.Name),
    notTagBlackList = not Misc:CheckBlackListTarget(Unit.GUID)
  }

  for _, info in pairs(Flags) do
    if not info then
      return false
    end
  end

  return true
end

function Combat:CheckTargetRequirement(Unit)
  
  local minLevel = PeaceMaker.MinLevel
  local maxLevel = PeaceMaker.MaxLevel

  if not minLevel and not maxLevel then return false end

  local Flags = {
    UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "normal",
    badUnit = not self:BadUnit(Unit.GUID),
    notCritter = lb.UnitTagHandler(UnitCreatureType, Unit.GUID) ~= "Critter",
    notPet = lb.ObjectCreator(Unit.GUID) == nil,
    notTargetOrMe = lb.UnitTarget(Unit.GUID) == "0000000000000000" or (PeaceMaker.Player.GUID and lb.UnitTarget(Unit.GUID) == PeaceMaker.Player.GUID),
    MobLevel = lb.UnitTagHandler(UnitLevel, Unit.GUID) >= minLevel and lb.UnitTagHandler(UnitLevel, Unit.GUID) <= maxLevel,
    inRange = self:UnitNearHotspot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end

  return true
end

function Combat:CheckTargetQuestRequirement(Unit)

  local Flags = {
    UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "normal",
    badUnit = not self:BadUnit(Unit.GUID),
    notCritter = lb.UnitTagHandler(UnitCreatureType, Unit.GUID) ~= "Critter",
    notPet = lb.ObjectCreator(Unit.GUID) == nil,
    notTargetOrMe = lb.UnitTarget(Unit.GUID) == "0000000000000000" or (PeaceMaker.Player.GUID and lb.UnitTarget(Unit.GUID) == PeaceMaker.Player.GUID),
    inRange = self:QuestUnitNearHotSpot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true
end

function Combat:CheckAnyTargetQuestRequirement(Unit)
  
  local Flags = {
    Reaction = lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) and lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) < 4,
    badUnit = not self:BadUnit(Unit.GUID),
    inRange = self:QuestUnitNearHotSpot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true
end

function Combat:CheckAnyEliteTargetQuestRequirement(Unit)

  local Flags = {
    UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "elite",
    Reaction = lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) and lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) < 4,
    badUnit = not self:BadUnit(Unit.GUID),
    inRange = self:QuestUnitNearHotSpot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true
end

function Combat:CheckTargetSpecialQuestRequirement(Unit)

  local Flags = {
    badUnit = not self:BadUnit(Unit.GUID),
    inRange = self:QuestUnitNearHotSpot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true
end

function Combat:CheckBossTargetQuestRequirement(Unit)

  local Flags = {
    badUnit = not self:BadUnit(Unit.GUID),
    notCritter = lb.UnitTagHandler(UnitCreatureType, Unit.GUID) ~= "Critter",
    notPet = lb.ObjectCreator(Unit.GUID) == nil,
    inRange = self:QuestUnitNearHotSpot(Unit),
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true
end

function Combat:CheckDungeonTargetQuestRequirement(Unit)

  local Flags = {
    badUnit = not self:BadUnit(Unit.GUID),
    notCritter = lb.UnitTagHandler(UnitCreatureType, Unit.GUID) ~= "Critter",
    notPet = lb.ObjectCreator(Unit.GUID) == nil,
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    notPlayer = not lb.UnitTagHandler(UnitIsPlayer, Unit.GUID),
    --inRange = self:DungeonUnitNearHotSpot(Unit),
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for v, info in pairs(Flags) do
    if not info then
      return false
    end
  end
  
  return true

end

function Combat:HostileTargetRequirement(Unit)

  if not UnitReaction then return end

  local Flags = {
    --UnitClassific = lb.UnitTagHandler(UnitClassification, Unit.GUID) == "normal",
    --Reaction = lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) and lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) < 4,
    --Distance = Unit.Distance <= Unit:GetAggroDistance() + 10,
    notDead = not lb.UnitTagHandler(UnitIsDeadOrGhost, Unit.GUID),
    Threat = lb.UnitTagHandler(UnitThreatSituation, PeaceMaker.Player.GUID, Unit.GUID),
    --TargetMe = lb.UnitTarget(Unit.GUID) == PeaceMaker.Player.GUID,
    canAttack = lb.UnitTagHandler(UnitCanAttack, PeaceMaker.Player.GUID, Unit.GUID),
    TapDenied = not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID),
    notPlayerPet = not UnitIsPlayer(lb.ObjectCreator(Unit.GUID))
  }

  for _, info in pairs(Flags) do
    if not info then
      return false
    end
  end

  return true
end

function Combat:BadUnit(GUID)
  if not GUID then return false end
  for i = 1, #BlackListTarget do 
    if BlackListTarget[i] == GUID then
      return true
    end
  end
  return false
end

function Combat:UnitNearHotspot(Unit)
  local HotSpot = PeaceMaker.GrindHotSpot
  if not HotSpot then return false end
  for i = 1, #HotSpot do
    local hx, hy, hz = HotSpot[i].x, HotSpot[i].y, HotSpot[i].z
    local radius = HotSpot[i].radius or 100
    if Unit.PosX and Unit.PosY and Unit.PosZ and hx and hy and hz then
      if lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, hx, hy, hz) <= radius then
        return true
      end
    end
  end
  return false
end

function Combat:QuestUnitNearHotSpot(Unit)
  local HotSpot = PeaceMaker.QuestGrindHotSpot
  if not HotSpot then return false end
  for i = 1, #HotSpot do
    local hx, hy, hz = HotSpot[i].x, HotSpot[i].y, HotSpot[i].z
    local radius = HotSpot[i].radius or 100
    if Unit.PosX and Unit.PosY and Unit.PosZ and hx and hy and hz then
      if lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, hx, hy, hz) <= radius then
        return true
      end
    end
  end
  return false
end

function Combat:DungeonUnitNearHotSpot(Unit)
  local HotSpot = PeaceMaker.QuestDungeonHotspot
  if not HotSpot then return false end
  local hx, hy, hz = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
  local radius = HotSpot[WPIndex].radius or 100
  if Unit.PosX and Unit.PosY and Unit.PosZ and hx and hy and hz then
    if lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, hx, hy, hz) <= radius then
      return true
    end
  end
  return false
end

function Combat:CountTagTarget()
  local Count = 0
  for _, Unit in pairs(PeaceMaker.Attackable) do
    if Unit then
      if (Unit.Target == PeaceMaker.Player.GUID or (PeaceMaker.Player.Pet and Unit.Target == PeaceMaker.Player.Pet.GUID)) then
        Count = Count + 1
      end
    end
  end
  return Count
end

function Combat:CountUnitNearHotSpot()
  local Count = 0
  local DistanceRadius = PeaceMaker.GrindHotSpot[WPIndex].radius or 100
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if Unit.Distance < DistanceRadius and self:CheckMobsAroundHotSpot(Unit) then
        Count = Count + 1
      end
    end
  end
  return Count
end

function Combat:GetUnitsNearPlayer(Distance)
  local x, y, z = lb.ObjectPosition('player')
  for _, Unit in pairs(PeaceMaker.Attackable) do
    if Unit 
      and lb.GetDistance3D(x, y, z, Unit.PosX, Unit.PosY, Unit.PosZ) <= Distance
    then
      return true
    end
  end
  return false
end

function Combat:CheckEnemyAtkPlayer()
  local Count = 0
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if (Unit.Target == PeaceMaker.Player.GUID or (PeaceMaker.Player.Pet and Unit.Target == PeaceMaker.Player.Pet.GUID)) then
        Count = Count + 1
      end
    end
  end
  return Count
end

function Combat:SearchTagAttackable()
  
  local DistanceRadius = PeaceMaker.GrindHotSpot[WPIndex].radius or 100

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if Unit.Distance <= DistanceRadius and self:CheckTagTargetRequirement(Unit) then
        table.insert(Table, Unit)
      end
    end
  end

  if #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    return Unit
  end

  return false
end

function Combat:SearchAttackable(Distance)

  if Distance == nil then Distance = 100 end

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if Unit.Distance < Distance and self:CheckTargetRequirement(Unit) then
        table.insert(Table, Unit)
      end
    end
  end

  if Table and #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    if lb.UnitTagHandler(UnitReaction, Unit.GUID, PeaceMaker.Player.GUID) < 4 then
      return Unit
    end
    return Unit
  end

  return false
end

function Combat:SearchQuestAttackable(npcid, Type, Distance)

  if Distance == nil then Distance = 100 end
  if Type == nil then Type = "Normal" end
  
  local Table = {}
  
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if (
          (Type == "Normal" and self:CheckTargetQuestRequirement(Unit)) 
          or (Type == "Boss" and self:CheckBossTargetQuestRequirement(Unit))
          or (Type == "Dungeon" and self:CheckDungeonTargetQuestRequirement(Unit))
          or (Type == "Any" and self:CheckAnyTargetQuestRequirement(Unit))
          or (Type == "AnyElite" and self:CheckAnyEliteTargetQuestRequirement(Unit))
        )
      then
        table.insert(Table, Unit)
      end
    end
  end

  if #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    if npcid ~= nil then
      if Misc:CompareList(Unit.ObjectID, npcid) then
        return Unit
      end
    else
      return Unit
    end
  end

  return false
end

function Combat:SearchSpecialQuestAttackable(npcid, Type, Distance)
  
  if Distance == nil then Distance = 80 end
  if Type == nil then Type = "Normal" end
  
  local Table = {}
  
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit then
      if Misc:CompareList(Unit.ObjectID, npcid) 
        and self:CheckTargetSpecialQuestRequirement(Unit)
      then
        table.insert(Table, Unit)
      end
    end
  end

  if Table and #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    return Unit
  end

  return false
end

function Combat:SearchEnemy(Distance)

  if not PeaceMaker.Player.Combat then return false end
  if Distance == nil then Distance = 100 end

  -- if PeaceMaker.Player.Target then
  --   local Enemy = PeaceMaker.Player.Target
  --   if not lb.UnitTagHandler(UnitIsTapDenied, Enemy.GUID) 
  --     and not Enemy.Dead 
  --     and Enemy.Attackable 
  --   then
  --     return Enemy
  --   end
  -- end

  local Table = {}
  for _, Unit in pairs(PeaceMaker.Attackable) do
    if Unit then
      if Unit.Distance < Distance
        and self:HostileTargetRequirement(Unit)
      then
        table.insert(Table, Unit)
      end
    end
  end

  if Table and #Table > 1 then
    table.sort(
      Table,
      function(x,y)
        return x.Distance < y.Distance
      end
    )
  end

  for _, Unit in ipairs(Table) do
    if Unit and Unit.GUID then
      if 
        (Unit.Target == PeaceMaker.Player.GUID) 
        or 
        (lb.UnitTagHandler(UnitAffectingCombat, Unit.GUID) and not lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID)) 
        or
        (PeaceMaker.Player.Pet and not PeaceMaker.Player.Pet.Dead and Unit.Target and Unit.Target == PeaceMaker.Player.Pet.GUID and PeaceMaker.Player.Pet.Combat)
      then
        return Unit
      end
    end
  end

  return false
end

function Combat:CheckTargetAttackUs()
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit 
      and Unit.GUID
      and (
        (lb.UnitTagHandler(UnitThreatSituation, PeaceMaker.Player.GUID, Unit.GUID) and lb.UnitTagHandler(UnitThreatSituation, PeaceMaker.Player.GUID, Unit.GUID) == 3)
        or
        (Unit.Target == PeaceMaker.Player.GUID or (PeaceMaker.Player.Pet and Unit.Target == PeaceMaker.Player.Pet.GUID))
      )
    then
      Misc:AddTargetToList(Unit.GUID)
    end
  end
end

function Combat:TagRun(Unit)

  local Second = 0

  if Misc:CheckBlackListTarget(Unit.GUID) then return end
  --if lb.UnitTagHandler(UnitIsTapDenied, Unit.GUID) and not Misc:CheckBlackListTarget(Unit.GUID) then Misc:AddBlackListTarget(Unit.GUID) lb.Unlock(ClearTarget) return end
  if UnitIsDeadOrGhost('target') then lb.Unlock(ClearTarget) return end

  local SpeedSpell = Misc:CheckSpeedSpellList()

  if SpeedSpell and not Misc:CheckBuff(SpeedSpell) and not IsMounted() then
    Misc:CastSpellByID(SpeedSpell)
    return
  end

  local Spell, Distance = Misc:CheckSpellList()

  if Spell then
    if Unit.Distance <= math.abs((Distance - 4)) and Unit.Los and not targetAction then
      Log:Run("Target : " .. Unit.GUID)
      lb.UnitTagHandler(TargetUnit, Unit.GUID)
      Misc:FaceUnit(Unit.GUID) 
      if Misc:CheckGroundSpell(Spell) then
        Misc:CastGroundSpell(Spell)
        Second = Second + 0.5
      elseif Misc:CheckChannelSpell(Spell) then
        Misc:CastChannelingSpell(Spell)
        Second = Second + 0.5
      else
        Misc:CastSpellByIDNoDelay(Spell)
      end
      targetAction = true
      C_Timer.After((1.5 + Second), function() targetAction = false Second = 0 Misc:AddBlackListTarget(Unit.GUID) end)
      return
    else
      if lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) then
        Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ)
      else
        table.insert(BlackListTarget, Unit.GUID)
      end
    end
  end

end

function Combat:Run(Unit)

  if not Unit then return end

  local AttackDistance

  if PeaceMaker.Mode == "Grind" then
    AttackDistance = PeaceMaker.Settings.profile.Grinding.AttackDistance
  end

  if PeaceMaker.Mode == "TagGrind" then
    AttackDistance = PeaceMaker.Settings.profile.TagGrinding.AttackDistance
  end

  if PeaceMaker.Mode == "Quest" then
    AttackDistance = PeaceMaker.Settings.profile.Questing.AttackDistance
  end

  if (PeaceMaker.Settings.profile.Grinding.UseControlDRotation) or (PeaceMaker.Settings.profile.TagGrinding.UseControlDRotation) then
    EnableDRotation = true
  end

  if UnitIsDeadOrGhost('target') then 
    lb.Unlock(ClearTarget) 
    return 
  end

  if PeaceMaker.Mode == "Grind" or PeaceMaker.Mode == "TagGrind" or PeaceMaker.Mode == "Quest" then

    -- if (Unit.Distance <= (AttackDistance + 5) or PeaceMaker.Player.Combat) and IsMounted() then
    --   Dismount()
    -- end

    -- local EnemyCollisionScale

    -- if lb.UnitCollisionScale(Unit.GUID) < 1.05 then 
    --   EnemyCollisionScale = lb.UnitCollisionScale(Unit.GUID) + 0.3 
    -- else
    --   EnemyCollisionScale = lb.UnitCollisionScale(Unit.GUID)
    -- end
    -- lb.UnitCollisionScale(Unit.GUID) + lb.UnitCollisionScale('player')
    
    local CombatReach = lb.UnitCombatReach(Unit.GUID) + lb.UnitCombatReach('player') + 0.50
    local UnitDistanceBetweenMobs = lb.GetDistance3D(Unit.GUID)

    if not doingAction then

      if PeaceMaker.Player.Target and PeaceMaker.Player.Target.GUID == Unit.GUID then
        if AttackDistance <= 5 then
          if (CombatReach + 2) >= UnitDistanceBetweenMobs then
            if not faceAction then
              if Misc:GetOffSetBetweenAngle(lb.ObjectFacing('Player'), Misc:AngleTo('player', Unit.GUID)) >= 1 then
                --lb.SetPlayerAngles(Misc:AngleTo('player', Unit.GUID))
                Misc:FaceUnit(Unit.GUID)
                faceAction = true
                C_Timer.After(0.3, function() faceAction = false end)
              end
            end
          end
        else
          if UnitDistanceBetweenMobs <= (AttackDistance + 2) then
            if Misc:GetOffSetBetweenAngle(lb.ObjectFacing('Player'), Misc:AngleTo('player', Unit.GUID)) >= 1 then
              Misc:FaceUnit(Unit.GUID)
              faceAction = true
              C_Timer.After(0.5, function() faceAction = false end)
            end
          end
        end
      end

      if PeaceMaker.Player.Target and PeaceMaker.Player.Target.GUID ~= Unit.GUID then 
        Log:Run("Target GUID : " .. PeaceMaker.Player.Target.GUID)
        Log:Run("Unit GUID : " .. Unit.GUID)
        lb.Unlock(ClearTarget)
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        doingAction = true
        C_Timer.After(0.5, function() doingAction = false end)
      else
        if not PeaceMaker.Player.Target then
          Log:Run("Target : " .. Unit.GUID)
          lb.UnitTagHandler(TargetUnit, Unit.GUID)
          doingAction = true
          C_Timer.After(0.5, function() doingAction = false end)
        end
      end

    end

    if AttackDistance <= 5 then

      if UnitDistanceBetweenMobs > CombatReach then
        if lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) then
          if lb.UnitHasMovementFlag(Unit.GUID, lb.EMovementFlags.Flying) then 
            if Unit.PosZ > PeaceMaker.Player.PosZ then
              local z = Unit.PosZ - (Unit.PosZ - PeaceMaker.Player.PosZ)
              Navigation:MoveTo(Unit.PosX, Unit.PosY, z, CombatReach)
            else
              table.insert(BlackListTarget, Unit.GUID)
            end
          else
            Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ, CombatReach) 
          end
        else
          table.insert(BlackListTarget, Unit.GUID)
        end
      else
        if IsMounted() then Dismount() end
        if CombatReach >= UnitDistanceBetweenMobs then
          if PeaceMaker.Player.Moving then Navigation:StopMoving() return end
        end
      end
    else
      if Unit.Distance > (AttackDistance - 2) then
        if lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) then
          Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ, (AttackDistance - 2))
        else
          table.insert(BlackListTarget, Unit.GUID)
        end
      else
        if Unit.Distance <= (AttackDistance + 2) then
          if PeaceMaker.Player.Moving then Navigation:StopMoving() return end
        end
      end
    end

  end

  if PeaceMaker.Mode == "Gather" then

    -- if IsMounted() then
    --   Dismount()
    -- end

    -- local EnemyCollisionScale

    -- if lb.UnitCollisionScale(Unit.GUID) < 1.05 then 
    --   EnemyCollisionScale = lb.UnitCollisionScale(Unit.GUID) + 0.3 
    -- else
    --   EnemyCollisionScale = lb.UnitCollisionScale(Unit.GUID)
    -- end

    --local CombatReach = lb.UnitCombatReach(Unit.GUID) + EnemyCollisionScale + lb.UnitCollisionScale('player')
    
    local CombatReach = lb.UnitCombatReach(Unit.GUID) + lb.UnitCombatReach('player') + 0.50
    local UnitDistanceBetweenMobs = lb.GetDistance3D(Unit.GUID)

    if not doingAction then
      if PeaceMaker.Player.Target and PeaceMaker.Player.Target.GUID == Unit.GUID then
        if PeaceMaker.Settings.profile.Gathering.AttackDistance <= 5 then
          if (CombatReach + 2) >= UnitDistanceBetweenMobs then
            if Misc:GetOffSetBetweenAngle(lb.ObjectFacing('Player'), Misc:AngleTo('player', Unit.GUID)) >= 1 then
              Misc:FaceUnit(Unit.GUID)
              faceAction = true
              C_Timer.After(0.5, function() faceAction = false end)
            end
          end
        else
          if UnitDistanceBetweenMobs <= (PeaceMaker.Settings.profile.Gathering.AttackDistance + 2) then
            if Misc:GetOffSetBetweenAngle(lb.ObjectFacing('Player'), Misc:AngleTo('player', Unit.GUID)) >= 1 then
              Misc:FaceUnit(Unit.GUID)
              faceAction = true
              C_Timer.After(0.5, function() faceAction = false end)
            end
          end
        end
      end
      if PeaceMaker.Player.Target and PeaceMaker.Player.Target.GUID ~= Unit.GUID then 
        Log:Run("Target GUID : " .. PeaceMaker.Player.Target.GUID)
        Log:Run("Unit GUID : " .. Unit.GUID)
        lb.Unlock(ClearTarget)
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        doingAction = true
        C_Timer.After(0.5, function() doingAction = false end)
      else
        if not PeaceMaker.Player.Target then
          Log:Run("Target : " .. Unit.GUID)
          lb.UnitTagHandler(TargetUnit, Unit.GUID)
          doingAction = true
          C_Timer.After(0.5, function() doingAction = false end)
        end
      end
    end

    if PeaceMaker.Settings.profile.Gathering.AttackDistance <= 5 then

      if UnitDistanceBetweenMobs > CombatReach then
        if lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) then
          if lb.UnitHasMovementFlag(Unit.GUID, lb.EMovementFlags.Flying) then 
            if Unit.PosZ > PeaceMaker.Player.PosZ then
              local z = Unit.PosZ - (Unit.PosZ - PeaceMaker.Player.PosZ)
              Navigation:MoveTo(Unit.PosX, Unit.PosY, z, CombatReach)
            else
              table.insert(BlackListTarget, Unit.GUID)
            end
          else
            Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ, CombatReach) 
          end
        else
          table.insert(BlackListTarget, Unit.GUID)
        end
      else
        if IsMounted() then Dismount() end
        if CombatReach >= UnitDistanceBetweenMobs then
          if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() return end
        end
      end

    else
      if Unit.Distance > PeaceMaker.Settings.profile.Gathering.AttackDistance then
        if lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) then
          Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ, (PeaceMaker.Settings.profile.Gathering.AttackDistance - 1))
        else
          table.insert(BlackListTarget, Unit.GUID)
        end
      else
        if IsMounted() then Dismount() end
        if Unit.Distance <= PeaceMaker.Settings.profile.Gathering.AttackDistance then
          if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() PeaceMaker.Pause = PeaceMaker.Time + 0.5 return end
        end
      end
    end

  end

end