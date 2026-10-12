-- WIP
local termx, termy = term.getSize()

if not(fs.exists("/hakosinstaller.config")) then printError("NO INSTALL CONFIG"); return end
--shell.exit()
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
        --{"/system/systemapps/calculator/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/app.config"},
        {"/system/systemapps/calculator/calculator_logic.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/calculator_logic.lua"},
        {"/system/systemapps/calculator/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calculator/main.lua"},

        {"/system/systemapps/calendar/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/main.lua"},
        --{"/system/systemapps/calendar/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/app.config"},
        {"/system/systemapps/calendar/calendar_logic.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/calendar/calendar_logic.lua"},

        {"/system/systemapps/cpl/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/cpl/main.lua"},
        --{"/system/systemapps/cpl/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/cpl/app.config"},

        --{"/system/systemapps/edit/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/edit/app.config"},

        --{"/system/systemapps/files/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/files/app.config"},
        {"/system/systemapps/files/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/files/main.lua"},

        {"/system/systemapps/notepad/main.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/notepad/main.lua"},
        --{"/system/systemapps/notepad/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/notepad/app.config"},

        --{"/system/systemapps/shell/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/shell/app.config"},

        --{"/system/systemapps/paint/app.config", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/system/systemapps/paint/app.config"},

        {"/boot/init.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/boot/init.lua"},
        {"/boot/bootloader.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/boot/bootloader.lua"},

        {"/apis/menu.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/apis/menu.lua"},
        {"/apis/basalt.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/apis/basalt.lua"},
        {"/apis/osapi.lua", "https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/os/apis/osapi.lua"},

    }
}

function printStatus(text, type, color)
    term.setTextColor(colors.white)
    local cursorx, cursory = term.getCursorPos()
    local termx, termy = term.getSize()
    term.setCursorPos(8, cursory)
    term.write(text)
    term.setCursorPos(1, cursory)
    term.write("[    ]")
    term.setCursorPos(2, cursory)
    term.setTextColor(color)
    term.write(type)

    if cursory == termy then nextLine = termy else nextLine = cursory + 1 end
    print("")
    term.setCursorPos(1, nextLine)
end

function download(url, file)
    local ok, data, reason = pcall(http.get, url)
    if not ok then return nil, tostring(data) end
    if not data then return nil, tostring(reason or "request failed") end
	local result = data.readAll()
    if type(result) ~= "string" then return nil, "empty response" end
	data.close()
	downloadedFile = fs.open(file , "w")
	downloadedFile.write(result)
	downloadedFile.close()
	return true
end

local function drawStatus(status)
    term.setCursorPos(3, termy)
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)
    term.clearLine()
    term.write(status)
    lastStatus = status
end

local function setTitle(title)
    term.setCursorPos(3, 2)
    term.write(title)
    term.setCursorPos(3, 3)
    term.write(("\x8C"):rep(#(title)))
end
wholeScreen = term.current()

term.setBackgroundColor(colors.blue)
term.clear()
setTitle("Hakiu OS Setup")
drawStatus("Downloading Files")

local logWindow = window.create(term.current(), 4, 6, 40, 10)
logWindow.setBackgroundColour(colours.black)
logWindow.setTextColour(colours.white)
term.redirect(logWindow)

downloadList = fileList["FilesDownload"]

failedDownloads = {}

for i = 1, #downloadList do
    local working, downloadError = true, nil download(downloadList[i][2], downloadList[i][1])
    if working then
        status = " OK "
        statusColor = colors.green
        text = "Downloading: "..downloadList[i][1]
    else
        status = "FAIL"
        statusColor = colors.red
        text = "Error downloading: " .. downloadError .. "while downloading " .. downloadList[i][2]
        table.insert(failedDownloads, {1, downloadList[i][1], downloadList[i][2], downloadError})
        sleep(2)
    end
    printStatus(text, status, statusColor)
    sleep(0.5)
end

term.redirect(wholeScreen)
drawStatus("Configureing Hakiu OS")
term.redirect(logWindow)
term.clear()
term.setTextColor(colors.white)
shell.run("wget run https://raw.githubusercontent.com/Browndog7912/CC-Haiku-OS/refs/heads/main/installer/write-config.lua")

local config = require("/system/apis/config")
config.init()
printStatus("Loading Config API", " OK ", colors.green)

local file = fs.open("/system/config/users.config", "r")
file.readAll()
file.close()

auth = {
    ["auth"] = {
        ["users"] = {
            root = {
                ["username"] = "root",
                ["displayName"] = "root",
                ["password"] = "root",
            },
        },
    },
}

local file = fs.open("/hakosinstaller.config", "w")
file.write(textutils.serialise(defaultAuth))
file.close()



while true do
    sleep(1)
end

