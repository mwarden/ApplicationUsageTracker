; The active window may be hidden. One example of this is when Menu,..,Show
; is used, as it activates the main AutoHotkey window (which owns the menu).
DetectHiddenWindows, On
Loop {
    ActiveBegin := A_TickCount
    WinGetActiveTitle, ActiveTitle
    ActiveAppName := SubStr(ActiveTitle, 1, StrLen("ER/Studio Data Architect"))
    
    ; Wait for some other window to be activated.
    WinWaitNotActive, % "ahk_id " . WinActive("A")
    
    ; Calculate how long it was active for.
    ActiveTime := (A_TickCount - ActiveBegin) / 1000
    
    ; Log the title and duration of the active window.
    if (ActiveAppName == "ER/Studio Data Architect")
        FileAppend, %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min% Usage: %ActiveTime% seconds %ActiveTitle%`n, erstudio_usage_log.txt
    
}