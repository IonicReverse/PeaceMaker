local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Misc = {}
PeaceMaker.BlackListLoot = {}
PeaceMaker.BlackListSkin = {}
PeaceMaker.BlackListHerb = {}
PeaceMaker.BlackListMine = {}
PeaceMaker.BlackListTarget = {}
PeaceMaker.BlackListGameObject = {}
PeaceMaker.PlayerTargetList = {}
PeaceMaker.GrindHotSpotBlackList = {}

local Misc = PeaceMaker.Helpers.Core.Misc
local FaceTarget = false
local AddTarget = false
local doingCast = false
local doingClickCast = false
local LockInteract = false

-- Check Spell

function Misc:SpellIsCastable(spell)
  local usable, noMana = IsUsableSpell(spell)
  local time, value = GetSpellCooldown(spell)
  if usable then
    if not time or time == 0 then
      return true
    else
      return false
    end
  end
  return false
end

-- Facing

function Misc:IsFacing(Unit1, Unit2, Degrees)

  if Degrees == nil then Degrees = 30 end
  if Unit2 == nil then Unit2 = "player" end

  local angle1 = lb.ObjectRawFacing(Unit1)
  local angle2 = lb.ObjectRawFacing(Unit2)
  local angle3
  local Y1,X1,Z1 = lb.ObjectPosition(Unit1)
  local Y2,X2,Z2 = lb.ObjectPosition(Unit2)
  
  if Y1 and X1 and Z1 and angle1 and Y2 and X2 and Z2 and angle2 then
    
    local deltaY = Y2 - Y1
    local deltaX = X2 - X1
    
    angle1 = math.deg(math.abs(angle1-math.pi*2))
    
    if deltaX > 0 then
      angle2 = math.deg(math.atan(deltaY/deltaX)+(math.pi/2)+math.pi)
    elseif deltaX <0 then
      angle2 = math.deg(math.atan(deltaY/deltaX)+(math.pi/2))
    end

    if angle2-angle1 > 180 then
      angle3 = math.abs(angle2-angle1-360)
    elseif angle1-angle2 > 180 then
      angle3 = math.abs(angle1-angle2-360)
    else
      angle3 = math.abs(angle2-angle1)
    end

    if angle3 < Degrees then
      return true
    else
      return false
    end
  end

  return false
end

function Misc:GetOffSetBetweenAngle(Angle, OtherAngle)
  local degree = math.deg(math.abs(Angle - OtherAngle))
  if degree > 180 then
    return 360 - degree
  end
  return degree
end

function Misc:AngleTo(Object1, Object2)
  local X1, Y1, Z1 = lb.ObjectPosition(Object1)
  local X2, Y2, Z2 = lb.ObjectPosition(Object2)
  if not X1 or not X2 then return 0 end
  local Angle = math.sqrt(math.pow(X1 - X2, 2) + math.pow(Y1 - Y2, 2))
  if Angle == 0 then Angle = 1 end
  return math.atan2(Y2 - Y1, X2 - X1) % (math.pi * 2), math.atan((Z1 - Z2) / Angle) % math.pi
end

function Misc:FaceUnit(Unit)
  if FaceTarget then return end
  local nx, ny  -- a point north of the player
  local px, py  -- the player
  local mx, my  -- the monster
  -- get location of player and mob
  px, py = lb.ObjectPosition('player')
  mx, my = lb.ObjectPosition(Unit)
  -- pick some point directly north of player
  nx = px + 25
  ny = py

  -- A is the distance between n and m
  -- B is the distance between p and m
  -- C is the distance between p and n
  local a = lb.GetDistance3D(nx, ny, 0, mx, my, 0)
  local b = lb.GetDistance3D(px, py, 0, mx, my, 0)
  local c = lb.GetDistance3D(px, py, 0, nx, ny, 0)
  -- cosine law ftw
  local numerator = (b^2)+(c^2)-(a^2)
  local denominator = 2*b*c
  if denominator == 0 then return end
  local angle = math.acos(numerator/denominator)
  if my < py then angle = 2*math.pi - angle end
  local minangle = angle - (math.pi/4)
  local maxangle = angle + (math.pi/4)
  local playerfacing = 0
  playerfacing = lb.ObjectFacing('player')
  if playerfacing < minangle or playerfacing > maxangle then
    lb.SetPlayerAngles(angle)
  end
  FaceTarget = true
  C_Timer.After(1, function() FaceTarget = false end)
end

function Misc:CameraTurnFaceUnit(Unit)
  
end

