#!/bin/sh

pushd ${RC_SHELLMAGICK_PATH} 1>/dev/null

# We fix the glob to the sh-extension, because
# a) /usr/local/etc/rc.d has the same (for rc(8))
# b) this way we can have other (documentation, helper) files in the directory
for rc_file in $(ls *.sh); do
	source $rc_file
done

popd 1>/dev/null
