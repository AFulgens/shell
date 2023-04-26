#!/bin/sh

echo "Note: the tests will run in this git repository and will create temporary files and branches"
echo "(Everything should be cleaned up though after the tests are done)"
echo

pushd tests >/dev/null

for test in $(ls *.test); do
	echo "Running ${test}"
	sh ${test}
	echo
done

popd >/dev/null
