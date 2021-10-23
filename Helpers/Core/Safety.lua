local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Safety = {}

local Safety = PeaceMaker.Helpers.Core.Safety
local Misc = PeaceMaker.Helpers.Core.Misc
local Index = 1

local function AvoidBlackListPlayerName(Unit)
  local List = PeaceMaker.Settings.profile.General.AFKPlayerBlackList
  if #List > 0 then
    for _, i in pairs(List) do
      if i == Unit then return true end
    end
  end
  return false
end

function Safety:CheckPlayerAround(Distance)
  local Units = PeaceMaker.Units
  if Distance == nil then Distance = 0 end
  for _, Unit in pairs(Units) do
    if Unit.Player
      and Unit.Distance <= Distance
      and not AvoidBlackListPlayerName(Unit.Name)
    then
      return true, Unit.Name
    end
  end
  return false
end

function Safety:Core(Distance)

  if self:CheckPlayerAround(Distance) then

    -- local x, y, z = PeaceMaker.GrindHotSpot[WPIndex].x, PeaceMaker.GrindHotSpot[WPIndex].y, PeaceMaker.GrindHotSpot[WPIndex].z
    -- local blacklistTimer = PeaceMaker.Settings.profile.General.BlackListHotSpotTimer
    -- if x and y and z then
    --   if not Misc:CheckBlackListHotSpot(x, y, z) then
    --     Misc:BlackListHotSpot(x, y, z, blacklistTimer)
    --   end
    -- end

    if PeaceMaker.GrindSafetySwitchProfile then
      WPIndex = 1
      local ProfileName = unpack(PeaceMaker.GrindSafetySwitchProfile[Index])
      lb.Unlock(RunMacroText, "/pc stop")
      lb.Unlock(RunMacroText, "/pc grindtag load " ..  ProfileName)
      C_Timer.After(0.5, function() lb.Unlock(RunMacroText, "/pc start taggrind") end)
    end

  end

end

function Safety:Run(Distance)
  if PeaceMaker.Time > PeaceMaker.Pause then
    self:Core(Distance)
  end
end