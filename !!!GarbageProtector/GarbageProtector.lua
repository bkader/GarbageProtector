local folder, core = ...
local L = core.L
_G.GarbageProtector = core

--default values for options saved between sessions
local defaults = {Enabled = true, Handlecollectgarbage = true, HandleUpdateAddOnMemoryUsage = true}

local function Print(msg)
	if msg then
		print("|cff33ff99" .. folder .. "|r", msg)
	end
end
--function to initialize missing saved variables with default values
local function InitializeGarbageProtectorDB(tbl)
	GarbageProtectorDB = GarbageProtectorDB or {}
	for k, v in pairs(tbl or defaults) do
		if GarbageProtectorDB[k] == nil then
			GarbageProtectorDB[k] = v
		end
	end
end

--option setter functions
--setter functions exposed globally to allow other addons and scripts to easily override GarbageProtector if they really need to
--both parameters in each setter function are booleans
--force lets you guarantee target state (true == enabled) (false == disabled)
--shouldPrint decides whether the setter prints the setting's new state
local function ToggleGarbageProtector(force, shouldPrint)
	if GarbageProtectorDB == nil or GarbageProtectorDB.Enabled == nil then
		InitializeGarbageProtectorDB(defaults)
	end
	if force ~= nil then
		GarbageProtectorDB.Enabled = force
	else
		GarbageProtectorDB.Enabled = not GarbageProtectorDB.Enabled
	end
	if shouldPrint ~= nil and shouldPrint == true then
		Print(GarbageProtectorDB.Enabled and L.Enabled or L.Disabled)
	end
	if GarbageProtectorEnabledCheckButton == nil then
		return
	end
	GarbageProtectorEnabledCheckButton:SetChecked(GarbageProtectorDB.Enabled)
end

local function ToggleHandlecollectgarbage(force, shouldPrint)
	if GarbageProtectorDB == nil or GarbageProtectorDB.Handlecollectgarbage == nil then
		InitializeGarbageProtectorDB(defaults)
	end
	if force ~= nil then
		GarbageProtectorDB.Handlecollectgarbage = force
	else
		GarbageProtectorDB.Handlecollectgarbage = not GarbageProtectorDB.Handlecollectgarbage
	end
	if shouldPrint ~= nil and shouldPrint == true then
		Print(L:F("Handling |cffffd700%s|r calls is now %s.", "collectgarbage", GarbageProtectorDB.Handlecollectgarbage and L.Enabled or L.Disabled))
	end
	if GarbageProtectorHandlecollectgarbageCheckButton == nil then
		return
	end
	GarbageProtectorHandlecollectgarbageCheckButton:SetChecked(GarbageProtectorDB.Handlecollectgarbage)
end

local function ToggleHandleUpdateAddOnMemoryUsage(force, shouldPrint)
	if GarbageProtectorDB == nil or GarbageProtectorDB.HandleUpdateAddOnMemoryUsage == nil then
		InitializeGarbageProtectorDB(defaults)
	end
	if force ~= nil then
		GarbageProtectorDB.HandleUpdateAddOnMemoryUsage = force
	else
		GarbageProtectorDB.HandleUpdateAddOnMemoryUsage = not GarbageProtectorDB.HandleUpdateAddOnMemoryUsage
	end
	if shouldPrint ~= nil and shouldPrint == true then
		Print(L:F("Handling |cffffd700%s|r calls is now %s.", "UpdateAddOnMemoryUsage", GarbageProtectorDB.HandleUpdateAddOnMemoryUsage and L.Enabled or L.Disabled))
	end
	if GarbageProtectorHandleUpdateAddOnMemoryUsageCheckButton == nil then
		return
	end
	GarbageProtectorHandleUpdateAddOnMemoryUsageCheckButton:SetChecked(GarbageProtectorDB.HandleUpdateAddOnMemoryUsage)
end

--GUI options menu; manually crafted for funzies, mental laziness, naivety, full control, or something
local optionsMenu = CreateFrame("Frame", "GarbageProtectorOptionsMenu", InterfaceOptionsFramePanelContainer)

local enabledCheckButton =
	CreateFrame("CheckButton", "GarbageProtectorEnabledCheckButton", optionsMenu, "OptionsCheckButtonTemplate")
