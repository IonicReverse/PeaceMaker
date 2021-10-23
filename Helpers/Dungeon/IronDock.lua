local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Dungeon.IronDock = {}
PeaceMaker.Helpers.Dungeon.IronDock.MerchantOpen = false

IronPathIndex = 1
IronMoveInPathIndex = 1
PreventMount = 0
local Iron_Dock = PeaceMaker.Helpers.Dungeon.IronDock
local InteractVendor = false
local MoveDelay = 0
local ExpireTime = 0
local CombatTimer = 0
local LootBlackList = {}

local IronDockWP1 = {
  [1] = { 6767.3530273438 , -577.27386474609 , 4.9254479408264 }, 
  [2] = { 6793.439453125 , -579.74224853516 , 4.7469205856323 }, 
  [3] = { 6839.7358398438 , -549.17932128906 , 4.9216394424438 }, 
  [4] = { 6862.5483398438 , -557.33966064453 , 4.924307346344 }, 
  [5] = { 6867.8208007813 , -581.06634521484 , 5.149594783783 }, 
  [6] = { 6856.4565429688 , -616.17681884766 , 4.742112159729 }, 
  [7] = { 6843.0131835938 , -594.619140625 , 4.5705885887146 }, 
  [8] = { 6794.8559570313 , -596.01965332031 , 4.7392816543579 }, 
  [9] = { 6805.0512695313 , -611.16223144531 , 4.5419235229492 }, 
  [10] = { 6762.4887695313 , -622.00439453125 , 4.9259042739868 }, 
  [11] = { 6780.771484375 , -639.83422851563 , 4.9260048866272 }, 
  [12] = { 6820.9252929688 , -642.59246826172 , 4.9260048866272 }, 
  [13] = { 6840.5571289063 , -690.98706054688 , 4.6207437515259 }, 
  [14] = { 6824.8198242188 , -687.41741943359 , 4.8336081504822 }, 
  [15] = { 6812.3227539063 , -684.27600097656 , 4.9815950393677 }, 
  [16] = { 6793.58984375 , -681.79229736328 , 4.743634223938 }, 
  [17] = { 6766.34765625 , -660.92327880859 , 4.9107694625854 }, 
  [18] = { 6829.154296875 , -731.6748046875 , 4.9293961524963 } 
}

local IronDockWP2 = {
  [1] = { 6862.5678710938 , -804.39739990234 , 4.9349217414856 }, 
  [2] = { 6880.1665039063 , -822.88385009766 , 4.9338912963867 }, 
  [3] = { 6889.4838867188 , -837.78533935547 , 4.9403166770935 },
  [4] = { 6911.5239257813 , -836.71618652344 , 4.9355626106262 }, 
  [5] = { 6947.3852539063 , -847.16876220703 , 4.9403538703918 }, 
  [6] = { 6944.3657226563 , -865.84826660156 , 4.934886932373 }, 
  [7] = { 6900.7651367188 , -810.98028564453 , 4.9342403411865 }, 
  [8] = { 6885.6752929688 , -790.23883056641 , 4.9251503944397 }, 
  [9] = { 6856.283203125 , -795.95965576172 , 4.9342985153198 }, 
  [10] = { 6825.4389648438 , -760.03234863281 , 4.9404335021973 }, 
  [11] = { 6720.25390625 , -760.74810791016 , 12.435115814209 }, 
  [12] = { 6723.4165039063 , -718.91259765625 , 12.331674575806 }, 
  [13] = { 6721.6489257813 , -689.55322265625 , 12.33952999115 }, 
  [14] = { 6719.5688476563 , -660.41729736328 , 12.357343673706 }, 
  [15] = { 6716.3203125 , -628.04266357422 , 10.110815048218 }, 
  [16] = { 6575.396484375 , -642.84594726563 , 4.9269404411316 }, 
  [17] = { 6577.28125 , -668.38513183594 , 4.7488059997559 }, 
  [18] = { 6614.8071289063 , -687.22326660156 , 4.7729878425598 }, 
  [19] = { 6634.2670898438 , -731.95495605469 , 4.9289703369141 }, 
  [20] = { 6629.3139648438 , -753.98870849609 , 4.934121131897 }, 
  [21] = { 6599.7885742188 , -778.4853515625 , 4.9377694129944 }, 
  [22] = { 6574.36328125 , -816.18774414063 , 4.938036441803 }, 
  [23] = { 6494.6538085938 , -841.98297119141 , 4.9398231506348 }, 
  [24] = { 6488.5029296875 , -890.07049560547 , 5.1999139785767 }, 
  [25] = { 6497.3544921875 , -919.48101806641 , 4.9585914611816 }, 
  [26] = { 6503.2749023438 , -964.20635986328 , 4.9594664573669 }, 
  [27] = { 6469.8286132813 , -955.73944091797 , 4.9593205451965 }, 
  [28] = { 6464.205078125 , -1012.8936767578 , 4.9593205451965 }, 
  [29] = { 6490.458984375 , -1027.1665039063 , 4.5832185745239 },
  [30] = { 6511.5361328125 , -1005.6330566406 , 4.9587736129761 }, 
  [31] = { 6509.955078125 , -1067.4346923828 , 4.9587736129761 }, 
  [32] = { 6506.4140625 , -1127.4227294922 , 4.9587736129761 },
  [33] = { 6507.9038085938 , -1141.8698730469 , 4.9822487831116 } 
}

