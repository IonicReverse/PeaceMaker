local PeaceMaker = PeaceMaker
PeaceMaker.Enemies, PeaceMaker.Attackable, PeaceMaker.Units, PeaceMaker.GrindMobs, PeaceMaker.Friends, PeaceMaker.GameObjects, PeaceMaker.UnitLootable, PeaceMaker.UnitSkinable = {}, {}, {}, {}, {}, {}, {}, {}
local Enemies, Attackable, Units, GrindMobs, GameObjects, UnitLootable, UnitSkinable = PeaceMaker.Enemies, PeaceMaker.Attackable, PeaceMaker.Units, PeaceMaker.GrindMobs, PeaceMaker.GameObjects, PeaceMaker.UnitLootable, PeaceMaker.UnitSkinable
local Unit, LocalPlayer, GameObject = PeaceMaker.Classes.Unit, PeaceMaker.Classes.LocalPlayer, PeaceMaker.Classes.GameObject


local function UpdateLocalPlayer()
  PeaceMaker.Player:Update()
end


local function ClearObject()

  if PeaceMaker.Player.Pet and PeaceMaker.Player.Pet.Dead then
    PeaceMaker.Player.Pet = nil
  end

  for _, Unit in pairs(Units) do  
    if Unit and Units[Unit.GUID] ~= nil then
      if not Unit.Pointer then Units[Unit.GUID] = nil end
      if not lb.UnitTagHandler(UnitExists, Unit.GUID) then Units[Unit.GUID] = nil end
    end
  end

  for _, Object in pairs(GameObjects) do
    if Object and GameObjects[Object.GUID] ~= nil then
      if not Object.ObjPointer then GameObjects[Object.GUID] = nil end
    end
  end

end

local function SortEnemies()
  local LowestHealth, HighestHealth, HealthNorm, EnemyScore, RaidTarget
  for _, v in pairs(Attackable) do
    if not LowestHealth or v.Health < LowestHealth then
      LowestHealth = v.Health
    end
    if not HighestHealth or v.Health > HighestHealth then
      HighestHealth = v.Health
    end
  end
  for _, v in pairs(Attackable) do
    HealthNorm = (10 - 1) / (HighestHealth - LowestHealth) * (v.Health - HighestHealth) + 10
    if HealthNorm ~= HealthNorm or tostring(HealthNorm) == tostring(0 / 0) then
      HealthNorm = 0
    end
    EnemyScore = HealthNorm
    if v.TTD > 1.5 then
      EnemyScore = EnemyScore + 5
    end
    v.EnemyScore = EnemyScore
  end
  if #Attackable > 1 then
    table.sort(
      Attackable,
      function(x, y)
        return x.EnemyScore > y.EnemyScore
      end
    )
    if UnitIsVisible("target") then
      table.sort(
        Attackable,
        function(x)
          if lb.UnitTarget('player') == UnitGUID('target') then
            return true
          else
            return false
          end
        end
      )
    end
  end
end

local function UpdateUnits()

  table.wipe(GrindMobs)
  table.wipe(Attackable)
  table.wipe(Enemies)
  table.wipe(UnitLootable)
  table.wipe(UnitSkinable)

  PeaceMaker.Player.Target = nil

  for _, Unit in pairs(Units) do  

    if Unit and not Unit.NextUpdate or Unit.NextUpdate < PeaceMaker.Time then
      Unit:Update()
    end

    if not PeaceMaker.Player.Target and lb.UnitTarget('player') == Unit.GUID then
      PeaceMaker.Player.Target = Unit
    end

    if not PeaceMaker.Player.Pet 
      and UnitExists('pet')
      and lb.UnitTagHandler(UnitIsUnit, Unit.GUID, UnitGUID('pet'))
    then
      PeaceMaker.Player.Pet = Unit
    end

    if Unit.Attackable then
      table.insert(Attackable, Unit)
    end

    if Unit.ValidEnemy then
      table.insert(Enemies, Unit)
    end

    if Unit.Attackable and not Unit.Player then
      table.insert(GrindMobs, Unit)
    end

    if lb.UnitIsLootable(Unit.GUID) then
      table.insert(UnitLootable, Unit)
    end

    if lb.UnitHasFlag(Unit.GUID, __LB__.EUnitFlags.Skinnable) then
      table.insert(UnitSkinable, Unit)
    end

  end

  SortEnemies()
end

local function UpdateGameObjects()
  for _, Object in pairs(GameObjects) do
    if Object and GameObjects[Object.GUID] ~= nil then
      if not Object.ObjPointer then GameObjects[Object.GUID] = nil end
    end
    if Object and (not Object.NextUpdate or Object.NextUpdate < PeaceMaker.Time) then
      Object:Update()
    end
  end
end

function PeaceMaker.UpdateOM()

  for _, guid in ipairs(lb.GetObjects(150)) do
    if (lb.ObjectType(guid) == 5 or lb.ObjectType(guid) == 6) and not Units[guid] then
      Units[guid] = Unit(guid)
    elseif lb.ObjectType(guid) == 8 and not GameObjects[guid] then
      GameObjects[guid] = GameObject(guid)
    end
  end 

  ClearObject()
  UpdateLocalPlayer()
  UpdateUnits()
  UpdateGameObjects()

end

