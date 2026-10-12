-- Add StartMenu
local wm = require("/system/apis/wm")
local process = require("/system/apis/process")
local dialog = require("/system/apis/dialog")

local termwid, termhigh = term.getSize()
local startMenu = nil
startmenu = {}
_G.desktopStartMenuIsOpen = false

function startmenu.init()
    if fs.exists("/config/startMenu.lua") == false then
        local file = fs.open("/config/startMenu.lua", "w")
        StartMenuPrograms = { ["shell"] = "/system/systemapps/shell/shell.lua", ["control panel"] = "/system/cpl/shell/shell.lua", ["notepad"] = "/system/systemapps/notepad/notepad.lua", ["calculator"] = "/system/systemapps/calculator/calculator.lua", ["calendar"] = "/system/systemapps/calendar/calendar.lua"}
        file.write(textutils.serialise(StartMenuPrograms))
        file.close()
    end
end

function startmenu.getTableKeys(tab)
    local keyset = {}
    for k, v in pairs(tab) do
        keyset[#keyset + 1] = k
    end
    return keyset
end
function startmenu.getStartMenuProg()
    local file = fs.open("/config/startMenu.lua", "r")
    local text = file.readAll()
    local progs = textutils.unserialise(tostring(text))
    file.close()
    _G.DesktopStartMenuProgs = progs
    return progs
end


function startmenu.pressStartButton(basalt)
    local frame = basalt.getMainFrame()
    local animation = basalt.use("animation")
    local toast = frame:addToast({
        duration = 2,
        maxWidth = 24,
    })

    if _G.desktopStartMenuIsOpen == true then
        local startFrame = startMenu
        _G.desktopStartMenuIsOpen = false
        isOpen = false
        startFrame:animate({x=1, y=termhigh + 1}, 0.15, "easeIn", function()
            startFrame:destroy()
        end)
        return
    end


    startmenu.openStartMenu(basalt)
end

function startmenu.closeStartMenu(basalt)
    if _G.desktopStartMenuIsOpen == true then
        local startFrame = startMenu
        _G.desktopStartMenuIsOpen = false
        isOpen = false

        startFrame:animate({x=1, y=termhigh + 1}, 0.15, "easeIn", function()
            startFrame:destroy()
        end)
        return
    end
end

function startmenu.openStartMenu(basalt) 
    
    local frame = basalt.getMainFrame()
    local startFrame = startMenu
    startMenu = frame:addFrame({
        x = 1,
        y = termhigh + 1,
        width = 29,
        height = 15,
        background = colors.blue
    })  
    startMenu:animate({x=1, y=termhigh - 15}, 0.15, "easeIn", function()
    end)
    _G.desktopStartMenuIsOpen = true

    local startMenuPrograms = startMenu:addList({
        height = 10,
        y = 3,
        items = startmenu.getTableKeys(startmenu.getStartMenuProg())
    })

    local startMenuSidebar = startMenu:addList({
        height = 10,
        x = 17,
        y = 3,
        items = { "Files", "Documents", "Pictures", "Music", "Computer", "Control Panel", "Run" },
    })

    local powerButton = startMenu:addButton({
        text = "Power",
        height = 1,
        width = 5,
        x = 23,
        y = 14,
    })

    local logoutButton = startMenu:addButton({
        text = "Logout",
        height = 1,
        width = 6,
        x = 16,
        y = 14,
    })

    local accountLogo = startMenu:addLabel({
        text = "root",
        height = 1,
        width = 6,
        x = 2,
        y = 1,
    })

    startMenuPrograms:onSelect(function(_, _, item)

        --local startMenuPrograms = startmenu.getStartMenuProg()
        --startmenu.closeStartMenu(basalt)
        --if startMenuPrograms[item.value] == nil then return end

        --local fileg = fs.open(startMenuPrograms[item.value], "r")
        --local textg = fileg.readAll()
        ---local progdata = textutils.unserialise(tostring(textg))
        --fileg.close()

        --if progdata["exe"] == nil then return end

        process.startWindowProcess(item.value)

        --[[if item.value == "shell" then
            wm.runApp("/system/shell.lua", basalt)
        end
        if item.value == "control panel" then
            wm.runApp("/system/systemprograms/cpl/main.lua", basalt)
        end
        if item.value == "run" then
            dialog.showRunBox(basalt)
        end
        if item.value == "calculator" then
            wm.runApp("/programs/calculator/main.lua", basalt)
        end
        if item.value == "notepad" then
            wm.runApp("/programs/notepad/main.lua", basalt)
        end
        if item.value == "calendar" then
            wm.runApp("/programs/calendar/main.lua", basalt)
        end]]
    end)

    startMenuSidebar:onSelect(function(_, _, item)
        startmenu.closeStartMenu(basalt)
        if item.value == "Run" then
            dialog.showRunBox(basalt)
        end
        if item.value == "Files" then
            process.startWindowProcessNoID("/system/systemapps/files/main.lua", basalt)
            --wm.runApp("/system/shell.lua", basalt)
        end
        if item.value == "Control Panel" then
            --wm.runApp("/system/systemprograms/cpl/main.lua", basalt)
        end
    end)

    logoutButton:onClick(function(_, _, item)
        dialog.logoutofuser()
    end)

    powerButton:onClick(function(_, _, item)
        dialog.showPowerBox(basalt)
    end)
end

return startmenu