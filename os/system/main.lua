-- Main.lua
-- Main Part of system
local event = require("/system/apis/event")
local kernal = require("/system/apis/kernal")
local main = {}

function main.initServices()
    
end

function main.initApis()
    main.printStatus("Loading Kernal API", "FAIL", colors.red)
    --local kernal = require("/system/apis/kernal")
    --kernal.init()
    
    main.printStatus("Loading Event API", " OK ", colors.green)
    local event = require("/system/apis/event")
    event.init()

    main.printStatus("Loading Config API", " OK ", colors.green)
    local configorationapi = require("/system/apis/config")
    configorationapi.init()
    
    main.printStatus("Loading Basalt (2.5)", " OK ", colors.green)
    local windoman = require("/system/services/ui")

    main.printStatus("Loading Dialog API", " OK ", colors.green)
    local dialog = require("/system/apis/dialog")
    dialog.init()

    main.printStatus("Loading Start Menu API", " OK ", colors.green)
    local startmenu = require("/system/apis/startmenu")
    startmenu.init()

    main.printStatus("Loading Taskbar API", " OK ", colors.green)
    local taskbar = require("/system/apis/taskbar")
    taskbar.init()

    main.printStatus("Loading Window Manager API", " OK ", colors.green)
    local windoman = require("/system/apis/wm")
    windoman.init()

    main.printStatus("Loading Driver Manager", " OK ", colors.green)
    local driver = require("/system/apis/driver")
    driver.init()
    
    main.printStatus("Loading Driver Manager", " OK ", colors.green)
    local processAPI = require("/system/apis/process")
    processAPI.init()

    event.on("peripheral", function(name)
        os.shutdown()
    end)

end

function main.run()
    running = true

    while running do
        local eventData = {os.pullEventRaw()}
        local eventType = eventData[1]

        if eventType == "terminate" then
            os.shutdown()
            break
        end

        event.dispatch(eventType, table.unpack(eventData, 2))
    end
end

function main.printStatus(text, type, color)
    term.setTextColor(colors.white)
    local cursorx, cursory = term.getCursorPos()
    term.setCursorPos(8, cursory)
    term.write(text)
    term.setCursorPos(1, cursory)
    term.write("[    ]")
    term.setCursorPos(2, cursory)
    term.setTextColor(color)
    term.write(type)

    term.setCursorPos(1, cursory+1)
end

return main