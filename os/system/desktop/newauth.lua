local basalt = _G.desktopUIBasalt
local frame = basalt.getMainFrame()
local tx, ty = term.getSize()
local config = require("/system/apis/config")
local wm = require("/system/apis/wm")
local logInFrame
local windowId, logInFrame = wm.drawWindow(20, 10, math.floor(tx / 2 - 10), math.floor(ty / 2 - 5), "Please Login", true, false, true)
logInFrame:addLabel({
    x = 2,
    y = 3,
    text = "Please Login"
})

local username = logInFrame:addInput({
    x = 2,
    y = 5,
    width = 18,
    placeholder = "Username",
})

local password = logInFrame:addInput({
    x = 2,
    y = 7,
    width = 18,
    placeholder = "Password",
    replaceChar = "*",
})

function power()
    dialog.showPowerBox(basalt)
end

function submit()
    if not username.text:match("%S") or not password.text:match("%S") then
        --Required
        username:focus()
        return
    end
    local result = _G.osAuthentificationFunction.login(username.text, password.text)
    if result then
        logInFrame.visible = false
        logInFrame = nil
		config.initUsersConfig()
        shell.run("/system/desktop/hde.lua")
        --correct
    else
        -- Incorrect
    end
end

local submitButton = logInFrame:addButton({
    x = 2,
    y = 9,
    background = colors.blue,
    width = 6,
    height = 1,
    text = "Submit",
}):onClick(submit)

local powerButton = logInFrame:addButton({
    x = 10,
    y = 9,
    background = colors.red,
    width = 6,
    height = 1,
    text = "Power",
}):onClick(power)


username:focus()
username:onEnter(function()
    password:focus()
end)
password:onEnter(submit)
