-- Driver Service
local event = require("/system/apis/event")
driverapi = {}


function driverapi.init()
    print("added event")
    event.on("peripheral", function(name)
        os.shutdown()
    end)
    print("added event")
    event.on("peripheral_detach", function(name)
        os.reboot()
    end)

    print("added event")
    event.on("system.shutdown", function()
        os.reboot()
    end)

    --[[log.info("DEVICES", "Device service initialized", {
        count=driverapi.count(),
    })]]
end

return driverapi