-- osapi main functions
-- load configuration values
function loadconfig()
	-- default values, we override these with the config in the config files.
	_G.kernalConfig = "/config/kernel.lua" -- default config file, can't be
	_G.colorConfig = "/config/color.lua"
	_G.shell = "/system/shell.lua" -- default shell to launch, system wide
	_G.userInterface = "/system/shell.lua" -- default user interface, system wide
	_G.shellui = "/system/shell.lua"
	_G.logPath = "/var/log/" -- directory for logs
	_G.oslogmode = 0 -- mode for log system, 0=disabled,1=error,2=warning,3=debug
	_G.crashhandler = true -- if crash handler is on or off
	_G.loginMode = false -- if login mode is on or off
	_G.userData = "/system/data/users/" -- where user data is stored
	_G.userHomeData = "/home/"
	_G.authsys = "/system/login.lua" -- default login script
	_G.osAuthentificationFunction = osapi -- default login function
	_G.aptPackageDatabase = "/config/apt/packages.db"
	_G.aptConfig = "/config/apt/config.lua"
	_G.aptSource = "https://raw.githubusercontent.com/JV-lab-create/CC-APIS/refs/heads/main/apis/auroraget/packages.lua"
	_G.tempFolder = "/temp/" -- temp file folder
	_G.audoUpdate = 0 -- auto update interval, 0=disabled
	_G.osProductName = "Haiku OS"
	_G.version = "1.0.0" -- set A value for version in case something go's foobar
	_G.textColor = colours.green -- regular text color
	_G.backgroudColor = colours.black -- background color
	_G.highlightColor = colours.orange -- promt/system text color
	-- look for config file and override default settings
	if fs.exists(_G.kernalConfig) then
        settings.clear()
        settings.load(_G.kernalConfig)
        _G.shell = settings.get("shell") 
        _G.userdata = settings.get("shell") 
        _G.tempfolder = settings.get("tempfolder") 
        _G.authsys = settings.get("authsys") 
        _G.crashhandler = settings.get("crashhandler") 
        _G.shellui = settings.get("ui") 
        _G.audoUpdate = settings.get("automaticSystemUpdate") 
        _G.aptconfig = settings.get("aptconfig")
        _G.aptinstall = settings.get("aptinstall")
        _G.loginMode = settings.get("loginMode")
	end
	return true
end

-- input url and file location, downloads url as file
function download(url, file)
	if http.checkURL(url) == true then rr = true osapi.log("osapi-func","dl:checkurl=true",3)
	else return false end
	while rc ~= 3 and rr == true do
		local data = http.get(url)
		local result = data.readAll()
		data.close()
		if result ~= nil then
			downloadedFile = fs.open(file , "w")
			downloadedFile.write(result)
			downloadedFile.close()
			return true
		else
			os.sleep(3)
			return false
		end
	end
end

function login(username, password)
	if _G.loginMode == false then
		return true
	end
	if fs.exists(_G.userData..username..".db") then
		local userfile = fs.open(_G.userData.."/"..username..".db", "r")
		userdata = userfile.readLine()
		userfile.close()
		if password == userdata then
			_G.oslogin = username
			_G.ospass = password
			_G.osisallowed = true
			_G.osisadmin = true

			_G.loginuserDirectory = _G.userHomeData .. username .. "/"

			return true
		end
	end
	return false
end

-- make user
function useradd(username, password)
	if fs.exists(_G.userData..username..".db") then return "user aredy exists" end
	local userfile = fs.open(_G.userData.."/"..username..".db","w")
	userfile.writeLine(password)
	userfile.close()
	return "user was added!"
end
-- delete user
function userdel(username)
	if fs.exists(_G.userData.."/"..username..".db") ~= true then
		return "user douse not exist"
	end

	fs.delete(_G.userData.."/"..username..".db") return "user was deleted!"
end
-- change password
function passwd(username, password)
	if fs.exists(_G.userData.."/"..username..".db") ~= true then
		return "user douse not exist"
	end

	fs.delete(_G.userData.."/"..username..".db")
	local tf = fs.open(_G.userData.."/"..username..".db","w")
	tf.writeLine(password)
	tf.close()
	return "user password was changed"
end

function log(f,m,l)
	
end

-- find a device
function perfind(type)
	if(peripheral.getType("top")) == type then
		return "top"
	elseif(peripheral.getType("back")) == type then
		return "back"
	elseif(peripheral.getType("bottom")) == type then
		return "bottom"
	elseif(peripheral.getType("right")) == type then
		return "right"
	elseif(peripheral.getType("left")) == type then
		return "left"
	elseif(peripheral.getType("front")) == type then
		return "front"
	else
		return "NONE"
	end
