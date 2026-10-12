
local termwid, termhigh = term.getSize()

if not osapi then
    return
end

shell.exit()

local basalt = require("/apis/basalt")
local theme = basalt.use("theme")
local palette = theme.applyPreset("basalt")

local frame = basalt.getMainFrame()
background = basalt.rgb("#22262e"),

frame:addLabel({
    x = 2,
    y = 1,
    text = "Login",
    foreground = colors.white,
})

local username = frame:addInput({
    x = 2,
    y = 4,
    width = 22,
    placeholder = "Username",
})

local password = frame:addInput({
    x = 2,
    y = 7,
    width = 22,
    placeholder = "Password",
    replaceChar = "*",
})

local status = frame:addLabel({
    x = 2,
    y = 11,
    width = 40,
    height = 3,
    text = "Please Login",
    foreground = colors.lightGray,
})

local function submit()
    if not username.text:match("%S") or not password.text:match("%S") then
        status.text = "Password and Username are requred is required."
        status.foreground = colors.red
        username:focus()
        return
    end
    local result = _G.osAuthentificationFunction.login(username.text, password.text)
    if result then
        status.text = "welcome"
        status.foreground = colors.lime
        sleep(0.5)
        basalt.stop()
        term.clear()
        term.setCursorPos(1,1)
        shell.run(_G.shellui)
    else
        username:focus()
        status.text = "Password was incorrect!"
        status.foreground = colors.red
    end
end

username:onEnter(function()
    password:focus()
end)
password:onEnter(submit)

local submitButton = frame:addButton({
    x = 27,
    y = 4,
    background = colors.blue,
    width = 12,
    height = 3,
    text = "Login",
}):onClick(submit)

function showPowerBox()
    local powerFrame = frame:addFrame({
        y = termhigh - 17,
        x = 5,
        width = 20,
        height = 5,
        background = colors.lightBlue,
    })

    local titleBar = powerFrame:addFrame({
        width = 20,
        height = 1,
        y = 1,
        text = "",
        background = colors.blue
    })
    local bottomBar = powerFrame:addFrame({
        width = 20,
        height = 1,
        y = 5,
        text = "",
        background = colors.blue
    })

    local closeButton = powerFrame:addButton({
        width = 1,
        height = 1,
        y = 1,
        x = 20,
        text = "X",
        background = colors.red
    })
    
    titleBar:addLabel({
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

    closeButton:onClick(function(self, mouseButton, x, y)
        powerFrame.visible = false
        powerFrame = null
    end)

    cancelButton:onClick(function(self, mouseButton, x, y)
        powerFrame.visible = false
        powerFrame = null
    end)
    restartButton:onClick(function(self, mouseButton, x, y)
        os.reboot()
    end)
    shutdownButton:onClick(function(self, mouseButton, x, y)
        os.shutdown()
    end)
end


frame:addButton({
    x = 27,
    y = 9,
    width = 12,
    height = 3,
    text = "Power",
    background = palette.danger,
}):onClick(function()
    showPowerBox()
end)

username:focus()
basalt.run()