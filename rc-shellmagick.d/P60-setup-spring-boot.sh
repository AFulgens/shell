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

if [[ -z ${SPRING_PROFILES_ACTIVE+x} ]]; then
	echo -e "\t[2m[33mSkipping setup for Spring Boot (SPRING_PROFILES_ACTIVE not set)[0m"
	return
fi

alias sb="mvn spring-boot:run"
