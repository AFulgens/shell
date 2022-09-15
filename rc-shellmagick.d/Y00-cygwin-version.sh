#!/bin/sh

if ! $cygwin; then
	return
fi

echo ""
echo "[1mCygwin version:[0m"
echo "[1m---------------[0m"

cygcheck -cds 2>/dev/null | grep "DLL version:" | uniq | sed 's/  //g'
