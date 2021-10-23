local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Dungeon.BloodMaul = {}
PeaceMaker.Helpers.Dungeon.BloodMaul.MerchantOpen = false

BloodMaulIndex = 1
BloodMoveInPathIndex = 1
BloodMaulRotation = false
PreventMount = 0

local Blood = PeaceMaker.Helpers.Dungeon.BloodMaul

local InteractVendor = false
local MoveDelay = 0
local ExpireTime = 0
local CombatTimer = 0

local LootBlackList = {}

local MoonFireState = 0
local SwipeState = 0

local IsWPRandomize = false

local VendorStepper = 0

local PlayMovie_hook = MovieFrame_PlayMovie
MovieFrame_PlayMovie = function(...)
	GameMovieFinished()
end

local CloneBloodMaulWP = {
  [1] = { 1856.873046875, -220.80368041992 , 245.23143005371 },
  [2] = { 1886.7530517578, -209.21284484863 , 239.74310302734 }, 
  [3] = { 1929.5874023438, -205.18460083008 , 240.05233764648 }, 
  [4] = { 1952.9146728516, -214.64823913574 , 244.42216491699 }, 
  [5] = { 2002.2103271484, -241.66571044922 , 239.22180175781 }, 
  [6] = { 2036.2230224609, -263.13446044922 , 230.26116943359 }, 
  [7] = { 2050.2429199219, -282.5471496582 , 229.4479675293 },
  [8] = { 2048.615, -294.127, 228.968 },
  [9] = { 2034.493, -375.210, 223.087 },
  --[9] = { 2038.288, -360.794, 223.158 },
  [10] = { 2050.723, -274.448, 229.486 },
  [11] = { 2089.43359375 , -271.50582885742 , 227.01651000977 }, 
  [12] = { 2108.564, -249.143, 226.039 },
  --[12] = { 2107.4401855469 , -254.21459960938 , 225.84939575195 }, 
  [13] = { 2113.5434570313 , -273.52786254883 , 224.10037231445 }, 
  [14] = { 2150.2631835938 , -284.19348144531 , 220.5251159668 }, 
  [15] = { 2183.022 , -309.503 , 219.730 }, 
  [16] = { 2203.2587890625 , -278.70492553711 , 216.05101013184 }, 
  [17] = { 2219.1000976563 , -211.79925537109 , 213.99252319336 }, 
  [18] = { 2195.3161621094 , -185.63540649414 , 213.98371887207 },
  [19] = { 2182.8054199219 , -155.93391418457 , 215.40673828125 },
  [20] = { 2161.0883789063 , -156.14747619629 , 219.65376281738 }, 
  [21] = { 2142.6203613281 , -145.69618225098 , 226.1332244873 }, 
  [22] = { 2132.9313964844 , -131.4027557373 , 228.06077575684 },
  [23] = { 2072.61328125 , -130.29666137695 , 231.10682678223 }, 
  [24] = { 2038.9548339844 , -133.41291809082 , 231.22033691406 }, 
  [25] = { 2031.1687011719 , -153.59934997559 , 231.36004638672 }, 
  [26] = { 2001.0438232422 , -153.43778991699 , 237.17417907715 }, 
  [27] = { 1992.3599853516 , -168.86572265625 , 241.18461608887 }, 
  [28] = { 2089.1667480469 , -117.35618591309 , 231.55386352539 },
  [29] = { 2081.7937011719 , -7.7607307434082 , 224.15446472168 }, 
  [30] = { 2051.9487304688 , 32.673847198486 , 224.16352844238 }, 
  [31] = { 2079.6396484375 , 65.44995880127 , 224.81651306152 },
  [32] = { 2081.776, 119.013, 224.829 },
  [33] = { 2122.665 , 31.742 , 224.347 },
  [34] = { 2088.193359375 , -125.00398254395 , 231.3957824707 },
  --[35] = { 2253.856, -213.085, 213.306 },
  [35] = { 2238.013, -213.403, 214.428 },
  [36] = { 2295.1667480469 , -211.90745544434 , 213.29005432129 },
  [37] = { 2383.5861816406 , -265.55895996094 , 208.54475402832 }, 
  [38] = { 2384.1372070313 , -375.48330688477 , 198.09909057617 }, 
  [39] = { 2403.6926269531 , -423.55255126953 , 198.48719787598 }, 
  [40] = { 2383.7785644531 , -446.42361450195 , 198.30859375 }, 
  [41] = { 2387.8322753906 , -472.03701782227 , 198.68772888184 } 
}

