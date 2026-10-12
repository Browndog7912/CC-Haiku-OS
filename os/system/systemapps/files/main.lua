local basalt = require("/apis/basalt")
local main = basalt.getMainFrame()
local uihelpers = require("/system/apis/uihelpers")
local config = require("/system/apis/config")
local dialog = require("/system/apis/dialog")
local processAPI = require("/system/apis/process")

local hx, hy = term.getSize()

-- Colors
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

-- ///////////// --
-- // Toolbar // --
-- ///////////// --
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
        if mouse_button == 1 then callback() end
    end)
    return button
end

toolbarButton(2, 1, string.char(27), function() end)
toolbarButton(4, 1, string.char(26), function() end)
-- Contexmenu add
local contextMenu = main:addContextMenu()
local creationMenu = main:addContextMenu()
-- /////////////////// --
-- // File  Indexer // --
-- // And Functions // --
-- /////////////////// --

local fileList = main:addList({
    height = main.height,
    width="{parent.width}",
    x = 1,
    y = 2,
    background = colorsTheme.background,
    foreground = colors.black,
})

toolbarButton(6, 1, string.char(30), function()
    naviageToPath(fs.combine(currentPath, ".."))
    currentPath = fs.combine(currentPath, "..")
end)

function naviageToPath(path)
    if not fs.exists(path) then return end
    fileList:clear()
    local files = fs.list(path)
    for i = 1, #files do
        local iconchar, iconcolor = getFileIcon(fs.combine(path, files[i]))
        fileList:addItem({
            text = "   " .. files[i],
            value = files[i],
            iconChar = string.char(iconchar),
            iconForeground=iconcolor,
            iconX=2,
        })
    end
    fileList:scrollToItem(1)
end

function getFileIcon(file)
    iconConfig = config.getFileIcons()
    if iconConfig["def"] == nil then config.configErrorFlag("icon"); return end
    local dirIcon = iconConfig["dir"]
    if iconConfig["dir"] == nil then local dir = iconConfig["def"]; return end
    local romIcon = iconConfig["rom"]
    if iconConfig["rom"] == nil then local dir = iconConfig["def"]; return end

    if not fs.exists(file) then return iconConfig["def"], colors.black end
    if fs.isReadOnly(file) then
        return romIcon, colors.orange
    elseif fs.isDir(file) then
        return dirIcon, colors.yellow
    else 
        return iconConfig["def"], colors.lime
    end
end

function openItem(file)
    if not fs.exists(file) then return end
    if fs.isDir(file) then
        currentPath = file
        naviageToPath(file)
        contextMenu:setItems({})
    else
        processAPI.startWindowProcess("edit", file)
    end
end


function openSelected()
    local listSelectedItem = fileList:getSelectedItem().value
    openItem(fs.combine(currentPath, listSelectedItem))
end

function editSelected()
    local listSelectedItem = fileList:getSelectedItem().value
    local file = fs.combine(currentPath, listSelectedItem)
    if not fs.exists(file) then return end
    processAPI.startWindowProcess("edit", file)
end
-- ////////////////// --
-- // Interactions // --
-- ////////////////// --

currentPath = "/"
uihelpers.onDoubleClick(fileList, function(_, button)
    if fileList:getSelectedItem() == nil then return end
    local listSelectedItem = fileList:getSelectedItem().value
    oswindow.setTitle("Files " .. fs.combine(currentPath, listSelectedItem))
    if button == 1 then openItem(fs.combine(currentPath, listSelectedItem)) end
end, 0.40)

naviageToPath(currentPath)

-- ///////////////// --
-- // Contex Menu // --
-- ///////////////// --

fileList:onSelect(function(self, index, item)
    local listSelectedItem = fileList:getSelectedItem().value
    local file = fs.combine(currentPath, listSelectedItem)
    oswindow.setTitle("Files " .. file)
    if not fs.exists(file) then return end
    if fs.isReadOnly(file) then
        if fs.isDir(file) then
            contextMenu:setItems({
                { text = "Open", callback = openSelected },
                { separator = true },
                { text = "Copy", callback = copySelected },
                { separator = true },
                { text = "Properties", callback = renameSelected },
            })
        else
            contextMenu:setItems({
                { text = "Open", callback = openSelected },
                { text = "Open With...", callback = editSelected },
                --{ text = "Edit", disabled=fs.isReadOnly(file), callback = editSelected },
                { separator = true },
                { text = "Copy", callback = renameSelected },
                --{ text = "Cut", disabled=fs.isReadOnly(file), callback = cutSelected },
                --{ separator = true },
                --{ text = "Rename", disabled=fs.isReadOnly(file), callback = renameSelected },
                --{ text = "Delete", disabled=fs.isReadOnly(file), callback = deleteSelected },
                { separator = true },
                { text = "Properties", callback = renameSelected },
            })
        end
    elseif fs.isDir(file) then
        contextMenu:setItems({
            { text = "Open", callback = openSelected },
            { separator = true },
            { text = "Copy", callback = copySelected },
            { text = "Cut", callback = cutSelected },
            { separator = true },
            { text = "Rename", callback = renameSelected },
            { text = "Delete", callback = deleteSelected },
            { separator = true },
            { text = "Properties", callback = renameSelected },
        })
    else
        contextMenu:setItems({
            { text = "Open", callback = openSelected },
            { text = "Open With...", callback = openSelected },
            { text = "Edit", callback = editSelected },
            { separator = true },
            { text = "Copy", callback = renameSelected },
            { text = "Cut", callback = cutSelected },
            { separator = true },
            { text = "Rename", callback = renameSelected },
            { text = "Delete", callback = deleteSelected },
            { separator = true },
            { text = "Properties", callback = renameSelected },
        })
    end
end)

local function creationItems()
    local items = {
        {label="New File", action=createFile},
        {label="New Folder", action=createFolder},
    }
    --[[if fileops then
        items[#items + 1] = {separator=true}
        items[#items + 1] = {
            label="Paste",
            disabled=isReadOnly() or not fileops.canPaste(current_path),
            action=function() pasteInto(current_path) end,
        }
    end]]
    return items
end

toolbarButton(hx - 2, 1, "+", function() 
    creationMenu:setItems(creationItems())
    creationMenu:openAt(hx - 2, 2)
end)

contextMenu:setItems({
    { text = "Open", callback = renameSelected },
    { separator = true },
    { text = "Copy", callback = renameSelected },
    { text = "Cut", callback = renameSelected },
    { separator = true },
    { text = "Rename", callback = renameSelected },
    { text = "Delete", callback = deleteSelected },
    { separator = true },
    { text = "Properties", callback = renameSelected },
})

fileList:onClickUp(function(_, button, x, y)
    if button ~= 2 then return end
    contextMenu:openAt(x, y + 1)
end)
basalt.run()