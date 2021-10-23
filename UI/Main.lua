local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
local PeaceMaker = PeaceMaker
local UI = PeaceMaker.UI

local ModeList = {"Grind", "TagGrind", "Gather", "Craft", "Dungeon", "Quest"}
local DungeonList = {"BloodMaul", "IronDock"}

local ProfileName = "Profile Name"
local ProfileRadius = 100
local TempHotSpot = {}

local npcX, npcY, npcZ
local pX, pY, pZ
local DumpText
local MovX, MovY, MovZ

local Log = PeaceMaker.Helpers.Core.Log
local Misc = PeaceMaker.Helpers.Core.Misc
local MountList = PeaceMaker.Helpers.Core.Mount:ListOfMount()

local function table_to_string(tbl)
  local result = " "

  for k, v in pairs(tbl) do
    -- Check the key type (ignore any numerical keys - assume its an array)
    if type(k) == "string" then
      result = result .. k .."="
    end
    -- Check the value type
    if type(v) == "table" then
      result = result .. "\n" .. "   [" .. k .. "] = { " ..  table_to_string(v) .. " }"
    elseif type(v) == "boolean" then
      result = result..tostring(v)
    else
      result = result.."\""..v.."\""
    end
    result = result..","
  end

  -- Remove leading commas from the result
  if result ~= "" then
    result = result:sub(1, result:len()-1)
  end

  return result 
end

local function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function debugmsg(message)
  print(string.format("%s: %s", "|cff42a5f5[Debug]|r", message))
end