local IronDockWP3 = {
  [1] = { 6497.3544921875 , -919.48101806641 , 4.9585914611816 }, 
  [2] = { 6503.2749023438 , -964.20635986328 , 4.9594664573669 }, 
  [3] = { 6469.8286132813 , -955.73944091797 , 4.9593205451965 }, 
  [4] = { 6464.205078125 , -1012.8936767578 , 4.9593205451965 }, 
  [5] = { 6490.458984375 , -1027.1665039063 , 4.5832185745239 } 
}

local IronDockWP4 = {
  [1] = { 6511.5361328125 , -1005.6330566406 , 4.9587736129761 }, 
  [2] = { 6509.955078125 , -1067.4346923828 , 4.9587736129761 }, 
  [3] = { 6506.4140625 , -1127.4227294922 , 4.9587736129761 },
  [4] = { 6507.9038085938 , -1141.8698730469 , 4.9822487831116 } 
}

local IronDockWP5 = {
  [1] = { 6509.333984375 , -1174.0864257813 , 12.431354522705 }, 
  [2] = { 6631.787109375 , -1170.9582519531 , 12.431354522705 }, 
  [3] = { 6653.9169921875 , -1174.9548339844 , 12.431354522705 }, 
  [4] = { 6654.1762695313 , -1119.0832519531 , 4.9319314956665 }, 
  [5] = { 6661.6088867188 , -1173.6112060547 , 12.432074546814 }, 
  [6] = { 6720.9638671875 , -1191.607421875 , 4.9591798782349 }, 
  [7] = { 6750.1450195313 , -1184.7703857422 , 4.9593434333801 }, 
  [8] = { 6790.0776367188 , -1181.5377197266 , 12.43057346344 }, 
  [9] = { 6802.9755859375 , -1115.9196777344 , 4.8086786270142 }, 
  [10] = { 6805.2709960938 , -1175.7435302734 , 12.431188583374 }, 
  [11] = { 6847.1782226563 , -1195.8531494141 , 4.9590382575989 }, 
  [12] = { 6902.8671875 , -1175.6728515625 , 4.9590382575989 }, 
  [13] = { 6927.3955078125 , -1141.5686035156 , 4.9586873054504 }, 
  [14] = { 6956.2241210938 , -1097.8570556641 , 4.6035084724426 },
  --[14] = { 6958.1030273438 , -1088.4736328125 , 4.6034903526306 },
  --[14] = { 6967.3374023438 , -1088.6011962891 , 4.6028475761414 }, 
  [15] = { 6909.0483398438 , -1087.3254394531 , 4.9610557556152 } 
}

