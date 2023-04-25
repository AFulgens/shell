#!/bin/sh

echo ""

if [[ -z ${GLOBAL_FORK_USE+x} ]]; then
	echo "[2m[3mSkipping setup for Fork (variable GLOBAL_FORK_USE is unset)[0m"
	return
fi

echo -n "[2m[3mRegistering global Fork commands "

if [[ ! -z ${GLOBAL_FORK_DO_NOT_OVERRIDE+x} ]]; then
	echo "by (optionally) adding commands the original content of the .fork directory[0m"
	if [ ! -d ${PROJECT_PATH}/.fork ]; then
		mkdir -p ${PROJECT_PATH}/.fork
	fi
	for command in $(ls ../fork-commands/*); do
		# Sadly, `cp -n` is not supported everywhere, so we have to handroll the logic
		target="${PROJECT_PATH}/.fork/$(basename ${command})"
		if [ ! -f "${target}" ]; then
			cp "${command}" "${target}"
			chmod +x "${target}"
		else
			echo -e "\t[1m[33m$(basename ${command}) already exists, not touching it[0m"
		fi
	done
else
	echo "by overriding already existing commands in .fork directory[0m"
	mkdir -p ${PROJECT_PATH}/.fork
	cp ../fork-commands/* ${PROJECT_PATH}/.fork
	chmod +x ${PROJECT_PATH}/.fork/*
fi