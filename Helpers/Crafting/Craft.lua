local PeaceMaker = PeaceMaker
PeaceMaker.Helpers.Crafting.Craft = {}

local Log = PeaceMaker.Helpers.Core.Log
local Craft = PeaceMaker.Helpers.Crafting.Craft

local DelayCraft = 0
local CraftState = {
  IsInit = false
}

function Craft:GetRecipeID(name)
  if TradeSkillFrame == nil then return false end
  if not TradeSkillFrame:IsVisible() then return false end
	for _, id in pairs(C_TradeSkillUI.GetAllRecipeIDs()) do
    local recipeInfo = C_TradeSkillUI.GetRecipeInfo(id)
    if name == recipeInfo.name then
      return recipeInfo.recipeID
    end
  end
  return false
end

function Craft:Core()
  local RecipeID = self:GetRecipeID(PeaceMaker.CraftRecipe)
  if not CraftState.IsInit then C_TradeSkillUI.OpenTradeSkill(165) CraftState.IsInit = true PeaceMaker.Pause = PeaceMaker.Time + 5 return end
  if not TradeSkillFrame:IsVisible() then
    C_TradeSkillUI.OpenTradeSkill(165)
    return
  else
    if not UnitCastingInfo('player') and PeaceMaker.Time > DelayCraft then
      if RecipeID then
        Log:Run("Craft ID : " .. tostring(RecipeID))
        lb.Unlock(C_TradeSkillUI.CraftRecipe, RecipeID, 200)
        DelayCraft = PeaceMaker.Time + 10
        return
      end
    end
  end
end

function Craft:Run()
  if PeaceMaker.Time > PeaceMaker.Pause then
    self:Core()
  end
end