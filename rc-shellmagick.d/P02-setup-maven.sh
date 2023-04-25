#!/bin/sh

echo ""

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping setup for Maven (no pom.xml found)[0m"
	return
fi

echo "[2m[3mSetting up Maven[0m"

if [[ -z ${JAVA_HOME+x} ]]; then
	echo -e "[1m[31m\tFAILURE: Java is not set up -> no setup possible for Maven[0m"
	return
fi

echo ""

export MVNW_VERBOSE=false

if [[ -z ${MAVEN_SETTINGS_FILE+x} ]]; then
	alias mvn="${PROJECT_PATH}/mvnw"
	echo "[1m\$MAVEN_SETTINGS_FILE: [1m[31mWARNING: No global settings file found[0m"
else
	# Currently this is not working in case ${MAVEN_SETTINGS_FILE} is already in Windows format, it will be prefixed with "C;"
	# MAVEN_SETTINGS_FILE=$(cygpath --path --windows ${MAVEN_SETTINGS_FILE})
	alias mvn="${PROJECT_PATH}/mvnw -gs \"${MAVEN_SETTINGS_FILE}\""
	echo "[1m\$MAVEN_SETTINGS_FILE: ${MAVEN_SETTINGS_FILE}[0m"
fi
echo "[1mNo user settings file will be used, only global (using two settings files is incompatible with IntelliJ IDEA)[0m"

echo ""
echo "[1mMaven version:[0m"
echo "[1m--------------[0m"
# only show relevant lines
pushd ${PROJECT_PATH}
mvn -version | grep "Maven"
export M2_HOME=$(mvn -version | grep "Maven home" | cut -d':' -f2- | cut -c2-)
echo "[1m\$M2_HOME: \"${M2_HOME}\"[0m"
popd
