-- AuroraOS Window Manager
local termwid, termhigh = term.getSize()
local config = require("/system/apis/config")
local progenv = require("/system/apis/progenv")

windoman = {}

function theme(key, fallback)
    local systemConfig = config.getSystemConfig(false)
    if systemConfig["apperance"][key] == nil then return fallback else return systemConfig["apperance"][key] end
    return fallback
end

wmTheme = {
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


function windoman.init()
    _G.windowFrames = {}

end

function runApp(program, basalt)
    local frame = basalt.getMainFrame()
    local appFrame = frame:addFrame({
        width = termwid,
        height = termhigh - 1
    })

    appFrame:addFrame({
        width = termwid,
        height = 1,
        y = 1,
        background = colors.blue
    })

    local closeButton = appFrame:addButton({
        width = 1,
        height = 1,
        y = 1,
        x = termwid,
        text = "X",
        background = colors.red
    })

    local prog = appFrame:addProgram({ x = 1, y = 2, width = termwid, height = termhigh - 2 })
    prog:execute(program)
    prog:onDone(function(self, ok, result)
        --prog.stop()
        appFrame.visible = false
        appFrame = null
    end)

    prog:onError(function(self, err, trace)
        if dialog then
            dialog.showError(basalt, "App Crashed", "This app closed due to an error!")
        end
        status.text = "Child error: " .. tostring(err)
    end)


    closeButton:onClick(function(self, mouseButton, x, y)
        --prog.stop()
        for i = 0, 15 do
            local color = 2^i
            term.setPaletteColor(color, term.nativePaletteColor(color))
        end
        appFrame.visible = false
        appFrame = null
    end)
end

function windoman.drawWindowApplication(program, title, windowwidth, windowhight, windowx, windowy, processID, args)
    if program == nil then return false end 
    if not fs.exists(program) then return false end
    if windowwidth == nil then return false end 
    if windowhight == nil then return false end 
    if windowx == nil then return false end 
    if windowy == nil then return false end 
    if title == nil then local title = "Application" end 
    if processID == nil then local processID = 0 end
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local windowFrame = windoman.drawFrameWindow(windowwidth, windowhight, windowx, windowy)
    --debugger.stop()
    local windowID = #_G.windowFrames + 1
    local WindowCloseButton = windowFrame:addButton({
        width = 1,
        height = 1,
        y = 1,
        x = windowwidth,
        text = "X",
        background = wmTheme.windowCloseButton,
        foreground = wmTheme.windowCloseForground,
    })
    WindowCloseButton:onClick(function(self, mouseButton, x, y)
        table.remove(_G.windowFrames, windowID)
        windowFrame:destroy()
    end)
    
    local WindowMinimiseButton = windowFrame:addButton({
        width = 1,
        height = 1,
        y = 1,
        x = windowwidth - 1,
        text = string.char(22),
        background = wmTheme.windowMinimiseButton,
        foreground = wmTheme.windowMinimiseForground,
    })
    WindowMinimiseButton:onClick(function(self, mouseButton, x, y)
        windowFrame.visible = false
        _G.windowFrames[windowID]["showing"] = false
    end)
    local WindowTitle = windowFrame:addLabel({
        width = windowwidth - 2,
        height = 1,
        y = 1,
        x = 1,
        text = title,
    })
    local WindowProgram = windowFrame:addProgram({
        x = 1,
        y = 2,
        width = windowwidth,
        height = windowhight - 1,
    })
    
    WindowProgram.env = progenv.build({
        processid = 0,
        ["windowid"] = windowID,
    })
    if args == nil then
        WindowProgram:execute(program)
    else
        WindowProgram:execute(program, args)
    end
    WindowProgram:onDone(function(self, ok, result)
        table.remove(_G.windowFrames, windowID)
        windowFrame:destroy()
    end)

    WindowProgram:onError(function(self, err, trace)
        local dialog = require("/system/apis/dialog")
        if dialog then
            dialog.showError(basalt, "App Crashed", tostrin(err))
        end
    end)
    windowFrame:focus()
    table.insert(_G.windowFrames, { id = windowID, ["program"] = program, ["Title"] = title, ["windowframe"] = windowFrame, showing = true, elements = { WindowCloseButton, WindowMinimiseButton, WindowTitle, program }, ["processId"] = processID })
end

function windoman.show(id)
    local windowFrame = _G.windowFrames[id]["windowframe"]
    windowFrame.visible = true
    _G.windowFrames[id]["showing"] = true
    windowFrame:focus()
end

function windoman.close(id)
    local windowFrame = _G.windowFrames[id]["windowframe"]
    table.remove(_G.windowFrames, windowID)
    windowFrame:destroy()
end

function windoman.hideWindow(id)
    local windowFrame = _G.windowFrames[id]["windowframe"]
    windowFrame.visible = false
    _G.windowFrames[windowID]["showing"] = false
end

function windoman.setWindowTitle(id, title)
    local windowFrame = _G.windowFrames[id]
    windowFrame.title = title
    local windowTitleElement = _G.windowFrames[id]["elements"][3]
    if windowTitleElement == nil then return nil end
    windowTitleElement.text = title
end


function windoman.drawFrameWindow(fwidth, fheight, fx, fy)
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local windowFrame = frame:addFrame({
        width = fwidth,
        height = fheight,
        x = fx,
        y = fy,
        background = wmTheme.windowBackground,
    })

    local titleBar = windowFrame:addFrame({
        width = fwidth,
        height = 1,
        y = 1,
        background = wmTheme.windowTitleBar,
    })
    return windowFrame
end

function windoman.drawWindow(fwidth, fheight, fx, fy, title, close, minimise, noclosework)
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local windowFrame = windoman.drawFrameWindow(fwidth, fheight, fx, fy)
    local windowID = #_G.windowFrames + 1

    local WindowTitle = windowFrame:addLabel({
        width = fwidth - 2,
        height = 1,
        y = 1,
        x = 1,
        text = title,
    })

    if close then
        local WindowCloseButton = windowFrame:addButton({
            width = 1,
            height = 1,
            y = 1,
            x = fwidth,
            text = "X",
            foreground = wmTheme.windowCloseForground,
            background = wmTheme.windowCloseButton,
        })
        if not noclosework == true then
            WindowCloseButton:onClick(function(self, mouseButton, x, y)
                table.remove(_G.windowFrames, windowID)
                windowFrame:destroy()
            end)
        end
    end
    if minimise then
        local WindowMinimiseButton = windowFrame:addButton({
            width = 1,
            height = 1,
            y = 1,
            x = fwidth - 1,
            text = string.char(22),
            background = wmTheme.windowMinimiseButton,
            foreground = wmTheme.windowMinimiseForground,
        })

        WindowMinimiseButton:onClick(function(self, mouseButton, x, y)
            windowFrame.visible = false
            _G.windowFrames[windowID]["showing"] = false
        end)
    end

    
    windowFrame:focus()
    table.insert(_G.windowFrames, { id = windowID, ["Title"] = title, ["windowframe"] = windowFrame, showing = true, elements = { nil, nil, WindowTitle, nil } })

    return windowID, windowFrame
end 

--[[function drawWindow(notbasalt, fwidth, fheight, fx, fy, fclosebutton)
    local basalt = _G.desktopUIBasalt
    local frame = basalt.getMainFrame()
    local windowFrame = frame:addFrame({
        width = fwidth,
        height = fheight,
        x = fx,
        y = fy,
    })

    local titleBar = windowFrame:addFrame({
        width = termwid,
        height = 1,
        y = 1,
        background = colors.blue
    })

    if fclosebutton == true then
        local WindowCloseButton = titleBar:addButton({
            width = 1,
            height = 1,
            y = 1,
            x = fwidth,
            text = "X",
            background = colors.red
        })

        WindowCloseButton:onClick(function(self, mouseButton, x, y)
            windowFrame.visible = false
            windowFrame = null
        end)
    end

    return windowFrame
end]]

return windoman