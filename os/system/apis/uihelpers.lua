local uihelpers = {}

-- Recreates the old double-click convenience at OS level. Mouse-down only
-- recognizes the gesture; the callback runs on the matching mouse-up. This
-- prevents the release event from refocusing a launcher/browser after its
-- callback opened a new window.
function uihelpers.onDoubleClick(element, callback, interval)
    local last_time = 0
    local last_key = nil
    local pending_key = nil
    interval = interval or 0.35
    element:onClick(function(self, button, ...)
        local now = os.clock()
        local item = self.getSelectedIndex and self:getSelectedIndex() or true
        local key = tostring(button) .. ":" .. tostring(item)
        if key == last_key and now - last_time <= interval then
            last_time, last_key = 0, nil
            pending_key = key
        else
            last_time, last_key = now, key
            pending_key = nil
        end
    end)
    element:onClickUp(function(self, button, ...)
        if not pending_key then return end
        local expected_key = pending_key
        pending_key = nil
        local item = self.getSelectedIndex and self:getSelectedIndex() or true
        local key = tostring(button) .. ":" .. tostring(item)
        if key == expected_key then
            callback(self, button, ...)
        end
    end)
    return element
end

return uihelpers