local emacs
local org_mode
emacs = hs.window'GNU Emacs\n'
org_mode = hs.window'Org Mode\n'


hs.hotkey.bind({"option"}, "1", function()
    if not emacs then
        emacs = hs.window'GNU Emacs\n'
    end
    emacs:focus()
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "2", function()
    hs.application.launchOrFocus("Warp")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "3", function()
    hs.application.launchOrFocus("Google Chrome")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "i", function()
    hs.application.launchOrFocus("iTerm")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "m", function()
    hs.application.launchOrFocus("Activity Monitor")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "4", function()
    if not org_mode then
        org_mode = hs.window'Org Mode\n'
    end
    org_mode:focus()
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"command", "option"}, ",", function()
    hs.application.launchOrFocus("System Preferences")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "q", function()
    hs.application.launchOrFocus("Webex")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "o", function()
    hs.application.launchOrFocus("Microsoft Outlook")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "d", function()
    hs.application.launchOrFocus("Dictionary")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "w", function()
    hs.application.launchOrFocus("WeChat")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "e", function()
    hs.application.launchOrFocus("Telegram")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "t", function()
    hs.application.launchOrFocus("Terminal")
    moveCursorToFocusedWindow()
end)

-- bind hotkey
hs.hotkey.bind({'option'}, 'a', function()
  -- get the focused window
  local win = hs.window.focusedWindow()
  -- get the screen where the focused window is displayed, a.k.a. current screen
  local screen = win:screen()
  -- compute the unitRect of the focused window relative to the current screen
  -- and move the window to the next screen setting the same unitRect
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
  moveCursorToFocusedWindow()
end)

local storedWindow = nil

function storeCurrentWindow()
    storedWindow = hs.window.focusedWindow()
    if storedWindow then
        hs.alert.show("Window stored")
    else
        hs.alert.show("No window to store")
    end
end

function restoreStoredWindow()
    if storedWindow and storedWindow:isVisible() then
        storedWindow:focus()
        moveCursorToFocusedWindow()
    else
        hs.alert.show("No stored window to restore")
    end
end

hs.hotkey.bind({"option", "shift"}, "r", storeCurrentWindow)
hs.hotkey.bind({"option"}, "r", restoreStoredWindow)


function moveCursorToFocusedWindow()
    local current = hs.window.focusedWindow()
    local screen = current:screen()
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
end
