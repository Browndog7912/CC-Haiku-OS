-- Selected Options are Indented
function indented(title, tChoices, tActions)
local check = true
local nSelection = 1
repeat
term.clear()
local width, height = term.getSize()
paintutils.drawLine(1, 1, width, 1, colors.gray)
term.setCursorPos(1, 1)
term.setBackgroundColor(colors.gray)
print(title)
term.setBackgroundColor(colors.black)
print("")
	for nLine = 1, #tChoices do
		local sLine = " "
		if nSelection == nLine then
			sLine = "->"
			pLine = true
		else
			pLine = false
		end
		sLine = sLine .." "..tChoices[nLine]
		if pLine == true then
			term.setTextColor(colors.lightGray)
			print(sLine)
			term.setTextColor(colors.white)
		else
			print(sLine)
		end
	end
	local sEvent, nKey = os.pullEvent("key")
	if nKey == keys.up or nKey == keys.w then
		if tChoices[nSelection - 1] then
			nSelection = nSelection - 1
		end
	elseif nKey == keys.down or nKey == keys.s  then
		if tChoices[nSelection + 1] then 
			nSelection = nSelection + 1
		end
	elseif nKey == keys.enter then 
		if tActions[nSelection] then
			tActions[nSelection]() 
			check = false
		else
			print("Error: Selection out of bounds: ", nSelection)
			print("Press Enter to continue...")
			read() 
		end
	end
until check == false 
end


-- Selected Options are NOT Indented
function notIndented(title, tChoices, tActions)
local check = true
local nSelection = 1
repeat
term.clear()
local width, height = term.getSize()
paintutils.drawLine(1, 1, width, 1, colors.gray)
term.setCursorPos(1, 1)
term.setBackgroundColor(colors.gray)
print(title)
term.setBackgroundColor(colors.black)
print("")
	for nLine = 1, #tChoices do 
		local sLine = " "
		if nSelection == nLine then
			sLine = "->"
			pLine = true
		else
			pLine = false
		end
		if pLine == true then
		    sLine = sLine.." "..tChoices[nLine]
		else
			sLine = sLine.." ".." "..tChoices[nLine]
		end
		if pLine == true then
			term.setTextColor(colors.lightGray)
			print(sLine)
			term.setTextColor(colors.white)
		else
			print(sLine)
		end
	end
	local sEvent, nKey = os.pullEvent("key") 
	if nKey == keys.up or nKey == keys.w then 
		if tChoices[nSelection - 1] then 
			nSelection = nSelection - 1
		end
	elseif nKey == keys.down or nKey == keys.s  then
		if tChoices[nSelection + 1] then 
			nSelection = nSelection + 1
		end
	elseif nKey == keys.enter then 
		if tActions[nSelection] then
			tActions[nSelection]()
			check = false
		else
			print("Error: Selection out of bounds: ", nSelection)
			print("Press Enter to continue...")
			read()
		end
	end
until check == false 
end

-- Uses ">" as pointer instead of "->"
function altPointer(title, tChoices, tActions)
local check = true
local nSelection = 1
repeat
term.clear()
local width, height = term.getSize()
paintutils.drawLine(1, 1, width, 1, colors.gray)
term.setCursorPos(1, 1)
term.setBackgroundColor(colors.gray)
print(title)
term.setBackgroundColor(colors.black)
print("")
	for nLine = 1, #tChoices do 
		local sLine = " "
		if nSelection == nLine then
			sLine = ">"
			pLine = true
		else
			pLine = false
		end
		sLine = sLine .." "..tChoices[nLine] 
		if pLine == true then
			term.setTextColor(colors.lightGray)
			print(sLine)
			term.setTextColor(colors.white)
		else
			print(sLine)
		end
	end
	local sEvent, nKey = os.pullEvent("key")
	if nKey == keys.up or nKey == keys.w then
		if tChoices[nSelection - 1] then
			nSelection = nSelection - 1
		end
	elseif nKey == keys.down or nKey == keys.s  then
		if tChoices[nSelection + 1] then 
			nSelection = nSelection + 1
		end
	elseif nKey == keys.enter then 
		if tActions[nSelection] then
			tActions[nSelection]() 
			check = false
		else
			print("Error: Selection out of bounds: ", nSelection)
			print("Press Enter to continue...")
			read() 
		end
	end
until check == false 
end

--Does not Indent nor Highlight Selected Option, Title does not have background
function basic(title, tChoices, tActions)
local check = true
local nSelection = 1
repeat
term.clear()
term.setCursorPos(1, 1)
print(title)
print("")
	for nLine = 1, #tChoices do 
		local sLine = " "
		if nSelection == nLine then
			sLine = ">"
		end
		sLine = sLine .." "..tChoices[nLine] 
		print(sLine)
	end
	local sEvent, nKey = os.pullEvent("key")
	if nKey == keys.up or nKey == keys.w then
		if tChoices[nSelection - 1] then
			nSelection = nSelection - 1
		end
	elseif nKey == keys.down or nKey == keys.s  then
		if tChoices[nSelection + 1] then 
			nSelection = nSelection + 1
		end
	elseif nKey == keys.enter then 
		if tActions[nSelection] then
			tActions[nSelection]() 
			check = false
		else
			print("Error: Selection out of bounds: ", nSelection)
			print("Press Enter to continue...")
			read() 
		end
	end
until check == false 
end

-- Makes you press Enter to continue/exit
function stallEnter()
local width, height = term.getSize()
term.setCursorPos(1, height)
write("[Press Enter to Continue]")
check = true
repeat
	local event, key = os.pullEvent("key")
	if key == keys.enter then
		check = false
	else
		sleep(0.05)
	end
until check == false
end


function stallAny()
local width, height = term.getSize()
term.setCursorPos(1, height)
write("[Press Any Key to Continue]")
check = true
repeat
	local event = os.pullEvent()
	if event == "key" then
		check = false
	else
		sleep(0.05)
	end
until check == false
end