local BloodMaulWP = {
  [1] = { 1856.873046875, -220.80368041992 , 245.23143005371 },
  [2] = { 1886.7530517578, -209.21284484863 , 239.74310302734 }, 
  [3] = { 1929.5874023438, -205.18460083008 , 240.05233764648 }, 
  [4] = { 1952.9146728516, -214.64823913574 , 244.42216491699 }, 
  [5] = { 2002.2103271484, -241.66571044922 , 239.22180175781 }, 
  [6] = { 2036.2230224609, -263.13446044922 , 230.26116943359 }, 
  [7] = { 2050.2429199219, -282.5471496582 , 229.4479675293 },
  [8] = { 2048.615, -294.127, 228.968 },
  --[9] = { 2038.288, -360.794, 223.158 },
  [9] = { 2034.493, -375.210, 223.087 },
  [10] = { 2050.723, -274.448, 229.486 },
  [11] = { 2089.43359375 , -271.50582885742 , 227.01651000977 }, 
  [12] = { 2108.564, -249.143, 226.039 },
  [13] = { 2113.5434570313 , -273.52786254883 , 224.10037231445 }, 
  [14] = { 2150.2631835938 , -284.19348144531 , 220.5251159668 }, 
  [15] = { 2183.022 , -309.503 , 219.730 }, 
  [16] = { 2203.2587890625 , -278.70492553711 , 216.05101013184 }, 
  [17] = { 2219.1000976563 , -211.79925537109 , 213.99252319336 }, 
  [18] = { 2195.3161621094 , -185.63540649414 , 213.98371887207 },
  [19] = { 2182.8054199219 , -155.93391418457 , 215.40673828125 },
  [20] = { 2161.0883789063 , -156.14747619629 , 219.65376281738 }, 
  [21] = { 2142.6203613281 , -145.69618225098 , 226.1332244873 }, 
  [22] = { 2132.9313964844 , -131.4027557373 , 228.06077575684 },
  [23] = { 2072.61328125 , -130.29666137695 , 231.10682678223 }, 
  [24] = { 2038.9548339844 , -133.41291809082 , 231.22033691406 }, 
  [25] = { 2031.1687011719 , -153.59934997559 , 231.36004638672 }, 
  [26] = { 2001.0438232422 , -153.43778991699 , 237.17417907715 }, 
  [27] = { 1992.3599853516 , -168.86572265625 , 241.18461608887 }, 
  [28] = { 2089.1667480469 , -117.35618591309 , 231.55386352539 },
  [29] = { 2081.7937011719 , -7.7607307434082 , 224.15446472168 }, 
  [30] = { 2051.9487304688 , 32.673847198486 , 224.16352844238 }, 
  [31] = { 2079.6396484375 , 65.44995880127 , 224.81651306152 },
  [32] = { 2081.776, 119.013, 224.829 },
  [33] = { 2122.665 , 31.742 , 224.347 },
  [34] = { 2088.193359375 , -125.00398254395 , 231.3957824707 },
  [35] = { 2238.013, -213.403, 214.428 },
  [36] = { 2295.1667480469 , -211.90745544434 , 213.29005432129 },
  [37] = { 2383.5861816406 , -265.55895996094 , 208.54475402832 }, 
  [38] = { 2384.1372070313 , -375.48330688477 , 198.09909057617 }, 
  [39] = { 2403.6926269531 , -423.55255126953 , 198.48719787598 }, 
  [40] = { 2383.7785644531 , -446.42361450195 , 198.30859375 }, 
  [41] = { 2387.8322753906 , -472.03701782227 , 198.68772888184 } 
}

local BloodMoveIn = {
  [1] = { 7263.710, 4453.390, 129.206 },
  [2] = { 7270.558, 4469.996, 125.923 }
}

local function lbObjInteract(...) 
  return lb.Unlock(lb.ObjectInteract, ...) 
end

local lastdebugmsg = ''
local lastdebugtime = 0
local function debugmsg(message)
  if (lastdebugmsg ~= message or PeaceMaker.Time > lastdebugtime) then
    lastdebugmsg = message
    lastdebugtime = PeaceMaker.Time + 5
    print(string.format("%s: %s", "|cff42a5f5[Debug]|r", message))
  end
end

