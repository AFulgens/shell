#!/bin/sh

echo ""

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping setup for Java (no pom.xml found)[0m"
	return
fi

echo "[2m[3mSetting up for Java[0m"

JAVA_VERSION=$(cat ${PROJECT_PATH}/pom.xml | grep "java.version" | head -n1 | cut -d'>' -f2 | cut -d'<' -f1)

echo ""
echo "[2m[3m(Looking for version "${JAVA_VERSION}")[0m"

CANDIDATE=$(find ${TOOLS_PATH} -type d -name "zulu${JAVA_VERSION}*")

if [[ -z ${CANDIDATE} ]]; then
	echo -e "[1m[31m\tFAILURE: Java version ${JAVA_VERSION} not found![0m"
	JAVA_HOME=""
else
	JAVA_HOME="$(cygpath --path --unix $CANDIDATE)"
	PATH=${JAVA_HOME}/bin:${PATH}
	echo ""
	echo "[1mJava version:[0m"
	echo "[1m-------------[0m"
	java -version
fi

unset CANDIDATE