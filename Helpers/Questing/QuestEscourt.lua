local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Quest.QuestEscort = {}

local QuestEscort = PeaceMaker.Helpers.Quest.QuestEscort
local Navigation = PeaceMaker.Helpers.Core.Navigation
local Log = PeaceMaker.Helpers.Core.Log

function QuestEscort:SearchNpc(id)
  for _, Unit in pairs(PeaceMaker.Units) do
    if Unit.ObjectID == id then
      return Unit
    end
  end
  return false
end

function QuestEscort:Escort(npcid, distance)
  local gotNpc = self:SearchNpc(npcid)
  if gotNpc then
    local nx,ny,nz = lb.ObjectPosition(gotNpc.GUID)
    Log:Run("State : Quest Escort")
    if lb.GetDistance3D(nx, ny, nz) > distance then
      Navigation:MoveTo(nx, ny, nz, 3)
    end
    return
  end
end