local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Core.Reloaded = {}

local Reloaded = PeaceMaker.Helpers.Core.Reloaded

local function Core()
  if PeaceMaker.Settings.profile.General.UseAutoReload then
    if IntialReloadedTime == nil then
      IntialReloadedTime = PeaceMaker.Time + PeaceMaker.Settings.profile.General.ReloadedTime
      return
    end

    if IntialReloadedTime then
      if PeaceMaker.Time > IntialReloadedTime then
        lb.Unlock(RunMacroText, "/reload")
      end
    end
  end
end

function Reloaded:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    Core()
  end
end