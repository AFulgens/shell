#!/bin/sh

echo ""

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping setup for Java (no pom.xml found)[0m"
	return
fi

echo "[2m[3mSetting up Java[0m"

echo ""

JAVA_VERSION=$(cat ${PROJECT_PATH}/pom.xml | grep "java.version" | head -n1 | cut -d'>' -f2 | cut -d'<' -f1)
echo "[2m[3m(Looking for version "${JAVA_VERSION}")[0m"

if [[ -z ${JAVA_BASE+x} ]]; then
	echo -e "[1m\t\$JAVA_BASE is not set[0m"
	if [[ -z ${JAVA_HOME+x} ]]; then
		echo -e "[1m\t\$JAVA_HOME is not set, we are looking for a azul-* in the version based on the pom.xml in ${PATH_TOOLS}[0m"
		JAVA_HOME=$(find ${PATH_TOOLS} -type d -name "azul-${JAVA_VERSION}*")
	else
		echo -e "[1m\t\$JAVA_HOME is set, we are pivoting to that (by thus ignoring the project's pom.xml)[0m"
	fi
else
	echo -e "[1m\t\$JAVA_BASE is set, we are pivoting to that folder instead of ${PATH_TOOLS}, we are looking for a azul-* in the version based on the pom.xml[0m"
	JAVA_HOME=$(find ${JAVA_BASE} -type d -name "azul-${JAVA_VERSION}*")
fi

if [[ -z ${JAVA_HOME+x} ]]; then
	echo -e "[1m[31m\tFAILURE: Java not found![0m"
else
	JAVA_HOME="$(cygpath --path --unix $JAVA_HOME)"
	PATH=${JAVA_HOME}/bin:${PATH}
	echo ""
	echo "[1mJava version:[0m"
	echo "[1m-------------[0m"
	java -version
fi

unset CANDIDATE