local FaceDirectionDelay = 0
local function FaceDirection(x, y)
  local px, py = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY
  local angle = rad(atan2(y - py, x - px))
  if GetTime() > FaceDirectionDelay then
    if angle < 0 then
      lb.SetCameraAngles(angle + (math.pi * 2), true)
      lb.SetPlayerAngles(angle + (math.pi * 2), true)
      FaceDirectionDelay = GetTime() + 1
    elseif angle > (math.pi * 2) then
      lb.SetCameraAngles(angle - (math.pi * 2), true)
      lb.SetPlayerAngles(angle - (math.pi * 2), true)
      FaceDirectionDelay = GetTime() + 1
    else
      lb.SetCameraAngles(angle, true)
      lb.SetPlayerAngles(angle, true)
      FaceDirectionDelay = GetTime() + 1
    end
  end
  return false
end

local FaceTargetDelay = 0
local function FaceTarget(guid)
  if FaceTargetDelay > PeaceMaker.Time then return end
  if not lb.UnitTagHandler(UnitExists, guid) or lb.UnitTagHandler(UnitIsDeadOrGhost, guid) then return end
  local px, py = lb.ObjectPosition('player')
  local mx, my = lb.ObjectPosition(guid)
  local nx = px + 20
  local ny = py
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
    FaceTargetDelay = PeaceMaker.Time + 3
  end
end

local function StopMoving()
  lb.Unlock(MoveForwardStart)
  lb.Unlock(MoveForwardStop)
end

local function RandomizeWaypoint()
  if IsWPRandomize == false then
    table.wipe(BloodMaulWP)
    local tmp = {}
    local mathRandomX = math.random(1, 1.5)
    local mathRandomY = math.random(1, 1.5)
    for i = 1, #CloneBloodMaulWP do
      local x,y,z = unpack(CloneBloodMaulWP[i])
      table.insert(tmp, {
        x + mathRandomX, y + mathRandomY, z
      })
    end
    BloodMaulWP = tmp
    IsWPRandomize = true
  end
end

local function ResetBlood()
  BloodMaulIndex = 1
  InteractVendor = false
  LootBlackList = {}
  CombatTimer = 0
  ResetInstances()
  RandomizeWaypoint()
  PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 1
end

local function ResetVariable()
  BloodMaulIndex = 1
  CombatTimer = 0
  LootBlackList = {}
  MoonFireState = 0
  SwipeState = 0
  InteractVendor = false
  IsWPRandomize = false
  PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 2
end

local function CheckForm(Mode)
  local Form = _G.GetShapeshiftForm()
  if Form then
    if Mode == Form then
      return true
    end
  end
  return false
end

local function SearchAroundMobArea(x,y,z, Distance, Mobid)
  local Enemy = PeaceMaker.Enemies
  for _, Unit in pairs(Enemy) do
    if Unit.PosX and Unit.PosY and Unit.PosZ then
      if not Mobid then
        if lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, x,y,z) < Distance then
          return true
        end
      else
        if Mobid then
          if Unit.ObjectID ~= Mobid   
            and Unit.ObjectID ~= 12217
            and Unit.ObjectID ~= 11789
            and lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, x,y,z) < Distance
          then
            return true
          end
        end
      end
    end
  end
  return false
end

local function SearchAroundPosAndCast(x, y, z, SpellID, Delay, Distance)
  local Units = PeaceMaker.Units
  local playerGUID = UnitGUID('player')
  if Delay == nil then Delay = 0 end
  for _, Unit in pairs(Units) do
    if Unit.PosX and Unit.PosY and Unit.PosZ 
      and lb.UnitTagHandler(UnitReaction, playerGUID, Unit.GUID) >= 1 
      and lb.UnitTagHandler(UnitReaction, playerGUID, Unit.GUID) <= 3
    then
      if Distance then
        if lb.GetDistance3D(Unit.PosX, Unit.PosY, Unit.PosZ, x,y,z) < Distance then
          lb.UnitTagHandler(TargetUnit, Unit.GUID)
          lb.Unlock(CastSpellByID, SpellID)
          MoveDelay = Delay
          return
        end
      else
        lb.UnitTagHandler(TargetUnit, Unit.GUID)
        lb.Unlock(CastSpellByID, SpellID)
        MoveDelay = Delay
        return
      end
    end
  end
  return
end

local function SpellIsReady(spell)
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

