-- processAPI API
processAPI = {}
local wm = require("/system/apis/wm")
local config = require("/system/apis/config")
local termx, termy = term.getSize()
function processAPI.init()
    _G.proceses = {}
    -- How the values are layed out 
    --[[
    {
        [1] = { -- ID is 1
            id=1, -- The processes ID
            mainwindowid = 1, -- the main proceses main window
        }
    }
    ]]
end

function processAPI.startWindowProcess(programid, args)
    local processID = #_G.proceses + 1
    table.insert(_G.proceses, { id = processID, wmId = 0 })
    local installedApps = config.getInstalledApps()
    local programPath = installedApps[programid]
    if programPath == nil then return "Invalid Path" end
    if not fs.exists(programPath) then return "Path not found!" end
    local file = fs.open(programPath, "r")
    local text = file.readAll()
    local progdata = textutils.unserialise(tostring(text))
    if progdata["exe"] == nil then return "Invalid Program Data" end
    local title = progdata["title"]
    --if progdata["title"] == nil then local title = "Application" end 
    wm.drawWindowApplication(progdata["exe"], title, termx, termy - 1, 1, 1, processID, args)
end

function processAPI.startWindowProcessNoID(programid)
    --print(#_G.proceses)
    --table.insert(_G.proceses, { id = #_G.proceses + 1 })
    local termx, termy = term.getSize()

    wm.drawWindowApplication(programid, "Test Application", termx, termy - 1, 1, 1)
end
return processAPI