local IronDockWP6 = {
  [1] = { 6897.1875 , -1073.8322753906 , 4.9636478424072 }, 
  [2] = { 6880.353515625 , -1074.8894042969 , 13.165958404541 }, 
  [3] = { 6879.0185546875 , -1056.7633056641 , 27.768371582031 }, 
  [4] = { 6873.9423828125 , -1014.802734375 , 23.047109603882 }, 
  [5] = { 6845.9853515625 , -1008.3414306641 , 23.046094894409 }, 
  [6] = { 6817.626953125 , -986.93377685547 , 22.782293319702 }, 
  [7] = { 6728.0288085938 , -976.68237304688 , 23.046949386597 },
  [8] = { 6730.64453125 , -969.83410644531 , 23.046611785889 } 
}

local IronMoveOut = {
  [1] = { 6750.501953125 , -542.37951660156 , 4.9254479408264 }
  --[2] = { 6750.0717773438 , -522.53594970703 , 5.9928789138794 } 
}

local IronMoveIn = {
  [1] = {8850.580, 1370.090, 96.893},
  [2] = {8851.432, 1347.015, 98.264}
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
  local px, py = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY
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

local function ResetDock()
  PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 1
  IronPathIndex = 1
  InteractVendor = false
  LootBlackList = {}
  CombatTimer = 0
  ResetInstances()
end

local function ResetVariable()
  PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 1
  IronPathIndex = 1
  InteractVendor = false
  CombatTimer = 0
  LootBlackList = {}
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

local function IronDock_1()
  if #IronDockWP1 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 2
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP1[IronPathIndex])
    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP1 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 3
        PeaceMaker.Pause = PeaceMaker.Time + 1
        FaceDirection(6823.155, -721.218)
      end
    else
      debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if (IronPathIndex <= 5 or IronPathIndex == 12) then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if (IronPathIndex > 5 and IronPathIndex ~= 12) then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_2()
  if #IronDockWP2 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 4
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP2[IronPathIndex])
    
    if IronPathIndex == 29
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3 
      and PeaceMaker.Time > ExpireTime 
    then
      MoveDelay = PeaceMaker.Time + 5
      ExpireTime = PeaceMaker.Time + 10
    end

    if IronPathIndex == 32
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3
      and PeaceMaker.Time > ExpireTime
    then
      MoveDelay = PeaceMaker.Time + 5
      ExpireTime = PeaceMaker.Time + 10
    end

    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP2 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 5
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if (IronPathIndex == 1 or IronPathIndex == 31) then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 and IronPathIndex ~= 31 then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_3()
  if #IronDockWP3 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 5
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP3[IronPathIndex])
    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP3 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 6
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if IronPathIndex == 1 then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_4()
  if #IronDockWP4 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 6
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP4[IronPathIndex])
    if IronPathIndex == 3
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3 
      and PeaceMaker.Time > ExpireTime 
    then
      MoveDelay = PeaceMaker.Time + 1
      ExpireTime = PeaceMaker.Time + 10
    end
    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP4 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 7
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if IronPathIndex == 1 then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_5()
  if #IronDockWP5 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 8
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP5[IronPathIndex])
    
    if IronPathIndex == 14
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3 
      and PeaceMaker.Time > ExpireTime 
    then
      MoveDelay = PeaceMaker.Time + 18
      ExpireTime = PeaceMaker.Time + 25
    end

    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP5 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 9
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if IronPathIndex == 1 then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_6()
  if #IronDockWP6 > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 10
    and PeaceMaker.Time > MoveDelay
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronDockWP6[IronPathIndex])

    if IronPathIndex == 7
      and lb.GetDistance3D(px,py,pz,x,y,z) < 3  
      and PeaceMaker.Time > ExpireTime 
    then
      MoveDelay = PeaceMaker.Time + 1
      ExpireTime = PeaceMaker.Time + 10
    end

    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronDockWP6 then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 11
        PeaceMaker.Pause = PeaceMaker.Time + 1
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        if IronPathIndex == 1 then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 then
            lb.MoveTo(x,y,z)
            FaceDirection(x,y)
          end
        end
      end
    end
  end
