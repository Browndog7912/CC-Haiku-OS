args = {...}

function printUsage()
    print("Ussage: ")
    print("useradd <Username> <Password>")
end

local username = args[1]
local password = args[2]
if password == nil then printUsage() return false end -- Check is password is nil
local result = osapi.useradd(username,password) 
print(result)

return false
