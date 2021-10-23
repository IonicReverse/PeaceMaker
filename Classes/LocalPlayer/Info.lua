local PeaceMaker = PeaceMaker
local PeaceMaker_LocalPlayer = PeaceMaker.Classes.LocalPlayer
local Spell = PeaceMaker.Classes.Spell
local Buff = PeaceMaker.Classes.Buff
local Debuff = PeaceMaker.Classes.Debuff

function PeaceMaker_LocalPlayer:GetSpells()
  self.Spells = {}
  self.Buffs = {}
  self.Debuffs = {}
  local CastType, Duration
  for Class, ClassTable in pairs(PeaceMaker.Enums.Spells) do
    if Class == "GLOBAL" or Class == self.Class then
      for Spec, SpecTable in pairs(ClassTable) do
        if Spec == "All" or Spec == self.Spec then
          for SpellType, SpellTable in pairs(SpecTable) do
            if SpellType == "Abilities" then
                for SpellName, SpellInfo in pairs(SpellTable) do
                    CastType = SpellInfo.CastType or "Normal"
                    self.Spells[SpellName] = Spell(SpellInfo.SpellID, CastType, SpellInfo.SpellType)
                end
            elseif SpellType == "Buffs" then
                for SpellName, SpellID in pairs(SpellTable) do
                    self.Buffs[SpellName] = Buff(SpellID)
                end
            elseif SpellType == "Debuffs" then
                for SpellName, SpellInfo in pairs(SpellTable) do
                    Duration = SpellInfo.BaseDuration or nil
                    self.Debuffs[SpellName] = Debuff(SpellInfo.SpellID, Duration)
                end
            end
          end
        end
      end
    end
  end
end

function PeaceMaker_LocalPlayer:UpdateProfessions()
  table.wipe(self.Professions)
  local prof1, prof2 = GetProfessions()
  if prof1 then
    local Name,_,Rank,MaxRank = GetProfessionInfo(prof1)
    if Name == "Mining" then
      self.Professions.Mining = Rank
      self.Professions.MiningMax = MaxRank
    elseif Name == "Herbalism" then
      self.Professions.Herbalism = Rank
      self.Professions.HerbalismMax = MaxRank
    elseif Name == "Skinning" then
      self.Professions.Skinning = Rank
      self.Professions.SkinningMax = MaxRank
    elseif Name == "Leatherworking" then
      self.Professions.Leatherworking = Rank
      self.Professions.Leatherworkingmax = MaxRank
    end
  end

  if prof2 then
    local Name,_,Rank,MaxRank = GetProfessionInfo(prof2)
    if Name == "Mining" then
      self.Professions.Mining = Rank
      self.Professions.MiningMax = MaxRank
    elseif Name == "Herbalism" then
      self.Professions.Herbalism = Rank
      self.Professions.HerbalismMax = MaxRank
    elseif Name == "Skinning" then
      self.Professions.Skinning = Rank
      self.Professions.SkinningMax = MaxRank
    elseif Name == "Leatherworking" then
      self.Professions.Leatherworking = Rank
      self.Professions.Leatherworkingmax = MaxRank
    end
  end
end

function PeaceMaker_LocalPlayer:GetTalents()
  local Selected
  local ActiveSpec = GetActiveSpecGroup()
  if self.Talents then
    table.wipe(self.Talents)
  else
    self.Talents = {}
  end
  for TalentName, TalentID in pairs(PeaceMaker.Enums.Spells[self.Class][self.Spec].Talents) do
    Selected = select(4, GetTalentInfoByID(TalentID, ActiveSpec))
    if Selected then
      self.Talents[TalentName] = {Active = true, Value = 1}
    else
      self.Talents[TalentName] = {Active = false, Value = 0}
    end
  end
end
