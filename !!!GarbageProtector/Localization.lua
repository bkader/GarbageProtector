local _, core = ...

local setmetatable, rawset, format = setmetatable, rawset, string.format
local L = setmetatable({}, {
	__newindex = function(self, key, value)
		rawset(self, key, value == true and key or value)
	end,
	__index = function(self, key)
		return key
	end
})
function L:F(line, ...)
	line = L[line]
	return format(line, ...)
end
core.L = L

local GAME_LOCALE = GetLocale()

-- default (enUS/enGB)
L["Eanbled"] = true
L["Disabled"] = true
L["Handling |cffffd700%s|r calls is now %s."] = true

L.EnabledTooltip = [[
This option effectively decides whether GarbageProtector's hooks do anything.
GarbageProtector hooks these functions on load either way.
If you want to completely disable the hooks, you'll have to disable GarbageProtector from the addons list and reload UI.
]]

L["Handle collectgarbage calls"] = true
L.CollecteGarbageTooltip = "Screw those irresponsible collectgarbage calls! Yeah!"

L.UpdateAddOnMemoryUsageTooltip = [[
UpdateAddOnMemoryUsage is a waste of CPU time and some addons call it periodically when they shouldn't.
This option effectively decides whether GarbageProtector's UpdateAddOnMemoryUsage hook should prevent execution.

Warning: All in-game memory usage reports obtained with GetAddOnMemoryUsage will be reported as 0 or the last returned value if this is enabled.
]]

L["Acceptable commands:"] = true
L["open the options interface"] = true
L["list CLI slash commands"] = true
L["toggle whether GP should handle any function calls"] = true
L["toggle whether GP should handle collectgarbage calls (prevents collectgarbage calls for slow full garbage collection cycles)"] = true
L["toggle whether GP should handle UpdateAddOnMemoryUsage calls (makes GetAddOnMemoryUsage always return 0 or the last returned value)"] = true

-- localizations:

if GAME_LOCALE == "deDE" then

elseif GAME_LOCALE == "esES" then

elseif GAME_LOCALE == "esMX" then

elseif GAME_LOCALE == "frFR" then

L["Eanbled"] = "Activé"
L["Disabled"] = "Désactivé"
L["Handling |cffffd700%s|r calls is now %s."] = "Gestion de la fonction |cffffd700%s|r est maintenant %s"

L.EnabledTooltip = [[
Cette option décide si GarbageProtector doit être activé ou pas.
GarbageProtector hook les fonctions après le chargement.
Si vous voulez empécher le hook, veuillez désactiver le addon et recharger votre interface.
]]

L["Handle |cffffd700%s|r calls"] = "Gérer la fonction |cffffd700%s|r"
L.CollecteGarbageTooltip = "Screw those irresponsible collectgarbage calls! Yeah!"
L.UpdateAddOnMemoryUsageTooltip = [[
UpdateAddOnMemoryUsage is a waste of CPU time and some addons call it periodically when they shouldn't.
This option effectively decides whether GarbageProtector's UpdateAddOnMemoryUsage hook should prevent execution.

Warning: All in-game memory usage reports obtained with GetAddOnMemoryUsage will be reported as 0 or the last returned value if this is enabled.
]]

L["Acceptable commands:"] = "Commandes acceptées:"
L["open the options interface"] = "ouvre l'interface options"
L["list CLI slash commands"] = "liste les commandes acceptées"
L["toggle whether GP should handle any function calls"] = "active ou désactive les fonctions de l'addon"
-- L["toggle whether GP should handle collectgarbage calls (prevents collectgarbage calls for slow full garbage collection cycles)"] = true
-- L["toggle whether GP should handle UpdateAddOnMemoryUsage calls (makes GetAddOnMemoryUsage always return 0 or the last returned value)"] = true

elseif GAME_LOCALE == "koKR" then

elseif GAME_LOCALE == "ruRU" then

elseif GAME_LOCALE == "zhCN" then

elseif GAME_LOCALE == "zhTW" then

end