function Misc:AddTargetToList(GUID)
  if not Misc:CheckTargetList(GUID) then
    table.insert(PeaceMaker.PlayerTargetList, GUID)
  end
end

function Misc:CheckTargetList(GUID)
  for _, i in pairs(PeaceMaker.PlayerTargetList) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Misc:RemoveTarget(GUID)
  for n, i in pairs(PeaceMaker.PlayerTargetList) do
    if i == GUID then
      table.remove(PeaceMaker.PlayerTargetList, n)
    end
  end
end

function Misc:ClearTargetList(GUID)
  for n, i in pairs(PeaceMaker.PlayerTargetList) do
    if not lb.UnitTagHandler(UnitExists, i) then
      table.remove(PeaceMaker.PlayerTargetList, n)
    end
  end
end

-- Get Bag Slot

function Misc:GetMaxBagSlots()
  local Total = 0
  for i = 0, NUM_BAG_SLOTS do
    local Free = GetContainerNumSlots(i)
    Total = Total + Free
  end
  return Total
end

function Misc:GetFreeBagSlots()
  local Total = 0
  for i = 0, NUM_BAG_SLOTS do
    local Free = GetContainerNumFreeSlots(i)
    Total = Total + Free
  end
  return Total
end

-- Check Mount

function Misc:CheckMountAvailable(MountID)
  local _, _, _, _, _, _, _, _, _, hideOnChar, isCollected = C_MountJournal.GetMountInfoByID(MountID)
  if (isCollected and hideOnChar ~= true) then
    return true
  end
  return false
end

function Misc:CheckMountedMount(MountID)
  local creatureName, spellID, icon, active = C_MountJournal.GetMountInfoByID(MountID)
  if active == true then
    return true
  end
  return false
end

-- Convert SpellName to SpellID

function Misc:CastSpellByIDNoDelay(spell, target)
  local spellid = GetSpellInfo(spell)
  if target then
    lb.Unlock(CastSpellByName, spellid, target)
  else
    lb.Unlock(CastSpellByName, spellid)
  end
end

function Misc:CastSpellByID(spell, target)
  if doingCast then return end
  local spellid = GetSpellInfo(spell)
  if target then
    lb.Unlock(CastSpellByName, spellid, target)
  else
    lb.Unlock(CastSpellByName, spellid)
  end
  doingCast = true
  C_Timer.After(1, function() doingCast = false end)
end

function Misc:CastGroundSpell(spell)
  if doingClickCast then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
  local x, y, z = lb.ObjectPosition('target')
  self:CastSpellByID(spell)
  C_Timer.After(0.8, function() lb.ClickPosition(x,y,z) end)
  doingClickCast = true
  C_Timer.After(1, function() doingClickCast = false end)
end

function Misc:CastChannelingSpell(spell)
  if doingCast then return end
  if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
  local spellid = GetSpellInfo(spell)
  C_Timer.After(0.5, function() lb.Unlock(CastSpellByName, spellid) end)
  PeaceMaker.Pause = PeaceMaker.Time + 1
  doingCast = true
  C_Timer.After(1, function() doingCast = false end)
end

-- Interact

function Misc:Interact(...)
  return lb.Unlock(lb.ObjectInteract, ...)
end

function Misc:InteractUnit(ID, Type)
  if not Type then Type = "Unit" end
  if Type == "Unit" then
    for _, i in pairs(PeaceMaker.Units) do
      if i.ObjectID == ID then
        lb.Unlock(lb.ObjectInteract, i.GUID)
      end
    end 
  else
    if Type == "Object" then
      for _, i in pairs(PeaceMaker.GameObjects) do
        if i.ObjectID == ID then
          lb.Unlock(lb.ObjectInteract, i.GUID)
        end
      end 
    end
  end
end

function Misc:InteractUnitAndLock(ID, Type)
  if not Type then Type = "Unit" end
  if Type == "Unit" then
    for _, i in pairs(PeaceMaker.Units) do
      if i.ObjectID == ID then
        lb.Unlock(lb.ObjectInteract, i.GUID)
      end
    end 
  else
    if Type == "Object" then
      for _, i in pairs(PeaceMaker.GameObjects) do
        if i.ObjectID == ID then
          lb.Unlock(lb.ObjectInteract, i.GUID)
        end
      end 
    end
  end
end

function Misc:InteractUnitWithinDistance(ID, Type, Distance)
  if not Type then Type = "Unit" end
  if Type == "Unit" then
    for _, i in pairs(PeaceMaker.Units) do
      if i.ObjectID == ID and i.Distance <= Distance then
        lb.Unlock(lb.ObjectInteract, i.GUID)
      end
    end 
  else
    if Type == "Object" then
      for _, i in pairs(PeaceMaker.GameObjects) do
        if i.ObjectID == ID and i.Distance <= Distance then
          lb.Unlock(lb.ObjectInteract, i.GUID)
        end
      end 
    end
  end