end

function initPeriferals() 
	_G.peripheralDisk = "NONE"
	_G.peripheralModem = "NONE"
	_G.peripheralPrinter = "NONE"
	_G.peripheralMonitor  = "NONE"
	_G.peripheralSpeaker  = "NONE"
	_G.peripheralComputer  = "NONE"
	_G.peripheralRedstoneRelay  = "NONE"
	_G.wirelessModem = false
	

	if fs.exists("/config/peripherals.lua") then
		settings.clear()
		settings.load("/config/peripherals.lua")
		_G.peripheralDisk = settings.get("peripheralDisk")
		_G.peripheralModem = settings.get("peripheralModem")
		_G.peripheralPrinter = settings.get("peripheralPrinter")
		_G.peripheralMonitor  = settings.get("peripheralMonitor")
		_G.peripheralSpeaker  = settings.get("peripheralSpeaker")
		_G.peripheralComputer  = settings.get("peripheralComputer")
	else
		settings.clear()
		settings.load("/config/peripherals.lua")

		_G.peripheralDisk = perfind("drive")
		_G.peripheralModem = perfind("modem")
		_G.peripheralPrinter = perfind("printer")
		_G.peripheralMonitor  = perfind("monitor")
		_G.peripheralSpeaker  = perfind("speaker")
		_G.peripheralComputer  = perfind("computer")

		connectPeripheralItem(_G.peripheralDisk, "drive", "peripheralDisk")
		connectPeripheralItem(_G.peripheralModem, "modem", "peripheralModem")
		connectPeripheralItem(_G.peripheralPrinter, "printer", "peripheralPrinter")
		connectPeripheralItem(_G.peripheralMonitor, "monitor", "peripheralMonitor")
		connectPeripheralItem(_G.peripheralSpeaker, "speaker", "peripheralSpeaker")
		connectPeripheralItem(_G.peripheralComputer, "computer", "peripheralComputer")
	end

	settings.save("/config/peripherals.lua")
end

function loadPeripheral()

end


function connectPeripheralItem(connectedPeripheral, periftype, settingtoset)
	if connectedPeripheral == "NONE" then
		settings.set(settingtoset, "NONE")
	end
	if peripheral.isPresent(connectedPeripheral) then
		settings.set(settingtoset, "NONE")
	end

	if peripheral.hasType(connectedPeripheral, periftype) then
		settings.set(settingtoset, connectedPeripheral)
		if periftype == "modem" then
			local modem = peripheral.wrap("top")
			settings.set("WirelessModem", modem.isWireless())
		end
	end
end


function getAPTConfig()
	_G.aptPackageDatabase = "/config/apt/packages.db"
	_G.aptConfig = "/config/apt/config.lua"
	_G.aptSource = "https://raw.githubusercontent.com/JV-lab-create/CC-APIS/refs/heads/main/apis/auroraget/packages.lua"
	settings.load(_G.aptConfig)
	_G.aptSource = settings.get("source")
end

function saveuser()
	_G.su = {_G.oslogin, _G.ospass, _G.osisallowed, _G.osisadmin, _G.oshomefolder, 				_G.ostxtcolor, _G.osbgcolor, _G.ossyscolor}
	return _G.su
end

function halt()
	os.shutdown()
end

function restart()
	os.reboot()
end

