on selectOptions()
	display dialog "Click a button to choose what picture(s) to rename" buttons Â
		{"More", "Select Image", "Select Folder"} default button 3
	if the button returned of the result is "Select Folder" then
		runScript((choose folder with prompt "Select Folder..."))
	else if the button returned of the result is "Select Image" then
		runScript((choose file with prompt "Select Image..."))
	else if the button returned of the result is "More" then
		set appPath to quoted form of POSIX path of (path to me)
		set scriptVer to do shell script Â
			"eval `sed '2!d' " & appPath & "/Contents/Resources/Scripts/PicNameSort.sh`; echo $VERSION"
		
		display dialog "PicNameSort (" & scriptVer & ") is a utility to change the name of pictures to help organize them. More info and help at https://nrauh.github.io/PicNameSort/" buttons {"Quit", "Update", "Back"} default button 3
		if the button returned of the result is "Back" then
			selectOptions()
		else if the button returned of the result is "Update" then
			updateScript(appPath & "/Contents/Resources/Scripts/")
		end if
	end if
end selectOptions

on runScript(selectedImg)
	set imgPath to quoted form of POSIX path of selectedImg
	set appPath to quoted form of POSIX path of (path to me)
	
	try
		do shell script Â
			"eval `/usr/libexec/path_helper`;" & appPath Â
			& "Contents/Resources/Scripts/PicNameSort.sh " & imgPath & " // &> /tmp/pns-output.log"
		endOptions()
	on error the errMsg number the errNum
		display dialog "Something went wrong: " & errNum & ", " & errMsg buttons {"View Log", "OK"} default button 2
		if the button returned of the result is "View Log" then
			set output to do shell script "cat /tmp/pns-output.log"
			display dialog "Output" default answer output buttons {"Close"} default button 1
		end if
	end try
end runScript

on endOptions()
	display dialog "Finished running" buttons {"View log", "Do more", "Quit"} default button 3
	if the button returned of the result is "View log" then
		set output to do shell script "cat /tmp/pns-output.log"
		display dialog "Output" default answer output buttons {"Close"} default button 1
		endOptions()
	else if the button returned of the result is "Do more" then
		selectOptions()
	end if
end endOptions

on updateScript(scriptDir)
	set output to do shell script "cd " & scriptDir Â
		& "; ./PicNameSort.sh --update"
	display dialog output buttons {"OK"} default button 1
	selectOptions()
end updateScript

selectOptions()