end

local function IronDock_7()
  if #IronMoveOut > 0 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 13
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronMoveOut[IronPathIndex])
    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronPathIndex = IronPathIndex + 1
      if IronPathIndex > #IronMoveOut then
        IronPathIndex = 1
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 14
        PeaceMaker.Pause = PeaceMaker.Time + 2
      end
    else
      --debugmsg('Move Index: ' .. IronPathIndex)
      if not PeaceMaker.Player.Moving then
        PeaceMaker.Navigator.MoveTo(x,y,z)
      end
    end
  end
end

local function IronMove_In()
  if #IronMoveIn > 0
    and PeaceMaker.Time > MoveDelay 
  then
    local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
    local x,y,z = unpack(IronMoveIn[IronMoveInPathIndex])
    
    if PeaceMaker.Player.Class == 11 then
      if (CheckForm(4) == true or CheckForm(0) == true) then
        lb.Unlock(CastSpellByName, "Travel Form")
      end
    end

    if (PeaceMaker.Player.Class == 5 or PeaceMaker.Player.Class == 8) and PeaceMaker.Time > PreventMount then
      if not IsMounted() and not PeaceMaker.Player.Casting and not PeaceMaker.Player.Combat and PeaceMaker.Time > PeaceMaker.Pause then
        if PeaceMaker.Player.Moving then StopMoving() end
        if not PeaceMaker.Player.Moving then
          C_Timer.After(0.5, function()
            lb.Unlock(RunMacroText, "/cast Swift Purple Wind Rider")
          end)
          MoveDelay = PeaceMaker.Time + 5
          return true
        end
      end
    end

    if lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, x,y,z) < 2 then
      IronMoveInPathIndex = IronMoveInPathIndex + 1
      if IronMoveInPathIndex > #IronMoveIn then
        IronMoveInPathIndex = 1
        MoveDelay = PeaceMaker.Time + 20
        return true
      end
    else
      --debugmsg('Move Index: ' .. IronMoveInPathIndex)
      if not PeaceMaker.Player.Moving then
        if IronPathIndex == 1 then
          PeaceMaker.Navigator.MoveTo(x,y,z)
        else
          if IronPathIndex > 1 then
            FaceDirection(x,y)
            lb.MoveTo(x,y,z)
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
          if Unit.Distance > 3.5 and not PeaceMaker.Player.Moving then
            --debugmsg('Move to looting pos')
            --debugmsg(Unit.Name)
            --debugmsg(Unit.GUID)
            PeaceMaker.Navigator.MoveTo(Unit.PosX, Unit.PosY, Unit.PosZ)
            return true
          else
            if Unit.Distance <= 3.5 then
              if PeaceMaker.Player.Target then lb.Unlock(ClearTarget) end
              if PeaceMaker.Player.Moving then PeaceMaker.Navigator.Stop() end
              if not PeaceMaker.Player.Moving then
                --debugmsg('Looting')
                --debugmsg(Unit.Name)
                --debugmsg(Unit.GUID)
                C_Timer.After(0.5, function()
                  lbObjInteract(Unit.GUID)
                  C_Timer.After(1, function()
                    BlackListLoot(Unit.GUID)
                  end)
                end)
                LootingDelay = PeaceMaker.Time + 1.5
                return true
              end
            end
          end
        end
      end

    end
  end

end

local function CheckNearEntrance()
  local px, py, pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
  if px and py and pz then
    if lb.GetDistance3D(px, py, pz, 6746.760, -546.786, 4.925) < 2 then
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

