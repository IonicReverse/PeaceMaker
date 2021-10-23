local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Log = {}

local Log = PeaceMaker.Helpers.Core.Log

local lastdebugmsg = ''
local lastdebugtime = 0

function Log:Run(message)
  if PeaceMaker.Settings.profile.General.EnableLog then
    if (lastdebugmsg ~= message or lastdebugtime < PeaceMaker.Time) then
      lastdebugmsg = message
      lastdebugtime = PeaceMaker.Time + 10
      print(string.format("%s: %s", "|cff42a5f5[Debug]|r", message))
    end
  end
end