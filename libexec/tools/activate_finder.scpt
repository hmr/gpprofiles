-- Bring Finder window frontmost or make new window
tell application "Finder"
    if (count of windows) is 0 then
        make new Finder window
    else
        set frontmost to true
    end if
    activate
end tell

