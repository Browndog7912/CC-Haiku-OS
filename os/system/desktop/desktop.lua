local args = { ... }
local kernalmain = require("/system/main")
local event = require("/system/apis/event")

local termwid, termhigh = term.getSize()
local basalt = require("/apis/basalt")
_G.desktopUIBasalt = basalt
local frame = basalt.getMainFrame()
if args[1] == nil then else
    shell.run(args[1])
end
frame.background = colors.lightBlue

basalt.schedule(function()
    kernalmain.run()
end)
basalt.run()