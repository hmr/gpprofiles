#!/usr/bin/osascript

-- Part of GPP
-- Copyright (c) 2026 hmr

-- Open a new Ghostty tab with a tmux session
-- Usage:
--    With CLI argument: `osascript ghostty_launch_in_tab.applescript "hostname"`
--    Without CLI argument: `osascript ghostty_launch_in_tab.applescript` (will show GUI selector)
-- Config file:
--    connect.conf (one host per line, supports comments with #)

on run argv
	-- Check if an argument was passed via CLI
	set targetHost to ""
	tell application "System Events" to set isRunning to (exists process "Ghostty")

	if isRunning then
		if (count of argv) > 0 then
			-- Use the first argument as the target host directly
			set targetHost to item 1 of argv
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

			-- Read and parse the configuration file natively
			try
				set fileContent to read file hostsFilePath as «class utf8»
				set rawHostList to paragraphs of fileContent
				set hostList to {}

				repeat with aLine in rawHostList
					set cleanLine to my trim(aLine)
					if cleanLine is not "" and cleanLine does not start with "#" then
						copy cleanLine to end of hostList
					end if
				end repeat
			on error errMsg
				display dialog "Error reading connect.conf: " & errMsg buttons {"OK"} default button "OK" with icon stop
				return
			end try

			if (count of hostList) is 0 then
				display dialog "No valid hosts found in connect.conf." buttons {"OK"} with icon caution
				return
			end if

			-- Show GUI Selector
			set selectedHost to choose from list hostList ¬
				with prompt ¬
				"Select a target host for tmux:" with title ¬
				"Ghostty Connector" default items {item 1 of hostList}

			if selectedHost is false then return
			set targetHost to item 1 of selectedHost
		end if
	else
		set targetHost to "localhost"
	end if

	-- Launch Ghostty with the target host (from either CLI or GUI)
	set launchCmd to "~/launch_tmux " & targetHost

	if isRunning then
		tell application "Ghostty"
			activate
			-- Configuration of nerw tab/window
			set myConfig to new surface configuration
			set command of myConfig to launchCmd
			set environment variables of myConfig to {"TERM=tmux-256color"}

			if (exists front window) then
				set currentTab to selected tab of front window
				set newTab to new tab in front window with configuration myConfig
				delay 0.5
				set targetTerminal to focused terminal of newTab
				perform action "move_tab:" & ((my countTabs()) + 1) on targetTerminal
				perform action "set_tab_title:" & targetHost on targetTerminal
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
				perform action "set_tab_title:" & targetHost on targetTerminal
				select tab currentTab
			end if
		end tell
	end if
end run

-- Helper handler to trim whitespace
on trim(someText)
	set theWords to words of someText
	if theWords is {} then return ""
	return someText
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
