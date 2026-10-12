-- OS LOGIN Script
local login = nil
local password = nil

-- When Infomation is provided to the command
args = {...}
local username = args[1]
local password = args[2]
local flags = args[3]

-- If nothing was provided 
if args[1] == nil then
	write("Username:")
	username = read()
end
if args[2] == nil then
	write("Password:")
	password = read("*")
end

-- if they still did not provide valid credentials, we give up
if username == nil or username == "" or password == nil or password == "" then
	print("Inavlid Data! Canceling!")
	read()
	return false
end

-- Now Login
local newLogin = false -- if this is a new login, (if shell is not running) aka if it was ran when system was booted up
local userData = {} -- This is the data for the user

-- Checks if this is a new login
if _G.oslogin ~= nil and _G.osrun ~= true then
	newLogin = true 
end
-- Retrive user data if this is a new login
if newLogin == true then
	userData = osapi.saveuser()
end
-- print "Checking Credentials" if we are loged in
if _G.login == nil then
	print("Checking Credentials") 
end

local result = _G.osAuthentificationFunction.login(username, password)
if flags ~= "-s" then -- Don't print infomation if silent flag is enabled
	if result == true then
		-- The pasword is correct
		print("Access Granted")
		-- set home folder and load user settings
		_G.homeFolder = "/home/".._G.oslogin
		
		if newshell == true then
			-- Initlise the Shell
			osapi.restoreuser(userData)
		end
	else print("Access Denied") end
end
return result
