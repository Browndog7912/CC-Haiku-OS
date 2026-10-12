-- Dialog Service
local termwid, termhigh = term.getSize()
local wm = require("/system/apis/wm")
local config = require("/system/apis/config")
dialog = {}

function theme(key, fallback)
    local systemConfig = config.getSystemConfig(false)
    if systemConfig["apperance"][key] == nil then return fallback else return systemConfig["apperance"][key] end
    return fallback
end

dialogTheme = {
    windowTitleBar=theme("windowTitleBar", colors.blue),
    windowTitleBarText=theme("windowTitleBarText", colors.white),
    windowCloseButton=theme("windowCloseButton", colors.red),
    windowMinimiseButton=theme("windowMinimiseButton", colors.yellow),
    windowMaximizeButton=theme("windowMaximizeButton", colors.green),
    windowMinimiseForground=theme("windowMinimiseForground", colors.black),
    windowMaximizeForground=theme("windowMaximizeForground", colors.white),
    windowMaximizeForground=theme("windowCloseForground", colors.white),
    windowBackground=theme("windowBackground", colors.white)
}


function dialog.showRunBox(basalt)
    local frame = basalt.getMainFrame()
    local windowId, runFrame = wm.drawWindow(32, 5, 2, termhigh - 6, "Run", true, false, false)
    runFrame.backgroud = colors.white

    runFrame:addLabel({
        text = "Open: ",
        x = 2,
        y = 3,
        foreground = colors.black,
    })

    local input = runFrame:addInput({
        x = 8,
        y = 3,
        width = 20,
        placeholder = "Run Program Here",
    })
    
    local submitButton = runFrame:addButton({
        x = 29,
        y = 3,
        width = 3,
        height = 1,
        text = "Run",
    })

    submitButton:onClick(function(self, mouseButton, x, y)
        dialog.showError(_G.desktopUIBasalt, "Unsupported", "This feature is not working yet!")
    end)
end

function dialog.showPowerBox(basalt)
    local frame = basalt.getMainFrame()
    local powerFrame = wm.drawWindow(basalt, 20, 5, 5, termhigh - 17, true)
    powerFrame.background = colors.cyan
    local bottomBar = powerFrame:addFrame({
        width = 20,
        height = 1,
        y = 5,
        text = "",
        background = colors.blue
    })

    powerFrame:addLabel({
        text = "Turn off computer"
    })
    
    local cancelButton = bottomBar:addButton({
        x = 14,
        y = 1,
        width = 6,
        height = 1,
        text = "Cancel",
    })

    local shutdownButton = powerFrame:addButton({
        x = 3,
        y = 3,
        width = 8,
        height = 1,
        background = colors.red,
        text = "Shutdown",
    })

    local restartButton = powerFrame:addButton({
        x = 12,
        y = 3,
        width = 7,
        background = colors.green,
        height = 1,
        text = "Restart",
    })
    cancelButton:onClick(function(self, mouseButton, x, y)
        powerFrame.visible = false
        powerFrame = null
    end)
end

function dialog.showError(basalt, title, message) 
    local frame = basalt.getMainFrame()
    local dialog = frame:addDialog({
        boxWidth = 32,
        titleBackground = dialogTheme.windowTitleBar,
        titleForeground = dialogTheme.white,
        boxBackground = dialogTheme.windowBackground,
        boxForeground = dialogTheme.black,
    })
    dialog:alert(title, message)
end

function dialog.showFilePicker(title, message) 
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local desktopwidth, desktopheight = frame:getSize()
    wm.drawWindow(32, 20, 5, 5, 5, "Dialog", true, false, false)
end

function dialog.askPrompt(basalt, title, message)
    local frame = basalt.getMainFrame()
    local askPromptDialog = frame:addDialog({
            boxWidth = 32,
            titleBackground = colors.blue,
            boxBackground = colors.white,
            boxForeground = colors.black,
        })
        askPromptDialog:confirm(title, message, function(yes)
            if yes == true then
                return true
            end
            return false
        end)
        askPromptDialog:focus()
end

function logoutofuser()
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local askPromptDialog = frame:addDialog({
        boxWidth = 32,
        titleBackground = colors.blue,
        boxBackground = colors.white,
        boxForeground = colors.black,
    })
    askPromptDialog:confirm("Log out ".._G.osProductName, "Logout of the user?", function(yes)
        if yes == true then
            _G.desktopUIBasalt.stop()
            os.shutdown()
        end
    end)
    askPromptDialog:focus()
end

function dialog.init()
    -- Placeholder for things to come!
end

return dialog