enabledCheckButton:SetPoint("TOPLEFT", 16, -16)
enabledCheckButton:SetHitRectInsets(0, -50, 0, 0)
enabledCheckButton:SetScript("OnClick", function() ToggleGarbageProtector(nil, false) end)
enabledCheckButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT")
	GameTooltip:AddLine(L.EnabledTooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)
enabledCheckButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
_G[enabledCheckButton:GetName() .. "Text"]:SetText(L.Eanbled)

local handlecollectgarbageCheckButton = CreateFrame("CheckButton", "GarbageProtectorHandlecollectgarbageCheckButton", optionsMenu, "OptionsCheckButtonTemplate")
handlecollectgarbageCheckButton:SetPoint("TOPLEFT", enabledCheckButton, "BOTTOMLEFT", 0, -8)
handlecollectgarbageCheckButton:SetScript("OnClick", function() ToggleHandlecollectgarbage(nil, false) end)
handlecollectgarbageCheckButton:SetHitRectInsets(0, -170, 0, 0)
handlecollectgarbageCheckButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT")
	GameTooltip:AddLine(L.CollecteGarbageTooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)
handlecollectgarbageCheckButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
_G[handlecollectgarbageCheckButton:GetName() .. "Text"]:SetText(L:F("Handle |cffffd700%s|r calls", "collectgarbage"))

local handleUpdateAddOnMemoryUsageCheckButton = CreateFrame("CheckButton", "GarbageProtectorHandleUpdateAddOnMemoryUsageCheckButton", optionsMenu, "OptionsCheckButtonTemplate")
handleUpdateAddOnMemoryUsageCheckButton:SetPoint("TOPLEFT", handlecollectgarbageCheckButton, "BOTTOMLEFT", 0, -8)
handleUpdateAddOnMemoryUsageCheckButton:SetScript("OnClick", function() ToggleHandleUpdateAddOnMemoryUsage(nil, false) end)
handleUpdateAddOnMemoryUsageCheckButton:SetHitRectInsets(0, -260, 0, 0)
handleUpdateAddOnMemoryUsageCheckButton:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT")
	GameTooltip:AddLine(L.UpdateAddOnMemoryUsageTooltip, 1, 1, 1, true)
	GameTooltip:Show()
end)
handleUpdateAddOnMemoryUsageCheckButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
_G[handleUpdateAddOnMemoryUsageCheckButton:GetName() .. "Text"]:SetText(L:F("Handle |cffffd700%s|r calls", "UpdateAddOnMemoryUsage"))

optionsMenu.name = "GarbageProtector"
InterfaceOptions_AddCategory(optionsMenu)

--handle PLAYER_ENTERING_WORLD events for initializing GUI options menu widget states at the right time
--UI reload doesn't seem to fire ADDON_LOADED
optionsMenu:RegisterEvent("PLAYER_ENTERING_WORLD")
optionsMenu:RegisterEvent("ADDON_LOADED")
optionsMenu:SetScript("OnEvent", function(self, event, arg1, ...)
	if event == "PLAYER_ENTERING_WORLD" or arg1 == "GarbageProtector" then
		InitializeGarbageProtectorDB(defaults)
		GarbageProtectorEnabledCheckButton:SetChecked(GarbageProtectorDB.Enabled)
		GarbageProtectorHandlecollectgarbageCheckButton:SetChecked(GarbageProtectorDB.Handlecollectgarbage)
		GarbageProtectorHandleUpdateAddOnMemoryUsageCheckButton:SetChecked(GarbageProtectorDB.HandleUpdateAddOnMemoryUsage)

		optionsMenu:UnregisterAllEvents()
		optionsMenu:SetScript("OnEvent", nil)
	end
end)

