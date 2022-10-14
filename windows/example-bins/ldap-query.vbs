' This can be useful in enterprise environments
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "cmd /c C:\Windows\System32\rundll32.exe dsquery.dll,OpenQueryWindow", 0, false
Set WshShell = Nothing