local function VendorStep()
  local maxBagSlot = maxBagSlot()
  if IsMounted() then
    if Iron_Dock.MerchantOpen == false
      and PeaceMaker.Player.Faction == "Alliance" 
    then
      local Units = PeaceMaker.Units
      for _, Unit in pairs(Units) do
        if Unit.ObjectID == 32639 then
          lb.Unlock(lb.ObjectInteract, Unit.GUID) 
          return true
        end
      end
    end

    if Iron_Dock.MerchantOpen == false
      and PeaceMaker.Player.Faction == "Horde" 
    then
      local Units = PeaceMaker.Units
      for _, Unit in pairs(Units) do
        if Unit.ObjectID == 32641 then
          lb.Unlock(lb.ObjectInteract, Unit.GUID) 
          return true
        end
      end
    end

    if not InteractVendor
      and Iron_Dock.MerchantOpen == true 
    then
      InteractVendor = PeaceMaker.Time + 10
      return true
    end

    if Iron_Dock.MerchantOpen == true
      and InteractVendor
      and PeaceMaker.Time > InteractVendor 
      and (maxBagSlot - PeaceMaker.Player:GetFreeBagSlots()) <= 10
    then
      InteractVendor = false
      PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 2
      CloseMerchant()
      return true
    end
  else
    if not IsMounted() and not PeaceMaker.Player.Casting and PeaceMaker.Time > PeaceMaker.Pause then
      if PeaceMaker.Player.Moving then StopMoving() end
      if not PeaceMaker.Player.Moving then
        lb.Unlock(RunMacroText, "/cast Traveler's Tundra Mammoth")
        PeaceMaker.Pause = PeaceMaker.Time + 5
      end
    end
  end
end

local function VendorRoutine()
  if CheckMountVendor() == true then
    if PeaceMaker.Player:GetFreeBagSlots() <= 20 then
      PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 1.5
    else
      PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 2
    end
  else
    if CheckMountVendor() == false then
      if PeaceMaker.Player:GetFreeBagSlots() <= 20 then
        if GetItemCooldown(6948) == 0 then
          local Cast = UnitCastingInfo('player')
          if not Cast then
            lb.Unlock(UseItemByName, 'Hearthstone')
          end
          if Cast and Cast == "Hearthstone" then
            PeaceMaker.Pause = PeaceMaker.Time + 5
            PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 0
          end
        end
      else
        if PeaceMaker.Player:GetFreeBagSlots() > 20 then
          PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 2
        end
      end
    end
  end
end

local function VendorRoutineOutSide()
  if Iron_Dock.MerchantOpen == false then
    local Units = PeaceMaker.Units
    for _, Unit in pairs(Units) do
      if Unit.ObjectID == 85821 then
        lb.Unlock(lb.ObjectInteract, Unit.GUID) 
        return true
      end
    end
  end
  
  if not InteractVendor
    and Iron_Dock.MerchantOpen == true 
  then
    if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 12 then ResetInstances() end
    InteractVendor = PeaceMaker.Time +  10
    return true
  end

  if Iron_Dock.MerchantOpen == true
    and InteractVendor
    and PeaceMaker.Time > InteractVendor 
    and (maxBagSlot() - PeaceMaker.Player:GetFreeBagSlots()) <= 10
  then
    InteractVendor = false
    PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 1
    CloseMerchant()
    return true
  end
end

