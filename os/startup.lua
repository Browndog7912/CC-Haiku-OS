-- OS Startup
shell.exit()
shell.run("clear")
if fs.exists("/boot/bootloader.lua") then
    shell.exit()
    shell.run("set shell.allow_disk_startup false")
    shell.run("/boot/bootloader.lua")
    os.reboot()
end
if fs.exists("/boot/init.lua") then
    shell.exit()
    shell.run("set shell.allow_disk_startup false")
    shell.run("/boot/init.lua")
    os.reboot()
end
printError("Cannot Boot to OS! Please use recovery tools disk!")
sleep(2)
shell.run("set shell.allow_disk_startup true")
os.reboot()
