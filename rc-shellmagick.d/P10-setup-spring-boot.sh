#!/bin/sh

echo ""

if [[ -z ${SETUP_SPRING_BOOT+x} ]]; then
	echo "[2m[3mSkipping setup for Spring-Boot (variable SETUP_SPRING_BOOT is unset)[0m"
	return
fi

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping setup for Spring-Boot (no pom.xml found)[0m"
	return
fi

echo "[2m[3mSetting up Spring-Boot[0m"

alias sbl='sb local'

function sb {
	mvn spring-boot:run -Dspring-boot.run.profiles=$1
}
FUNCTIONS[sb]="run Spring boot via maven with the profile given as parameter"
