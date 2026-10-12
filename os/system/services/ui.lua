-- Basalt Manager
local basalt = require("/apis/basalt")
local uiapi = {}
local RENDER_INTERVAL = 0.05
local event = require("/system/apis/event")
function init()
    basalt.setRenderInterval(RENDER_INTERVAL)
    main_frame = basalt.getMainFrame()

    event.on("system.boot_complete", function()
        ui.switchScreen("login")
    end)
end

function uiapi.getMainFrame()
    return main_frame
end

function uiapi.getBasalt()
    return basalt
end

return uiapi