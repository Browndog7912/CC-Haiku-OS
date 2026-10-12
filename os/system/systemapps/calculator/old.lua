-- Auroroa OS Calculator

local basalt = require("/apis/basalt")

local frame = basalt.getMainFrame()
frame.background = basalt.rgb("#14161b")

local sizeX, sizeY = term.getSize()

local calculatorAnswer = frame:addFrame({
    width = sizeX,
    height = sizeY / 2,
    background = colors.white,
})

local calculatorKeypad = frame:addFrame({
    width = sizeX,
    height = sizeY / 2 + 4,
    y = sizeY / 2 - 3,
    background = basalt.rgb("#5c5c5c"),
})

local keypadSize = sizeY / 2

calculatorKeypad:addButton({
    x = 2,
    y = 1,
    width = 10,
    text = "7",
}):onClick(click)

calculatorKeypad:addButton({
    x = 12,
    y = 1,
    width = 10,
    text = "8",
}):onClick(click)

calculatorKeypad:addButton({
    x = 22,
    y = 1,
    width = 10,
    text = "9",
}):onClick(click)

-- Row 2

calculatorKeypad:addButton({
    x = 2,
    y = 4,
    width = 10,
    text = "4",
}):onClick(click)

calculatorKeypad:addButton({
    x = 12,
    y = 4,
    width = 10,
    text = "5",
}):onClick(click)

calculatorKeypad:addButton({
    x = 22,
    y = 4,
    width = 10,
    text = "6",
}):onClick(click)

-- Row 1

calculatorKeypad:addButton({
    x = 2,
    y = 7,
    width = 10,
    text = "1",
}):onClick(click)

calculatorKeypad:addButton({
    x = 12,
    y = 7,
    width = 10,
    text = "2",
}):onClick(click)

calculatorKeypad:addButton({
    x = 22,
    y = 7,
    width = 10,
    text = "3",
}):onClick(click)

-- Row 1

calculatorKeypad:addButton({
    x = 2,
    y = 10,
    width = 10,
    text = "."
}):onClick(click)

calculatorKeypad:addButton({
    x = 22,
    y = 10,
    width = 10,
    text = "=",
}):onClick(click)

calculatorKeypad:addButton({
    x = 12,
    y = 10,
    width = 10,
    text = "0",
}):onClick(click)


-- Sidebar of math

calculatorKeypad:addButton({
    x = 40,
    y = 2,
    width = 10,
    height = 2,
    text = "CA"
}):onClick(click)
calculatorKeypad:addButton({
    x = 40,
    y = 4,
    width = 10,
    height = 2,
    text = "/"
}):onClick(click)
calculatorKeypad:addButton({
    x = 40,
    y = 6,
    width = 10,
    height = 2,
    text = "X"
}):onClick(click)
calculatorKeypad:addButton({
    x = 40,
    y = 8,
    width = 10,
    height = 2,
    text = "-"
}):onClick(click)
calculatorKeypad:addButton({
    x = 40,
    y = 10,
    width = 10,
    height = 2,
    text = "+"
}):onClick(click)

--[[ frame:addLabel({
    x = 2,
    y = 2,
    text = "What is your name?",
    foreground = colors.orange,
})

local nameInput = frame:addInput({
    x = 2,
    y = 4,
    width = 24,
    placeholder = "Steve",
})

local result = frame:addLabel({
    x = 2,
    y = 6,
    width = 30,
    text = "Enter a name to continue.",
    foreground = colors.lightGray,
})

local function greet()
    local name = nameInput.text:match("^%s*(.-)%s*$")
    if name == "" then
        result.text = "Please enter a name."
        result.foreground = colors.red
        return
    end

    result.text = "Hello, " .. name .. "!"
    result.foreground = colors.lime
end

frame:addButton({
    x = 2,
    y = 8,
    width = 10,
    text = "Say hello",
}):onClick(greet)

frame:addButton({
    x = 16,
    y = 8,
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

nameInput:onEnter(greet)
nameInput:focus()]]


local function click()
    
end

basalt.run()