local DelayClick = 0
local function CombatMode()
  
  local EnemiesCount = #PeaceMaker.Enemies

  --debugmsg(tostring(EnemiesCount))

  if PeaceMaker.Time > DelayClick then
    lb.ClickPosition(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ)
    DelayClick = PeaceMaker.Time + 5
  end  
  
  if CombatTimer == 0 then CombatTimer = PeaceMaker.Time + 300 end

  if IsMounted() then Dismount() end
  
  if (PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 11 or PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 12)
    and lb.GetDistance3D(PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ, 6730.64453125,-969.83410644531,23.046611785889 ) > 2 
  then
    PeaceMaker.Navigator.MoveTo(6730.64453125,-969.83410644531,23.046611785889)
  end

  if PeaceMaker.Player.Class == 11 then
    if (PeaceMaker.Player.Target and PeaceMaker.Player.Target.Dead) 
      or (PeaceMaker.Player.Target and not PeaceMaker.Player.Target.Dead and PeaceMaker.Player.Target.Distance > 50) 
    then 
      lb.Unlock(ClearTarget) 
    end
  end

  if (PeaceMaker.Player.Class == 5 or PeaceMaker.Player.Class == 8) then
    if (PeaceMaker.Player.Target and PeaceMaker.Player.Target.Dead) 
      or (PeaceMaker.Player.Target and not PeaceMaker.Player.Target.Dead and PeaceMaker.Player.Target.Distance > 43) 
    then 
      lb.Unlock(ClearTarget) 
    end
  end

  if PeaceMaker.Player.Target and not PeaceMaker.Player.Target.Dead then FaceTarget(PeaceMaker.Player.Target.GUID) end

  if EnemiesCount ~= nil 
    and EnemiesCount <= 2
    and PeaceMaker.Player.Target
    and (PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 3 or PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 5)
  then
    PeaceMaker.Navigator.MoveTo(PeaceMaker.Player.Target.PosX, PeaceMaker.Player.Target.PosY, PeaceMaker.Player.Target.PosZ)
  end

  -- Druid
  if PeaceMaker.Player.Class == 11 then
    if CheckForm(4) == false then
      lb.Unlock(RunMacroText, '/cast Moonkin Form')
      PeaceMaker.Pause = PeaceMaker.Time + 2
      return true
    else
      if CheckForm(4) == true then
        if IsMounted() then Dismount() end
        if not IsMounted() then
          if PeaceMaker.Player.Target and not PeaceMaker.Player.Target.Dead then
            local EluneSpellCD = GetSpellCooldown(202770)
            if EluneSpellCD == 0 then
              lb.Unlock(CastSpellByID, 202770)
            end
          end
        end
        return true
      end
    end
  end

end

local function NextMode(Value)
  if IsMounted() then Dismount() end
  if not IsMounted() then
    if CheckCorpseAndLoot() == true then
      Looting()
    else  
      if CheckCorpseAndLoot() == false then
        if CombatTimer > 0 then CombatTimer = 0 end
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = Value
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

local function CheckMovementPhase()
  if (IsMounted() == true) or (not IsMounted() and PeaceMaker.Player.Combat) or CheckForm(3) == true then
    return true
  end
  return false
end

