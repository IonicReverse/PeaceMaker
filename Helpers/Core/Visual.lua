
local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Visual = {}
local LibDraw = LibStub("LibDraw-1.0")
local Visual = PeaceMaker.Helpers.Core.Visual
local doingDraw = false

local function VisualCore()
  local VisualPulse = function() 
    if PeaceMaker.Settings.profile.General.EnableGroundVisual then
      if doingDraw then doingDraw = false end

      LibDraw.clearCanvas()
      LibDraw.SetWidth(4)
      LibDraw.SetColor(0, 248, 249, 249)

      if PeaceMaker.Mode ~= "Gather" and PeaceMaker.GrindHotSpot and #PeaceMaker.GrindHotSpot > 0 then
        for i = 1, #PeaceMaker.GrindHotSpot do
          if PeaceMaker.GrindHotSpot[i] then
            local x,y,z = PeaceMaker.GrindHotSpot[i].x, PeaceMaker.GrindHotSpot[i].y, PeaceMaker.GrindHotSpot[i].z
            LibDraw.Text(tostring(i), "GameFontNormalLarge", x, y, z + 5)
            LibDraw.Box(x,y,z,5,20)
          end
        end
      end

      if PeaceMaker.Mode == "Gather" and PeaceMaker.GatherHotSpot and #PeaceMaker.GatherHotSpot > 0 then
        for i = 1, #PeaceMaker.GatherHotSpot do
          if PeaceMaker.GatherHotSpot[i] then
            local x,y,z = PeaceMaker.GatherHotSpot[i].x, PeaceMaker.GatherHotSpot[i].y, PeaceMaker.GatherHotSpot[i].z
            LibDraw.Text(tostring(i), "GameFontNormalLarge", x, y, z + 5)
            LibDraw.Box(x,y,z,5,20)
          end
        end
      end
    else
      if not doingDraw then LibDraw.clearCanvas() doingDraw = true end
    end
  end
  C_Timer.NewTicker(0.1, VisualPulse)
  return
end

function Visual:Run()
  if not Visual.Engine then
    Visual.Engine = VisualCore()
  end
end