local options = {
  name = "PeaceMaker By Xetro",
  handler = PeaceMaker,
  type = "group",
  childGroups = "tab",
  args = {

    GeneralTab = {
      
      name = "General",
      type = "group",
      order = 1,
      args = {

        Mode = {
          type = "select",
          order = 1,
          name = "Mode",
          width= "full",
          values = function()
            return ModeList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(ModeList) do
              if i == PeaceMaker.Settings.profile.General.Mode then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.Mode = ModeList[value]
          end
        },

        Rotation = {
          type = "select",
          order = 2,
          name = "Rotation",
          width= "full",
          values = function()
            return PeaceMaker.RotationList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.RotationList) do
              if PeaceMaker.Settings.profile.General.LastRotation then
                if i == PeaceMaker.Settings.profile.General.LastRotation .. ".lua" then
                  return n
                end
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.LastRotation = string.gsub(PeaceMaker.RotationList[value], ".lua", "")
            PeaceMaker.Settings.profile.General.RotationName = string.gsub(PeaceMaker.RotationList[value], ".lua", "")
          end
        },

        AutoStart = {
          type = "toggle",
          order = 3,
          name = "Auto Start",
          width = "full",
          get = function()
            return PeaceMaker.Settings.profile.General.AutoStart
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.AutoStart = value
          end
        },

        AutoEquip = {
          type = "toggle",
          order = 4,
          name = "Auto Equip",
          width = "full",
          get = function()
            return PeaceMaker.Settings.profile.General.AutoEquip
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.AutoEquip = value
            if value == true then
              lb.Unlock(RunMacroText, "/ag start")
            else
              if value == false then
                lb.Unlock(RunMacroText, "/ag stop")
              end
            end
          end
        },

        Log = {
          type = "toggle",
          order = 5,
          name = "Enable Log",
          width = "full",
          get = function()
            return PeaceMaker.Settings.profile.General.EnableLog
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.EnableLog = value
          end
        },

        ClickToMove = {
          type = "toggle",
          order = 6,
          name = "Use Click To Move",
          width = "full",
          get = function()
            return PeaceMaker.Settings.profile.General.ClickToMove
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.ClickToMove = value
          end
        },

        Visual = {
          type = "toggle",
          order = 7,
          name = "Enable Visual",
          width = "full",
          get = function()
            return PeaceMaker.Settings.profile.General.EnableGroundVisual
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.EnableGroundVisual = value
          end
        },

        Pulse = {
          type = "range",
          order = 8,
          name = "Pulse Rate",
          width = "full",
          min = 0.0,
          max = 10.0,
          step = 0.1,
          get = function()
            return PeaceMaker.Settings.profile.General.Pulse
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.General.Pulse = value
          end
        },

        CheckAroundObject = {
          type = "execute",
          order = 9,
          name = "Check Nearby Object",
          width = "full",
          func = function()
            local objx = lb.GetObjects()
            local table = {}
            for _, i in ipairs(objx) do
              local px, py, pz = lb.ObjectPosition("player")
              local ox, oy, oz = lb.ObjectPosition(i)
              local objDistance = lb.GetDistance3D(px, py, pz, ox, oy, oz)
              local objName = lb.ObjectName(i)
              local objType = lb.ObjectType(i)
              local objFlags = lb.ObjectDynamicFlags(i)
              local npcFlags = lb.UnitHasFlag(i)
              local objID = lb.ObjectId(i)
              if objDistance <= 30 then
                debugmsg("Object Name : " .. objName .. "\n" .. "Object ID : "  .. objID .. "\n" .. "Dist : " .. tostring(objDistance))
                debugmsg("Object Type : " .. objType)
                debugmsg("Object Dynamic Flag : " .. objFlags)
                debugmsg("Npc Has Flag : " .. tostring(npcFlags))
                debugmsg("Object Pos : " .. "X : " .. round(ox, 3) .. " Y : " .. round(oy, 3) .. " Z : " .. round(oz,3))
                debugmsg("------------------------")
              end
            end
            
          end
        },
        
        Start = {
          type = "execute",
          order = -1,
          name = "START",
          width = "full",
          func = function()
            if PeaceMaker.IsRunning == true then
              PeaceMaker.IsRunning = false
              PeaceMaker.UIOptions.args.GeneralTab.args.Start.name = "START"
              if PeaceMaker.Navigator then PeaceMaker.Navigator.Stop() end
              PeaceMaker.UI.ConfigFrame:SetStatusText("Stop Bot")
            else
              if not PeaceMaker.IsRunning then

                if PeaceMaker.Settings.profile.General.Mode == "Grind" or PeaceMaker.Settings.profile.General.Mode == "TagGrind" then
                  PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
                  if PeaceMaker.Settings.profile.Grinding.LastProfile then
                    if PeaceMaker.Settings.profile.General.Mode == "Grind" then
                      lb.Unlock(RunMacroText, "/pc grind load " ..  PeaceMaker.Settings.profile.Grinding.LastProfile)
                    else
                      lb.Unlock(RunMacroText, "/pc grindtag load " ..  PeaceMaker.Settings.profile.Grinding.LastProfile)
                    end
                  end
                end

                if PeaceMaker.Settings.profile.General.Mode == "Gather" then
                  PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
                  if PeaceMaker.Settings.profile.Gathering.LastProfile then
                    lb.Unlock(RunMacroText, "/pc gather load " .. PeaceMaker.Settings.profile.Gathering.LastProfile)
                  end
                end

                if PeaceMaker.Settings.profile.General.Mode == "Craft" then
                  PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
                  if PeaceMaker.Settings.profile.Crafting.LastProfile then
                    lb.Unlock(RunMacroText, "/pc craft load " .. string.gsub(PeaceMaker.Settings.profile.Crafting.LastProfile, ".lua", ""))
                  end
                end

                if PeaceMaker.Settings.profile.General.Mode == "Quest" then
                  PeaceMaker.Mode = PeaceMaker.Settings.profile.General.Mode
                  if PeaceMaker.Settings.profile.Questing.LastProfile then
                    lb.Unlock(RunMacroText, "/pc quest load " .. string.gsub(PeaceMaker.Settings.profile.Questing.LastProfile, ".lua", ""))
                  end
                end

                PeaceMaker.UIOptions.args.GeneralTab.args.Start.name = "STOP"
                PeaceMaker.UI.ConfigFrame:SetStatusText("Start Bot")
                PeaceMaker.IsRunning = true

              end
            end
          end
        }
      }

    },

    GrindTab = {
      name = "Grind",
      type = "group",
      childGroups = "tab",
      order = 2,
      args = {

        ProfileList = {
          type = "select",
          order = 2,
          name = "Profile List",
          width= "full",
          values = function()
            return PeaceMaker.ProfileList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.ProfileList) do
              if i == PeaceMaker.Settings.profile.Grinding.LastProfile .. ".lua" then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Grinding.LastProfile = string.gsub(PeaceMaker.ProfileList[value], ".lua", "")
            lb.Unlock(RunMacroText, "/pc grind load " .. PeaceMaker.Settings.profile.Grinding.LastProfile)
          end
        },

        MountList = {
          type = "select",
          order = 3,
          name = "Mount List",
          width= "full",
          values = function()
            return MountList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(MountList) do
              if i == PeaceMaker.Settings.profile.Grinding.MountID then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Grinding.MountID = MountList[value]
          end
        },

        GeneralOption = {
          name = "General",
          type = "group",
          order = 4,
          args = {
            AutoLoot = {
              type = "toggle",
              order = 1,
              name = "Auto Loot",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.AutoLoot
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.AutoLoot = value
              end
            },

            AutoSkinning = {
              type = "toggle",
              order = 2,
              name = "Auto Skinning",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.AutoSkinning
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.AutoSkinning = value
              end
            },

            AutoGather = {
              type = "toggle",
              order = 3,
              name = "Auto Gather",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.AutoGather
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.AutoGather = value
              end
            },

            AutoMount = {
              type = "toggle",
              order = 4,
              name = "Auto Mount",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.UseMount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.UseMount = value
              end
            },

            AutoSummon = {
              type = "toggle",
              order = 5,
              name = "Auto Summon Pet",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.UsePet
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.UsePet = value
              end
            },

            UseRandomJump = {
              type = "toggle",
              order = 6,
              name = "Use Random Jump",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.UseRandomJump
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.UseRandomJump = value
              end
            },

            UseRandomTabTarget = {
              type = "toggle",
              order = 7,
              name = "Use Random TabTarget",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.UseRandomTabTarget
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.UseRandomTabTarget = value
              end
            }
          },
        },

        Grinding = {
          name = "Grinding",
          type = "group",
          order = 5,
          args = {
            
            AttackDistance = {
              type = "range",
              order = 1,
              name = "Attack Distance",
              width = "full",
              min = 0.0,
              max = 40.0,
              step = 0.1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.AttackDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.AttackDistance = value
              end
            },

            FoodPercent = {
              type = "range",
              order = 2,
              name = "Food Percent",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.FoodPercent
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.FoodPercent = value
              end
            },

            DrinkPercent = {
              type = "range",
              order = 3,
              name = "Drink Percent",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.DrinkPercent
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.DrinkPercent = value
              end
            },

            MountWhenEnemyDistance = {
              type = "range",
              order = 4,
              name = "Mount When Enemy Distance",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MountWhenEnemyDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MountWhenEnemyDistance = value
              end
            }
          }
        },

        Vendor = {
          name = "Vendor",
          type = "group",
          order = 6,
          args = {
            
            Durability = {
              type = "range",
              order = 1,
              name = "Durability",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.Durability
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.Durability = value
              end
            },

            BagSlot = {
              type = "range",
              order = 2,
              name = "BagSlot",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.BagSlot
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.BagSlot = value
              end
            },

            FoodID = {
              type = "input",
              order = 3,
              name = "Food ID",
              width = "full",
              get = function()
                return tostring(PeaceMaker.Settings.profile.Grinding.FoodID)
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.FoodID = tonumber(value)
              end
            },

            DrinkID = {
              type = "input",
              order = 4,
              name = "Drink ID",
              width = "full",
              get = function()
                return tostring(PeaceMaker.Settings.profile.Grinding.DrinkID)
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.DrinkID = tonumber(value)
              end
            },

            FoodAmount = {
              type = "range",
              order = 5,
              name = "Food Amount",
              width = "full",
              min = 0,
              max = 500,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.FoodAmount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.FoodAmount = value
              end
            },

            DrinkAmount = {
              type = "range",
              order = 6,
              name = "Drink Amount",
              width = "full",
              min = 0,
              max = 500,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.DrinkAmount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.DrinkAmount = value
              end
            }

          }
        },

        Mail = {
          name = "Mail",
          type = "group",
          order = 7,
          args = {

            MailGold = {
              type = "toggle",
              order = 1,
              name = "Mail Gold When Gold is Above 500",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MailToGold
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MailToGold = value
              end 
            },

            MailTitle = {
              type = "input",
              order = 2,
              name = "Mail To (Title Name)",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MailToTitle
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MailToTitle = value
              end 
            },

            MailTo = {
              type = "input",
              order = 3,
              name = "Mail To (Recipient Name)",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MailTo
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MailTo = value
              end 
            },

            MailItemList = {
              type = "input",
              order = 4,
              name = "Mail To Item List",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MailItemList
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MailItemList = value
              end 
            },

            MailPos = {
              type = "input",
              order = 5,
              name = "Mail Location",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Grinding.MailLoc
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.MailLoc = value
              end 
            }
          }
        },

        Safety = {
          name = "Safety",
          type = "group",
          order = 8,
          args = {
            PauseSwitchTimer = {
              type = "range",
              order = 10,
              name = "Pause Switch Hotspot",
              width = "full",
              min = 1,
              max = 999,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Grinding.SwitchSpotTimer
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Grinding.SwitchSpotTimer = value
              end 
            }
          }
        }

      }
    },

    TagGrindTab = {
      name = "TagGrind",
      type = "group",
      childGroups = "tab",
      order = 3,
      args = {

        ProfileList = {
          type = "select",
          order = 2,
          name = "Profile List",
          width= "full",
          values = function()
            return PeaceMaker.ProfileTagGrindList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.ProfileTagGrindList) do
              if i == PeaceMaker.Settings.profile.Grinding.LastProfile .. ".lua" then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Grinding.LastProfile = string.gsub(PeaceMaker.ProfileTagGrindList[value], ".lua", "")
            lb.Unlock(RunMacroText, "/pc grind load " .. PeaceMaker.Settings.profile.Grinding.LastProfile)
          end
        },

        MountList = {
          type = "select",
          order = 3,
          name = "Mount List",
          width= "full",
          values = function()
            return MountList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(MountList) do
              if i == PeaceMaker.Settings.profile.TagGrinding.MountID then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.TagGrinding.MountID = MountList[value]
          end
        },

        GeneralOption = {
          name = "General",
          type = "group",
          order = 4,
          args = {

            AutoLoot = {
              type = "toggle",
              order = 1,
              name = "Auto Loot",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.AutoLoot
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.AutoLoot = value
              end
            },

            AutoSkinning = {
              type = "toggle",
              order = 2,
              name = "Auto Skinning",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.AutoSkinning
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.AutoSkinning = value
              end
            },

            AutoGather = {
              type = "toggle",
              order = 3,
              name = "Auto Gather",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.AutoGather
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.AutoGather = value
              end
            },

            AutoMount = {
              type = "toggle",
              order = 4,
              name = "Auto Mount",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.UseMount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.UseMount = value
              end
            },

            AutoSummon = {
              type = "toggle",
              order = 5,
              name = "Auto Summon Pet",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.UsePet
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.UsePet = value
              end
            },

            OverPull = {
              type = "toggle",
              order = 6,
              name = "Keep Pull When In Combat and Enemy Around XX Yards",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.OverPull
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.OverPull = value
              end
            },

            UseRestSpell = {
              type = "toggle",
              order = 7,
              name = "Use Rest Spell Like Paladin, Monk And Etc",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.UseRestSpell
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.UseRestSpell = value
              end
            },

            UseSafetyFeature = {
              type = "toggle",
              order = 8,
              name = "Use Safety Feature",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.General.UseSafetyFeature
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.General.UseSafetyFeature = value
              end
            },
            
            UseRandomJump = {
              type = "toggle",
              order = 9,
              name = "Use Random Jump",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.UseRandomJump
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.UseRandomJump = value
              end
            },

            UseRandomTabTarget = {
              type = "toggle",
              order = 10,
              name = "Use Random TabTarget",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.UseRandomTabTarget
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.UseRandomTabTarget = value
              end
            }
          },
        },

        Grinding = {
          name = "Grinding",
          type = "group",
          order = 5,
          args = {
            
            AttackDistance = {
              type = "range",
              order = 1,
              name = "Attack Distance",
              width = "full",
              min = 0.0,
              max = 40.0,
              step = 0.1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.AttackDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.AttackDistance = value
              end
            },

            PullDistanceLimit = {
              type = "range",
              order = 2,
              name = "Pull Distance Limit",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.PullDistanceLimit
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.PullDistanceLimit = value
              end
            },

            StopOverPullWhen = {
              type = "range",
              order = 3,
              name = "Stop Over Pull When HP Below",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.StopOverPullWhen
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.StopOverPullWhen = value
              end
            },

            OverPullDistance = {
              type = "range",
              order = 4,
              name = "Over Pull Distance",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.OverPullDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.OverPullDistance = value
              end
            },

            CombatTargetDistance = {
              type = "range",
              order = 5,
              name = "Combat Target Distance",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.CombatTargetDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.CombatTargetDistance = value
              end
            },

            FoodPercent = {
              type = "range",
              order = 6,
              name = "Food Percent",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.FoodPercent
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.FoodPercent = value
              end
            },

            DrinkPercent = {
              type = "range",
              order = 7,
              name = "Drink Percent",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.DrinkPercent
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.DrinkPercent = value
              end
            },

            SpellRestPercent = {
              type = "range",
              order = 8,
              name = "Spell Rest Percent",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.RestSpellHP
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.RestSpellHP = value
              end
            },

            MountWhenEnemyDistance = {
              type = "range",
              order = 9,
              name = "Mount When Enemy Distance",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MountWhenEnemyDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MountWhenEnemyDistance = value
              end
            },

            LootRange = {
              type = "range",
              order = 10,
              name = "Loot Range",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.LootRange
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.LootRange = value
              end
            },

            SkinRange = {
              type = "range",
              order = 11,
              name = "Skin Range",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.SkinRange
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.SkinRange = value
              end
            },
          }
        },

        Vendor = {
          name = "Vendor",
          type = "group",
          order = 6,
          args = {
            
            Durability = {
              type = "range",
              order = 1,
              name = "Durability",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.Durability
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.Durability = value
              end
            },

            BagSlot = {
              type = "range",
              order = 2,
              name = "BagSlot",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.BagSlot
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.BagSlot = value
              end
            },

            FoodID = {
              type = "input",
              order = 3,
              name = "Food ID",
              width = "full",
              get = function()
                return tostring(PeaceMaker.Settings.profile.TagGrinding.FoodID)
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.FoodID = tonumber(value)
              end
            },

            DrinkID = {
              type = "input",
              order = 4,
              name = "Drink ID",
              width = "full",
              get = function()
                return tostring(PeaceMaker.Settings.profile.TagGrinding.DrinkID)
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.DrinkID = tonumber(value)
              end
            },

            FoodAmount = {
              type = "range",
              order = 5,
              name = "Food Amount",
              width = "full",
              min = 0,
              max = 500,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.FoodAmount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.FoodAmount = value
              end
            },

            DrinkAmount = {
              type = "range",
              order = 6,
              name = "Drink Amount",
              width = "full",
              min = 0,
              max = 500,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.DrinkAmount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.DrinkAmount = value
              end
            }

          }
        },

        Mail = {
          name = "Mail",
          type = "group",
          order = 7,
          args = {

            MailGold = {
              type = "toggle",
              order = 1,
              name = "Mail Gold When Gold is Above 500",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MailToGold
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MailToGold = value
              end 
            },

            MailTitle = {
              type = "input",
              order = 2,
              name = "Mail To (Title Name)",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MailToTitle
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MailToTitle = value
              end 
            },

            MailTo = {
              type = "input",
              order = 3,
              name = "Mail To (Recipient Name)",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MailTo
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MailTo = value
              end 
            },

            MailItemList = {
              type = "input",
              order = 4,
              name = "Mail To Item List",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MailItemList
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MailItemList = value
              end 
            },

            MailPos = {
              type = "input",
              order = 5,
              name = "Mail Location",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.MailLoc
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.MailLoc = value
              end 
            }
          }
        },

        Safety = {
          name = "Safety",
          type = "group",
          order = 8,
          args = {
            PauseSwitchTimer = {
              type = "range",
              order = 10,
              name = "Pause Switch Hotspot",
              width = "full",
              min = 1,
              max = 999,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.TagGrinding.SwitchSpotTimer
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.TagGrinding.SwitchSpotTimer = value
              end 
            }
          }
        }

      }
    },

    GatherTab = {

      name = "Gather",
      type = "group",
      order = 4,
      childGroups = "tab",
      args = {

        GatheringProfileList = {
          type = "select",
          order = 1,
          name = "Profile List",
          width= "full",
          values = function()
            return PeaceMaker.ProfileGatherList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.ProfileGatherList) do
              if i == PeaceMaker.Settings.profile.Gathering.LastProfile .. ".lua" then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Gathering.LastProfile = string.gsub(PeaceMaker.ProfileGatherList[value], ".lua", "")
            lb.Unlock(RunMacroText, "/pc gather load " .. PeaceMaker.Settings.profile.Gathering.LastProfile)
          end
        },

        MountList = {
          type = "select",
          order = 2,
          name = "Mount List",
          width= "full",
          values = function()
            return MountList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(MountList) do
              if i == PeaceMaker.Settings.profile.Gathering.MountID then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Gathering.MountID = MountList[value]
          end
        },

        
        General = {

          name = "General",
          type = "group",
          order = 3,
          args = {

            SkipCombat = {
              type = "toggle",
              order = 1, 
              name = "Skip Combat",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.SkipCombat
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.SkipCombat = value
              end
            },

            LootItem = {
              type = "toggle",
              order = 2,
              name = "Auto Loot",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.AutoLoot
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.AutoLoot = value
              end
            },

            UseHerb = {
              type = "toggle",
              order = 3,
              wdith = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.UseHerbing
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.UseHerbing = value
              end
            },

            UseMine = {
              type = "toggle",
              order = 4,
              wdith = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.UseMining
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.UseMining = value
              end
            },
            
            UseMount = {
              type = "toggle",
              order = 5,
              name = "Use Mount",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.UseMount
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.UseMount = value
              end
            },

            UseRandomJump = {
              type = "toggle",
              order = 6,
              name = "Use Random Jump",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.UseRandomJump
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.UseRandomJump = value
              end
            },

            UseRandomTabTarget = {
              type = "toggle",
              order = 7,
              name = "Use Random TabTarget",
              width = "full",
              get = function()
                return PeaceMaker.Settings.profile.Gathering.UseRandomTabTarget
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.UseRandomTabTarget = value
              end
            }
            
          }
        },

        Gather = {

          name = "Gathering",
          type = "group",
          order = 4,
          args = {

            AttackDistance = {
              type = "range",
              order = 1,
              name = "Attack Distance",
              width = "full",
              min = 0.0,
              max = 40.0,
              step = 0.1,
              get = function()
                return PeaceMaker.Settings.profile.Gathering.AttackDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.AttackDistance = value
              end
            },

            CombatTargetDistance = {
              type = "range",
              order = 2,
              name = "Target Range",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Gathering.CombatTargetDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.CombatTargetDistance = value
              end
            },

            LootRange = {
              type = "range",
              order = 3,
              name = "Loot Range",
              width = "full",
              min = 0.0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Gathering.LootRange
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Gathering.LootRange = value
              end
            }
            
          }
        }
      }

    },

    QuestTab = {
      name = "Quest",
      type = "group",
      order = 5,
      childGroups = "tab",
      args = {
        ProfileList = {
          name = "Profile List",
          type = "select",
          order = 1,
          width= "full",
          values = function()
            return PeaceMaker.ProfileQuestList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.ProfileQuestList) do
              if i == PeaceMaker.Settings.profile.Questing.LastProfile .. ".lua" then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Questing.LastProfile = string.gsub(PeaceMaker.ProfileQuestList[value], ".lua", "")
          end
        },

        Questing = {
          name = "Questing",
          type = "group",
          order = 2,
          args = {

            AttackDistance = {
              type = "range",
              order = 1,
              name = "Attack Distance",
              width = "full",
              min = 0.0,
              max = 40.0,
              step = 0.1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.AttackDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.AttackDistance = value
              end
            },

            CombatTargetDistance = {
              type = "range",
              order = 2,
              name = "Target Distance",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.CombatTargetDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.CombatTargetDistance = value
              end
            },

            MountWhenEnemyDistance = {
              type = "range",
              order = 3,
              name = "Mount When Enemy Distance Above",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.MountWhenEnemyDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.MountWhenEnemyDistance = value
              end
            },

            LootRange = {
              type = "range",
              order = 4,
              name = "Loot Range",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.LootRange
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.LootRange = value
              end
            }
          }
        },

        Safety = {
          name = "Safety",
          type = "group",
          order = 3,
          args = {
            AFKDistance = {
              type = "range",
              order = 1,
              name = "AFK Distance",
              width = "full",
              min = 0,
              max = 100,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.AFKDistance
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.AFKDistance = value
              end
            },

            AFKTimer = {
              type = "range",
              order = 2,
              name = "AFK Timer In MilliSecond",
              width = "full",
              min = 0,
              max = 999,
              step = 1,
              get = function()
                return PeaceMaker.Settings.profile.Questing.AFKTimer
              end,
              set = function(info, value)
                PeaceMaker.Settings.profile.Questing.AFKTimer = value
              end
            }
          }
        },

        Misc = {
          name = "Misc",
          type = "group",
          order = 4,
          args = {
            
            GetNpcCoordinate = {
              type = "execute",
              order = 1,
              name = "Get Npc Coordinate",
              width = "full",
              func = function()
                npcX, npcY, npcZ = lb.ObjectPosition('target')
              end
            },

            NpcCoordinateOnput = {
              type = "input",
              order = 2,
              name = "Npc XYZ",
              width = "full",
              get = function()
                if npcX and npcY and npcZ then
                  return tostring(round(npcX, 2)) .. ", " .. tostring(round(npcY, 2)) .. ", " .. tostring(round(npcZ, 2))
                end
              end,
              set = function(info, value)
                
              end 
            },

            GetPlayerCoordinate = {
              type = "execute",
              order = 3,
              name = "Get Player Coordinate",
              width = "full",
              func = function()
                pX, pY, pZ = lb.ObjectPosition('player')
              end
            },
    
            PlayerCoordinateOutput = {
              type = "input",
              order = 4,
              name = "Player XYZ",
              width = "full",
              get = function()
                if pX and pY and pZ then
                  return tostring(round(pX, 2)) .. ", " .. tostring(round(pY, 2)) .. ", " .. tostring(round(pZ, 2))
                end
              end,
              set = function(info, value)
                
              end 
            },

            DumpCode = {
              type = "execute",
              order = 5,
              name = "Dump Code",
              width = "full",
              func = function()
                lb.Unlock(RunMacroText, "/dump " .. DumpText)
              end
            },

            DumpCodeInput = {
              type = "input",
              order = 6,
              name = "Dump Input",
              width = "full",
              get = function()
                return DumpText
              end,
              set = function(info, value)
                DumpText = value                
              end 
            },

            MoveTo = {
              type = "execute",
              order = 7,
              name = "Move To",
              width = "full",
              func = function()
                if PeaceMaker.Navigator then
                  PeaceMaker.Helpers.Core.Navigation:MoveTo(MovX, MovY, MovZ)
                end
              end
            },

            MoveToCoordinate = {
              type = "input",
              order = 8,
              name = "Coordinate MoveTo",
              width = "full",
              get = function()
                if MovX and MovY and MovZ then
                  return tostring(round(MovX, 2)) .. ", " .. tostring(round(MovY, 2)) .. ", " .. tostring(round(MovZ, 2))
                end
              end,
              set = function(info, value)
                MovX, MovY, MovZ = Misc:SplitStrComma(value)     
              end 
            },

            GenerateHotspotOutput = {
              type = "input",
              order = 9,
              name = "Hotspot Output Based On Player Pos",
              width = "full",
              get = function()
                if pX and pY and pZ then
                  return "local hotspot = { [1] = { x = " .. tostring(round(pX, 2)) .. ", y = " .. tostring(round(pY, 2)) .. ", z = " .. tostring(round(pZ, 2)) .. ", radius = " .. "100" .. "} }"
                end
              end,
              set = function(info, value)
                          
              end 
            }

          }
        }
      },
    },

    DungeonTab = {
      name = "Dungeon",
      type = "group",
      order = 5,
      childGroups = "tab",
      args = {
        
        ProfileList = {
          name = "Profile List",
          type = "select",
          order = 1,
          width= "full",
          values = function()
            return DungeonList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(DungeonList) do
              if i == PeaceMaker.Settings.profile.Dungeon.LastProfile then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Dungeon.LastProfile = DungeonList[value]
            PeaceMaker.DungeonName = PeaceMaker.Settings.profile.Dungeon.LastProfile
          end
        }

      }
    },

    Craft = {
      name = "Craft",
      type = "group",
      order = 6,
      childGroups = "tab",
      args = {
        
        ProfileList = {
          name = "Profile List",
          type = "select",
          order = 1,
          width= "full",
          values = function()
            return PeaceMaker.ProfileCraftList
          end,
          style = "dropdown",
          get = function()
            for n, i in pairs(PeaceMaker.ProfileCraftList) do
              if i == PeaceMaker.Settings.profile.Crafting.LastProfile .. ".lua" then
                return n
              end
            end
          end,
          set = function(info, value)
            PeaceMaker.Settings.profile.Crafting.LastProfile = string.gsub(PeaceMaker.ProfileCraftList[value], ".lua", "")
            lb.Unlock(RunMacroText, "/pc craft load " .. PeaceMaker.Settings.profile.Crafting.LastProfile)
          end
        }

      }
    },

    Misc = {
      name = "Misc",
      type = "group",
      order = 7,
      childGroups = "tab",
      args = {

        ProfileName = {
          type = "input",
          order = 1,
          name = "Profile Name",
          width = "full",
          get = function()
            return ProfileName
          end,
          set = function(info, value)
            ProfileName = value
          end 
        },

        HotSpotRadius = {
          type = "input",
          order = 2,
          name = "Radius",
          width = "full",
          get = function()
            return tostring(ProfileRadius)
          end,
          set = function(info, value)
            ProfileRadius = value
          end 
        },
        
        AddHotSpot = {
          type = "execute",
          order = 3,
          name = "Add HotSpot",
          width = "full",
          func = function()
            local HX, HY, HZ = lb.ObjectPosition('player')
            local radius = tonumber(ProfileRadius)
            table.insert(TempHotSpot, {
              x = round(HX, 3), y = round(HY, 3), z = round(HZ, 3), radius = radius
            })
            debugmsg("HotSpot " .. tostring(HotSpotPathIndex) .. " : X : " .. tostring(round(HX, 3)) .. ", Y : " .. tostring(round(HY, 3)) .. ", Z: " .. tostring(round(HZ, 3)) .. ", Radius : " .. radius)
            HotSpotPathIndex = HotSpotPathIndex + 1
          end
        },

        SaveHotSpot = {
          type = "execute",
          order = 4,
          name = "Save Profile",
          width = "full",
          func = function()
            local ProfileDirectPath = lb.GetGameDirectory() .. "\\Interface\\AddOns\\PeaceMaker\\Profile\\GenerateProfile\\" .. ProfileName .. ".lua"
            local TableString = string.gsub(table_to_string(TempHotSpot), '"', '')
            lb.WriteFile(ProfileDirectPath, "HotSpot = { "  .. TableString .. "\n" .. " } ")
            debugmsg(ProfileName .. " Profile Saved")
          end
        },

        ResetHotSpot = {
          type = "execute",
          order = 5,
          name = "Reset Hotspot",
          width = "full",
          func = function()
            TempHotSpot = {}
            HotSpotPathIndex = 1
            debugmsg(ProfileName .. " Reset HotSpot")
          end
        },

        UseKeyToGetPos = {
          type = "execute",
          order = 6,
          name = "Use Key To Get Position -- Key Is CTRL + R",
          width = "full",
          func = function()
            if PeaceMaker.UseKeyGetPosition == false then
              PeaceMaker.UseKeyGetPosition = true
            else
              PeaceMaker.UseKeyGetPosition = false
            end
          end
        }

      }
    }

  }
}

function UI.Show()
  if not UI.ConfigFrame then
    UI.ConfigFrame = AceGUI:Create("Frame")
    UI.ConfigFrame:Hide()
  end
  if not UI.ConfigFrame:Show() then
    LibStub("AceConfigDialog-3.0"):Open("PeaceMaker", UI.ConfigFrame)
  else
    UI.ConfigFrame:Hide()
  end
end

function PeaceMaker.UI.Init()
  PeaceMaker.UIOptions = options
  LibStub("AceConfig-3.0"):RegisterOptionsTable("PeaceMaker", options)
  LibStub("AceConfigDialog-3.0"):SetDefaultSize("PeaceMaker", 420, 550)
end

