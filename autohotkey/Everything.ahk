;================================================
;seems like globals MUST be placed before anything else
#SingleInstance,Force
CoordMode, Mouse, Screen

;VLC screen settings
window_width := 1080
window_height := 620

left_xpos := -1080
right_xpos := 1920

top_ypos := 200
spacer := 5
middle_ypos := top_ypos + window_height + spacer
bottom_ypos := middle_ypos + window_height + spacer

;================================================
;UNIX like shortcut for launching terminal
^!t::
{
	SetWorkingDir, %HOMEDRIVE%%HOMEPATH%
	Run, PowerShell -NoLogo
	return
}

;================================================
CreateVLCWindow(xpos, ypos, width, height)
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , xpos, ypos, width, height
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
;spam a chat window with rapid text
^j::
{
	sleep_time := 200

	SendInput, {enter}in a 32 bit world {enter}
	Sleep sleep_time
	SendInput, {enter}you're a 2 bit user {enter}
	Sleep sleep_time
	SendInput, {enter}you got your own news group {enter}
	Sleep sleep_time
	SendInput, {enter}alt total loser {enter}
	Sleep sleep_time
	SendInput, {enter}your motherboard melts {enter}
	Sleep sleep_time
	SendInput, {enter}when you try and send a fax {enter}
	Sleep sleep_time
	SendInput, {enter}where'd you get your cpu in a box of crackerjax {enter}
	Sleep sleep_time
	SendInput, {enter}play me online and I know that I'll beat you {enter}
	Sleep sleep_time
	SendInput, {enter}if I ever meet you I'll control alt delete you {enter}
	Sleep sleep_time
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

	SendInput, {f2}
	Click, Right
	Sleep sleep_time
	SendInput, {f3}
	Click, Right
	Sleep sleep_time
	SendInput, {f4}
	Click, Right
	Sleep sleep_time
	SendInput, {f5}
	Click, Right
	Sleep sleep_time
	SendInput, {f5}
	Click, Right
	Sleep sleep_time
	SendInput, {f5}
	Click, Right
	Sleep sleep_time
	SendInput, {f5}
	Click, Right
	Sleep sleep_time
	SendInput, {f5}
	Click, Right
	Sleep sleep_time
	SendInput, {f1}
	Click, Right
	return
}

;================================================
KeepAlive()
{
	; 1 min since last REAL user action
	if (A_TimeIdlePhysical > 60000)
	{
		BlockInput, On
		SendInput, {LWin}
		Sleep 200
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


