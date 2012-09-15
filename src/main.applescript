on GetWindowLocation()
	set front_app to (path to frontmost application as Unicode text)
	
	tell application front_app
		try
			item 1 of (get bounds of front window)
		on error
			return 300
		end try
	end tell
	
end GetWindowLocation

on GetDockSize()
	tell application "System Events"
		set DockLocation to (value of property list item "tilesize" of contents of property list file "~/Library/Preferences/com.apple.Dock.plist") - 29
	end tell
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
	if WindowLocation is less than or equal to DockSize then HideDock()
	if WindowLocation is greater than DockSize then ShowDock()
	if WindowLocation is equal to "-1728" then ShowDock()
end repeat

