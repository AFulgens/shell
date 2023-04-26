#!/bin/sh

# Update the title of the window
TITLE="${PROJECT_NAME} - ShellMagick"
if $cygwin; then
	TITLE="${TITLE} (Cygwin)"
fi

settitle "${TITLE}"

echo "[1m[33m"

if [[ -f "${PROJECT_PATH}/.banner" ]]; then
	cat "${PROJECT_PATH}/.banner"; echo
else
	PROJECT_NAME_LENGTH=$(echo $((${#PROJECT_NAME}+20)))

	for i in $(seq 1 $PROJECT_NAME_LENGTH); do echo -n "*"; done; echo
	echo "* ShellMagick for ${PROJECT_NAME} *"
	for i in $(seq 1 $PROJECT_NAME_LENGTH); do echo -n "*"; done; echo

	unset PROJECT_NAME_LENGTH
fi
echo -n "[0m"