local DelayReset = 0
local function Step()

  if IronMoveInPathIndex > 1 then IronMoveInPathIndex = 1 end

  if CheckNearEntrance() == true 
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step ~= 0
    and PeaceMaker.Settings.profile.Dungeon.IronDock_Step < 12
    and PeaceMaker.Time > DelayReset 
  then
    ResetVariable()
    DelayReset = PeaceMaker.Time + 60
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 1 then
    VendorRoutine()
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 1.5 then
    VendorStep()
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 2 then
    if CheckMovementPhase() == true then
      IronDock_1()
    else
      MountPhase()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 3 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode(4)
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 4 then
    if CheckMovementPhase() == true then
      IronDock_2()
    else
      MountPhase()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 5 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode(8)
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 8 then
    if CheckMovementPhase() == true then
      IronDock_5()
    else
      MountPhase()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 9 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode(10)
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 10 then
    if CheckMovementPhase() == true then
      IronDock_6()
    else
      MountPhase()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 11 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat then
      NextMode(12)
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 12 then
    if PeaceMaker.Player.Combat then
      CombatMode()
    end
    if not PeaceMaker.Player.Combat and not PeaceMaker.Player.Dead then
      lb.Unlock(RunMacroText, "/click HelpFrameCharacterStuckStuck")
      PeaceMaker.Pause = PeaceMaker.Time + 5
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 13 then
    if CheckMovementPhase() == true then
      IronDock_7()
    else
      MountPhase()
    end
  end

  if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 14 then

    if PeaceMaker.Player.Class == 5 then
      if not PeaceMaker.Player.Moving then
        FaceDirection(6750.0717773438,-522.53594970703)
        lb.MoveTo(6750.0717773438,-522.53594970703,5.9928789138794)
        PeaceMaker.Pause = PeaceMaker.Time + 1
      end
    end

    if PeaceMaker.Player.Class == 8 then
      if IsMounted() then Dismount() end
      if CheckBuff("Invisibility") == false then
        lb.Unlock(CastSpellByName, "Invisibility")
        PeaceMaker.Pause = PeaceMaker.Time + 1
      else
        if CheckBuff("Invisibility") == true then
          if not PeaceMaker.Player.Moving then
            FaceDirection(6750.0717773438,-522.53594970703)
            lb.MoveTo(6750.0717773438,-522.53594970703,5.9928789138794)
            PreventMount = PeaceMaker.Time + 20
            PeaceMaker.Pause = PeaceMaker.Time + 1
          end
        end
      end
    end
   
    if PeaceMaker.Player.Class == 11 then
      if IsMounted() then Dismount() end
      if PeaceMaker.Player.Combat then
        CombatMode()
      end
      if not PeaceMaker.Player.Dead 
        and not IsMounted()
        and not PeaceMaker.Player.Combat 
      then
        if CheckBuff("Prowl") == false then
          lb.Unlock(CastSpellByName, "Prowl")
          PeaceMaker.Pause = PeaceMaker.Time + 1
        else
          if CheckBuff("Prowl") == true then
            if not PeaceMaker.Player.Moving then
              FaceDirection(6750.0717773438,-522.53594970703)
              lb.MoveTo(6750.0717773438,-522.53594970703,5.9928789138794)
              lb.Unlock(CastSpellByName, 'Dash')
              PeaceMaker.Pause = PeaceMaker.Time + 1
            end
          end
        end
      end
    end

  end

end

local MoveDelayAggro = 0
local function Core()
  local mapid = lb.GetMapId()
  if mapid == 1195 then
    if PeaceMaker.Player.Dead then
      RepopMe()
      if PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 12 then 
        PeaceMaker.Settings.profile.Dungeon.IronDock_Step = 13 
      end
      PeaceMaker.Pause = PeaceMaker.Time + 2
      CombatTimer = 0
      return true
    end
    if not PeaceMaker.Player.Dead then
      if PeaceMaker.Player.Level >= 110 and PeaceMaker.Player.Level < 115 then
        Step()
      end
      if PeaceMaker.Player.Level > 115 then
        if PeaceMaker.Time > MoveDelayAggro then
          Step()
          MoveDelayAggro = PeaceMaker.Time + 0.5
        end
      end
    end
  else
    if mapid == 1116 then
      local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
      if PeaceMaker.Settings.profile.Dungeon.IronDock_Step >= 14 then
        ResetDock()
      end
      if px and py and pz then
        if (PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 0 or PeaceMaker.Settings.profile.Dungeon.IronDock_Step == 12) then
          local px,py,pz = PeaceMaker.Player.PosX, PeaceMaker.Player.PosY, PeaceMaker.Player.PosZ
          local vx,vy,vz = 7610.052, 1792.317, 81.152
          if lb.GetDistance3D(px,py,pz,vx,vy,vz) > 2 then
            PeaceMaker.Navigator.MoveTo(vx,vy,vz)
          else
            VendorRoutineOutSide()
          end
        end
        if mapid ~= 1195 and (PeaceMaker.Settings.profile.Dungeon.IronDock_Step ~= 0 and PeaceMaker.Settings.profile.Dungeon.IronDock_Step ~= 12) then
          IronMove_In()
        end
      end
    end
  end
end

function Iron_Dock.Run(IsAllowed)
  if IsAllowed == 1 then
    if PeaceMaker.Time > PeaceMaker.Pause then
      Core()
    end
  end
end