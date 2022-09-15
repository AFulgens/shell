#!/bin/sh

if ! $cygwin; then
	return
fi

echo ""
echo "[2m[3mLooks like you are using Cygwin, let's fix some stuff[0m"

export TERM=cygwin
