#!/bin/sh

echo ""

if [[ ! -f "${GLOBAL_MAILMAP_PATH}" ]]; then
	echo "[2m[3mSkipping global mailmap registration (no path set)[0m"
	return
fi

echo -n "[2m[3mRegistering global mailmap by potentially overriding already existing .mailmap[0m"

cat ${GLOBAL_MAILMAP_PATH} > ${PROJECT_PATH}/.mailmap
