#!/bin/sh

echo ""

if [ $mingw == "false" ] && [ $cygwin == "false" ]; then
	echo "[2m[3mSkipping aliases for Windows (not in MingW nor in Cygwin)[0m"
	return
fi

echo "[2m[3mRegistering aliases for Windows[0m"

alias expl='explorer.exe /e,$(cygpath --path --windows .)'
