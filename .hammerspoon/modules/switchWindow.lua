local emacs
local org_mode
emacs = hs.window'GNU Emacs\n'
org_mode = hs.window'Org Mode\n'

local function focusAppIfRunning(appName)
    local app = hs.application.get(appName)
    if app and #app:allWindows() > 0 then
        app:activate()
        moveCursorToFocusedWindow()
    end
end

hs.hotkey.bind({"option"}, "1", function()
    hs.application.launchOrFocus("Visual Studio Code")
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
    hs.application.launchOrFocus("Emacs")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"command", "option"}, ",", function()
    hs.application.launchOrFocus("System Preferences")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "q", function()
	focusAppIfRunning("Webex")
	moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "o", function()
	focusAppIfRunning("Microsoft Outlook")
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

hs.hotkey.bind({"option"}, "r", function()
    hs.application.launchOrFocus("vifmm")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "c", function()
    hs.application.launchOrFocus("Terminal")
    moveCursorToFocusedWindow()
end)

hs.hotkey.bind({"option"}, "p", function()
    hs.application.launchOrFocus("iPhone Mirroring")
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

function moveCursorToFocusedWindow()
    local current = hs.window.focusedWindow()
    local screen = current:screen()
    local rect = screen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
end
