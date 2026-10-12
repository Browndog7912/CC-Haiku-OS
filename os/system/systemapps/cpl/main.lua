local basalt = require("/apis/basalt")
local main = basalt.getMainFrame()

local colorsChoices = {
    "white", "orange", "magenta", "lightBlue",
    "yellow", "lime", "pink", "gray",
    "lightGray", "cyan", "purple", "blue",
    "brown", "green", "red", "black",
}

local sidebar = main:addFrame({
    x=1, 
    y=1, 
    width=12, 
    height="{parent.height}",
    background=colors.lightGray,
})
sidebar:addLabel({
    x=2, 
    y=1, 
    width=10, 
    height=1, 
    text="Control Panel",
    foreground=foreground, 
    disabled=true,
})

_G.content = main:addFrame({
    x=13, 
    y=1, 
    width="{parent.width - 12}", 
    height="{parent.height - 1}",
    background=colors.white,
})

function createAppearancePage()
    local mobileSwitch = content:addSwitch({ 
        name="", 
        x=2, 
        y=2, 
        width=4, 
        height=1, 
        visible=true, 
        disabled=false, 
        checked=false, 
        offColor=colors.gray, 
        onColor=colors.blue, 
        knobColor=colors.lightGray
    })

    content:addLabel({
        name="", 
        x=7, 
        y=2, 
        width=17, 
        height=1, 
        z=0, 
        visible=true, 
        disabled=false, 
        foreground=colors.black, 
        text="Mobile Interface" 
    })

    local taskbarColorDrop = content:addDropdown({
        x = 2,
        y = 5,
        width = 18,
        text = "light mode",
        dropHeight = 5,
        items = {"Light Mode", "Dark Mode"},
    })
    content:addLabel({ 
        name="", 
        x=2, 
        y=4, 
        width=17, 
        height=1, 
        visible=true, 
        disabled=false, 
        foreground=colors.black, 
        text="Theme"
    })

    local taskbarColorDrop = content:addDropdown({
        x = 2,
        y = 7,
        width = 18,
        text = "error",
        dropHeight = 5,
        items = colorsChoices,
    })
    content:addLabel({ 
        name="", 
        x=2, 
        y=6, 
        width=17, 
        height=1, 
        visible=true, 
        disabled=false, 
        foreground=colors.black, 
        text="Taskbar Color"
    })

    local taskbarColorDrop = content:addDropdown({
        x = 2,
        y = 9,
        width = 18,
        text = "error",
        dropHeight = 5,
        items = colorsChoices,
    })
    content:addLabel({ 
        name="", 
        x=2, 
        y=8, 
        height=10, 
        visible=true, 
        disabled=false, 
        foreground=colors.black, 
        text="Desktop Wallpaper Color"
    })

end

function createAboutPage()
    content:addLabel({ 
        x=2, 
        y=2, 
        foreground=colors.black, 
        text="Haiku OS"
    })
    content:addLabel({ 
        x=2, 
        y=3, 
        foreground=colors.black, 
        text="with Haiku Desktop Enviorment v1"
    })
    content:addLabel({ 
        x=2, 
        y=5, 
        foreground=colors.black, 
        text="2026 JMC Co."
    })
end

function createUpdatePage()
    content:addLabel({ 
        x=2, 
        y=2, 
        foreground=colors.red, 
        text="Unsupported"
    })
    content:addLabel({ 
        x=2, 
        y=4, 
        foreground=colors.black, 
        text="Update is not supported, it is not "
    })
    content:addLabel({ 
        x=2, 
        y=5, 
        foreground=colors.black, 
        text="working and will be made soon and "
    })
    content:addLabel({ 
        x=2, 
        y=6, 
        foreground=colors.black, 
        text="be working."
    })
end


local categoryButtons = {}
local current_category = nil


-- Apperance Frame





function showCategory(item) 
    _G.settingspage = item.id

    _G.content = main:addFrame({
        x=13, 
        y=1, 
        width="{parent.width - 12}", 
        height="{parent.height - 1}",
        background=colors.white,
    })

    if item.id == "appearance" then
        createAppearancePage()
    end
    if item.id == "about" then
        createAboutPage()
    end
    if item.id == "update" then
        createUpdatePage()
    end
end

local categories = {
    {text = "Apperance", id="appearance"},
    {text = "Taskbar", id="taskbar"},
    {text = "Windows", id="window"},
    {text = "Start Menu", id="startmenu"},
    {text = "File Types", id="filetypes"},
    {text = "Users", id="users"},
    {text = "System", id="system"},
    {text = "Devices", id="peripherals"},
    {text = "Security", id="security"},
    {text = "About", id="about"},
    {text = "Update", id="update"},
    
}

for index, category in ipairs(categories) do
    local categoryCopy = category
    local button = sidebar:addButton({
        x=1, 
        y=index + 2, 
        width=12, 
        height=1,
        text=category.text, 
        foreground=colors.black, 
        background=colors.lightGray,
    })
    button:setStateStyle("hover", {background=background, foreground=foreground})
    button:onClick(function() showCategory(categoryCopy) end)
    categoryButtons[category.id] = button
end

if categories[1] then showCategory(categories[1]) end

basalt.run()
