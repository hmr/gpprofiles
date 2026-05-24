#!/usr/bin/osascript

-- open_as_ghostty_tab
-- https://github.com/hmr/open_as_ghostty_tab
-- Copyright (c) 2026 hmr

-- Open a new Ghostty tab from menu or commanf line argument.
-- Usage:
--    With CLI argument: `osascript open_as_ghostty_tab.applescript "hostname"`
--    Without CLI argument: `osascript open_as_ghostty_tab.applescript` (will show GUI selector)
-- Config file:
--    connect.conf (title="..."; command="..." per line, supports comments with #)

on run argv
	-- Check if an argument was passed via CLI
	set targetTitle to ""
	set targetCommand to ""
	tell application "System Events" to set isRunning to (exists process "Ghostty")

	if (count of argv) > 0 then
		-- Use the first argument as the target host directly
		set targetTitle to item 1 of argv
		set targetCommand to item 1 of argv
	else
		-- No argument passed: Fallback to GUI menu selection
		-- Define the path to connect.conf (Assuming it's in the same folder as this script)
		try
			set scriptPath to (path to me as text)
			tell application "Finder" to set scriptDir to (container of file scriptPath) as text
			set hostsFilePath to scriptDir & "connect.conf"
		on error
			-- Fallback for unsaved scripts in Script Editor
			set hostsFilePath to ((path to desktop folder as text) & "connect.conf")
		end try

		-- Configuration file not found
		tell application "System Events" to set hostsFileExists to (exists file hostsFilePath)
		if hostsFileExists is false then
			display dialog "Error: connect.conf was not found" buttons {"OK"} default button "OK" with icon stop
			return
		end if

		-- Read and parse the configuration file natively
		try
			set fileContent to read file hostsFilePath as «class utf8»
			set rawHostList to paragraphs of fileContent
			set titleList to {}
			set commandList to {}

			repeat with aLine in rawHostList
				set cleanLine to my trim(aLine)
				if cleanLine is not "" and cleanLine does not start with "#" then
					set parsedEntry to my parseConfigLine(cleanLine)
					copy item 1 of parsedEntry to end of titleList
					copy item 2 of parsedEntry to end of commandList
				end if
			end repeat
		on error errMsg
			display dialog "Error reading connect.conf: " & errMsg buttons {"OK"} default button "OK" with icon stop
			return
		end try

		if (count of titleList) is 0 then
			display dialog "No valid hosts found in connect.conf." buttons {"OK"} with icon caution
			return
		end if

		-- Show GUI Selector
		repeat while targetCommand is ""
			set selectedHost to choose from list titleList ¬
				with prompt ¬
				"Select a target host for tmux:" with title ¬
				"Ghostty Connector" default items {item 1 of titleList} ¬
				OK button name "OPEN TAB" ¬
				empty selection allowed false

			if selectedHost is false then return
			set targetTitle to item 1 of selectedHost
			set selectedIndex to my indexOf(targetTitle, titleList)
			if selectedIndex is 0 then return
			set targetCommand to item selectedIndex of commandList
		end repeat
	end if

	-- Launch Ghostty with the target host (from either CLI or GUI)
	set launchCmd to targetCommand

	if isRunning then
		tell application "Ghostty"
		activate
			-- Configuration of new tab/window
			set myConfig to new surface configuration
			set command of myConfig to launchCmd
			set environment variables of myConfig to {"TERM=tmux-256color"}

			if (exists front window) then
				set currentTab to selected tab of front window
				set newTab to new tab in front window with configuration myConfig
				delay 0.5
				set targetTerminal to focused terminal of newTab
				perform action "move_tab:" & ((my countTabs()) + 1) on targetTerminal
				perform action "set_tab_title:" & targetTitle on targetTerminal
				select tab currentTab
			else
				set newWindow to new window with configuration myConfig
			end if
		end tell
	else
		-- Ghostty is not running, launch it with the target host
		do shell script "open -a Ghostty --args -e " & launchCmd
		delay 1
		tell application "Ghostty"
			activate
			if (exists front window) then
				set currentTab to selected tab of front window
				set targetTerminal to focused terminal of currentTab
				perform action "set_tab_title:" & targetTitle on targetTerminal
				select tab currentTab
			end if
		end tell
	end if
end run

-- Parse connect.conf entries.
-- Supported forms:
--   title="display title"; command="command to run"
--   command="command to run"
--   title="display title"
--   raw command
on parseConfigLine(configLine)
	set titleResult to my quotedValueForKey("title", configLine)
	set commandResult to my quotedValueForKey("command", configLine)
	set hasTitle to item 1 of titleResult
	set parsedTitle to item 2 of titleResult
	set hasCommand to item 1 of commandResult
	set parsedCommand to item 2 of commandResult

	if hasTitle is false and hasCommand is false then
		return {configLine, configLine}
	else if hasTitle is false then
		return {parsedCommand, parsedCommand}
	else if hasCommand is false then
		return {parsedTitle, ""}
	else
		return {parsedTitle, parsedCommand}
	end if
end parseConfigLine

on quotedValueForKey(keyName, configLine)
	set markerText to keyName & "=\""
	set markerOffset to offset of markerText in configLine
	if markerOffset is 0 then return {false, ""}

	set valueStart to markerOffset + (length of markerText)
	if valueStart > (length of configLine) then return {true, ""}

	set remainingText to text valueStart thru -1 of configLine
	set quoteOffset to offset of "\"" in remainingText
	if quoteOffset is 0 then return {true, remainingText}
	if quoteOffset is 1 then return {true, ""}
	return {true, text 1 thru (quoteOffset - 1) of remainingText}
end quotedValueForKey

on indexOf(needle, haystack)
	repeat with i from 1 to count of haystack
		if item i of haystack is needle then return i
	end repeat
	return 0
end indexOf

-- Helper handler to trim whitespace
on trim(someText)
	set whitespaceChars to {" ", tab}
	set startIndex to 1
	set endIndex to length of someText

	repeat while startIndex ≤ endIndex and character startIndex of someText is in whitespaceChars
		set startIndex to startIndex + 1
	end repeat

	repeat while endIndex ≥ startIndex and character endIndex of someText is in whitespaceChars
		set endIndex to endIndex - 1
	end repeat

	if startIndex > endIndex then return ""
	return text startIndex thru endIndex of someText
end trim

-- Return number of tabs in the front window
on countTabs()
	tell application "Ghostty"
		if (exists front window) then
			return count tabs of front window
		else
			return 0
		end if
	end tell
end countTabs
