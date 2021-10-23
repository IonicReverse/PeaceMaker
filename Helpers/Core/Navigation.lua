local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Navigation = {}

local Log = PeaceMaker.Helpers.Core.Log
local Navigation = PeaceMaker.Helpers.Core.Navigation

WPIndex = 1
DisableNaviUnstuck = false
local RequeryNav = 0
local PrevAngle = 0

local StopMovingUnstuck = 0
local RandomizeTimerSwitchSpot = 0
local HotSpotSwitchTimer = 0

local TurnLeft = false
local TurnRight = false

local NavigationState = {
  ItemOnlocation = false
}

local function getObsMin(yardsInfront)
  local _lx, _ly, _lz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
  local _angle = lb.ObjectFacing("Player")
  local _x, _y, _z = _lx+(yardsInfront*math.cos(_angle)), _ly+(yardsInfront*math.sin(_angle)), _lz;
  for i = 1, 20 do	
    local hit = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x, _y, _z + (i*0.2), 1245521)
    local hitL = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x+(yardsInfront*math.cos(_angle-i*0.02)), _y+(yardsInfront*math.sin(_angle-i*0.02)), _z + (i*0.2), 1245521)
    local hitR = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x+(yardsInfront*math.cos(_angle+i*0.02)), _y+(yardsInfront*math.sin(_angle+i*0.02)), _z + (i*0.2), 1245521)	
    if(hit or hitL or hitR) then
      return i * 0.2
    end
  end
  return 0
end

local function getObsMax(yardsInfront)
  local _lx, _ly, _lz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
  local _angle = lb.ObjectFacing("Player")
  local _x, _y, _z = _lx+(yardsInfront*math.cos(_angle)), _ly+(yardsInfront*math.sin(_angle)), _lz
  local zHit = 0
  for i = 1, 20 do	
    local hit = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x, _y, _z + (i*0.2), 1245521)
    local hitL = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x+(yardsInfront*math.cos(_angle-i*0.02)), _y+(yardsInfront*math.sin(_angle-i*0.02)), _z + (i*0.2), 1245521)
    local hitR = lb.Raycast(_lx, _ly, _lz + (i*0.2),  _x+(yardsInfront*math.cos(_angle+i*0.02)), _y+(yardsInfront*math.sin(_angle+i*0.02)), _z + (i*0.2), 1245521)
    if(hit or hitL or hitR) then
      zHit = i * 0.2;
    end
  end
  return zHit
end

local function JumpOverZ()

  local min1 = getObsMin(1)
  local max1 = getObsMax(1)
  local min2 = getObsMin(2)
  local max2 = getObsMax(2)

  print("min1 = " .. min1 .. " max1 = " .. max1)
  print("min2 = " .. min2 .. " max2 = " .. max2)  

  if min1 >= 0.2 and max1 > 1.5 and max1 <= 2.5 then
    print("min1 = " .. min1 .. " max1 = " .. max1)
    if not IsSwimming() and not IsSubmerged() then
      lb.Unlock(JumpOrAscendStart)
    end
  end

  if min2 >= 0.2 and max2 > 1.8 and max2 < 2.4 then
    print("min2 = " .. min2 .. " max2 = " .. max2)
    if not IsSwimming() and not IsSubmerged() then
      lb.Unlock(JumpOrAscendStart)
    end
  end

end

local function InteractAnyObjectWithinDistance(Distance)
  if Distance == nil then Distance = 10 end
  for _, i in pairs(PeaceMaker.GameObjects) do
    if i.Distance <= Distance then
      lb.Unlock(lb.ObjectInteract, i.GUID)
    end
  end 
end

---------------------------------
-- Begin of Table Lib
---------------------------------
local InitTableLib = function(lb)
  
  local _TableLib = {}

  _TableLib.valid = function(t)
    if ( t ~= nil and type(t) == "table" ) then
        local k,v = next(t)
        if (k ~= nil and v ~= nil) then
            return true
        end
    end
    return false
  end

  _TableLib.size = function(t)
    if ( t == nil or type(t) ~= "table" ) then
        return 0
    end

    local count = 0
    for k,v in pairs(t) do
        count = count + 1
    end
    return count
  end

  _TableLib.find = function(t,searchval)
    for i, value in pairs(t) do
        if value == searchval then
            return i
        end
    end
    return nil
  end

  return _TableLib

end