local function lbCastSpellByID(spell)
  local spellid = GetSpellInfo(spell)
  return lb.Unlock(CastSpellByName, spellid)
end

local function TargetNearestEnemy(x,y,spell)
  FaceDirection(x,y)
  lb.Unlock(ClearTarget)
  C_Timer.After(0.3, function()
    lb.Unlock(TargetNearestEnemy)
    lbCastSpellByID(spell)
  end)
  MoveDelay = PeaceMaker.Time + 0.5
end

local function TargetUnit(x,y,spell,name)
  FaceDirection(x,y)
  lb.Unlock(ClearTarget)
  C_Timer.After(0.3, function()
    --lb.Unlock(TargetUnit,name)
    lb.Unlock(TargetUnit, name)
    lbCastSpellByID(spell)
  end)
  MoveDelay = PeaceMaker.Time + 0.5
end

local function DistanceCheck(px,py,pz,x,y,z,dist)
  if dist == nil then dist = 3 end
  if lb.GetDistance3D(px,py,pz,x,y,z) <= dist then
    return true
  end
  return false
end

local function BloodMaul_1()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 2
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 1
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if BloodMaulIndex == 2
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if BloodMaulIndex == 3 
      and SwipeState == 1
    then
      SwipeState = 0
    end

    if BloodMaulIndex == 4
      and SpellIsReady(77764)
    then
      lbCastSpellByID(77764)
    end

    if BloodMaulIndex == 7
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end
  
    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 8 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 3
        --TargetNearestEnemy(2048.413,-303.165, 8921)
        SwipeState = 0
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_2()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 4
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])
    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 9 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 5
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        MoveDelay = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_3()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 6
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 10
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if BloodMaulIndex == 13
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if BloodMaulIndex == 14
      and SwipeState == 1
    then
      SwipeState = 0
    end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 15 then
        --TargetUnit(2184.363, -322.833, 8921, "Gnasher")
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 7
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_4()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 8
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])
    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 18 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 9
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_5()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 10
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 20 
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if BloodMaulIndex == 20
      and SwipeState == 0 
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if BloodMaulIndex == 21
      and SwipeState == 1
    then
      SwipeState = 0
    end

    if BloodMaulIndex == 23
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end
    
    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 23 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 11
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_6()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 12
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 24
      and SpellIsReady(77764)
    then
      lbCastSpellByID(77764)
    end

    if BloodMaulIndex == 24
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3
    then
      lbCastSpellByID(106785)
    end

    if BloodMaulIndex == 25
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if BloodMaulIndex == 26
      and SwipeState == 1
    then
      SwipeState = 0
    end

    if BloodMaulIndex == 26
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3 
    then
      lbCastSpellByID(106785)
    end
    
    -- if BloodMaulIndex == 28
    --   and SwipeState == 0
    -- then
    --   lbCastSpellByID(106785)
    --   SwipeState = 1
    -- end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 27 then
        SwipeState = 0
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 13
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_7()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 14
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 28
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 29 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 15
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_7_5()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 16
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 31
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 31 then
        SwipeState = 0
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 17
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_8()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 18
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 32 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 19
        PeaceMaker.Pause = PeaceMaker.Time + 1
        MoveDelay = PeaceMaker.Time + 2
        lbCastSpellByID(106785)
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_9()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 20
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 33
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if BloodMaulIndex == 34
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if BloodMaulIndex == 35
      and SpellIsReady(77764)
    then
      lbCastSpellByID(77764)
    end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 35 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 21
        PeaceMaker.Pause = PeaceMaker.Time + 1
        lbCastSpellByID(252216)
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_10()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 22
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 36 then
        SwipeState = 0
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 23
        lbCastSpellByID(106785)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        MoveDelay = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMaul_11()
  if #BloodMaulWP > 0 
    and PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 24
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = lb.ObjectPosition("player")
    local x,y,z = unpack(BloodMaulWP[BloodMaulIndex])

    if BloodMaulIndex == 37
      and SpellIsReady(252216)
    then
      lbCastSpellByID(252216)
    end

    if BloodMaulIndex == 38
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3
    then
      lbCastSpellByID(106785)
    end

    if BloodMaulIndex == 40
      and SwipeState == 0
    then
      lbCastSpellByID(106785)
      SwipeState = 1
    end

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMaulIndex = BloodMaulIndex + 1
      if BloodMaulIndex > 41 then
        SwipeState = 0
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 25
        lbCastSpellByID(252216)
        PeaceMaker.Pause = PeaceMaker.Time + 1
        MoveDelay = PeaceMaker.Time + 1
        return
      end
    else
      debugmsg('Move Index: ' .. BloodMaulIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
      end
    end
  end
end

local function BloodMove_In()
  if #BloodMoveIn > 0
    and PeaceMaker.Time > MoveDelay 
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(BloodMoveIn[BloodMoveInPathIndex])

    if DistanceCheck(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) then
      BloodMoveInPathIndex = BloodMoveInPathIndex + 1
      if BloodMoveInPathIndex > #BloodMoveIn then
        BloodMoveInPathIndex = 1
        return
      end
    else
      if not PeaceMaker.Player.Moving then
        if BloodMoveInPathIndex == 1 then
          FaceDirection(x,y)
          PeaceMaker.Helpers.Core.Navigation:MoveTo(x,y,z,2)
        else
          if BloodMoveInPathIndex > 1 then
            FaceDirection(x,y)
            lb.MoveTo(x,y,z)
            C_Timer.After(0.2, function()
              PeaceMaker.Pause = PeaceMaker.Time + 5
            end)
            return
          end
        end
      end
    end

  end

end

local function BlackListLoot(GUID)
  table.insert(LootBlackList, GUID)
end

local function CheckLootBlackList(GUID)
  for _, i in pairs(LootBlackList) do
    if i == GUID then
      return true
    end
  end
  return false
end

local function CheckCorpseAndLoot()
  
  if PeaceMaker.UnitLootable ~= nil 
    and #PeaceMaker.UnitLootable > 0 
  then 
    local Table = {}
    
    for _, Unit in ipairs(PeaceMaker.UnitLootable) do
      if Unit.GUID ~= nil then
        table.insert(Table, Unit)
      end
    end
  
    if Table ~= nil and #Table > 1 then
      table.sort(
        Table,
        function(x, y)
          if type(x) == "table" and type(y) == "table" then
            if x ~= nil and y ~= nil then
              if x.Distance and y.Distance then
                return x.Distance < y.Distance
              end
            end
          end
        end
      )
    end
  
    for _, Unit in ipairs(Table) do
      if Unit and CheckLootBlackList(Unit.GUID) == false and lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) == true then
        return true
      end
    end
  end

  return false
