local fileList = {
    ["FilesDownload"] = {
        {"/startup.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/startup.lua"},
        {"/system/userdel.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/userdel.lua"},
        {"/system/useradd.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/useradd.lua"},
        {"/system/sudo.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/sudo.lua"},
        {"/system/shutdown.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/shutdown.lua"},
        {"/system/shell.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/shell.lua"},
        {"/system/screenfetch.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/screenfetch.lua"},
        {"/system/restart.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/restart.lua"},
        {"/system/newtab.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/newtab.lua"},
        {"/system/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/main.lua"},
        {"/system/login.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/login.lua"},
        {"/system/gist.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/gist.lua"},
        {"/system/config.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/config.lua"},
        {"/system/clock.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/clock.lua"},
        {"/system/calc.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/calc.lua"},
        {"/system/apis/config.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/config.lua"},
        {"/system/apis/dialog.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/dialog.lua"},
        {"/system/apis/driver.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/driver.lua"},
        {"/system/apis/event.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/event.lua"},
        {"/system/apis/kernal.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/kernal.lua"},
        {"/system/apis/process.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/process.lua"},
        {"/system/apis/progenv.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/progenv.lua"},
        {"/system/apis/startmenu.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/startmenu.lua"},
        {"/system/apis/taskbar.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/taskbar.lua"},
        {"/system/apis/uihelpers.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/uihelpers.lua"},
        {"/system/apis/wm.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/apis/wm.lua"},
        {"/system/desktop/desktop.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/desktop/desktop.lua"},
        {"/system/desktop/hde.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/desktop/hde.lua"},
        {"/system/desktop/newauth.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/desktop/newauth.lua"},
        {"/system/systemapps/calculator/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/app.config"},
        {"/system/systemapps/calculator/calculator_logic.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/calculator_logic.lua"},
        {"/system/systemapps/calculator/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/main.lua"},

        {"/system/systemapps/calendar/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/main.lua"},
        {"/system/systemapps/calendar/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/app.config"},
        {"/system/systemapps/calendar/calendar_logic.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/calendar_logic.lua"},

        {"/system/systemapps/cpl/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/cpl/main.lua"},
        {"/system/systemapps/cpl/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/cpl/app.config"},

        {"/system/systemapps/edit/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/edit/app.config"},

        {"/system/systemapps/files/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/files/app.config"},
        {"/system/systemapps/files/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/files/main.lua"},

        {"/system/systemapps/notepad/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/notepad/main.lua"},
        {"/system/systemapps/notepad/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/notepad/app.config"},

        {"/system/systemapps/shell/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/shell/app.config"},

        {"/system/systemapps/paint/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/paint/app.config"},

        {"/boot/init.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/boot/init.lua"},
        {"/boot/bootloader.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/boot/bootloader.lua"},

    }
}


local file = fs.open("files.config", "w")
file.write(textutils.serialise(fileList))
file.close()