local termwid, termhigh = term.getSize()
local startmenu = require("/system/apis/startmenu")
local config = require("/system/apis/config")
taskbar = {}
topbar = false

function taskbar.init()
    topbar = false
end

function theme(key, fallback)
    local systemConfig = config.getSystemConfig(false)
    if systemConfig["apperance"][key] == nil then return fallback else return systemConfig["apperance"][key] end
    return fallback
end

local colors = {
    taskbarColor = colors.blue,
    startButtonColor = colors.green,
    clockButtonColor = colors.cyan
}

colors = {
    taskbarColor=theme("taskbarBackground", colors.blue),
    startButtonColor=theme("startButtonBackground", colors.green),
    clockButtonColor=theme("taskbarClockBackground", colors.cyan),

    -- Forground
    startButtonForground=theme("startButtonForground", colors.white),
    taskbarClockForground=theme("taskbarClockForground", colors.white),
}

function taskbar.displayTaskbar(basalt, topbar)
    --[[if false then
        local taskbarYPos = 1
        local colors = {
            taskbarColor = colors.gray,
            startButtonColor = colors.gray,
            clockButtonColor = colors.gray,
        }
    else]]
    local taskbarYPos = termhigh

    local frame = basalt.getMainFrame()
    local taskbar = frame:addFrame({
        width = termwid,
        height = 1,
        y = taskbarYPos,
        text = "",
        background = colors.taskbarColor
    })
    local startButton = taskbar:addButton({
        width = 5,
        height = 1,
        y = 1,
        text = "Start",
        background = colors.startButtonColor,
        forground = colors.startButtonForground,
    })

    if topbar == true then
        startButton.text = "---"
    end

    local clockButton = taskbar:addButton({
        width = string.len(textutils.formatTime(os.time())),
        height = 1,
        x = termwid - string.len(textutils.formatTime(os.time())) + 1,
        y = 1,
        text = textutils.formatTime(os.time()),
        background = colors.clockButtonColor,
    })

    if topbar == true then
        clockButton.x = math.floor(termwid / 2 - string.len(textutils.formatTime(os.time())) + 4)
    end

    startButton:onClick(function(self, mouseButton, x, y)
        startmenu.pressStartButton(basalt)
    end)

    clockButton:onClick(function(self, mouseButton, x, y)
    local toast = frame:addToast()
    toast:show("The time is "..textutils.formatTime(os.time()))
end)
end

return taskbar