local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Rotation.Helper = {}
local Helper = PeaceMaker.Helpers.Rotation.Helper

function Helper:TargetExists()
  if UnitExists('target') then 
    return true
  end
  return false
end

function Helper:TargetDead()
  if UnitIsDeadOrGhost('target') then
    return true
  end
  return false
end
function Helper:TargetIsEnemy()
  if UnitCanAttack('player', 'target') then
    return true
  end
  return false
end

function Helper:TargetHealthPercent()
  return UnitHealth('target') / UnitHealthMax('target') * 100
end

function Helper:PlayerHealthPercent()
  return UnitHealth('player') / UnitHealthMax('player') * 100
end

function Helper:GetDistanceBetweenMobs()
  return lb.GetDistance3D('target')
end

function Helper:GetEnemySize(Unit)
  local boundingHeight = lb.UnitBoundingHeight(Unit)
  local collisionScale = lb.UnitCollisionScale(Unit)
  if not boundingHeight or not collisionScale then return 0 end
  return ((boundingHeight and collisionScale) and (boundingHeight * collisionScale)) / 2 or 25
end

function Helper:TargetLos()
  local px, py, pz = lb.ObjectPosition('player')
  local tx, ty, tz = lb.ObjectPosition('target')
  local playerSize = self:GetEnemySize('player')
  local enemySize = self:GetEnemySize('target')
  return lb.Raycast(px, py, pz + playerSize, tx, ty, tz + enemySize, lb.ERaycastFlags.LineOfSight) == nil
end

function Helper:CheckEnemyNearby(Distance)
  local Count = 0
  for i, guid in ipairs(__LB__.GetObjects(Distance)) do
    if lb.ObjectType(guid) == 5 and lb.UnitTarget(guid) == PeaceMaker.Player.GUID then
      Count = Count + 1
    end
  end
  return Count
end

function Helper:Cast(spell)
  local spellid = GetSpellInfo(spell)
  lb.Unlock(CastSpellByName, spellid)
end

function Helper:Castable(spell)
  local usable, noMana = IsUsableSpell(spell)
  if usable then
    if GetSpellCooldown(spell) == 0 then
      return true
    else
      return false
    end
  end
  return false
end

function Helper:CheckBuff(spellbuff, target)
  local buff, count, caster, expires, spellID
  local i = 0
  local go = true
  while i <= 40 and go do
    i = i + 1
    buff, _, count, _, duration, expires, caster, stealable, _, spellID = _G['UnitBuff'](target, i)
    if type(spellbuff) == "string" then if buff and buff == spellbuff then go = false return true end end
    if type(spellbuff) == "number" then if buff and buff == GetSpellInfo(spellbuff) then go = false return true end end
  end
  return false
end

function Helper:CheckDebuff(spellbuff, target)
  local debuff, count, caster, expires, spellID
  local i = 0
  local go = true
  while i <= 40 and go do
    i = i + 1
    debuff, _, count, _, duration, expires, caster, _, _, spellID = _G['UnitDebuff'](target, i)
    if type(spellbuff) == "string" then if debuff and debuff == spellbuff then go = false return true end end
    if type(spellbuff) == "number" then if debuff and debuff == GetSpellInfo(spellbuff) then go = false return true end end
  end
  return false
end

function Helper:AutoAttack()
  lb.Unlock(RunMacroText,"/startattack")
end