--CLI options menu
_G["SLASH_GarbageProtector1"] = "/garbageprotector"
_G["SLASH_GarbageProtector2"] = "/gp"
_G["SLASH_GarbageProtector3"] = "/garbage"
SlashCmdList["GarbageProtector"] = function(msg)
	local param1, param2, param3 = msg:match("([^%s,]*)[%s,]*([^%s,]*)[%s,]*([^%s,]*)[%s,]*")
	--print("Parameters passed were: "..tostring(param1).." "..tostring(param2).." "..tostring(param3))
	if param1 == "toggle" or param1 == "release" then
		ToggleGarbageProtector(nil, true)
	elseif param1 == "enable" or param1 == "on" or param1 == "start" then
		ToggleGarbageProtector(true, true)
	elseif param1 == "disable" or param1 == "off" or param1 == "stop" then
		ToggleGarbageProtector(false, true)
	elseif param1 == "collectgarbage" then
		if param2 == "enable" or param2 == "on" or param2 == "start" then
			ToggleHandlecollectgarbage(true, true)
		elseif (param2 == "disable" or param2 == "off" or param2 == "stop") then
			ToggleHandlecollectgarbage(false, true)
		else
			ToggleHandlecollectgarbage(nil, true)
		end
	elseif param1 == "UpdateAddOnMemoryUsage" then
		if param2 == "enable" or param2 == "on" or param2 == "start" then
			ToggleHandleUpdateAddOnMemoryUsage(true, true)
		elseif (param2 == "disable" or param2 == "off" or param2 == "stop") then
			ToggleHandleUpdateAddOnMemoryUsage(false, true)
		else
			ToggleHandleUpdateAddOnMemoryUsage(nil, true)
		end
	elseif (param1 == "") then
		InterfaceOptionsFrame_OpenToCategory(optionsMenu)
	else
		Print(L["Acceptable commands:"])
		print("|caaf49141/gp|r", L["open the options interface"])
		print("|caaf49141/gp|r help", L["list CLI slash commands"])
		print("|caaf49141/gp|r toggle/[enable/on/start]/[disable/off/stop]", L["toggle whether GP should handle any function calls"])
		print("|caaf49141/gp|r collectgarbage [enable/on/start]/[disable/off/stop]", L["toggle whether GP should handle collectgarbage calls (prevents collectgarbage calls for slow full garbage collection cycles)"])
		print("|caaf49141/gp|r UpdateAddOnMemoryUsage [enable/on/start]/[disable/off/stop]", L["toggle whether GP should handle UpdateAddOnMemoryUsage calls (makes GetAddOnMemoryUsage always return 0 or the last returned value)"])
	end
end

--main functionality; dirty collectgarbage hook; so beautiful!
local oldcollectgarbage = collectgarbage
oldcollectgarbage("setpause", 110)
oldcollectgarbage("setstepmul", 200)

_G.collectgarbage = function(opt, arg)
	if GarbageProtectorDB == nil or GarbageProtectorDB.Enabled == nil or GarbageProtectorDB.Handlecollectgarbage == nil then
		InitializeGarbageProtectorDB(defaults)
	end
	if GarbageProtectorDB.Handlecollectgarbage == false or GarbageProtectorDB.Enabled == false then
		return oldcollectgarbage(opt, arg)
	end

	if opt == nil or opt == "collect" or opt == "stop" or opt == "restart" or opt == "step" then
		--fuck addons that want to run full garbage collections, blocking all execution for way too long; no!
		--no brakes!
		--why?  no
		-- bad idea!
	elseif opt == "count" then
		--this probably just returns the GC's current count, so it should be okay
		return oldcollectgarbage(opt, arg)
	elseif opt == "setpause" then
		--prevents addons from changing GC pause from default of 110, but still returns current value
		return oldcollectgarbage("setpause", 110)
	elseif opt == "setstepmul" then
		--prevents addons from changing GC step multiplier from default of 200, but still returns current value
		return oldcollectgarbage("setstepmul", 200)
	else
		--if lua adds something new like isrunning to this, it should still work
		return oldcollectgarbage(opt, arg)
	end
end

--UpdateAddOnMemoryUsage is a waste of time and some addons like Details call it periodically for no apparent reason
--this hook makes memory profiling addons that call GetAddOnMemoryUsage show 0 or the last returned value of course
local oldUpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage
_G.UpdateAddOnMemoryUsage = function(...)
	if GarbageProtectorDB == nil or GarbageProtectorDB.Enabled == nil or GarbageProtectorDB.HandleUpdateAddOnMemoryUsage == nil then
		InitializeGarbageProtectorDB(defaults)
	end
	if GarbageProtectorDB.HandleUpdateAddOnMemoryUsage == false or GarbageProtectorDB.Enabled == false then
		return oldUpdateAddOnMemoryUsage(...)
	end
end