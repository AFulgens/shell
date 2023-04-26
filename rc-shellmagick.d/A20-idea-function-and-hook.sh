#!/bin/sh

echo ""

if [[ -z ${GLOBAL_IDEA_USE+x} ]]; then
	echo "[2m[3mSkipping setup for IntelliJ IDEA (variable GLOBAL_IDEA_USE is unset)[0m"
	return
fi

echo "[2m[3mSetting up IntelliJ IDEA[0m"

if [[ -z ${INTELLIJ_HOME+x} ]]; then
	INTELLIJ_HOME="${PATH_TOOLS}/idea"
fi

INTELLIJ_BIN="${INTELLIJ_HOME}/bin"

if [[ -d ${INTELLIJ_BIN} ]]; then
	function idea {
		# We are so early in the bootstrapping process, that pushd/popd are not hushed yet
		pushd "${PROJECT_PATH}" >/dev/null
		"${INTELLIJ_BIN}"/idea64.exe . &
		popd >/dev/null
	}
	FUNCTIONS[idea]="open current project in IntelliJ IDEA"

	while true; do
		printf >&2 "\tDo you want to start IntelliJ IDEA now for this project? (Y/n) "
		IFS= read -r start_idea

		if [[ ${start_idea} =~ [nN] ]]; then
			echo -e "[2m[3mNot starting IntelliJ IDEA[0m"
		else
			if [[ ${start_idea} =~ [yY]? ]]; then
				echo -e "[2m[3mStarting IntelliJ IDEA[0m"
				idea .
			else
				echo "This is a yes or no question!"
				continue
			fi
		fi
		break
	done
else
	echo -e "[1m[31m\tFAILURE: IntelliJ IDEA binary folder not found![0m"
	return
fi
