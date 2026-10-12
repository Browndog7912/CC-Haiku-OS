--newtab script
print("Opening new tab")
if term.isColor then
    shell.openTab("/rom/programs/shell.lua")
else 
    print("Advanced computers only") 
end
