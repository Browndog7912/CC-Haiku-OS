-- /system/core/event.lua
-- Event system: Event bus for system-wide event handling

-- from Basalt OS 
-- MIT License
-- Copyright (c) 2025 Pyroxenium

local event = {}

function event.init()
    _G.oseventlisteners = {}
    _G.oseventRawcallbacks = {}
end

-- Register an event listener
-- @param event_name: Name of the event (e.g., "mouse_click", "system.boot_complete")
-- @param callback: Function to call when event fires
-- @param priority: Optional priority (higher = called first), default = 0
function event.on(event_name, callback, priority)
    if type(callback) ~= "function" then
        error("Event callback must be a function")
    end

    priority = priority or 0

    if not _G.oseventlisteners[event_name] then
        _G.oseventlisteners[event_name] = {}
    end

    table.insert(_G.oseventlisteners[event_name], {
        callback = callback,
        priority = priority
    })

    table.sort(_G.oseventlisteners[event_name], function(a, b)
        return a.priority > b.priority
    end)
end

function event.off(event_name, callback)
    if not _G.oseventlisteners[event_name] then
        return
    end

    for i = #_G.oseventlisteners[event_name], 1, -1 do
        if _G.oseventlisteners[event_name][i].callback == callback then
            table.remove(_G.oseventlisteners[event_name], i)
        end
    end
end

-- Register a raw callback that receives ALL events
-- Useful for UI systems that need to handle all OS events
-- @param callback: Function(event_name, ...) that receives every event
function event.onRaw(callback)
    if type(callback) ~= "function" then
        error("Raw callback must be a function")
    end

    table.insert(_G.oseventRawcallbacks, callback)
end

function event.offRaw(callback)
    for i = #_G.oseventRawcallbacks, 1, -1 do
        if _G.oseventRawcallbacks[i] == callback then
            table.remove(_G.oseventRawcallbacks, i)
        end
    end
end

-- Dispatch an event to all registered _G.oseventlisteners
-- @param event_name: Name of the event
-- @param ...: Additional arguments passed to _G.oseventlisteners
function event.dispatch(event_name, ...)
    local args = {...}

    if _G.oseventlisteners[event_name] then
        -- Iterate over a snapshot so callbacks may safely register or remove
        -- _G.oseventlisteners (for example when an application window is closed).
        local snapshot = {}
        for i, listener in ipairs(_G.oseventlisteners[event_name]) do snapshot[i] = listener end
        for _, listener in ipairs(snapshot) do
            local ok, err = pcall(function()
                listener.callback(table.unpack(args))
            end)

            if not ok then
                print("Error in event listener for '" .. event_name .. "': " .. tostring(err))
            end
        end
    end

    for _, callback in ipairs(_G.oseventRawcallbacks) do
        local ok, err = pcall(function()
            callback(event_name, table.unpack(args))
        end)

        if not ok then
            print("Error in raw event callback: " .. tostring(err))
        end
    end
end


function event.once(event_name, callback, priority)
    local wrapper
    wrapper = function(...)
        event.off(event_name, wrapper)
        callback(...)
    end

    event.on(event_name, wrapper, priority)
end

function event.getRegisteredEvents()
    local events = {}
    for event_name, _ in pairs(_G.oseventlisteners) do
        table.insert(events, event_name)
    end
    return events
end

function event.clear(event_name)
    if event_name then
        _G.oseventlisteners[event_name] = nil
    else
        _G.oseventlisteners = {}
    end
end

return event
