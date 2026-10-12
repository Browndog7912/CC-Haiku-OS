local basalt = require("/apis/basalt")
local hx, hy = term.getSize()
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
        --if mouse_button == 1 then callback() end
        addContact()
    end)
    return button
end

local yourcontacts = {"Google"}
toolbarButton(2, 4, "New")
function drawContacts()
    local contactslistitem = main:addList({
        height = main.height,
        width="{parent.width}",
        x = 1,
        y = 2,
        background = colorsTheme.background,
        foreground = colors.black,
        items = yourcontacts,
    })
end
function addContact() 
    local dialog = main:addDialog({
        boxWidth = 32,
        titleBackground = colors.blue,
        titleForeground = colors.white,
        boxBackground = colors.lightGray,
        boxForeground = colors.black,
    })
    dialog:prompt("Add Contact", "Contact Name:", currentName, function(value)
        table.insert(yourcontacts, value)
        drawContacts()
    end)
end
basalt.run()