end

local LootingDelay = 0
local function Looting()

  if PeaceMaker.Time > LootingDelay then

    if not PeaceMaker.Player.Combat and not PeaceMaker.Player.Dead then

      local Table = {}
      for _, Unit in ipairs(PeaceMaker.UnitLootable) do
        if Unit.GUID ~= nil then
          table.insert(Table, Unit)
        end
      end

      if Table ~= nil and #Table > 1 then
        table.sort(
          Table,
          function(x, y)
            if type(x) == "table" and type(y) == "table" then
              if x ~= nil and y ~= nil then
                if x.Distance and y.Distance then
                  return x.Distance < y.Distance
                end
              end
            end
          end
        )
      end

      for _, Unit in ipairs(Table) do
        if Unit and CheckLootBlackList(Unit.GUID) == false and lb.NavMgr_IsReachable(Unit.PosX, Unit.PosY, Unit.PosZ) == true then
          if Unit.Distance > 3 and not PeaceMaker.Player.Moving then
            FaceDirection(Unit.PosX, Unit.PosY)
            PeaceMaker.Helpers.Core.Navigation:MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ, 3)
            return
          else
            if Unit.Distance <= 3 then
              if PeaceMaker.Player.Target then lb.Unlock(ClearTarget) end
              if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
              if not PeaceMaker.Player.Moving then
                C_Timer.After(0.5, function()
                  lbObjInteract(Unit.GUID)
                  C_Timer.After(1, function()
                    BlackListLoot(Unit.GUID)
                  end)
                end)
                LootingDelay = PeaceMaker.Time + 1.5
                return
              end
            end
          end
        end
      end

    end
  end

end

local function CheckNearEntrance(x,y,z)
  local px, py, pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
  if px and py and pz then
    if lb.GetDistance3D(px, py, pz, x,y,z) <= 2 then
      return true
    end
  end
  return false
end 

local function CheckMountVendor()
  if GetSpellInfo("Traveler's Tundra Mammoth") then
    return true
  end
  return false
end

