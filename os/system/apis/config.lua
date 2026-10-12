-- Config API
config = {}

defaultConfig = {
    ["auth"] = {
        ["users"] = {
            root = {
                ["username"] = "root",
                ["displayName"] = "root",
                ["password"] = "root",
            },
        },
    },
    
    ["apperance"] = {
        ["windowTitleBar"] = colors.blue,
        ["windowTitleBarText"] = colors.white,
        ["windowCloseButton"] = colors.red,
        ["windowMinimiseButton"] = colors.yellow,
        ["windowMaximizeButton"] = colors.green,
        ["windowMinimiseForground"] = colors.black,
        ["windowMaximizeForground"] = colors.white,
        ["windowCloseForground"] = colors.white,

        -- Taskbar
        ["taskbarBackground"] = colors.blue,
        ["taskbarClockBackground"] = colors.cyan,
        ["taskbarClockForground"] = colors.white,
        ["taskbarProcessBackground"] = colors.cyan,
        ["taskbarProcessForground"] = colors.white,
        ["startButtonBackground"] = colors.green,
        ["startButtonForground"] = colors.white,

        -- Applications
        --["darktheme"] = false,
        ["windowBackground"] = colors.white,
        ["windowButtonBackground"] = colors.gray,
        ["windowButtonForground"] = colors.white,
        ["windowSurfaceColor"] = colors.gray,
        ["windowSurfaceTextColor"] = colors.white,

        -- Context Menu
        ["contextBackgroundColor"] = colors.gray,
        ["contextTextColor"] = colors.white,
        ["contextInactiveColor"] = colors.lightGray,
    },
    ["desktop"] = {
        ["desktopWallpaperFile"] = "/wallpaper.nfp",
    },
    ["taskbar"] = {
        ["showClock"] = true,
        ["position"] = "bottom",
    },
    ["startmenu"] = {
        ["pinned"] = {
            "notepad",
            "terminal",
            "calculator",
            "calender",
            "cpl",
            "paint"
        }
    },
    ["filetypes"] = {
        ["defaultApp"] = "notepad",
        ["associations"] = {
            txt = "notepad",
            lua = "run",
            json = "notepad",
            md = "notepad",
            log = "notepad",
            nfp = "paint",
            flimg = "paint",
            bimg = "paint",
        },
        ["editors"] = {
            lua = "edit",
            txt = "edit",
            json = "edit",
            md = "edit",
            log = "edit",
            nfp = "paint",
        }
    },
}

kernalDefaultConfig = {
    authsys = "/system/desktop/desktop.lua /system/desktop/newauth.lua",
    logpath = "/system/log/",
    ui = "/system/desktop/desktop.lua",
    tempfolder = "/temp/",
    shell = "/system/shell.lua",
    ["system"] = {
        name = "Hakui OS",
        version = "0.0.1",
    },
}


defaultUserConfig = {
    ["apperance"] = {
        ["windowTitleBar"] = colors.blue,
        ["windowTitleBarText"] = colors.white,
        ["windowCloseButton"] = colors.red,
        ["windowMinimiseButton"] = colors.yellow,
        ["windowMaximizeButton"] = colors.green,
        ["windowMinimiseForground"] = colors.black,
        ["windowMaximizeForground"] = colors.white,
        ["windowCloseForground"] = colors.white,

        -- Taskbar
        ["taskbarBackground"] = colors.blue,
        ["taskbarClockBackground"] = colors.cyan,
        ["taskbarClockForground"] = colors.white,
        ["taskbarProcessBackground"] = colors.cyan,
        ["taskbarProcessForground"] = colors.white,
        ["startButtonBackground"] = colors.green,
        ["startButtonForground"] = colors.white,

        -- Start Menu

        -- Applications
        ["darktheme"] = false,
        ["windowBackground"] = colors.white,
        ["windowButtonBackground"] = colors.gray,
        ["windowButtonForground"] = colors.white,
        ["windowSurfaceColor"] = colors.gray,
        ["windowSurfaceTextColor"] = colors.white,

        -- Context Menu
        ["contextBackgroundColor"] = colors.gray,
        ["contextTextColor"] = colors.white,
        ["contextInactiveColor"] = colors.lightGray,
    },
    ["desktop"] = {
        ["desktopWallpaperFile"] = "/wallpaper.nfp",
    },
    ["taskbar"] = {
        ["showClock"] = true,
        ["position"] = "bottom",
    },
    ["startmenu"] = {
        ["pinned"] = {
            "notepad",
            "terminal",
            "calculator",
            "calender",
            "cpl",
            "paint"
        }
    },
    ["filetypes"] = {
        ["defaultApp"] = "notepad",
        ["associations"] = {
            txt = "notepad",
            lua = "run",
            json = "notepad",
            md = "notepad",
            log = "notepad",
            nfp = "paint",
            flimg = "paint",
            bimg = "paint",
        },
        ["editors"] = {
            lua = "edit",
            txt = "edit",
            json = "edit",
            md = "edit",
            log = "edit",
            nfp = "paint",
        }
    },
}