---------------------------------
-- Begin of MathLib
---------------------------------
local InitMathLib = function(lb)

  local _MathLib = {}

  if(not lb.table) then
    lb.table = InitTableLib(lb)
  end

  _MathLib.distance3d = function(x, y, z, x1, y1, z1)
    if ( type(x) == "table" and type(y) == "table" ) then
      return lb.math.distance3d(x.x, x.y, x.z, y.x, y.y, y.z)
    else
      if x1 and y1 and z1 then
        local dx = x1-x
        local dy = y1-y
        local dz = z1-z
        local dt = (dx * dx) + (dy * dy) + (dz * dz)
        return math.sqrt(dt)
      end
    end
  end

  _MathLib.magnitude = function(x,y,z)
    if ( type(x) == "table" and lb.table.size(x) >= 3) then
      return math.sqrt( x.x*x.x + x.y*x.y + x.z*x.z )
    else
      return math.sqrt( x*x + y*y + z*z )
    end
    return 0
  end

  _MathLib.normalize = function(t)
    if (type(t) == "table" and lb.table.size(t) >= 3) then
      local magnitude = lb.math.magnitude(t)
      if(magnitude == 0) then
          magnitude = 1
      end
      local _res = {}
      if(t.x ~= 0)then _res.x = t.x / magnitude else _res.x = 0 end
      if(t.y ~= 0)then _res.y = t.y / magnitude else _res.y = 0 end
      if(t.z ~= 0)then _res.z = t.z / magnitude else _res.z = 0 end
      return _res
    end
  end

  _MathLib.round = function (x,n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
  end

  _MathLib.vectorize = function (x, y, z, x1, y1, z1)
    if ( type(x) == "table" and type(y) == "table" ) then
      return lb.math.vectorize(x.x, x.y, x.z, y.x, y.y, y.z)
    else
      local dx = x1-x
      local dy = y1-y
      local dz = z1-z
      return {x = dx, y = dy, z = dz}
    end
  end

  _MathLib.normalizeRadian = function(p_Angle)
    if p_Angle < 0.0 then
      return (-(-p_Angle % (2.0 * math.pi)) + 2.0 * math.pi)
    else
      return p_Angle % (math.pi * 2)
    end
  end

  return _MathLib
end

---------------------------------
-- Begin of Unstuck Handler
---------------------------------
local InitUnstuckHandler = function(lb)
  local _Unstuck = {}
  local _LastTick = GetTime()
  local _LastPlayerPosition = nil
  local _JumpCount = 0
  local _StuckTryCount = 0

  _Unstuck.Reset = function()
    _LastTick = GetTime()
    _LastPlayerPosition = nil
    _LastPosition = nil
    _JumpCount = 0
  end

  _Unstuck.Run = function ()
    local l_Time = GetTime()
    if DisableNaviUnstuck then return end 
    if(l_Time - _LastTick >= 0.2)then
        _LastTick = l_Time
        local l_PlayerSpeed = GetUnitSpeed("player")
        local l_PlayerX, l_PlayerY, l_PlayerZ = lb.ObjectPosition("player")
        local l_PlayerPos = { x=l_PlayerX, y=l_PlayerY, z=l_PlayerZ}
        if(_LastPlayerPosition) then

            -- Do a raycast ahead of us to know when we need to jump:
            -- local l_AheadPosition = { x=l_PlayerX, y=l_PlayerY, z=l_PlayerZ}
            -- local l_AheadDist = 1.5
            -- local l_Angle = lb.math.normalizeRadian(lb.ObjectFacing("player"))
            -- l_AheadPosition.x = l_AheadPosition.x + l_AheadDist * math.cos(l_Angle)
            -- l_AheadPosition.y = l_AheadPosition.y + l_AheadDist * math.sin(l_Angle)
            -- l_AheadPosition.z = l_AheadPosition.z + 1
            
            local _MovedDist = lb.math.distance3d(l_PlayerPos,_LastPlayerPosition)

            if(_MovedDist < 0.6)then
              if(_JumpCount < 2)then
                _JumpCount = _JumpCount + 1
                lb.Unlock(JumpOrAscendStart)
                C_Timer.After(0.5, function()
                  lb.Unlock(AscendStop)
                end)
                StopMovingUnstuck = PeaceMaker.Time + 1
              else
                -- We are really stuck here ...
                -- lb.Print("[Navigation] - Player is really stuck .. Waht now ?!?")
                local random = math.random(1, 2)
                if random == 1 then
                  if PeaceMaker.Player.Moving then
                    lb.Unlock(MoveForwardStop)
                    lb.Unlock(MoveBackwardStart)
                    C_Timer.After(1, function()
                      lb.Unlock(MoveBackwardStop)
                      lb.Unlock(StrafeLeftStart)
                      C_Timer.After(1, function()
                        lb.Unlock(StrafeLeftStop)
                      end)
                    end)
                  else
                    if not PeaceMaker.Player.Moving then
                      lb.Unlock(MoveBackwardStart)
                      C_Timer.After(1, function()
                        lb.Unlock(MoveBackwardStop)
                        lb.Unlock(StrafeLeftStart)
                        C_Timer.After(1, function()
                          lb.Unlock(StrafeLeftStop)
                        end)
                      end)
                    end
                  end
                  _LastTick = l_Time + 1
                  _JumpCount = 0
                  StopMovingUnstuck = PeaceMaker.Time + 1
                  _StuckTryCount = _StuckTryCount + 1
                end

                if random == 2 then
                  if PeaceMaker.Player.Moving then
                    lb.Unlock(MoveForwardStop)
                    lb.Unlock(MoveBackwardStart)
                    C_Timer.After(1, function()
                      lb.Unlock(MoveBackwardStop)
                      lb.Unlock(StrafeRightStart)
                      C_Timer.After(1, function()
                        lb.Unlock(StrafeRightStop)
                      end)
                    end)
                  else
                    if not PeaceMaker.Player.Moving then
                      lb.Unlock(MoveBackwardStart)
                      C_Timer.After(1, function()
                        lb.Unlock(MoveBackwardStop)
                        lb.Unlock(StrafeRightStart)
                        C_Timer.After(1, function()
                          lb.Unlock(StrafeRightStop)
                        end)
                      end)
                    end
                  end
                  _LastTick = l_Time + 1
                  _JumpCount = 0
                  StopMovingUnstuck = PeaceMaker.Time + 1  
                  _StuckTryCount = _StuckTryCount + 1
                end

                if _StuckTryCount >= 3 then
                  if IsMounted() then Dismount() PeaceMaker.DelayMount = PeaceMaker.Time + 8 end
                  _StuckTryCount = 0
                end
              end
            end
              
            -- end
        end
        _LastPlayerPosition = l_PlayerPos
    end
  end
  return _Unstuck
end

function Navigation:AttemptRequery(x,y,z,query) 
  if query <= 3 then
    PeaceMaker.Navigator.MoveToQuery(x + math.random(10,15), y + math.random(2, 5), z, 0)
    query = query + 1
    return 
  else
    query = 0
  end
end

---------------------------------
-- Begin of  the LuaBox Navigator
---------------------------------
local InitNavigator = function(lb)

  local _Navigator        = {}
  local _Destination      = nil
  local _StopDistance     = 2.0
  local _CurrentPath      = nil
  local _CurrentPathIndex = nil
  local _LastPathIndex    = nil
  local _LastPulseTime    = nil
  local _TargetId         = 0
  local _CurrentNavConnection = nil
  local _NextNavCon         = nil
  local _EnsurePosition   = nil
  local _Thresholds = lb.NavMgr_GetThresholds() -- This would need an updater if the values are changed in the dev imgui window ..

  if(not lb.table) then
    lb.table = InitTableLib(lb)
  end

  if(not lb.math)then
    lb.math = InitMathLib(lb)
  end

  if(not _Navigator.Unstuck)then
    _Navigator.Unstuck = InitUnstuckHandler(lb)
  end

  -- The MoveTo function 'just' gets a (new)Path from c++, or prints the error why it coult not. It returns the path lenght or the error code.
  _Navigator.MoveTo = function(x, y, z, targetId, stopDistance)
      _TargetId = targetId or _TargetId
      _StopDistance = stopDistance or _StopDistance

      if ( not _CurrentNavConnection ) then -- dont call MoveTo while we are handling a NavConnection, else it can make the char walk backwards or worse

          local l_PlayerX, l_PlayerY, l_PlayerZ = lb.ObjectPosition("player")
          
          if (l_PlayerX and l_PlayerY and l_PlayerZ) then
              _Destination= { x = x, y = y, z = z }

              if(lb.math.magnitude(_Destination) == 0) then
                  lb.Print("[Navigation] - Invalid MoveTo Position (0,0,0)")
                  return
              end

              if(lb.math.magnitude(l_PlayerX, l_PlayerY, l_PlayerZ) == 0) then
                  lb.Print("[Navigation] - Invalid Start Position (0,0,0)")
                  return
              end

              if lb.NavMgr_GetMeshState() == 0 then --// MESH is not Empty
                  lb.Print("[Navigation] - No Navmesh Loaded")
                  return
              end

              local l_newpath = lb.NavMgr_MoveTo(_Destination.x, _Destination.y, _Destination.z, _TargetId)
              --local l_newpath = lb.NavMgr_GetPath(_Destination.x, _Destination.y, _Destination.z)

              if l_newpath and (lb.table.valid(l_newpath)) then
                   -- We got a valid path:
                   _CurrentPath = l_newpath
                   local psize = lb.table.size(l_newpath)
                   --lb.Print("[Navigation] - New path with "..tostring(psize).. " Nodes")
                   return psize

              elseif(type(l_newpath) == "number") then
                  -- Errors:
                  local pPos = { x=l_PlayerX, y=l_PlayerY, z=l_PlayerZ}
                  local mapid = lb.GetMapId()
                  if ( l_newpath == -12 ) then
                      lb.Print("[Navigation] - Mesh empty or Player not found.")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif ( l_newpath == -11 ) then
                      lb.Print("[Navigation] - Invalid arguments, 'x, y, z, targetid(optional)' expected!")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif ( l_newpath == -10 ) then
                      lb.Print("[Navigation] - Error: MacroPath to Target Position not found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif ( l_newpath == -9 ) then
                      lb.Print("[Navigation] - Error: MacroPath to Start Position not found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif ( l_newpath == -8 ) then
                      lb.Print("[Navigation] - Error: No Macronode near Target Position found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif ( l_newpath == -7 ) then
                      lb.Print("[Navigation] - Error: No Macronode near Start Position found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -6 ) then
                      lb.Print("[Navigation] - Error: No Macropath found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -5 ) then
                      lb.Print("[Navigation] - Error: Path too long (out of nodes) - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -4 ) then
                      lb.Print("[Navigation] - Error: Straightpath failed - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -3 ) then
                      lb.Print("[Navigation] - Error: No Path found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -2 ) then
                      lb.Print("[Navigation] - Error: Target Position is not on the NavMesh - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  elseif( l_newpath == -1 ) then
                      lb.Print("[Navigation] - Error: Player is not on the NavMesh - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  else
                      lb.Print("[Navigation] - GetPath Error Code " ..tostring(l_newpath))
                      Navigation:AttemptRequery(_Destination.x, _Destination.y, _Destination.z,RequeryNav)
                  end
                  return l_newpath    -- give back the error code

              elseif(type(l_newpath) == "table" and lb.table.size(l_newpath) == 0) then
                  lb.Print("[Navigation] - Received empty path table...")
              end
          else
              lb.Print("[Navigation] - Unable to get Player Position.")
          end
      end
      return 0
  end

  _Navigator.MoveToQuery = function(x, y, z, targetId, stopDistance)
    _TargetId = targetId or _TargetId
    _StopDistance = stopDistance or _StopDistance

    if ( not _CurrentNavConnection ) then -- dont call MoveTo while we are handling a NavConnection, else it can make the char walk backwards or worse

        local l_PlayerX, l_PlayerY, l_PlayerZ = lb.ObjectPosition("player")
        if (l_PlayerX and l_PlayerY and l_PlayerZ) then
            _Destination= { x = x, y = y, z = z }

            if(lb.math.magnitude(_Destination) == 0) then
                lb.Print("[Navigation] - Invalid MoveTo Position (0,0,0)")
                return
            end

            if(lb.math.magnitude(l_PlayerX, l_PlayerY, l_PlayerZ) == 0) then
                lb.Print("[Navigation] - Invalid Start Position (0,0,0)")
                return
            end

            if lb.NavMgr_GetMeshState() == 0 then --// MESH is not Empty
                lb.Print("[Navigation] - No Navmesh Loaded")
                return
            end

            local l_newpath = lb.NavMgr_MoveTo(_Destination.x, _Destination.y, _Destination.z, _TargetId)
            --local l_newpath = lb.NavMgr_GetPath(_Destination.x, _Destination.y, _Destination.z)

            if(lb.table.valid(l_newpath)) then
                 -- We got a valid path:
                 _CurrentPath = l_newpath
                 local psize = lb.table.size(l_newpath)
                 --lb.Print("[Navigation] - New path with "..tostring(psize).. " Nodes")
                 return psize

            elseif(type(l_newpath) == "number") then
                -- Errors:
                local pPos = { x=l_PlayerX, y=l_PlayerY, z=l_PlayerZ}
                local mapid = lb.GetMapId()
                if ( l_newpath == -12 ) then
                    lb.Print("[Navigation] - Mesh empty or Player not found.")
                elseif ( l_newpath == -11 ) then
                    lb.Print("[Navigation] - Invalid arguments, 'x, y, z, targetid(optional)' expected!")
                elseif ( l_newpath == -10 ) then
                    lb.Print("[Navigation] - Error: MacroPath to Target Position not found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")
                elseif ( l_newpath == -9 ) then
                    lb.Print("[Navigation] - Error: MacroPath to Start Position not found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif ( l_newpath == -8 ) then
                    lb.Print("[Navigation] - Error: No Macronode near Target Position found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif ( l_newpath == -7 ) then
                    lb.Print("[Navigation] - Error: No Macronode near Start Position found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -6 ) then
                    lb.Print("[Navigation] - Error: No Macropath found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -5 ) then
                    lb.Print("[Navigation] - Error: Path too long (out of nodes) - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -4 ) then
                    lb.Print("[Navigation] - Error: Straightpath failed - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -3 ) then
                    lb.Print("[Navigation] - Error: No Path found - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -2 ) then
                    lb.Print("[Navigation] - Error: Target Position is not on the NavMesh - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                elseif( l_newpath == -1 ) then
                    lb.Print("[Navigation] - Error: Player is not on the NavMesh - MapID "..tostring(mapid).." - From [ "..tostring(lb.math.round(pPos.x,0)).." / "..tostring(lb.math.round(pPos.y,0)).." / "..tostring(lb.math.round(pPos.z,0)).."] To [".. tostring(lb.math.round(x,0)).. " / "..tostring(lb.math.round(y,0)).." / "..tostring(lb.math.round(z,0)).."]")

                -- Unknown error code !?.
                else
                    lb.Print("[Navigation] - GetPath Error Code " ..tostring(l_newpath))
                end
                return l_newpath    -- give back the error code

            elseif(type(l_newpath) == "table" and lb.table.size(l_newpath) == 0) then
                lb.Print("[Navigation] - Received empty path table...")
            end
        else
            lb.Print("[Navigation] - Unable to get Player Position.")
        end
    end
    return 0
  end

  -- Stops Navigation and the Player
  _Navigator.Stop = function()
    local px,py,pz = lb.ObjectPosition('player')
    _Destination        = nil
    _CurrentPathIndex   = nil
    _LastPathIndex      = nil
    _CurrentPath        = nil
    _NextNavCon         = nil
    _CurrentNavConnection = nil
    _TargetId         = 0
    _EnsurePosition   = nil
    _Navigator.Unstuck.Reset()
    lb.NavMgr_Stop()
    if GetUnitSpeed('player') > 0 then
      if lb.UnitHasMovementFlag("player", lb.EMovementFlags.Forward) then
        lb.Unlock(MoveForwardStop)
      else
        local x,y,z = lb.ObjectPosition('player')
        lb.MoveTo(x,y,z)
      end
    end
    --lb.Print("[Navigation] - Stopped")
  end

  local _GetTurnDirectionRequired = function(p_X, p_Y, p_Z)
      local l_l_PlayerX, l_l_PlayerY  = lb.ObjectPosition("player")
      local l_PlayerFacing        = lb.ObjectFacing("player")
      local l_AngleRequired       = lb.math.normalizeRadian(math.atan2(p_Y - l_l_PlayerY, p_X - l_l_PlayerX))

      local l_Delta = lb.math.normalizeRadian(l_AngleRequired - l_PlayerFacing)
      if l_Delta < math.pi then
        return "left", l_Delta
      else
        return "right", lb.math.normalizeRadian(l_PlayerFacing - l_AngleRequired)
      end
  end

  local _UpdatePlayerFacing = function(p_Delta, l_PlayerPos, l_NextNode, l_distToNode, l_AdjustPitch)
    local l_AngleRequired = lb.ObjectFacing("player")
    --local l_AngleRequired = lb.ObjectRawFacing("player")
    local l_PitchRequired = lb.math.round(lb.ObjectPitch("player"),3)

    if(l_distToNode > 4) then
        -- Smooth turn
        local l_Dir, l_Delta = _GetTurnDirectionRequired(l_NextNode.x, l_NextNode.y, l_NextNode.z)
        if l_Delta > 0 then
          local l_AddAngle = ((l_Delta / 2) * p_Delta) * 20

          if l_AddAngle > l_Delta then
            l_AddAngle = l_Delta
          end

          if l_Dir == "left" then
            --if not TurnRight and not TurnLeft then lb.Unlock(TurnLeftStart) TurnLeft = true end
            l_AngleRequired = lb.math.normalizeRadian(l_AngleRequired + l_AddAngle)
            --C_Timer.After(0.5, function() lb.Unlock(TurnLeftStop) TurnLeft = false end)
          elseif l_Dir == "right" then
            --if not TurnLeft and not TurnRight then lb.Unlock(TurnRightStart) TurnRight = true end
            l_AngleRequired = lb.math.normalizeRadian(l_AngleRequired - l_AddAngle)
            --C_Timer.After(0.5, function() lb.Unlock(TurnRightStop) TurnRight = false end)
          end
        end
    else
      -- hard turn
      l_AngleRequired = lb.math.normalizeRadian(math.atan2(l_NextNode.y - l_PlayerPos.y, l_NextNode.x - l_PlayerPos.x))
    end

    if(not l_AdjustPitch or l_AdjustPitch == false )then
      -- Just set horizontal facing direction
      lb.SetPlayerAngles(l_AngleRequired)
    else
      -- Also set Pitch for 3D movement
      local l_Vector = lb.math.normalize(lb.math.vectorize(l_PlayerPos,l_NextNode))
      l_PitchRequired = math.asin(-1 * l_Vector.z)
    -- Limit pitch if needed:
      --[[if (l_PitchRequired > 1.4835) then
          lb.Print("[Navigation] - Required pitch was too high (downwards) ["..tostring(l_PitchRequired).."], adjusted it to max.")
          l_PitchRequired = 1.4835
      elseif (l_PitchRequired < -0.7599) then
          lb.Print("[Navigation] - Required pitch was too high (upwards) ["..tostring(l_PitchRequired).."], adjusted it to max.")
          l_PitchRequired = -0.7599
      end]]
      lb.SetPlayerAngles(l_AngleRequired, l_PitchRequired)
    end
  end

  -- Stops all further navigation until the player is standing exactly on the wanted position (and optionally faces the desired direction), used for precise NavConnection handling
  local _HandleEnsurePosition = function(position)
      -- TODO
      return false
  end

  -- Needs to return 3 bools: l_AllowSetMovement, l_AllowSetFacing, l_AllowPathUpdates
  local _HandleCurrentNavConnection = function(lb)
      if(_CurrentNavConnection.type == 4)then
          -- Custom NavConnection
          local l_SubType = _CurrentNavConnection.details.subtype
          if(l_SubType == 0)then
              -- Handle Jump
              -- TODO: _HandleEnsurePosition & facing for precise jumps...
              lb.Unlock(JumpOrAscendStart)
              return true, true, false

          elseif(l_SubType == 1)then
              -- Handle Walk: From Start (where we are right now) to End
              return true, true, false

          elseif(l_SubType == 2)then
              -- Handle Interact
              -- lb.Print("[Navigation] - TODO: HANDLE INTERACT NAV CONNECTIONS")
              InteractAnyObjectWithinDistance(10)
              return true, true, false
          elseif(l_SubType == 3)then
              -- Lua Code
              lb.Print("[Navigation] - TODO: HANDLE Lua Code NAV CONNECTIONS")
              local l_Result
              if(_CurrentNavConnection.details.luacode ~= "")then
                if ( not _CurrentNavConnection.details.luacode_compiled and not _CurrentNavConnection.details.luacode_bugged ) then
                    local execstring = 'return function(self,startnode,endnode) '.._CurrentNavConnection.details.luacode..' end'
                    local func = loadstring(execstring)
                    if ( func ) then
                        l_Result = func()(_CurrentNavConnection)
                        _CurrentNavConnection.details.luacode_compiled = func
                    else
                        _CurrentNavConnection.details.luacode_compiled = nil
                        _CurrentNavConnection.details.luacode_bugged = true
                        lb.Print("[Navigation] - The NavConnection Lua Code has a bug !")
                        assert(loadstring(execstring)) -- print out the actual error
                    end
                else
                    --executing the already loaded function
                    if(_CurrentNavConnection.details.luacode_compiled) then
                        l_Result = _CurrentNavConnection.details.luacode_compiled()(_CurrentNavConnection)
                    end
                end
              else
                  lb.Print("[Navigation] - Error: Lua Code Navconnection has no Lua code!")
              end
              return l_Result, l_Result, false
          end
      end
      return true, true, true
  end

  -- Does the actual Player Movement / Follow Path
  local PauseUpdate = 0
  local _OnPulse = function()
      
      local l_Time = GetTime()
      local l_Delta = l_Time - (_LastPulseTime or 0)
  
      if(l_Delta >= 0.1 and PeaceMaker.Time > StopMovingUnstuck) then
          
          _LastPulseTime = l_Time

          if(_CurrentPath) then

              local l_PlayerX, l_PlayerY, l_PlayerZ = lb.ObjectPosition("player")
              local l_playerPos = { x=l_PlayerX, y=l_PlayerY, z=l_PlayerZ}
              local l_PathSize = lb.table.size(_CurrentPath)

              if ( l_PathSize > 0 and l_PlayerX and l_PlayerY and l_PlayerZ ) then

                  _CurrentPathIndex = lb.NavMgr_GetPathIndex() or 1

                  if ( _CurrentPathIndex <= l_PathSize ) then
                    
                      if( not _LastPathIndex or _LastPathIndex ~= _CurrentPathIndex)then
                        _LastPathIndex = _CurrentPathIndex
                      end

                      local l_LastNode =  _CurrentPathIndex > 1 and _CurrentPath[ _CurrentPathIndex - 1] or nil
                      local l_NextNode = _CurrentPath[ _CurrentPathIndex ]
                      local l_NextNextNode = _CurrentPath[ _CurrentPathIndex + 1]

                      -- Ensure Position: Takes the time to make sure the player is really stopped at the wanted position (used for precise NavConnection handling)
                      if ( lb.table.valid (_EnsurePosition) and _HandleEnsurePosition(l_playerPos) ) then
                          return
                      end

                      -- Handle _CurrentNavConnection
                      local l_AllowSetMovement = true
                      local l_AllowSetFacing = true
                      local l_AllowPathUpdates = true
                      local l_AllowMount = true

                      if(_CurrentNavConnection) then
                          -- Some NavConnections require special handling
                          l_AllowSetMovement, l_AllowSetFacing, l_AllowPathUpdates = _HandleCurrentNavConnection(lb)
                      end

                      -- Moving to the next node in our path:
                      local l_NC = nil
                      local l_NCRadius = 0
                      if( l_NextNode and l_NextNode.navcon_id and l_NextNode.navcon_id ~= 0) then
                        -- take into account navconnection radius, to randomize the movement on places where precision is not needed                            
                        l_NC = _NextNavCon
                        if(not _NextNavCon or _NextNavCon.id ~= l_NextNode.navcon_id) then
                            l_NC = lb.NavMgr_GetNavConnection(l_NextNode.navcon_id) -- this is spammed, quite bad and useless, therefore the _NextNavCon code
                        end
                        if ( l_NC ) then
                            --lb.Print("[Navigation] - A navcon_side_A "..tostring(l_NC.sideA.radius))
                            if(l_NextNode.navcon_side_A == true) then
                                l_NCRadius = l_NC.sideA.radius
                            else
                                l_NCRadius = l_NC.sideB.radius
                            end
                        end
                      else
                        if(_NextNavCon)then
                            _NextNavCon = nil
                        end
                      end
                      
                      local l_distToNode = lb.math.distance3d(l_NextNode, l_playerPos) - l_NCRadius

                      -- Get our current movement states
                      local l_isMoving = lb.UnitHasMovementFlag("player", lb.EMovementFlags.Forward) or GetUnitSpeed('player') > 0
                      local l_isSwimming = lb.UnitHasMovementFlag("player", lb.EMovementFlags.Swimming)
                      local l_isFlying = lb.UnitHasMovementFlag("player", lb.EMovementFlags.Flying)
                      local l_isMounted = lb.UnitHasMovementFlag("player", lb.EMovementFlags.CanFly)
                      if((l_isFlying or l_isSwimming) and l_isMoving == false)then
                          -- check additionally if we fly up/down
                        l_isMoving = lb.UnitHasMovementFlag("player", lb.EMovementFlags.Ascending)
                        if(l_isMoving == false)then
                            l_isMoving = lb.UnitHasMovementFlag("player", lb.EMovementFlags.Descending)
                        end
                      end

                      -- Check if we reached the next node in our path:
                      local l_pointReachedThreshold
                      if(l_NextNextNode == nil) then
                          l_pointReachedThreshold = _StopDistance -- We are walking to the last node in our pathdistance
                      else
                        local l_PlayerSpeed = GetUnitSpeed("player") or 7.0 -- Default speed
                        if l_PlayerSpeed <= 2.5 then
                            l_pointReachedThreshold = 1.2
                        else
                            l_pointReachedThreshold = l_PlayerSpeed / 4
                        end
                        if(l_isSwimming == true or l_isFlying ==true) then
                            l_pointReachedThreshold = l_pointReachedThreshold * 1.25 -- ???
                        end
                      end
                      
                      if(l_distToNode <= l_pointReachedThreshold)then
                          
                        if(_CurrentNavConnection)then
                            -- We arrived at the end of the NavConnection
                            _CurrentNavConnection = nil
                        end
                        
                        -- We arrived at the next node
                        if(l_NC)then
                            -- next node is the start of a navcon_id
                            _CurrentNavConnection = l_NC                                
                            if(l_NCRadius > 0 and l_NCRadius < 1.0)then
                                lb.Print("[Navigation] - TODO: SetEnsureStartPosition")
                            end
                        end

                        _CurrentPathIndex = _CurrentPathIndex + 1
                        lb.NavMgr_SetPathIndex(_CurrentPathIndex)
                        return
                      end

                      if(l_AllowSetFacing == true) then
                          -- Move to the next node in our pathdistance
                          if not PeaceMaker.Settings.profile.General.UseClickToMove then
                            local l_AdjustPitch = l_isSwimming == true or l_isFlying ==true or l_isMounted == true
                            _UpdatePlayerFacing(l_Delta, l_playerPos, l_NextNode, l_distToNode, l_AdjustPitch)
                          end
                      end

                      if (l_AllowMount == true) then

                      end

                      if(l_AllowSetMovement == true) then
                        if PeaceMaker.Settings.profile.General.UseClickToMove then
                          lb.MoveTo(l_NextNode.x, l_NextNode.y, l_NextNode.z)
                        else
                          lb.Unlock(MoveForwardStart)
                        end
                        _Navigator.Unstuck.Run()
                      end

                      if(l_AllowPathUpdates == true and PeaceMaker.Time > PauseUpdate) then
                        -- Update & adjust existing path by repeatly calling the MoveTo
                        _Navigator.MoveTo(_Destination.x, _Destination.y, _Destination.z, _TargetId, _StopDistance)
                        PauseUpdate = PeaceMaker.Time + 1
                      end

                  else
                    --lb.Print("[Navigation] - Path End Reached.")
                    _Navigator.Stop()
                  end
              else
                lb.Print("Path Size is 0!!??")
              end
            end
      end
  end

  _Navigator.GetDestination = function()
      if _Destination then
        return _Destination.x, _Destination.y, _Destination.z
      else
        return nil
      end
  end

  C_Timer.NewTicker(0.1, _OnPulse)
  return _Navigator
end

local OnInitialize = function(lb)
  PeaceMaker.Navigator = InitNavigator(lb)
end

function Navigation:MoveTo(toX, toY, toZ, Distance)
  local px, py, pz = lb.ObjectPosition('player')
  if toX == nil or toY == nil or toZ == nil then return end
  if UnitCastingInfo("player") then return end
  if UnitInVehicle("player") or UnitOnTaxi("player") then if PeaceMaker.Navigator.GetDestination() then PeaceMaker.Navigator.Stop() end return end
  if Distance == nil then Distance = 4 end
  if not lb.GetDistance3D(px, py, pz, toX, toY, toZ) then return end
  if lb.GetDistance3D(px, py, pz, toX, toY, toZ) > Distance then
    if Distance < 3 then
      local nx, ny, nz = PeaceMaker.Navigator.GetDestination()
      if nx == toX and ny == toY and nz == toZ then
        return false
      end
      PeaceMaker.Navigator.MoveTo(toX, toY, toZ, 1, Distance)
    else
      local nx, ny, nz = PeaceMaker.Navigator.GetDestination()
      if nx == toX and ny == toY and nz == toZ then
        if PeaceMaker.Player.Moving then
          return false
        end
      end
      PeaceMaker.Navigator.MoveTo(toX, toY, toZ)
    end
    PeaceMaker.Navigator.MoveTo(toX, toY, toZ, 1, Distance)
    return false
  end
  if lb.GetDistance3D(px, py, pz, toX, toY, toZ) < Distance then
    return true
  end
  return false
end

function Navigation:MoveToPlace(toX, toY, toZ)
  if not Path or (toX ~= EndX or toY ~= EndY or toZ ~= EndZ) then
    self:MoveTo(toX, toY, toZ)
    return true
  end
  return false
end

function Navigation:NearGrindHotSpot()
  local HotSpot = PeaceMaker.GrindHotSpot
  if HotSpot then
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local px,py,pz = lb.ObjectPosition('player')
      local PlayerDistanceBetweenSpot = lb.GetDistance3D(px,py,pz,x,y,z)
      if PlayerDistanceBetweenSpot <= radius then
        return true
      end
    end
  end
  return false
end

function Navigation:NearGatherHotSpot()
  local HotSpot = PeaceMaker.GatherHotSpot
  if HotSpot then
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local px,py,pz = lb.ObjectPosition('player')
      local PlayerDistanceBetweenSpot = lb.GetDistance3D(px,py,pz,x,y,z)
      if PlayerDistanceBetweenSpot <= radius then
        return true
      end
    end
  end
  return false
end

function Navigation:GetNearbyWayPoint(WayPointTable)
  local tmp = {}
  for i = 1, #WayPointTable do
    local px,py,pz = lb.ObjectPosition('player')
    local nx,ny,nz = WayPointTable[i].x, WayPointTable[i].y, WayPointTable[i].z
    local Dist = lb.GetDistance3D(px,py,pz,nx,ny,nz)
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
  WPIndex = tmp[1].Index
end

function Navigation:GrindRoam()
  local HotSpot = PeaceMaker.GrindHotSpot
  if HotSpot ~= nil and HotSpot then
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    --if PeaceMaker.Helpers.Core.Misc:CheckBlackListHotSpot(x,y,z) then WPIndex = WPIndex + 1 if WPIndex > #HotSpot then WPIndex = 1 end return end
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 2.5 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:TagGrindRoam()
  local HotSpot = PeaceMaker.GrindHotSpot
  if PeaceMaker.Helpers.Core.Mount:HasMount() 
    and PeaceMaker.Helpers.Core.Mount:CheckMountedMount()
    and not PeaceMaker.Player.Combat
  then 
    PeaceMaker.Helpers.Core.Mount:Run(PeaceMaker.Settings.profile.TagGrinding.MountID) 
    return 
  end
  if HotSpot ~= nil and HotSpot then    
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance <= 20 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x, y, z)
      end
    end
  end
end

function Navigation:GatherRoam()
  local HotSpot = PeaceMaker.GatherHotSpot
  if HotSpot ~= nil and HotSpot then
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 8 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestRoam()
  local HotSpot = PeaceMaker.QuestGrindHotSpot
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 2 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestGatherRoam()
  local HotSpot = PeaceMaker.QuestGatherHotSpot
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 2 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestDungeonRoam()
  local HotSpot = PeaceMaker.QuestDungeonHotspot
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance and Distance < 2 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestInteractRoam()
  local HotSpot = PeaceMaker.QuestInteractHotSpot
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 2 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestUseItemRoam()
  local HotSpot = PeaceMaker.QuestUseItemHotspot
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    local radius = HotSpot[WPIndex].radius or 100
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < 2 then
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:QuestUseItemOnLocationRoam(itemid, second, distance)
  local HotSpot = PeaceMaker.QuestUseItemOnLocation
  if distance == nil then distance = 3 end
  if HotSpot ~= nil and HotSpot then
    if WPIndex > #HotSpot then WPIndex = 1 return end
    local px,py,pz = lb.ObjectPosition('player')
    local x,y,z = HotSpot[WPIndex].x, HotSpot[WPIndex].y, HotSpot[WPIndex].z
    if x and y and z then
      local Distance = lb.GetDistance3D(px,py,pz,x,y,z)
      if Distance < distance then
        lb.Unlock(UseItemByName, itemid)
        WPIndex = WPIndex + 1
        if WPIndex > #HotSpot then
          WPIndex = 1
        end
        PeaceMaker.Pause = PeaceMaker.Time + second
      else
        self:MoveTo(x,y,z,2)
      end
    end
  end
end

function Navigation:MoveToCorpse() 

  if StaticPopup1 
    and StaticPopup1:IsVisible() 
    and (StaticPopup1.which == "DEATH" or StaticPopup1.which == "RECOVER_CORPSE")
    and StaticPopup1Button1
    and StaticPopup1Button1:IsEnabled()
  then
    --StaticPopup1Button1:Click()
    lb.Unlock(RunMacroText, "/run StaticPopup1Button1:Click()")
    self:StopMoving()
    PeaceMaker.Pause = PeaceMaker.Time + 2
    return true
  end

  if PeaceMaker.Player.Ghost then
    local px, py, pz = lb.ObjectPosition('player')
    local corpseX, corpseY, corpseZ = lb.GetPlayerCorpsePosition()
    if lb.GetDistance3D(px, py, pz, corpseX, corpseY, corpseZ) > PeaceMaker.Settings.profile.General.RessDistance then
      self:MoveTo(corpseX, corpseY, corpseZ)
    else
      if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
    end
  end

  return false
end

function Navigation:StopMoving()
  PeaceMaker.Navigator.Stop()
  lb.Unlock(MoveForwardStart)
  lb.Unlock(MoveForwardStop)
end

function Navigation:CheckRidingSkill()
  local RidingSkillList = { "Expert Riding", "Artisan Riding", "Master Riding" }
  if GetSpellInfo(RidingSkillList[1]) or GetSpellInfo(RidingSkillList[2]) or GetSpellInfo(RidingSkillList[3]) then
    return true
  end
  return false
end

function Navigation:SetFilterNavigation()
  if self:CheckRidingSkill() and IsFlyableArea() then 
    if lb.NavMgr_GetExcludeFilter(1) ~= 0 then
      lb.NavMgr_SetExcludeFilter(1, 0) 
    end
  else
    if lb.NavMgr_GetExcludeFilter(1) ~= 1 then
      lb.NavMgr_SetExcludeFilter(1, 1) 
    end
  end
end

function Navigation:Run()
  if PeaceMaker.Navigator then
    self:SetFilterNavigation()
  else
    if not PeaceMaker.Navigator then
      PeaceMaker.Navigator = InitNavigator(lb)
      return
    end
  end
end