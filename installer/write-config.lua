local file = fs.open("/config/startMenu.lua", "w")
text = {
    ["shell"] = "/system/systemapps/shell/app.config",
    ["control panel"] = "/system/systemapps/cpl/app.config",
    ["notepad"] = "/system/systemapps/notepad/app.config",
    ["calculator"] = "/system/systemapps/calculator/app.config",
    ["contacts"] = "/system/systemapps/contacts/app.config",
    ["calendar"] = "/system/systemapps/calendar/app.config",
    ["files"] = "/system/systemapps/files/app.config",
    ["minex"] = "/programs/minex/app.config",
    ["edit"] = "/system/systemapps/edit/app.config",
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/config/programs.config", "w")
text = {
    ["shell"] = "/system/systemapps/shell/app.config",
    ["control panel"] = "/system/systemapps/cpl/app.config",
    ["notepad"] = "/system/systemapps/notepad/app.config",
    ["calculator"] = "/system/systemapps/calculator/app.config",
    ["contacts"] = "/system/systemapps/contacts/app.config",
    ["calendar"] = "/system/systemapps/calendar/app.config",
    ["files"] = "/system/systemapps/files/app.config",
    ["minex"] = "/programs/minex/app.config",
    ["edit"] = "/system/systemapps/edit/app.config",
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/calculator/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/calculator/main.lua",
    ["title"] = "Calculator"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/notepad/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/notepad/main.lua",
    ["title"] = "Notepad"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/calendar/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/calendar/main.lua",
    ["title"] = "Calendar"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/contacts/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/contacts/main.lua",
    ["title"] = "Contacts"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/files/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/files/main.lua",
    ["title"] = "Files"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/minex/app.config", "w")
local text = {
    ["exe"] = "/system/programs/minex/main.lua",
    ["title"] = "minex"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/shell/app.config", "w")
local text = {
    ["exe"] = "/system/shell.lua",
    ["title"] = "Terminal"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/cpl/app.config", "w")
local text = {
    ["exe"] = "/system/systemapps/cpl/main.lua",
    ["title"] = "Control Panel"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/edit/app.config", "w")
local text = {
    ["exe"] = "/rom/programs/edit.lua",
    ["title"] = "Edit"
}
file.write(textutils.serialise(text))
file.close()

local file = fs.open("/system/systemapps/paint/app.config", "w")
local text = {
    ["exe"] = "/rom/programs/fun/advanced/paint.lua",
    ["title"] = "Paint",
    ["args"] = {{["type"] = filePath}}
}
file.write(textutils.serialise(text))
file.close()
