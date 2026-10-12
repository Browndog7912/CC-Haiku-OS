args = { ... }

local function printUsage() 
    print("Usage:")
    print("sudo <program>")
end

-- Print Ussage
if args[1] == nil then 
    printUsage()
    return true
end

shell.run(args[1])