-- Bootloader

if _G.btlloaded == true then
    return -- Douse not opens bootloder if the Computer has loaded
end
if fs.exists("/apis/menu.lua") ~= true then
    printError("[!] Bootloader Failed to load, please run repair command!") -- Check if the MENU Api exsits
    sleep(5)
end

os.loadAPI("/apis/menu.lua") -- Load MENU Api

choices = {}
title = "Bootloader"

function boot(bootProgram) 
    _G.btlloaded = true
    os.unloadAPI("/apis/menu.lua")
    term.clear()
    term.setCursorPos(1,1)
    shell.run(bootProgram)
end

actions = {}

if fs.exists("/boot/init.lua") then
    choices[1] = "OS"
    actions[1] = function()
        boot("/boot/init.lua")
    end
    actions[2] = function()
        printError("Failed to laod Recovery Mode!")
        sleep(5)
        os.reboot()
    end
    choices[#choices + 1] = "OS Recovery Mode"
end


choices[3] = "Craft OS Shell"
actions[3] = function()
    boot("/rom/programs/shell.lua")
end



menu.indented(title, choices, actions)