end

function Misc:InteractAnyObjectWithinDistance(Distance)
  if Distance == nil then Distance = 10 end
  for _, i in pairs(PeaceMaker.GameObjects) do
    if i.Distance <= Distance then
      lb.Unlock(lb.ObjectInteract, i.GUID)
    end
  end 
end

function Misc:TargetUnit(id)
  for _, i in pairs(PeaceMaker.Units) do
    if i.ObjectID == id then
      lb.UnitTagHandler(TargetUnit, i.GUID)
    end
  end 
end

-- Grinding BlackList Loot

function Misc:BlackListLoot(GUID)
  table.insert(PeaceMaker.BlackListLoot, GUID)
end

function Misc:CheckLootBlackList(GUID)
  for _, i in pairs(PeaceMaker.BlackListLoot) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Misc:BlackListSkin(GUID)
  table.insert(PeaceMaker.BlackListSkin, GUID)
end

function Misc:CheckSkinBlackList(GUID)
  for _, i in pairs(PeaceMaker.BlackListSkin) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Misc:BlackListHerb(GUID)
  table.insert(PeaceMaker.BlackListHerb, {GUID = GUID, Time = GetTime() + 30})
end

function Misc:CheckBlackListHerb(GUID)
  for _, i in pairs(PeaceMaker.BlackListHerb) do
    if i.GUID == GUID then
      return true
    end
  end
  return false
end

function Misc:BlackListMine(GUID)
  table.insert(PeaceMaker.BlackListMine, {GUID = GUID, Time = GetTime() + 30})
end

function Misc:CheckBlackListMine(GUID)
  for _, i in pairs(PeaceMaker.BlackListMine) do
    if i.GUID == GUID then
      return true
    end
  end
  return false
end

function Misc:BlackListGameObject(GUID)
  table.insert(PeaceMaker.BlackListGameObject, GUID)
end

function Misc:CheckBlackListGameObject(GUID)
  for _, i in pairs(PeaceMaker.BlackListGameObject) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Misc:ClearNodeBlackList()
  for _, i in pairs(PeaceMaker.BlackListHerb) do
    if GetTime() > i.Time and i.GUID ~= nil then
      i.GUID = nil
    end
  end
  for _, i in pairs(PeaceMaker.BlackListMine) do
    if GetTime() > i.Time and i.GUID ~= nil then
      i.GUID = nil
    end
  end
end

function Misc:CheckObjectExists(id)
  local obj = lb.GetObjects()
  for _, i in pairs(obj) do
    local idx = lb.ObjectId(i)
    if idx == id and lb.ObjectExists(i) then
      return true
    end
  end 
  return false
end

-- Grinding BlackList/WhiteList

function Misc:BlackListHotSpot(ax, ay, az, aTime)
  table.insert(PeaceMaker.GrindHotSpotBlackList, {x = ax, y = ay, z = az, Time = GetTime() + aTime})
end

function Misc:CheckBlackListHotSpot(x, y, z)
  if PeaceMaker.GrindHotSpotBlackList ~= nil and #PeaceMaker.GrindHotSpotBlackList > 0 then
    for i = 1, #PeaceMaker.GrindHotSpotBlackList do
      local nodeX, nodeY, nodeZ = unpack(PeaceMaker.GrindHotSpotBlackList[i])
      local dist = lb.GetDistance3D(x, y, z, nodeX, nodeY, nodeZ)
      if dist and dist < 2 then
        return true
      end
    end
  end
  return false
end

function Misc:ClearBlackListHotSpot()
  table.wipe(PeaceMaker.GrindHotSpotBlackList)
end

function Misc:CheckWhiteList(Unit)
  if string.len(PeaceMaker.WhiteList) > 0 then
    local WhiteList = self:SplitStrTable(PeaceMaker.WhiteList, ";")
    for _, i in pairs (WhiteList) do
      if i == Unit then return true end
    end
  else
    return true
  end
  return false
end

function Misc:CheckBlackList(Unit)
  if string.len(PeaceMaker.BlackList) > 0 then
    local BlackList = self:SplitStrTable(PeaceMaker.BlackList, ";")
    for _, i in pairs (BlackList) do
      if i == Unit then return true end
    end
  end
  return false
end

