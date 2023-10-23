#!/bin/sh

echo ""
echo "[2m[3mRegistering project-specific stuff[0m"

mkdir -p ${PROJECT_PATH}/.shellmagick

pushd ${PROJECT_PATH}/.shellmagick

# We fix the glob to the sh-extension, because
# a) /usr/local/etc/rc.d has the same (for rc(8))
# b) this way we can have other (helper) files in the directory
for rc_file in $(ls *.sh); do
	source $rc_file
done

popd 1>/dev/null
