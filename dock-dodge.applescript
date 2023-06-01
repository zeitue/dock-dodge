tell application "Finder"
	set screenResolution to bounds of window of desktop
	set screenHeight to item 4 of screenResolution
end tell

on GetWindowLocation()
	tell application "System Events"
		set activeApps to name of application processes whose frontmost is true
		set currentApplication to item 1 of activeApps
		try
			set frontWindow to the first window of application process currentApplication whose role description is "standard window"
			set windowSize to size of frontWindow
			set windowPosition to position of frontWindow
			return (item 2 of windowSize) + (item 2 of windowPosition)
		on error
			return 300
		end try
	end tell
end GetWindowLocation

on GetDockSize()
	tell application "System Events" to tell process "Dock"
		set dock_dimensions to size in list 1
		set dock_width to item 1 of dock_dimensions
		set dock_height to item 2 of dock_dimensions
	end tell
	dock_height
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
repeat
	delay 0.2
	set DockSize to GetDockSize() as integer
	set WindowLocation to GetWindowLocation() as integer
	if WindowLocation is less than or equal to (screenHeight - DockSize) then ShowDock()
	if WindowLocation is greater than (screenHeight - DockSize) then HideDock()
end repeat
