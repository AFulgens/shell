' Starting a program via CMD but hiding the window 😎
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "%JAVA_HOME%\bin\java -jar .\jd-gui-1.6.6.jar", 0
Set WshShell = Nothing