local function CheckGear()
  local _, avgEQ, _ = GetAverageItemLevel()
  if avgEQ < 170 then
    C_EquipmentSet.UseEquipmentSet("0")
  end
  return false
end

local function CheckUnGear()
  local _, avgEQ, _ = GetAverageItemLevel()
  if avgEQ > 170 then
    C_EquipmentSet.UseEquipmentSet("1")
  end
  return false
end

local function CheckBuff(Name)
  local _buff
  local i = 0
  while i <= 40 do
    i = i + 1
    _buff = _G.UnitBuff('player', i)
    if _buff == Name then return true end
  end
  return false
end

local function maxBagSlot()
  local Slots = 0
  for i = 0, 4, 1 do
    Slots = Slots + GetContainerNumSlots(i)
  end
  return Slots
end

local DreamTimeOutVendor = false
local function VendorStep()
  local maxBagSlot = maxBagSlot()
  if IsMounted() then
    
    if InteractVendor 
      and DreamTimeOutVendor 
    then
      if PeaceMaker.Time > DreamTimeOutVendor then
        if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step ~= 28 then
          CloseMerchant()
          DreamTimeOutVendor = PeaceMaker.Time + 10
        end
      end
    end

    if Blood.MerchantOpen == false
      and PeaceMaker.Player.Faction == "Alliance" 
    then
      local Units = PeaceMaker.Units
      for _, Unit in pairs(Units) do
        if Unit.ObjectID == 32639 then
          lb.Unlock(lb.ObjectInteract, Unit.GUID) 
          return
        end
      end
    end

    if Blood.MerchantOpen == false
      and PeaceMaker.Player.Faction == "Horde" 
    then
      local Units = PeaceMaker.Units
      for _, Unit in pairs(Units) do
        if Unit.ObjectID == 32641 then
          lb.Unlock(lb.ObjectInteract, Unit.GUID) 
          return
        end
      end
    end

    if not InteractVendor
      and Blood.MerchantOpen == true 
    then
      InteractVendor = PeaceMaker.Time + PeaceMaker.Settings.profile.Dungeon.VendorDelay
      DreamTimeOutVendor = PeaceMaker.Time + 10
      return
    end

    if Blood.MerchantOpen == true
      and InteractVendor
      and PeaceMaker.Time > InteractVendor 
      and (maxBagSlot - PeaceMaker.Player:GetFreeBagSlots()) <= 15
    then
      InteractVendor = false
      DreamTimeOutVendor = false
      PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 28
      CloseMerchant()
      return
    end
  else
    if CheckMountVendor() == true then
      if not IsMounted() and not PeaceMaker.Player.Casting and PeaceMaker.Time > PeaceMaker.Pause then
        if PeaceMaker.Player.Moving then StopMoving() end
        if not PeaceMaker.Player.Moving then
          lb.Unlock(RunMacroText, "/cast Traveler's Tundra Mammoth")
          PeaceMaker.Pause = PeaceMaker.Time + 5
        end
      end
    else
      if CheckMountVendor() == false then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 28
      end
    end
  end
end

local TimeOutVendor = false
local function VendorRoutineOutSide()
  if InteractVendor
    and TimeOutVendor
  then
    if PeaceMaker.Time > TimeOutVendor then
      if VendorStepper ~= 0 then
        CloseMerchant()
        TimeOutVendor = PeaceMaker.Time + 10
      end
    end
  end

  if Blood.MerchantOpen == false then
    local Units = PeaceMaker.Units
    for _, Unit in pairs(Units) do
      if Unit.ObjectID == 85545 then
        lb.Unlock(lb.ObjectInteract, Unit.GUID) 
        return
      end
    end
  end
  
  if not InteractVendor
    and Blood.MerchantOpen == true 
  then
    InteractVendor = PeaceMaker.Time + 5
    TimeOutVendor = PeaceMaker.Time + 10
    return
  end

  if Blood.MerchantOpen == true
    and InteractVendor
    and PeaceMaker.Time > InteractVendor 
    and (maxBagSlot() - PeaceMaker.Player:GetFreeBagSlots()) <= 15
  then
    VendorStepper = 0
    InteractVendor = false
    TimeOutVendor = false
    CloseMerchant()
    return
  end
end

