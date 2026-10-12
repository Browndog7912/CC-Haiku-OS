args = { ... }

local function printUsage() {
    print("Usage:")
    print("Calc <number> <type of math> <number>")
    print("type of math is + / * - %")
    print("Example: calc 1 + 1")
}
-- Print Ussage
if args[3] == nil then 
    printUsage()
    return true
end

function calc(n1,o,n2)
    local c = 0
    if o == "+" then c = n1 + n2
    elseif o == "-" then c = n1 - n2
    elseif o == "*" then c = n1 * n2
    elseif o == "/" then c = n1 / n2
    elseif o == "%" then c = n1 / 100 * n2
    end
    return c
end

local n1 = tonumber(args[1])
local o = args[2]
local n2 = tonumber(args[3])
local r = 0
local ac = 4
if n1 == nil then 
    printError("First number is not a number!") 
return 
    false 
end
if o ~= "+" and o ~= "-" and o ~= "/" and o ~= "*" and o ~= "%" then 
    printError("Invalid operator, +,-,*,/,%") 
    return false 
end

if n2 == nil then 
    print("Second number is not a number!") 
    return false 
end
-- Operate the calculation
r = calc(n1,o,n2)
while args[ac] == "+" or args[ac] == "-" or args[ac] == "/" or args[ac] == "*" or args[ac] == "%" do
    to = args[ac]
    ac = ac + 1
    tn = tonumber(args[ac])
    if tn ~= nil then r = calc(r,to,tn) end
    ac = ac + 1
end

print("Result:"..r)
return r
