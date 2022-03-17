global screenWidth
global screenHeight

tell application "Finder"
	set screenResolution to bounds of window of desktop
	set screenWidth to item 3 of screenResolution
	set screenHeight to item 4 of screenResolution
end tell

on GetWindowLocation(edge)
	tell application "System Events"
		set activeApps to name of application processes whose frontmost is true
		set currentApplication to item 1 of activeApps
		try
			set frontWindow to the first window of application process currentApplication
			set windowSize to size of frontWindow
			set windowPosition to position of frontWindow
			if edge is equal to "bottom" then
				return (item 2 of windowSize) + (item 2 of windowPosition)
			else if edge is equal to "top" then
				return (item 2 of windowPosition)
			else if edge is equal to "right" then
				return (item 1 of windowSize) + (item 1 of windowPosition)
			else
				return (item 1 of windowPosition)
			end if
		on error
			return 300
		end try
	end tell
end GetWindowLocation

on GetDockEdge()
	tell application "System Events" to get the screen edge of the dock preferences
end GetDockEdge

on GetDockSize(edge)
	tell application "System Events" to tell process "Dock"
		set dock_dimensions to size in list 1
		set dock_width to item 1 of dock_dimensions
		set dock_height to item 2 of dock_dimensions
	end tell
	if edge is equal to "bottom" or edge is equal to "top" then
		return dock_height
	else
		return dock_width
	end if
end GetDockSize

on GetDockStatus()
	tell application "System Events" to get the autohide of the dock preferences
end GetDockStatus

on ShowDock()
	set Status to GetDockStatus()
	if Status is equal to true then tell application "System Events" to set the autohide of the dock preferences to false
end ShowDock

on HideDock()
	set Status to GetDockStatus()
	if Status is equal to false then tell application "System Events" to set the autohide of the dock preferences to true
end HideDock

on ToggleDock()
	set edge to GetDockEdge() as string
	set DockSize to GetDockSize(edge) as integer
	set WindowLocation to GetWindowLocation(edge) as integer
	if edge is equal to "bottom" then
		if WindowLocation is less than or equal to (screenHeight - DockSize) then
			return ShowDock()
		end if
	else if edge is equal to "top" then
		if WindowLocation is greater than or equal to DockSize then
			return ShowDock()
		end if
	else if edge is equal to "right" then
		if WindowLocation is less than or equal to (screenWidth - DockSize) then
			return ShowDock()
		end if
	else
		if WindowLocation is greater than or equal to DockSize then
			return ShowDock()
		end if
	end if
	HideDock()
end ToggleDock

repeat
	delay 0.2
	ToggleDock()
end repeat