local MovingDelay = 0
local DelayClick = 0
local SpamRotaOn = 0
local EnableRotaMode = false
local function CombatMode()
  
  local EnemiesCount = #PeaceMaker.Enemies
  local CombatReached = lb.UnitCombatReach("target")
  local TargetDistance = CombatReached or 3

  if not EnableDRotation then EnableDRotation = true return end

  if CombatTimer == 0 then CombatTimer = PeaceMaker.Time + 300 end
  if IsMounted() then Dismount() end

  if PeaceMaker.Player.Target then
    FaceDirection(PeaceMaker.Player.Target.PosX, PeaceMaker.Player.Target.PosY)
  end

  if PeaceMaker.Player.Target
    and (PeaceMaker.Player.Target.Dead or PeaceMaker.Player.Target.Distance > 50)
  then
    lb.Unlock(ClearTarget)
  end
  
  if PeaceMaker.Player.Target 
    and not PeaceMaker.Player.Target.Dead
    and PeaceMaker.Player.Target.Distance > TargetDistance
    and not PeaceMaker.Player.Moving
    and PeaceMaker.Time > MovingDelay
  then 
    PeaceMaker.Helpers.Core.Navigation:MoveTo(PeaceMaker.Player.Target.PosX, PeaceMaker.Player.Target.PosY, PeaceMaker.Player.Target.PosZ, 3)
    MovingDelay = PeaceMaker.Time + 0.2
  end

  -- Druid
  if PeaceMaker.Player.Class == 11 then
    if CheckForm(2) == false then
      lbCastSpellByID(768)
      PeaceMaker.Pause = PeaceMaker.Time + 2
      return
    else
      if CheckForm(2) == true then
        if IsMounted() then Dismount() end     
        return
      end
    end
  end

end

local LockScene = false
local DelayCombatCheck = 0
local SpamRotaOff = 0
local function NextMode()
  if EnableDRotation then EnableDRotation = false end
  if IsMounted() then Dismount() return end
  if not IsMounted() then
    if PeaceMaker.Time > DelayCombatCheck then
      if CheckCorpseAndLoot() == true then
        Looting()
      else  
        if CheckCorpseAndLoot() == false then
          if CombatTimer > 0 then CombatTimer = 0 end
          PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step + 1
        end
      end
    end
  end
end

local function MountPhase()
  if CheckMountVendor() == true then
    if not IsMounted() and not PeaceMaker.Player.Casting and not PeaceMaker.Player.Combat and PeaceMaker.Time > PeaceMaker.Pause then
      if PeaceMaker.Player.Moving then StopMoving() end
      if not PeaceMaker.Player.Moving then
        C_Timer.After(0.5, function()
          lb.Unlock(RunMacroText, "/cast Traveler's Tundra Mammoth")
        end)
        PeaceMaker.Pause = PeaceMaker.Time + 5
        return true
      end
    end
  end

  if CheckMountVendor() == false then
    if PeaceMaker.Player.Class == 11 then
      if CheckForm(3) == false then
        lb.Unlock(CastSpellByName, "Travel Form")
      end
    end

    if (PeaceMaker.Player.Class == 5 or PeaceMaker.Player.Class == 8) then
      if not IsMounted() and not PeaceMaker.Player.Casting and not PeaceMaker.Player.Combat and PeaceMaker.Time > PeaceMaker.Pause then
        if PeaceMaker.Player.Moving then StopMoving() end
        if not PeaceMaker.Player.Moving then
          C_Timer.After(0.5, function()
            lb.Unlock(RunMacroText, "/cast Swift Purple Wind Rider")
          end)
          PeaceMaker.Pause = PeaceMaker.Time + 5
          return true
        end
      end
    end
  end
end

local function CastCatForm()
  lbCastSpellByID(768)
  PeaceMaker.Pause = PeaceMaker.Time + 1
  return
end

local function CheckMovementPhase()
  if CheckForm(2) == true then
    return true
  end
  return false
end

