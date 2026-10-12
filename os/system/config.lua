-- OS CONFIG SCRIPT
-- This is a bit old!
args = {...}

selection = args[1]
configName = args[2]
setOption = args[3]

function printUsage()
	print("Usage:")
	print("config list")
	print("config get <config item>")
	print("config set <config item> <value to set>")
end

local configItems = {"authsys", "loginmode", "autoupdate", "userdata", "ui", "shell", "txtcolor", "highlgtcolor", "bckgrdcolor", "tempfolder", "logpath"}

local configCFGFILE = {["authsys"] = "authsys", ["loginmode"] = "loginMode", ["autoupdate"] = "automaticSystemUpdate", ["userdata"] = "userdata", ["logpath"] = "logpath", ["ui"] = "ui", ["shell"] = "shell", ["tempfolder"] = "tempfolder", ["txtcolor"] = "highlightColor", ["highlgtcolor"] = "terminalColor", ["bckgrdcolor"] = "backgroundColor"}

function validateItem(list, name)
	for i, v in ipairs(list) do
		if v == name then
			return true
		end
	end
	return
end

function generateConfigItemsString(list)
	local value = "Config: "
	for i, v in ipairs(list) do
		value = value .. v .. ", "
	end
	return value
end

function getConfigValue(configName)
	if configName == "authfun" or configName == "authsys" or configName == "loginmode" or configName == "autoupdate" or configName == "userdatapth" or configName == "ui" or configName == "shell" or configName == "tempfolder" then
		settings.clear()
		settings.load(_G.kernalConfig)
		return settings.get(configCFGFILE[configName])
	elseif configName == "highlgtcolor" or configName == "bckgrdcolor" or configName == "txtcolor" then
		settings.clear()
		settings.load(_G.colorConfig)
		return settings.get(configCFGFILE[configName])
	end
end

function setConfigValue(configName, setTo)
	if configName == "authfun" or configName == "authsys" or configName == "loginmode" or configName == "autoupdate" or configName == "userdatapth" or configName == "ui" or configName == "shell" or configName == "tempfolder" then
		settings.clear()
		settings.load(_G.kernalConfig)
		settings.set(configCFGFILE[configName], setTo)
		settings.save(_G.kernalConfig)
	elseif configName == "highlgtcolor" or configName == "bckgrdcolor" or configName == "txtcolor" then
		settings.clear()
		settings.load(_G.colorConfig)
		settings.set(configCFGFILE[configName], setTo)
		settings.save(_G.colorConfig)
	end
end




if selection == "list" then
	print(generateConfigItemsString(configItems))
elseif selection == "get" then
	if configName == null or configName == "" then
		printUsage()
		return
	end
	if validateItem(configItems, configName) ~= true then
		printError("Warning! '"..configName.."' was not found as a valid config, type config list to see all config options")
		return false
	end
	print(configName .. " value:")
	print(getConfigValue("authsys"))
elseif selection == "set" then
	if configName == null or configName == "" then
		printUsage()
		return
	end
	if setOption == null or setOption == "" then
		printUsage()
		return
	end

	setConfigValue(configName, setOption)
	print(configName .. " now set to " .. setOption)

	if validateItem(configItems, configName) ~= true then
		printError("Warning! '"..configName.."' was not found as a valid config, type config list to see all config options")
		return false
	end


else
	printUsage()
	return
end
