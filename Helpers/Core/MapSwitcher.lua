local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.MapSwitcher = {}

local MapSwitcher = PeaceMaker.Helpers.Core.MapSwitcher
local Misc = PeaceMaker.Helpers.Core.Misc

local MapInfo = {
  [1] = { Name = "Bastion", x = 123123, y = 1231231, z = 1231231 },
  [2] = { Name = "Maldraxxus", x = 12312, y = 1231, z = 123123 },
  [3] = { Name = "Ardenweald", x = 1231, y = 1231, z = 123123 },
  [4] = { Name = "Revendreth", x = 1231, y = 1231, z = 1231 },
  [5] = { Name = "The Maw", x = 1231, y = 123123, z = 1231 } 
}

function MapSwitcher:MoveToNpcAndTakeFP(x, y, z, mapname)
  if lb.GetDistance3D(x, y, z) > 3 then
    Navigation:MoveTo(x, y, z, 2)
  else
    if not FlightMapFrame or (FlightMapFrame and not FlightMapFrame:IsVisible()) then Misc:InteractUnit(npcid) PeaceMaker.Pause = PeaceMaker.Time + 2 end
    if FlightMapFrame and FlightMapFrame:IsVisible() then 
      for i = 1, NumTaxiNodes() do
        if TaxiNodeName(i) == mapname then
          TakeTaxiNode(i)
        end
      end
    end
  end
end

local function Core()
  
end

function MapSwitcher:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end