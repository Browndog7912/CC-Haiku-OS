args = {...}
local username = args[1]
if username == nil then print("Invalid Input") return false end
local result = osapi.userdel(username)
print(result)
return false