defaultAuth = {
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

fileIconConfig = {
    ["icons"] = {
        ["dfpwm"] = 15,
        ["lua"] = 42,
        ["txt"] = 20,
        ["dir"] = 143,
        ["rom"] = 143,
        ["def"] = 143,
    },
}

function config.init()
    _G.shell = "/system/shell.lua"
    if not fs.exists("/system/config/system.config") then
        local file = fs.open("/system/config/system.config", "w")
        file.write(textutils.serialise(defaultConfig))
        file.close()
    end
    if not fs.exists("/system/config/users.config") then
        local file = fs.open("/system/config/users.config", "w")
        file.write(textutils.serialise(defaultAuth))
        file.close()
    end
    if not fs.exists("/system/config/kernal.config") then
        local file = fs.open("/system/config/kernal.config", "w")
        file.write(textutils.serialise(kernalDefaultConfig))
        file.close()
    end
    if not fs.exists("/system/config/fileicons.config") then
        local file = fs.open("/system/config/fileicons.config", "w")
        file.write(textutils.serialise(fileIconConfig))
        file.close()
    end

    _G.systemConfigPath = "/system/config/system.config"
end

function config.initUsersConfig()
    if not fs.exists(_G.loginuserDirectory .. "config/settings.config") then
        local file = fs.open(_G.loginuserDirectory .. "config/settings.config", "w")
        file.write(textutils.serialise(defaultUserConfig))
        file.close()
    end

    _G.systemConfigPath = _G.loginuserDirectory .. "config/settings.config"
end

function config.getSystemConfig(rootSystem)
    --[[if rootSystem then
        local file = fs.open("/system/config/system.config", "r")
        if not file then return end
        local content = file.readAll()
        local ok, value = pcall(textutils.unserialize, content)
        if ok and type(value) == "table" then return value end
    else]]
    if not fs.exists(_G.systemConfigPath) then return nil end
    local file = fs.open(_G.systemConfigPath, "r")
    if not file then return end
    local content = file.readAll()
    local ok, value = pcall(textutils.unserialize, content)
    if ok and type(value) == "table" then return value end
    --end
end

function config.setSystemConfig(configData, rootSystem)
    if rootSystem then 
        local file = fs.open("/system/config/system.config", "w")
        file.write(textutils.serialise(configData))
        file.close()
    else
        local file = fs.open(_G.loginuserDirectory .. "config/settings.config", "w")
        file.write(textutils.serialise(configData))
        file.close()
    end
end

function config.saveUserConfig(filename, filedata)
    local file = fs.open(_G.loginuserDirectory .. "config/" .. filename, "w")
    file.write(filedata)
    file.close()
end

function config.getUserConfig(filename)
    local file = fs.open(_G.systemConfigPath, "r")
    if not file then return end
    local content = file.readAll()
    return content
end

function config.getUserConfigFilePath(filename)
    return _G.loginuserDirectory .. "config/" .. filename
end

function config.getInstalledApps()
    local file = fs.open("/system/config/programs.config", "r")
    local text = file.readAll()
    local progs = textutils.unserialise(tostring(text))
    file.close()
    return progs
end


function config.getFileTypes()
    local systemconfig = config.getSystemConfig()
    if systemconfig["filetypes"] == nil then config.configErrorFlag(); return end
    return systemconfig["filetypes"]
end

function config.getFileIcons()
    if fs.exists("/system/config/fileicons.config") == false then config.configErrorFlag("icon"); return end
    local file = fs.open("/system/config/fileicons.config", "r")
    local text = file.readAll()
    local icondata = textutils.unserialise(tostring(text))
    file.close()
    if icondata["icons"] == nil then config.configErrorFlag("icon"); return end
    return icondata["icons"]
end

function config.configErrorFlag(type)
    _G.configErrorFlag = true
end

--[[function config.setConfigSetting(rootSystem, catagory, key, value)
    local config = config.getSystemConfig(rootSystem)
    config[catagory][key] = value
    config.setSystemConfig(rootSystem)
end]]
return config