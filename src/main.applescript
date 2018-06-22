on GetWindowLocation()
	set front_app to (path to frontmost application as Unicode text)
	
	tell application front_app
		try
			item 4 of (get bounds of front window)
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
	set DockSize to GetDockSize() as integer
	set WindowLocation to GetWindowLocation() as integer
	if WindowLocation is less than or equal to (1200 - DockSize) then ShowDock()
	if WindowLocation is greater than (1200 - DockSize) then HideDock()
end repeat

