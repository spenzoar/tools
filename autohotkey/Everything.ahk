;================================================
#SingleInstance,Force
CoordMode, Mouse, Screen

;================================================
;UNIX like shortcut for launching terminal
^!t::
{
	SetWorkingDir, %HOMEDRIVE%%HOMEPATH%
	Run, PowerShell -NoLogo
	return
}

;================================================
;create VLC window at the current mouse location
^!v::
{
	MouseGetPos, xpos, ypos
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , 0, 0, 1050, 600
	WinMove, VLC, , xpos, ypos
	return
}

;================================================
;create VLC window at location 1 top left screen
^!1::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , -1080, 200, 1050, 600
	return
}

;================================================
;create VLC window at location 2 middle left screen
^!2::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , -1080, 800, 1050, 600
	return
}

;================================================
;create VLC window at location 3 bottom left screen
^!3::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , -1080, 1400, 1050, 600
	return
}

;================================================
;create VLC window at location 4 top right screen
^!4::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , 1950, 200, 1050, 600
	return
}

;================================================
;create VLC window at location 5 middle right screen
^!5::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , 1950, 800, 1050, 600
	return
}

;================================================
;create VLC window at location 6 bottom right screen
^!6::
{
	Run, vlc
	WinWait, VLC
	WinMove, VLC, , 1950, 1400, 1050, 600
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
Jiggle()
{
	; 2 minutes since last REAL user action
	;if (A_TimeIdlePhysical > 120000)
	if (A_TimeIdlePhysical > 60000)
	{
		;CoordMode, Mouse, Screen
	
		; mouse pointer stays in place but sends a mouse event
		;MouseGetPos, xpos, ypos
		; need a second monitor check for doing something differently
		;MouseMove, xpos, ypos - 1
		;MouseMove, xpos, ypos + 1
		;MouseMove, ypos, xpos
		;MsgBox, , , xpos: %xpos% ypos: %ypos%, 1
		;MouseMove, xpos + 5, ypos + 5
		;MouseMove, xpos, ypos
		;MouseMove,5,0,0,R
		;MouseMove,-5,0,0,R
		;MsgBox, , , Moved Mouse, 1
		
		;should be just as harmless and keep the screen/apps alive
		BlockInput, On
		SendInput, {ScrollLock}
		SendInput, {ScrollLock}
		BlockInput, Off
	}
	
	;debuggin A_TimeIdlePhysical
	;MsgBox, , , Mouse Jiggle Timer %A_TimeIdlePhysical%, 1

	;above ends up always moving on other monitors.
	;DllCall("SetCursorPos", "int", 257, "int", -1075)
	
	return
}

;================================================
; turn on or turn off periodic mouse jiggling
^!m::
{
	if(timerOn)
	{
		timerOn := false
		MsgBox, , , Mouse Jiggle Timer Off, 2
		SetTimer, Jiggle, Off
	}
	else
	{
		timerOn := true
		MsgBox, , , Mouse Jiggle Timer On, 2
		SetTimer, Jiggle, 1000
	}
	
	return
}

;================================================


