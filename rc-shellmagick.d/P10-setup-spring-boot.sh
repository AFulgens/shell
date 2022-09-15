#!/bin/sh

echo ""

if [[ ! -f "${PROJECT_PATH}/pom.xml" ]]; then
	echo "[2m[3mSkipping setup for Spring-Boot (no pom.xml found)[0m"
	return
fi

echo "[2m[3mSetting up for Spring-Boot[0m"

alias sbl='sb local'

function sb {
	mvn spring-boot:run -Dspring-boot.run.profiles=$1
}
FUNCTIONS[sb]="run Spring boot via maven with the profile given as parameter"
