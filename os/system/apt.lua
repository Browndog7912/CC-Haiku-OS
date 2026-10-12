-- Beta intergration for "Aurora Store "
-- when i was still useing Aurora OS Nake
local args = { ... }

method = args[1]
package = args[2]

function printUsage()

end
osapi.getAPTConfig()
local packageDatabase = _G.aptSource

function getAptData()
    download(packageDatabase, "/temp/apt/pack")
    if fs.exists("/temp/apt/pack") then else return false end
    os.loadAPI("/temp/apt/pack")
end

function getPackage(package)
    local data = pack.getData()
    return data["store"][package]
end

function downloadPackage(package) 
    local data = pack.getData()
    if data["store"][package]["type"] == "command" then
        local command = data["store"][package]["command"]
        

        settings.clear()
        settings.load(_G.aptPackageDatabase)
        settings.set(package, {type = "command"})
        settings.save(_G.aptPackageDatabase)

        shell.run(command)
    end
    if data["store"][package]["type"] == "file" then
        local file = data["store"][package]["fileURL"]
        local savePath = data["store"][package]["filePath"]

        settings.clear()
        settings.load(_G.aptPackageDatabase)
        settings.set(package, {fileURL = file, type = "file", path = savePath})
        settings.save(_G.aptPackageDatabase)
        
        download(file, savePath)
    end
    if data["store"][package]["type"] == "pastebin" then
        local pasteid = data["store"][package]["id"]
        local savePath = data["store"][package]["filePath"]

        settings.clear()
        settings.load(_G.aptPackageDatabase)
        settings.set(package, {pastebinId = pasteid, type = pastebin, path = savePath})
        settings.save(_G.aptPackageDatabase)
        
        download("https://pastebin.com/raw/" .. pasteid, savePath)
    end
end

-- Download File
function download(link, file)
	if http.checkURL(link) ~= true then
		return false 
	end
	local url = http.get(link)
	local result = url.readAll()
	if result ~= nil then
		newFile = fs.open(file , "w")
		newFile.write(result)
		newFile.close()
	else
		osapi.log("osapi-func","dl:retrieve=nil",3)
		rc = rc + 1
		os.sleep(3)
	end
	end
	if rc == 3 and realurl == true then osapi.log("osapi-func","E:dl:failed",1) return false
end

if args[1] == "install" then
    if args[2] == null or args[2] == "" then
        printUsage()
    end
    getAptData()
    print("downloading "..args[2].." from apt")
    downloadPackage(args[2])
end
