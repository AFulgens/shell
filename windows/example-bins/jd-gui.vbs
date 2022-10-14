' Starting a program via CMD but hiding the window 😎
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "..\..\tools\java\zulu17.36.17-ca-jdk17.0.4.1-win_x64\bin\java -jar .\jd-gui-1.6.6.jar", 0
Set WshShell = Nothing
