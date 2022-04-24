hs.hotkey.bind({"control"}, "1", function()
    hs.window'GNU Emacs\n':focus()
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control"}, "2", function()
    hs.application.launchOrFocus("iTerm")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control"}, "3", function()
    hs.application.launchOrFocus("Google Chrome")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control", "command"}, "3", function()
    hs.application.launchOrFocus("Safari")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control"}, "4", function()
    hs.window'Org Mode\n':focus()
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"command", "option"}, ",", function()
    hs.application.launchOrFocus("System Preferences")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control"}, "q", function()
    hs.application.launchOrFocus("Webex")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control", "command"}, "q", function()
    hs.application.launchOrFocus("Microsoft Outlook")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"control", "command"}, "d", function()
    hs.application.launchOrFocus("Dictionary")
    moveCursorToFocusedWindow()
end)

function moveCursorToFocusedWindow()
    local current = hs.window.focusedWindow()
    local screen = current:screen()
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
end
