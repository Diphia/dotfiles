local function Chinese()
    hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
end

local function English()
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

function updateFocusAppInputMethod()
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(appInputMethod) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            if expectedIme == 'English' then
                English()
            else
                Chinese()
            end
            break
        end
    end
end

-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({'ctrl', 'cmd'}, ".", function()
    hs.alert.show("App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID())
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appInputMethod = {
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Warp.app', 'English'},
    {'/Applications/Google Chrome.app', 'English'},
    {'/Applications/Emacs.app', 'English'},
    {'/opt/homebrew/Cellar/emacs-plus@27/27.2/Emacs.app', 'English'},
    {'/opt/homebrew/Cellar/emacs-plus@28/28.1/Emacs.app', 'English'},
    {'/opt/homebrew/Cellar/emacs-plus@28/28.2/Emacs.app', 'English'},
    {'/usr/local/Cellar/emacs-plus@28/28.2/Emacs.app', 'English'},
    {'/Applications/Webex.app', 'English'},
    {'/System/Library/CoreServices/Finder.app', 'English'},
    {'/Applications/WeChat.app', 'Chinese'},
    {'/Applications/System Preferences.app', 'English'},
}

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
