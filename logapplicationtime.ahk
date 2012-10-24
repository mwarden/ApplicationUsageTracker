; The active window may be hidden. One example of this is when Menu,..,Show
; is used, as it activates the main AutoHotkey window (which owns the menu).
DetectHiddenWindows, On



; ############################## BEGIN CONFIG ##############################

; track only a single application or all application usage?
TrackAllApps := false

; names of the application to track (each must be the first part of the window title)
; delimit multiple application names with a pipe (|) character
; ignored if TrackAllApps is true
TargetAppNames := "ER/Studio Data Architect|Entity Editor|Relationship Editor|Table Editor|Index Editor|Schema Editor|Procedure SQL Editor|Function SQL Editor|View Editor|Key Editor"

; output log file desired name
LogFileName := "erstudio_usage_log.txt"

; ############################## END CONFIG ##############################



; there should not be a need to modify any of the below

StringSplit, TargetAppArray, TargetAppNames, |

Loop {
    AppNameMatch := false
    ActiveBegin := A_TickCount
    WinGetActiveTitle, ActiveTitle
    
    
    ; Wait for some other window to be activated.
    WinWaitNotActive, % "ahk_id " . WinActive("A")
    
    ; Calculate how long it was active for, in seconds.
    ActiveTime := (A_TickCount - ActiveBegin) / 1000
    
    ; see if app name matches anything in our list
    Loop, Parse, TargetAppNames, |
    {
        StringLen, TargetAppNameLength, A_LoopField
        ActiveAppName := SubStr(ActiveTitle, 1, TargetAppNameLength)
    	if (ActiveAppName = A_LoopField) {
            AppNameMatch := true
            break
            
        }
    }
    
    ; Log the title and duration of the active window.
    if (TrackAllApps or AppNameMatch) {
        FileAppend, %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min% Usage: %ActiveTime% seconds %ActiveTitle%`n, %LogFileName%
    }
    
}