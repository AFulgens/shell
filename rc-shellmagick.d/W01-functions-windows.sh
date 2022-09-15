#!/bin/sh

echo ""

if [ $mingw == "false" ] && [ $cygwin == "false" ]; then
	echo "[2m[3mSkipping functions for Windows (not in MingW nor in Cygwin)[0m"
	return
fi

echo "[2m[3mRegistering functions for Windows[0m"

function ed {
	cmd /c 'C:\Program Files\Notepad++\notepad++.exe' $@ &
}
FUNCTIONS[ed]="open given file in Notepad++"
