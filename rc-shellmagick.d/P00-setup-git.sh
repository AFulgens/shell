#!/bin/sh

echo ""
echo "[2m[3mSetting up Git[0m"

if [[ -z ${GIT_HOME+x} ]]; then
	GIT_VERSION=$(git --version 2>/dev/null)
else
	echo -e "[1m\tGIT_HOME is set, we are pivoting to that (by thus overriding any pre-installed version)[0m"
	GIT_VERSION=$(${GIT_HOME}/bin/git --version 2>/dev/null)
fi

if [[ -z ${GIT_VERSION+x} ]]; then
	echo -e "[1m[31m\tFAILURE: Could not determine git version![0m"
else
	PATH=${GIT_HOME}/bin:$PATH
	echo ""
	echo "[1mGit version:[0m"
	echo "[1m------------[0m"
	git --version
fi

unset GIT_VERSION
