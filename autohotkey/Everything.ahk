;================================================
;seems like globals MUST be placed before anything else
#SingleInstance,Force
CoordMode, Mouse, Screen

;VLC screen settings
;screen1: 1080x1920. 100%. +195y screen2 offset.
;screen2: 1920x1080. 100%.    0y screen2 offset.
;screen3: 1080x1920. 100%. +195y screen2 offset.
window_width := 1080
window_height := 620

left_xpos := -1080
right_xpos := 1920

;cant figure out why but seems to jump some times.
;top_ypos := 160
top_ypos :=200

spacer := 5
middle_ypos := top_ypos + window_height + spacer
bottom_ypos := middle_ypos + window_height + spacer

;================================================
;UNIX like shortcut for launching terminal
^!t::
{
	;SetWorkingDir, %HOMEDRIVE%%HOMEPATH%
	SetWorkingDir, Z:\_git\tools
	Run, PowerShell -NoLogo
	return
}

;================================================
CreateVLCWindow(xpos, ypos, width, height)
{
	Run, vlc
	WinWait, VLC,, 3
	if ErrorLevel
	{
		MsgBox, WinWait timed out, 2
	}
	
	WinMove, VLC, , xpos, ypos, width, height
	
	;paste HLS m3u8 stream url into vlc if in the clipboard
	stream_url := "=.m3u8"
	IfInString, Clipboard, %stream_url%
	{
		sleep_time := 100
		Sleep sleep_time
		SendInput, {control down}n{control up}
		Sleep sleep_time
		SendInput, {backspace}
		Sleep sleep_time
		SendInput, {control down}v{control up}
		Sleep sleep_time
		SendInput, {enter}
	}
	return
}

;================================================
;create VLC window at the current mouse location
^!v::
{
	MouseGetPos, xpos, ypos
	CreateVLCWindow(xpos, ypos, window_width, window_height)
	WinMove, VLC, , xpos, ypos
	return
}

;================================================
;create VLC window at location 1 top left screen
^!1::
{
	CreateVLCWindow(left_xpos, top_ypos, window_width, window_height)
	return
}

;================================================
;create VLC window at location 2 middle left screen
^!2::
{
	CreateVLCWindow(left_xpos, middle_ypos, window_width, window_height)
	return
}

;================================================
;create VLC window at location 3 bottom left screen
^!3::
{
	CreateVLCWindow(left_xpos, bottom_ypos, window_width, window_height)
	return
}

;================================================
;create VLC window at location 4 top right screen
^!4::
{
	CreateVLCWindow(right_xpos, top_ypos, window_width, window_height)
	return
}

;================================================
;create VLC window at location 5 middle right screen
^!5::
{
	CreateVLCWindow(right_xpos, middle_ypos, window_width, window_height)
	return
}

;================================================
;create VLC window at location 6 bottom right screen
^!6::
{
	CreateVLCWindow(right_xpos, bottom_ypos, window_width, window_height)
	return
}

;================================================
;start firefox with given URL and attempt login
^!c::
{
	;keep login information here instead of in git repo
	;these each return a simple string in quotes ""
	#include UserInfo.ahk
	username := get_username()
	password := get_password()
	url := get_url()
	popup := get_popup()

	sleep_time := 500

	Run, firefox.exe %url%
	WinWait, Login,, 10
	if ErrorLevel
	{
		MsgBox,,, WinWait timed out, 2
		return
	}
	
	;enter info into login screen
	Sleep sleep_time
	SendInput, %username%
	Sleep sleep_time
	SendInput, {tab}
	Sleep sleep_time
	SendInput, %password%
	Sleep sleep_time
	SendInput, {enter}
	Sleep sleep_time
	
	;tab to accept popup and accept
	WinWait, %popup%,, 5
	if ErrorLevel
	{
		MsgBox,,, WinWait timed out, 2
		return
	}
	SendInput, {tab}
	Sleep sleep_time
	SendInput, {tab}
	Sleep sleep_time
	SendInput, {tab}
	Sleep sleep_time
	SendInput, {tab}
	Sleep sleep_time
	SendInput, {enter}
	Sleep sleep_time
	
	;MsgBox,,, done, 2
	
	return
}

;================================================
;spam a chat window with rapid text
^!g::
{
	sleep_time := 200

	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	SendInput, {enter}gg easy {enter}
	Sleep sleep_time
	return
}

;================================================
;spam a chat window with rapid text
^!q::
{
	sleep_time := 100
	
	Loop, 50
	{
		SendInput, {enter}%A_Index%{enter}
		Sleep sleep_time
	}
	
	return
}

;================================================
;league of legends dance emote
^!d::
{
	SendInput, {enter}/dance{enter}
	return
}

;================================================
^a::
{
	;how fast these can be cast would be based on casting speed breakpoints
	sleep_time := 500

	SendInput, {2}
	Click, Right
	Sleep sleep_time
	SendInput, {3}
	Click, Right
	Sleep sleep_time
	SendInput, {4}
	Click, Right
	Sleep sleep_time
	SendInput, {5}
	Click, Right
	Sleep sleep_time
	SendInput, {5}
	Click, Right
	Sleep sleep_time
	SendInput, {5}
	Click, Right
	Sleep sleep_time
	SendInput, {5}
	Click, Right
	Sleep sleep_time
	SendInput, {5}
	Click, Right
	Sleep sleep_time
	SendInput, {1}
	Click, Right
	return
}

;================================================
KeepAlive()
{
	; 2 min since last REAL user action
	if (A_TimeIdlePhysical > 120000)
	{
		sleep_time := 200
		BlockInput, On
		SendInput, {LWin}
		Sleep sleep_time
		SendInput, {LWin}
		BlockInput, Off
	}
	
	;debuggin A_TimeIdlePhysical
	;MsgBox, , , KeepAlive Timer %A_TimeIdlePhysical%, 1
	
	return
}

;================================================
; turn on or turn off periodic fake user interaction
^!m::
{
	if(timerOn)
	{
		timerOn := false
		MsgBox, , , KeepAlive Timer Off, 2
		SetTimer, KeepAlive, Off
	}
	else
	{
		timerOn := true
		MsgBox, , , KeepAlive Timer On, 2
		SetTimer, KeepAlive, 1000
	}
	
	return
}

;================================================





;================================================
;https://www.autohotkey.com/board/topic/27988-edit-this-script-with-notepad/
;regedit
;
;HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Edit\Command
;
;modify the value in
;
;"C:\*\Notepad++"%1 (with the quotation marks)
;
;* = notepad++ path 