local DelayReset = 0
local function Step()

  if BloodMoveInPathIndex > 1 then BloodMoveInPathIndex = 1 end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 1 then
    ResetVariable()
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 2 then
    if CheckMovementPhase() == true then
      BloodMaul_1()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 3 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 4 then
    if CheckMovementPhase() == true then
      BloodMaul_2()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 5
    and PeaceMaker.Time > MoveDelay 
  then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 6 then
    if CheckMovementPhase() == true then
      BloodMaul_3()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 7 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 8 then
    if CheckMovementPhase() == true then
      BloodMaul_4()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 9 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 10 then
    if CheckMovementPhase() == true then
      BloodMaul_5()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 11 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 12 then
    if CheckMovementPhase() == true then
      BloodMaul_6()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 13 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 14 then
    if CheckMovementPhase() == true then
      BloodMaul_7()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 15 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 16 then
    if CheckMovementPhase() == true then
      BloodMaul_7_5()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 17 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 18 then
    if CheckMovementPhase() == true then
      BloodMaul_8()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 19 
    and PeaceMaker.Time > MoveDelay
  then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 20 then
    if CheckMovementPhase() == true then
      BloodMaul_9()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 21 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 22 then
    if CheckMovementPhase() == true then
      BloodMaul_10()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 23 
    and PeaceMaker.Time > MoveDelay
  then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 24 then
    if CheckMovementPhase() == true then
      BloodMaul_11()
    else
      CastCatForm()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 25 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 26 then
    local mapid = lb.GetMapId()
    if mapid == 1175 
      and not PeaceMaker.Player.Casting 
    then
      lbCastSpellByID(193753)
      PeaceMaker.Pause = PeaceMaker.Time + 15
      return
    end
  end
end

local DelayVendor = 0
local function ExtendedStep()

  local mapid = lb.GetMapId()

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 26 then
    if mapid == 1540 then
      StopMoving()
      PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 27
      DelayVendor = PeaceMaker.Time + 0.5
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 27 
    and PeaceMaker.Time > DelayVendor
  then
    if mapid == 1540 then
      if PeaceMaker.Player:GetFreeBagSlots() <= 20 then
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 27.5
      else
        PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 28
      end
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 27.5 then
    VendorStep()
  end
  
  if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step == 28
    and mapid == 1540 
    and not PeaceMaker.Player.Casting 
  then
    lbCastSpellByID(193753)
    return
  end
end 

local function OutSideStep()
  local mapid = lb.GetMapId()
  if CheckMountVendor() == false then
    if VendorStepper == 0 then
      if PeaceMaker.Player:GetFreeBagSlots() < 15 then
        VendorStepper = 1
      else
        if mapid ~= 1175 then
          BloodMove_In()
        end
      end
    end
    if VendorStepper == 1 then
      local px,py,pz = lb.ObjectPosition('player')
      local vx,vy,vz = 7400.561, 4335.775, 126.407
      if lb.GetDistance3D(px,py,pz,vx,vy,vz) > 2 then
        if not PeaceMaker.Player.Moving then
          if CheckForm(3) == false then
            lbCastSpellByID(783)
          else
            PeaceMaker.Helpers.Core.Navigation:MoveTo(vx,vy,vz,2)
          end
        end
      else
        VendorRoutineOutSide()
      end
    end
  else
    if mapid ~= 1175 then
      BloodMove_In()
    end
  end
end

local function GetNearestWayPoint()
  
  local tmp = {}

  for i = 1, #BloodMaulWP do
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = unpack(BloodMaulWP[i])
    local Dist = lb.GetDistance3D(px,py,pz,x,y,z)
    table.insert(tmp, {Index = i, Distance = Dist})
  end

  if #tmp > 1 then
    table.sort(
      tmp,
      function(x, y)
        return x.Distance < y.Distance
      end
    )
  end

  return tmp[1].Index
end

local IsInit = false
local function Init()
  if IsInit == false then
    if CheckNearEntrance(1829.370, -245.757, 255.727) then
      PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step = 1
      IsInit = true
    else
      BloodMaulIndex = GetNearestWayPoint()
      IsInit = true
    end
  end
end

local function Core()

  local mapid = lb.GetMapId()

  ExtendedStep()

  if mapid == 1175 then
    if PeaceMaker.Player.Dead then
      RepopMe()
      PeaceMaker.Pause = PeaceMaker.Time + 2
      CombatTimer = 0
      return
    end
    if not PeaceMaker.Player.Dead then
      if IsInit == true then
        Step()
      else
        Init()
      end
    end
  else
    if mapid == 1116 then
      local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
      if PeaceMaker.Settings.profile.Dungeon.BloodMaul_Step >= 28 then
        ResetBlood()
      end
      if px and py and pz then
        OutSideStep()
      end
    end
  end
end

function Blood.Run(IsAllowed)
  if IsAllowed == 1 then
    if PeaceMaker.Time > PeaceMaker.Pause then
      Core()
    end
  end
end