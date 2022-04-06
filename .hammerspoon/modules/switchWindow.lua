hs.hotkey.bind({"control"}, "1", function()
    hs.window'GNU Emacs':focus()
end)

hs.hotkey.bind({"control"}, "2", function()
    hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"control"}, "3", function()
    hs.application.launchOrFocus("Google Chrome")
end)

hs.hotkey.bind({"control"}, "4", function()
    hs.window'Org Mode':focus()
end)

hs.hotkey.bind({"command", "option"}, ",", function()
    hs.application.launchOrFocus("System Preferences")
end)

hs.hotkey.bind({"control"}, "q", function()
    hs.application.launchOrFocus("Webex")
end)

hs.hotkey.bind({"control"}, "5", function()
    hs.application.launchOrFocus("Microsoft Outlook")
end)
