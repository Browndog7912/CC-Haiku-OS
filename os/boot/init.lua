-- Initlise OS
local main = require("/system/main")


local args = { ... }
--[[if _G.initloaded == true then
	return -- Checks if os has not fully loaded and will not load if it is aredy loaded
end
]]
_G.initloaded = true

local productName = "Hakiu OS"
local version = "0"

-- Clear the Screen
function clearScreen() 
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
end

function printStatus(type)
	local cursorx, cursory = term.getCursorPos()
	local termx, termy = term.getSize()
	if (type == "load") then
		term.setCursorPos(termx-5, cursory - 1)
    	if term.isColor() then
        	term.setTextColor(colors.green)
    	end
    	print("[ OK ]")
	elseif (type == "fail") then
		term.setCursorPos(termx-5, cursory - 1)
		if term.isColor() then
        	term.setTextColor(colors.red)
    	end
    	print("[FAIL]")
	end
	term.setTextColor(colors.white)
end

function crashOS(error) 
	term.setBackgroundColor(colors.blue)
	term.clear()
	term.setCursorPos(1,1)
	print("Kernel panic - Critical error")
	print("Please restart your computer")
	print(error)
	while true do 
		sleep(1) -- Loop forever so it
	end
	os.shutdown()
end

clearScreen()
os.loadAPI("/apis/osapi.lua")


main.initApis()

term.setCursorPos(10,10)

shell.run("/boot/stage.2.lua")

--sleep(5)

--[[local function do_sleep() sleep(0) end
parallel.waitForAny(do_sleep, main.run)]]


term.setTextColor(colors.white)
print("Loading kernel functions")

-- Load Kernal Functions
local kernel = false
if fs.exists("/apis/osapi.lua") then -- Check if APT Api is valid and load it
    os.loadAPI("/apis/osapi.lua")
	print("")
	-- load os api
end
if fs.exists("/apis/apt.lua") then -- Check if APT Api is valid and load it
    os.loadAPI("/apis/apt.lua")
	-- load apt api
end
if fs.exists("/apis/menu.lua") then -- Check if menu api is valid and load it
    os.loadAPI("/apis/menu.lua")
end

if fs.exists("/apis/basalt.lua") then -- Check if basalt api is valid
    local basalt = true
end

if osapi and apt and menu then -- check if apis exsit
	printStatus("load")
    kernel = true
else
    printStatus("fail")
	sleep(1)
end

if term.isColor() then
    term.setTextColor(colors.white)
end

if kernel == false then
	sleep(1)
	crashOS("Kernal functions failed to load!")
	-- Crash os if Kenrnal functions failed to load!
end

-- Init Memory Varabkes
_G.expect = "/delete.me" -- turn expect into easy to call function
cursorhor, cursorver = term.getCursorPos()

if pocket or turtle then print("Loading Data:")
else print("Loading Configuration Data") end

-- Load the configoration
local cfr = osapi.loadconfig() -- Load config

-- Check if settings was able to load
if cfr == true then
	printStatus("load")
else
	printStatus("fail")
end

-- Run aleternative boot file
if fs.exists("/boot/stage.2.lua") then
	shell.run("/boot/stage.2.lua") 
end


-- Run aleternative boot file
if fs.exists("/boot/stage.3.lua") then
	shell.run("/boot/stage.3.lua") 
end



cursorhor, cursorver = term.getCursorPos()

printStatus("load")
-- if a service requires starting a new tab
if fs.exists("/boot/service.lua") then
	shell.run("/boot/service.lua")
end
-- override if required to start before login
if fs.exists("/boot/override.lua") then
	shell.run("/boot/override.lua")
end

if fs.exists("/boot/loginoveride.lua") then
	shell.run("/boot/loginoveride.lua")
	return
end

if args[1] == "--nologin" then shell.run("shell") else end

shell.run(_G.authsys)
--login function, restart if failed to reconnect if needed 
--[[
if _G.loginMode == true then
	shell.run(_G.authsys)
    if _G.oslogin == nil then
    os.sleep(2)
    osapi.restart() end
else
    _G.oslogin = "root"
    _G.ospass = "none"
    _G.osisallowed = true
    _G.osisadmin = true
    _G.oshomefolder = "/home/root/"
end

]]
--main.run()

--[[ look for and launch the default ui, if not set then shell
osapi.getcolor()
shell.run(_G.authSystem)

if fs.exists(_G.shellui) then
	sleep(1)
	shell.run(_G.shellui)
elseif fs.exists(_G.shellui) then
	sleep(1)
	shell.run(_G.shell)
else
	printError("Shell was not found")
	shell.run("/rom/programs/shell.lua")
end
--shell.run("shell.lua")
--osapi.halt()]]
