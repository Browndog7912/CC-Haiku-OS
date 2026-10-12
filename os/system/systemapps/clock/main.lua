local basalt = require("/apis/basalt")
local logic = require("logic")

local function theme(key, fallback)
    return fallback
end

local colorpal = {
    background=theme("menu_bg", basalt.rgb("#14395d")),
    foreground=theme("menu_fg", colors.black),
    muted=theme("menu_muted", colors.gray),
    surface=theme("surface", colors.lightGray),
    primary=theme("primary", colors.blue),
    text=theme("text", colors.white),
    success=theme("success", colors.green),
    danger=theme("danger", colors.red),
    border=theme("border", colors.gray),
    pressed=theme("btn_clicked", colors.cyan),
}


local main = basalt.getMainFrame()

main:addButton({
    text="ALARM",
    foreground=colorpal.text, 
    background=colorpal.background,
    x = 1,
    y = 1,
})

main:addButton({
    text="CLOCK",
    foreground=colorpal.text, 
    background=colorpal.background,
    x = 10,
    y = 1,
})

main:addButton({
    text="TIMER",
    foreground=colorpal.text, 
    background=colorpal.background,
    x = 20,
    y = 1,
})

main:addButton({
    text="STOPWATCH",
    foreground=colorpal.text, 
    background=colorpal.background,
    x = 30,
    y = 1,
})



main:setBackground(colorpal.background)
basalt.run()