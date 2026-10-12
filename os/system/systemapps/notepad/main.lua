local basalt = require("/apis/basalt")

local main = basalt.getMainFrame()

local colorsTheme = {
    background=colors.white,
    foreground=colors.black,
    muted=colors.gray,
    surface=colors.lightGray,
    primary=colors.blue,
    text=colors.white,
    pressed=colors.cyan,
    border=colors.gray,
    toolbarforground=colors.white,
}

main:setBackground(colorsTheme.background)

local toolbar = main:addFrame({
    x=1, 
    y=1, 
    width="{parent.width}", height=2,
    background=colorsTheme.background,
})

toolbar:addFrame({
    x=1, y=1, width="{parent.width}", height=1,
    background=colorsTheme.border, 
    disabled=true,
})

local function toolbarButton(x, width, text, callback)
    local button = toolbar:addButton({
        x=x,
        y=1, 
        width=width, 
        height=1, 
        text=text,
        foreground=colorsTheme.toolbarforground, 
        background=colorsTheme.border,
    })
    button:setStateStyle("hover", {background=colorsTheme.primary, foreground=colorsTheme.text})
    button:setStateStyle("pressed", {background=colorsTheme.pressed, foreground=colorsTheme.text})
    button:onClickUp(function(_, mouse_button)
        
    end)
    return button
end


toolbarButton(2, 4, "New", newDocument)
toolbarButton(7, 4, "Open", openDocument)
toolbarButton(12, 4, "Save", saveDocument)
toolbarButton(17, 7, "Save As", saveAs)

basalt.run()