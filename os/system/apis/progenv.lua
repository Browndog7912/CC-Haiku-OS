-- Program Enviroment Builder


-- The builder recives these values

-- processid
-- windowid
-- window
-- focused
-- wm

local progenv = {}

function progenv.init()

end

function progenv.build(contex)
    local env = {}
    local processid = contex.processid
    local windowid = contex.windowid
    local windows = _G.windowFrames
    --locall focused = contex.focused
    local wm = require("/system/apis/wm")

    env.isHakiuOS = true
    env.osData = {
        version = "0.0.1",
        release = "alpha",
        versionType = "home"
    }
    
    -- OSWindow API
    env.oswindow = {
        getId = function()
            return windowid
        end,

        getTitle = function()
            local currentwindow = windows[windowid]
            if currentwindow.title == nil then return nil else return windowid.title end
        end,

        setTitle = function(title)
            local currentwindow = windows[windowid]
            if currentwindow == nil then return false end
            if wm.setWindowTitle then
                return wm.setWindowTitle(windowid, title)
            end
            currentwindow.title = tostring(title)
        end,

        close = function()
            wm.close(windowid)
        end,
    }

    env.windows = windows

    return env
end

return progenv