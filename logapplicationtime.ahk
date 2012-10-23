; The active window may be hidden. One example of this is when Menu,..,Show
; is used, as it activates the main AutoHotkey window (which owns the menu).
DetectHiddenWindows, On



; ############################## BEGIN CONFIG ##############################

; track only a single application or all application usage?
TrackAllApps := false

; name of the application to track (this must be the first part of the window title)
; ignored if TrackAllApps is true
TargetAppName := "ER/Studio Data Architect"

; output log file desired name
LogFileName := "erstudio_usage_log.txt"

; ############################## END CONFIG ##############################



; there should not be a need to modify any of the below

Loop {
    ActiveBegin := A_TickCount
    WinGetActiveTitle, ActiveTitle
    StringLen, TargetAppNameLength, TargetAppName
    ActiveAppName := SubStr(ActiveTitle, 1, TargetAppNameLength)
    
    ; Wait for some other window to be activated.
    WinWaitNotActive, % "ahk_id " . WinActive("A")
    
    ; Calculate how long it was active for, in seconds.
    ActiveTime := (A_TickCount - ActiveBegin) / 1000
    
    ; Log the title and duration of the active window.
    if (TrackAllApps or ActiveAppName = TargetAppName) {
        FileAppend, %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min% Usage: %ActiveTime% seconds %ActiveTitle%`n, %LogFileName%
    }
    
}