function Misc:AddBlackListTarget(GUID)
  table.insert(PeaceMaker.BlackListTarget, GUID)
end

function Misc:CheckBlackListTarget(GUID)
  for _, i in pairs(PeaceMaker.BlackListTarget) do
    if i == GUID then
      return true
    end
  end
  return false
end

function Misc:ClearBlackListTarget()
  table.wipe(PeaceMaker.BlackListTarget)
end

function Misc:CheckSpeedSpellList()
  for i = 1, #PeaceMaker.GrindSpeedSpellList do
    local Spell = unpack(PeaceMaker.GrindSpeedSpellList[i])
    if self:SpellIsCastable(Spell) then
      return Spell
    end
  end
  return false
end

function Misc:CheckSpellList()
  for i = 1, #PeaceMaker.GrindSpellList do
    local Spell, Distance = unpack(PeaceMaker.GrindSpellList[i])
    if self:SpellIsCastable(Spell) then
      return Spell, Distance
    end
  end
  return false, 0
end

function Misc:CheckGroundSpell(Spell)
  local GroundSpellList = { "Infernal Strike", "Summon Black Ox Statue" }
  for _, i in pairs(GroundSpellList) do
    if i == Spell then 
      return true
    end
  end
  return false
end

function Misc:CheckChannelSpell(Spell)
  local ChannelSpellList = { "Crackling Jade Lightning" }
  for _, i in pairs(ChannelSpellList) do
    if i == Spell then 
      return true
    end
  end
  return false
end

function Misc:CheckBuff(spellname)
  local buff, count, caster, expires, spellID
  local i = 0
  local go = true
  while i <= 40 and go do
    i = i + 1
    buff, _, count, _, duration, expires, caster, stealable, _, spellID = _G['UnitBuff']('player', i)
    if buff and buff == spellname then go = false return true end
  end
  return false
end

function Misc:CheckGuidBuff(spellname, guid, buffType)
  if buffType == nil then buffType = UnitBuff end
  local buff, count, caster, expires, spellID
  local i = 0
  local go = true
  while i <= 40 and go do
    i = i + 1
    buff, _, count, _, duration, expires, caster, stealable, _, spellID = lb.UnitTagHandler(buffType, guid, i)
    if buff and buff == spellname then go = false return true end
  end
  return false
end

-- Compare List

function Misc:CompareList(element, list)
  for _, i in pairs(list) do
    if i == element then
      return true
    end
  end
  return false
end

function Misc:CompareTableToTable(tbl1, tbl2)
  for _, i in pairs(tbl1) do
    for _, q in pairs(tbl2) do
      if i == q then
        return true
      end
    end
  end
  return false
end

-- Split String

function Misc:SplitStr(str)
  if str == nil then return 0, 0, 0 end
  local newstring, replace = string.gsub(str, ";", " ")
  local Table = {}
  if str ~= nil then
    for i in string.gmatch(newstring, '%S+') do
      table.insert(Table, tonumber(i))
    end
    return Table[1], Table[2], Table[3]
  end
  return 0, 0, 0
end

function Misc:SplitStrComma(str)
  if str == nil then return 0, 0, 0 end
  local newstring, replace = string.gsub(str, ",", " ")
  local Table = {}
  if str ~= nil then
    for i in string.gmatch(newstring, '%S+') do
      table.insert(Table, tonumber(i))
    end
    return Table[1], Table[2], Table[3]
  end
  return 0, 0, 0
end

function Misc:SplitStrTable(str, pattern)
  local Table = {}
  for str in string.gmatch(str, "([^" .. pattern .. "]+)") do
    table.insert(Table, str)
  end
  return Table
end

-- Food / Drink Check

function Misc:CheckFoodCount()
  
  local Name

  if PeaceMaker.Mode == "Grind" then
    Name = PeaceMaker.Settings.profile.Grinding.FoodName
  end

  if PeaceMaker.Mode == "TagGrind" then
    Name = PeaceMaker.Settings.profile.TagGrinding.FoodName
  end

  if Name then
    local FoodCount = GetItemCount(Name)
    if FoodCount == 0 then
      return true
    end
  end

  return false
end

function Misc:CheckDrinkCount()

  local Name

  if PeaceMaker.Mode == "Grind" then
    Name = PeaceMaker.Settings.profile.Grinding.DrinkName
  end

  if PeaceMaker.Mode == "TagGrind" then
    Name = PeaceMaker.Settings.profile.TagGrinding.DrinkName
  end

  if Name then
    local DrinkCount = GetItemCount(Name)
    if DrinkCount == 0 then
      return true
    end
  end

  return false
end