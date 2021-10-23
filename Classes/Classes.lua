local PeaceMaker = PeaceMaker
PeaceMaker.Classes = {}

local Classes = PeaceMaker.Classes

local function Class()
  local cls = {}
  cls.__index = cls
  local callcls = {
    __call = function (self, ...)
      local instance = setmetatable({}, self)
      instance:New(...)
      return instance
    end
  }
  setmetatable(cls, callcls)
  return cls
end

Classes.Spell = Class()
Classes.Buff = Class()
Classes.Debuff = Class()
Classes.Unit = Class()
Classes.LocalPlayer = Class()
Classes.Item = Class()
Classes.GameObject = Class()