--[[ file functions
-- read a file for "c", returns what is after m
function getconf(f,c,m)
	expect(1,f,"string")
	expect(2,c,"string")
	expect(3,m,"string")
    if fs.exists(f) then
		osapi.log("osapi-func","getconf:f:"..f.." c:"..c.." m:"..m,3)
        local tln = osapi.findline(f,c)
        if tln ~= false then
            local tld = osapi.printline(f,tln)
            local l = osapi.findchar(tld,m)
            local r = string.sub(tld, l + 1)
            return r
        end
    end
    osapi.log("osapi-func","E:getconf:nofile",1)
    return false
end
-- input a file, returns how many lines it contains
function countline(fln)
	expect(1, fln, "string")
	osapi.log("osapi-func","i:countline:file"..fln,3)
	if fs.exists(fln) == false then osapi.log("E:osapi-func","cl:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("E:osapi-func","cl:isdir",1) return false end
	osapi.log("osapi-func","cl:open:"..fln,2)
	local tmf = fs.open(fln , "r")
	local lc = 0
	local l = tmf.readLine()
	while l ~= nil do
		osapi.log("osapi-func","cl:l:"..l,3)
		if l ~= nil then lc = lc + 1 end
		l = tmf.readLine()
	end
	tmf.close()
	osapi.log("osapi-func","cl:end",3)
	return lc
end
-- input a file and a search string, returns false or line number, searches for parts of string
function findline(fln,t)
	expect(1, fln, "string")
	expect(2, t, "string")
	osapi.log("osapi-func","findline:"..fln.." t:"..t,3)
	if fs.exists(fln) == false then osapi.log("E:osapi-func","fl:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("E:osapi-func","fl:isdir",1) return false	end
	osapi.log("osapi-func","fl:open:"..fln,2)
	local ln = 1
	local tmf = fs.open(fln , "r")
	local l = "start"
	while l ~= nil do
		osapi.log("osapi-func","fl:l:"..l,3)
		if string.find(l, t) ~= nil then
			tmf.close()
			ln = ln - 1
			osapi.log("osapi-func","fl:target:"..ln,2)
			return ln
		end
		l = tmf.readLine()
		ln = ln + 1
	end
	tmf.close()
	osapi.log("osapi-func","fl:target:notfound",2)
	return false
end
-- file contains, returns true or false, searches for exact string
function filecontains(fln, t)
	expect(1, fln, "string")
	expect(2, t, "string")
	osapi.log("osapi-func","fc:fln:"..fln.." t:"..t,3)
	if fs.exists(fln) == false then osapi.log("E:osapi-func","fc:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("E:osapi-func","fc:isdir",1) return false	end
	osapi.log("osapi-func","fc:open:"..fln,2)
	local tmf = fs.open(fln , "r")
	local l = "start"
	while l ~= nil do
		osapi.log("osapi-func","fc:l:"..l,3)
		l = tmf.readLine()
		if l == t then
			osapi.log("osapi-func","fc:targetfound:"..l,2)
			tmf.close()
			return true
		end
	end
	osapi.log("osapi-func","fc:targetnotfound",2)
	tmf.close()
	return false
end
-- input search string, searches hard disk for string
function findfile(fln)
	expect(1, fln, "string")
	osapi.log("osapi-func","ff:file:"..fln,3)
	osapi.lsr("/")
	local ln = 1
	osapi.log("osapi-func","ff:read:".._G.ostempfolder.."/ls/files.ls",3)
	local tmf = fs.open(_G.ostempfolder.."/ls/files.ls","r")
	local l = "start"
	local h = 0
	local rt = { }
	rt[1] = "noresult"
	while l ~= nil do
		l = tmf.readLine()
		if l ~= nil then
			if string.find(l,fln) ~= nil then
				osapi.log("osapi-func","ff:hit:"..ln..":"..l,3)
				h = h + 1
				rt[h] = ln
			end
		end
		ln = ln + 1
	end
	osapi.log("osapi-func","ff:end",3)
	tmf.close()
	return rt
end
-- input file and linenumber, outputs contents of said line
function printline(fln, ln)
	expect(1, fln, "string")
	expect(2, ln, "number")
	osapi.log("osapi-func","pl:"..fln.." ln:"..ln,3)
	if fs.exists(fln) == false then osapi.log("osapi-func","E:pl:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("osapi-func","E:pl:isdir",1) return false	end
	osapi.log("osapi-func","pl:open:"..fln,2)
	local tmf = fs.open(fln , "r")
	local lc = 0
	local l = "start"
	while lc ~= ln and l ~= nil do
		osapi.log("osapi-func","pl:hit:printline",3)
		l = tmf.readLine()
		lc = lc + 1
	end
	tmf.close()
	osapi.log("osapi-func","pl:end",3)
	return l
end
-- input file and linenumber, removes line from file
function removeline(fln, ln)
	expect(1, fln, "string")
	expect(2, ln, "number")
	osapi.log("osapi-func","rl:file:"..fln.." l:"..ln,3)
	if fs.exists(fln) == false then osapi.log("osapi-func","E:rl:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("osapi-func","E:rl:isdir",1) return false	end
	osapi.log("osapi-func","rl:open:"..fln,2)
	local tmf = fs.open(fln, "r")
	local nwf = fs.open(_G.ostempfolder.."/dev/removeline.tmp","w")
	local l = "start"
	local c = 0
	while l ~= nil do
		c = c + 1
		l = tmf.readLine()
		if l ~= nil and c ~= ln then nwf.writeLine(l)
		else osapi.log("osapi-func","rl:found:"..ln,2) end
	end
	tmf.close()
	nwf.close()
	fs.delete(fln)
	fs.move(_G.ostempfolder.."/dev/removeline.tmp",fln)
	osapi.log("osapi-func","rl:end",3)
	return true
end
-- input file and string, removes string from file
function removestring(fln, s)
	expect(1, fln, "string")
	expect(2, s, "string")
	osapi.log("osapi-func","rs:file:"..fln.." s:"..s,3)
	if fs.exists(fln) == false then osapi.log("osapi-func","E:rs:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("osapi-func","E:rs:isdir",1) return false end
	osapi.log("osapi-func","rs:open:"..fln,2)
	local tmf = fs.open(fln, "r")
	local nwf = fs.open(_G.ostempfolder.."/dev/removeline.tmp","w")
	local l = "start"
	while l ~= nil do
		l = tmf.readLine()
		if l ~= nil and l ~= s then nwf.writeLine(l)
		else osapi.log("osapi-func","rs:targetfound:",3) end
	end
	tmf.close()
	nwf.close()
	fs.delete(fln)
	fs.move(_G.ostempfolder.."/dev/removeline.tmp",fln)
	osapi.log("osapi-func","rs:end",3)
	return true
end
-- input file, og string and replace string, replaces og string with replace string
function replaceline(fln,i, o)
	expect(1, fln, "string")
	expect(2, i, "string")
	expect(3, o, "string")
	osapi.log("osapi-func","rpl:file:"..fln.." i:"..i.." o:"..o,3)
	if fs.exists(fln) == false then osapi.log("osapi-func","E:rpl:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("osapi-func","E:rpl:isdir",1) return false end
	osapi.log("osapi-func","E:rpl:open:"..fln,2)
	local tmf = fs.open(fln,"r")
	local nwf = fs.open(_G.ostempfolder.."/dev/removeline.tmp","w")
	local l = "start"
	while l ~= nil do
		l = tmf.readLine()
		if l ~= nil and l ~= i then nwf.writeLine(l) end
		if l == i then nwf.writeLine(o) r = true osapi.log("osapi-func","rpl:Target:l:"..l,3) end
	end
	tmf.close()
	nwf.close()
	fs.delete(fln)
	fs.move(_G.ostempfolder.."/dev/removeline.tmp",fln)
	osapi.log("osapi-func","rpl:end",3)
	if r == true then return true
	else return false
	end
end
-- input file and string, adds string to file
function insertline(fln, i)
	expect(1, fln, "string")
	expect(2, i, "string")
	osapi.log("osapi-func","il:file:"..fln.." i:"..i,3)
	if fs.isDir(fln) == true then osapi.log("osapi-func","il:E:isdir",1) return false end
	osapi.log("osapi-func","il:open:"..fln,3)
	local tmf = fs.open(fln,"a")
	tmf.writeLine(i)
	tmf.close()
	osapi.log("osapi-func","il:end",3)
	return true
end
-- input file and table, writes table to file
function writetable(fln, d)
	expect(1,fln, "string")
	expect(2,d, "table")
	osapi.log("osapi-func","wt:file:"..fln,3)
	if fs.isDir(fln) == true then osapi.log("osapi-func","E:wt:isdir",1) return false end
	osapi.log("osapi-func","wt:open:",3)
	local tmf = fs.open(fln, "w")
	local tc = 1
	while d[tc] ~= nil do
		tmf.writeLine(d[tc])
		tc = tc + 1
	end
	tmf.close()
	osapi.log("osapi-func","wt:end",3)
	return true
end
-- input file, returns file as table
function readtable(fln)
	expect(1,fln, "string")
	osapi.log("osapi-func","rtb:file:"..fln,3)
	if fs.exists(fln) == false then osapi.log("osapi-func","E:rtb:noexist",1) return false
	elseif fs.isDir(fln) == true then osapi.log("osapi-func","E:rtb:isdir",1) return false end
	osapi.log("osapi-func","rtb:open:"..fln,3)
	local tmf = fs.open(fln, "r")
	local tc = 1
	local d = {}
	d[1] = tmf.readLine()
	while d[tc] ~= nil do
		tc = tc + 1
		d[tc] = tmf.readLine()
	end
	osapi.log("osapi-func","rtb:end",3)
	tmf.close()
	return d
end

-- input folder, returns contents recursive (ls -r)
function lsr(ptn)
	expect(1, ptn, "string")
	if fs.exists(ptn) == false then return false end
	if fs.isDir(ptn) == false then return false end
	if fs.exists(_G.ostempfolder.."/ls/files.ls") then fs.delete(_G.ostempfolder.."/ls/files.ls") end
	if fs.exists(_G.ostempfolder.."/ls/todo") then fs.delete(_G.ostempfolder.."/ls/todo") end
	local lsfc = 0
	osapi.list(ptn,lsfc)
	local tdff = "start"
	while tdff ~= nil and tofolderfile ~= "" and fs.exists(_G.ostempfolder.."/ls/todo/") do
		local todofolderlist = fs.list(_G.ostempfolder.."/ls/todo/")
		tdff = todofolderlist[1]
		if tdff ~= nil then
			if fs.exists(_G.ostempfolder.."/ls/todo/"..tdff) then
				local line = "start"
				local todofile = fs.open(_G.ostempfolder.."/ls/todo/"..tdff , "r")
				while line ~= nil do
					line = todofile.readLine()
					if line ~= nil then osapi.list(line, lsfc) end
				end
				todofile.close()
				fs.delete(_G.ostempfolder.."/ls/todo/"..tdff)
			end
		else
			tdff = nil
		end
		lsfc = lsfc + 1
	end
	local returndata = osapi.readtable(_G.ostempfolder.."/ls/files.ls")
	return returndata
end
-- internal function
function list(ptn, lsfc)
	expect(1,ptn, "string")
	expect(2,lsfc,"number")
	local tempfile = fs.list(ptn)
	local count = 1
	local fln = tempfile[count]
	local fls = fs.open(_G.ostempfolder.."/ls/files.ls" , "a")
	while fln ~= nil do
		if fs.isDir(ptn..fln) then
			local folderfile = fs.open(_G.ostempfolder.."/ls/todo/"..lsfc..".ls" , "a")
			folderfile.writeLine(ptn..fln.."/")
			folderfile.close()
			count = count + 1
			fln = tempfile[count]
		elseif fs.exists(ptn..fln) then
			fls.writeLine(ptn..fln)
			count = count + 1
			fln = tempfile[count]
		else fln = nil end
	end
	fls.close()
	return tempfile
end
-- input location, outputs detailed contents of folder (ls -a)
function lsa(ptn)
	expect(1,ptn,"string")
	local tempfile = fs.list(ptn)
	local count = 1
	local fln = tempfile[count]
	local fls = fs.open(_G.ostempfolder.."/ls/a.ls" , "w")
	while fln ~= nil do
		if fs.isDir(ptn..fln) then
			fls.writeLine("DIR:"..ptn..fln)
			count = count + 1
			fln = tempfile[count]
		elseif fs.exists(ptn..fln) then
			local filesize = fs.getSize(ptn..fln)
			fls.writeLine("File:"..ptn..fln.." "..filesize.."b")
			count = count + 1
			fln = tempfile[count]
		else fln = nil end
	end
	fls.writeLine("Free space:"..fs.getFreeSpace(ptn).." bytes")
	fls.close()
	local returndata osapi.readtable(_G.ostempfolder.."/ls/a.ls")
	return returndata
end
-- string functions
-- find target char and return location in string
function findchar(s,t)
	expect(1,s,"string")
	expect(2,t,"string")
	osapi.log("osapi-func","fc:s:"..s.." t:"..t,3)
	local run = true
	local d = false
	local c = 1
	while run == true do
		local r = string.sub(s,c,c)
		if r == t then
			osapi.log("osapi-func","fc:found:"..c,3)
			run = false
			d = c
		end
		if r == nil then run = false end
		c = c + 1
	end
	osapi.log("osapi-func","fc:end",3)
	return d
end
-- table functions
-- same as filecontains but for a table
function tablecontains(t, v, s)
	expect(1, t, "table")
	expect(2, v, "string")
	expect(3, s, "number", "nil")
	osapi.log("osapi-func","tbc:start",3)
    local c = 0
    if not s then s = 1 end
    for k, a in pairs(t) do
        if a == v then c = c + 1 end
        if c == s then return k end
    end
    osapi.log("osapi-func","tbd:stop",3)
    return false
end
-- same as file line count but for a table
function tablecount(t)
	expect(1,t,"table")
	osapi.log("osapi-func","tbc:start",3)
	local k = true
	local s = 0
	local n = 0
	while k == true do
		n = s + 1
		if t[n] ~= nil then
			s = s + 1
		else
			k = false
		end
	end
	osapi.log("osapi-func","tbc:end",3)
	return s
end
-- system hardware functions
-- shut down and mark crashhandler
function halt()
	osapi.log("osapi-func","halt!",3)
	t = fs.open("/etc/osapi-main/boot/fail3.tmp" ,"w")
	t.write("0")
	t.close()
	os.shutdown()
end
-- restart and mark crashhandler
function restart()
	osapi.log("osapi-func","reboot!",3)
	t = fs.open("/etc/osapi-main/boot/fail3.tmp" ,"w")
	t.write("0")
	t.close()
	os.reboot()
end
-- random number generator
function rng(i)
	expect(1, i, "number", "nil")
	if i == nil or i == 0 then i = 1 end
	if _G.osrngnr == nil or _G.osrngnr == false or _G.osrngnr == 0 then _G.osrngnr = 1 end
	_G.osrngnr = _G.osrngnr + 1
	local r = _G.osrngnr * i * os.getComputerID() * (os.time() * 1000)
	return r
end
-- disable screen output
function disableoutput()
  d = window.create(term.current(), 1, 1, 1, 1, false);
  o = term.current();
  term.redirect(d);
  return o
end
-- enable screen output
function enableoutput(o)
  term.redirect(o);
end
-- find a device
function perfind(type)
	expect(1, type, "string")
	if(peripheral.getType("top")) == type then
		return "top"
	elseif(peripheral.getType("back")) == type then
		return "back"
	elseif(peripheral.getType("bottom")) == type then
		return "bottom"
	elseif(peripheral.getType("right")) == type then
		return "right"
	elseif(peripheral.getType("left")) == type then
		return "left"
	elseif(peripheral.getType("front")) == type then
		return "front"
	else
		return "NONE"
	end
end
-- print on the monitor quick and dirty
function monitorprint(p)
	expect(1, p, "string", "number")
	if _G.monitorside == "NONE" then return false end
	if p == nil or p == "" then return false end
	local o = term.redirect(_G.monitor)
	print(p)
	term.redirect(o)
	return true
end
-- log system, f = filename, m = log contents, l = level: 0=disabled 1=error 2=notice 3=debug
function log(f,m,l)
	expect(1,f,"string")
	expect(2,m,"string")
	expect(3,l,"number")
	-- if logmode is not enabled, don't log
	if type(_G.oslogmode) ~= "number" then return end
	if _G.oslogmode == 0 then return true end
	-- if it is, log if required.
	local tf = fs.open(_G.oslogpath.."/"..f,"a")
	if _G.oslogmode >= l then tf.writeLine(m) end
	tf.close()
	return true
end
-- user account section
-- user check, check a password without actually logging in.
function usercheck(u,p)
	expect(1, u, "string")
	expect(2, p, "string")
	osapi.log("osapi-func","uc:"..u,2)
	if _G.loginMode == false then osapi.log("osapi-func","uc:login=false",2) return true end
	if fs.exists(_G.userData..u..".db") then
		osapi.log("osapi-func","uc:u:found",3)
		local tf = fs.open(_G.userData.."/"..u..".db", "r")
		tp = tf.readLine()
		tf.close()
		if p == tp then
			osapi.log("osapi-func","uc:pass=true",2)
			local r = {true}
			if u == "root" then r[2] = true
			else r[2] = false end
		end
	end
	osapi.log("osapi-func","uc:end",3)
	return r
end
-- login system, input username and password, returns true or false
function login(u, p)
	expect(1, u, "string")
	expect(2, p, "string")
	osapi.log("osapi-func","login:"..u,2)
	if _G.loginMode == false then return true end
	if fs.exists(_G.userData..u..".db") then
		osapi.log("osapi-func","login:exists",3)
		local tf = fs.open(_G.userData.."/"..u..".db", "r")
		tp = tf.readLine()
		tf.close()
		if p == tp then
			osapi.log("osapi-func","login:accept",2)
			_G.oslogin = u
			_G.ospass = p
			_G.osisallowed = true
			if u == "root" then _G.osisadmin = true
			else _G.osisadmin = false end
			return true
		end
		osapi.log("osapi-func","login:wrongpass",2)
	else osapi.log("osapi-func","login:noexist",2) end
	osapi.log("osapi-func","login:denied",2)
	return false
end
-- save and restore user, for temp login.
function restoreuser(data)
	expect(1,data,"table","nil")
	if data ~= nil then
		_G.oslogin = data[1]
		_G.ospass = data[2]
		_G.osisallowed = data[3]
		_G.osisadmin = data[4]
		_G.oshomefolder = data[5]
		_G.ostxtcolor = data[6]
		_G.osbgcolor = data[7]
		_G.ossyscolor = data[8]
	else
		_G.oslogin = _G.su[1]
		_G.ospass = _G.su[2]
		_G.osisallowed = _G.su[3]
		_G.osisadmin = _G.su[4]
		_G.oshomefolder = _G.su[5]
		_G.ostxtcolor = _G.su[6]
		_G.osbgcolor = _G.su[7]
		_G.ossyscolor = _G.su[8]
	end
	return true
end
-- make user
function useradd(u,p)
	expect(1, u, "string")
	expect(2, p, "string")
	if _G.loginMode ~= true then return 201 end
	if _G.osisadmin ~= true then return 204 end
	if fs.exists(_G.userData..u..".db") then return 202 end
	local tf = fs.open(_G.userData.."/"..u..".db","w")
	tf.writeLine(p)
	tf.close()
	return 200
end
-- delete user
function userdel(u)
	expect(1, u, "string")
	if _G.loginMode ~= true then return 201 end
	if _G.osisadmin ~= true or _G.oslogin == u then return 204 end
	if fs.exists(_G.userData.."/"..u..".db") ~= true then return 203 end
	fs.delete(_G.userData.."/"..u..".db") return 200
end
-- change password
function passwd(u,p)
	expect(1, u, "string")
	expect(2, p, "string")
	if _G.loginMode ~= true then return 201 end
	if _G.osisadmin ~= true and _G.oslogin ~= u then return 204 end
	if fs.exists(_G.userData.."/"..u..".db") ~= true then return 203 end
	fs.delete(_G.userData.."/"..u..".db")
	local tf = fs.open(_G.userData.."/"..u..".db","w")
	tf.writeLine(p)
	tf.close()
	return 200
end
-- config options, set login mode
function setlogin(s)
	expect(1, s, "string")
	if s ~= "true" and s ~= "false" then return 307 end
	if _G.osisadmin ~= true then return 304 end
	if s == "true" then
		if _G.loginMode == true then return 301 end
		osapi.replaceline(_G.kernalConfig,"login=false","login=true")
		_G.loginMode = true
		return 300
	elseif s == "false" then
		if _G.loginMode ~= true then return 302 end
		osapi.replaceline(_G.kernalConfig,"login=true","login=false")
		_G.loginMode = false
		return 300
	else
		return 303
	end
end
-- set default shell
function setshell(s)
	expect(1, s, "string")
	if _G.osisadmin ~= true then return 304 end
	if fs.exists(s) ~= true then return 305 end
	_G.osdshell = s
    local templnr = osapi.findline(_G.kernalConfig,"shell=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"shell="..s)
    return 300
end
-- set default user interface
function setsui(s)
	expect(1, s, "string")
	if _G.osisadmin ~= true then return 304 end
	if fs.exists(s) ~= true then return 305 end
	_G.ossui = s
    local templnr = osapi.findline(_G.kernalConfig,"ui=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"ui="..s)
    return 300
end
-- set default ui - this is a user specific setting
function setui(s)
	expect(1, s, "string")
	if fs.exists(s) ~= true then return 305 end
	_G.osdui = s
    local templnr = osapi.findline(_G.oshomefolder.."/osapi/config/user.cfg","dui=")
    if templnr ~= false then
		osapi.removeline(_G.oshomefolder.."/osapi/config/user.cfg",templnr)
    end
    osapi.insertline(_G.oshomefolder.."/osapi/config/user.cfg","dui="..s)
    return 300
end
-- set logpath
function setlogpath(p)
	expect(1,p,"string")
	if fs.isDir(p) ~= true then return 306 end
	if _G.osisadmin ~= true then return 304 end
	_G.oslogpath = p
    local templnr = osapi.findline(_G.kernalConfig,"logpath=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"logpath="..p)
    return 300
end
-- set logmode
function setlogmode(p)
	expect(1,p,"string","number")
	if type(p) == "string" then p = tonumber(p) end
	if p == nil then return 307 end
	if _G.osisadmin ~= true then return 304 end
	if p ~= 0 and p ~= 1 and p ~= 2 and p ~= 3 then return 307 end
	_G.oslogmode = p
	local templnr = osapi.findline(_G.kernalConfig,"logmode=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"logmode="..p)
    return 300
end
-- mapt repo source list
function setmaptsource(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	_G.osmaptsource = p
    local templnr = osapi.findline(_G.kernalConfig,"maptsource=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"maptsource="..p)
    return 300
end
-- mapt installed list
function setmaptinstalled(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	_G.osmaptinstall = p
    local templnr = osapi.findline(_G.kernalConfig,"maptinstalled=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"maptinstalled="..p)
    return 300
end
-- user data location
function setuserdata(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	_G.userData = p
    local templnr = osapi.findline(_G.kernalConfig,"userdata=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"userdata="..p)
    return 300
end
-- temp file location
function settempfolder(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	_G.ostempfolder = p
    local templnr = osapi.findline(_G.kernalConfig,"tempfolder=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"tempfolder="..p)
    return 300
end
-- auto update setting
function setupdate(tp)
	expect(1,tp,"string")
	if _G.osisadmin ~= true then return 304 end
	local p = tonumber(tp)
	_G.osupdate = p
    local templnr = osapi.findline(_G.kernalConfig,"update=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"update="..p)
    return 300
end
-- login system path - the login binary the user would call in command line
function setauthsys(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	if fs.exists(p) ~= true then return 308 end
	_G.authsys = p
    local templnr = osapi.findline(_G.kernalConfig,"authsys=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"authsys="..p)
    return 300
end
-- login system function - the lua function
function setauthfun(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	fs.delete("/etc/osapi-main/sys/login.tmp")
	osapi.insertline("/etc/osapi-main/sys/login.tmp","_G.osauthfun = "..p)
	os.run({},"/etc/osapi-main/sys/login.tmp")
	if _G.osauthfun then
		fs.delete("/etc/osapi-main/sys/login.d")
		osapi.insertline("/etc/osapi-main/sys/login.d","_G.osauthfun = "..p)
		os.run({},"/etc/osapi-main/sys/login.d")
		return 300
    else
    return 308 end
end
-- crash handler
function setcrashhandler(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	if p ~= "true" and p ~= "false" then return 308 end
	if p == "true" then _G.oscrashh = true
	else _G.oscrashh = false end
    local templnr = osapi.findline(_G.kernalConfig,"crashhandler=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"crashhandler="..p)
    return 300
end
-- mapt manifest file path
function setmaptmfpath(p)
	expect(1,p,"string")
	if _G.osisadmin ~= true then return 304 end
	if fs.exists(p) ~= true then return 308 end
	_G.osmaptmfpath = p
    local templnr = osapi.findline(_G.kernalConfig,"maptmfpath=")
    if templnr ~= false then
		osapi.removeline(_G.kernalConfig,templnr)
    end
    osapi.insertline(_G.kernalConfig,"maptmfpath="..p)
    return 300
end
-- color, user setting. loads when a user logs in.
function setcolor(t,c)
	expect(1,t,"string")
	expect(2,c,"string")
	if t ~= "bc" and t ~= "tc" and t ~= "sc" then return 101 end
	if c ~= "white" and c ~= "orange" and c ~= "magenta" and c ~= "lightBlue" and c ~= "yellow" and c ~= "lime" and c ~= "pink" and c ~= "gray" and c ~= "lightGray" and c ~= "cyan" and c ~= "purple" and c ~= "blue" and c ~= "brown" and c ~= "green" and c ~= "red" and c ~= "black" then return 102 end
	local l = osapi.findline(_G.oshomefolder.."/osapi/config/color.cfg",t.."=")
	if l ~= false then osapi.removeline(_G.oshomefolder.."/osapi/config/color.cfg",l) end
	osapi.insertline(_G.oshomefolder.."/osapi/config/color.cfg",t.."="..c)
	if t == "bg" then _G.osbgcolor = c
	elseif t == "tc" then _G.ostxtcolor = c
	elseif t == "sc" then _G.ossyscolor = c end
	return 100
end
function setsyscolor(t,c)
	expect(1,t,"string")
	expect(2,c,"string")
	if t ~= "bc" and t ~= "tc" and t ~= "sc" then return 101 end
	if c ~= "white" and c ~= "orange" and c ~= "magenta" and c ~= "lightBlue" and c ~= "yellow" and c ~= "lime" and c ~= "pink" and c ~= "gray" and c ~= "lightGray" and c ~= "cyan" and c ~= "purple" and c ~= "blue" and c ~= "brown" and c ~= "green" and c ~= "red" and c ~= "black" then return 102 end
	local l = osapi.findline("/etc/osapi-main/config/color.cfg",t.."=")
	if l ~= false then osapi.removeline("/etc/osapi-main/config/color.cfg",l) end
	osapi.insertline("/etc/osapi-main/config/color.cfg",t.."="..c)
	return 100
end

]]
function getcolor()
	-- first default so we always reply
	_G.ostxtcolor = colors.white
	_G.osbgcolor = colors.black
	_G.ossyscolor = colors.blue
end

function transcolor(color)
	expect(1,color, "string")
	local result = false
	if color == "white" then result = colors.white
	elseif color == "orange" then result = colors.orange
	elseif color == "magenta" then result = colors.magenta
	elseif color == "lightBlue" then result = colors.lightBlue
	elseif color == "yellow" then result = colors.yellow
	elseif color == "lime" then result = colors.lime
	elseif color == "pink" then result = colors.pink
	elseif color == "gray" then result = colors.gray
	elseif color == "lightGray" then result = colors.lightGray
	elseif color == "cyan" then result = colors.cyan
	elseif color == "purple" then result = colors.purple
	elseif color == "blue" then result = colors.blue
	elseif color == "brown" then result = colors.brown
	elseif color == "green" then result = colors.green
	elseif color == "red" then result = colors.red
	elseif color == "black" then result = colors.black end
	return result
end
