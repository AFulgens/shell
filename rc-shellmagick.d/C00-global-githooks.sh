#!/bin/sh

echo ""
echo -n "[2m[3mRegistering global git hooks "

if [[ ! -z ${!GLOBAL_GITHOOKS_DO_NOT_OVERRIDE+x} ]]; then
	echo "by (optionally) adding hooks the original content of the .git/hooks directory[0m"
	if [ ! -d ${PROJECT_PATH}/.git/hooks ]; then
		mkdir -p ${PROJECT_PATH}/.git/hooks
	fi
	for hook in $(ls ../global-git-hooks/*); do
		# Sadly, `cp -n` is not supported everywhere, so we have to handroll the logic
		target="${PROJECT_PATH}/.git/hooks/$(basename ${hook})"
		if [ ! -f "${target}" ]; then
			cp "${hook}" "${target}"
			chmod +x "${target}"
		else
			echo -e "\t[1m[33m$(basename ${hook}) already exists, not touching it[0m"
		fi
	done
else
	echo "by overriding already existing hooks in .git/hooks directory[0m"
	mkdir -p ${PROJECT_PATH}/.git/hooks
	cp ../global-git-hooks/* ${PROJECT_PATH}/.git/hooks
	chmod +x ${PROJECT_PATH}/.git/hooks/*
fi