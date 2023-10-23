#!/bin/sh

echo ""
echo "[2m[3mRegistering common function[0m"

# make pushd silent
function pushd {
	command pushd "$@" >/dev/null
}

# make popd silent
function popd {
	command popd "$@" >/dev/null
}

# recursively find files with the given name (case-sensitive)
# exclude libraries that usually are not looked for
function f {
	find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
	       -o -type f | grep --color "${1}"
}
FUNCTIONS[f]="find files with the given name (case-sensitive)"

# recursively find files with the given name (case-insensitive)
# exclude libraries that usually are not looked for
# fi is taken 🙄
function Fi {
	find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
	       -o -type f | grep -i --color "${1}"
}
FUNCTIONS[Fi]="find files with the given name (case-insensitive)"

# search for strings in files (optionally only files with names matching a pattern)
function ff {
	if [ "$#" -eq 1 ]; then # in all files
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -print0 \
		| xargs -0 grep --color "${1}"
	else # in files according to pattern
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -name "${2}" -print0 \
		| xargs -0 grep --color "${1}"
	fi
}
FUNCTIONS[ff]="find case-sensitive string files (optional second argument: file name pattern)"

# search for strings in files (optionally only files with names matching a pattern)
function ffi {
	if [ "$#" -eq 1 ]; then # in all files
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -print0 \
		| xargs -0 grep -i --color "${1}"
	else # in files according to pattern
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -name "${2}" -print0 \
		| xargs -0 grep -i --color "${1}"
	fi
}
FUNCTIONS[ffi]="find case-insensitive string files (optional second argument: file name pattern)"

# search for regex in files (optionally only files with names matching a pattern)
function ffir {
	if [ "$#" -eq 1 ]; then # in all files
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -print0 \
		| xargs -0 grep -Ei --color "${1}"
	else # in files according to pattern
		find . -type d \( -name "\.git" -o -name "\.idea" -o -name "target" -o -name "bin" \) -prune \
		       -o -type f -name "${2}" -print0 \
		| xargs -0 grep -Ei --color "${1}"
	fi
}
FUNCTIONS[ffir]="find case-insensitive regex files (optional second argument: file name pattern)"

# quick way home
function goto-project {
	cd "${PROJECT_PATH}"
}
FUNCTIONS[goto-project]="change directory to project root (currently: ${PROJECT_PATH})"
