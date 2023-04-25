#!/bin/sh

echo ""
echo "[2m[3mDefining function describer helper function[0m"

function __describe_function() {
	if [ "$#" -ne 2 ]; then
		echo -e "\t usage: __describe_function <name of the function> <description of the function>"
	fi

	local function_name=${1}
	local function_desc=${2}

	if [ -n "$(type -t ${function_name})" ] && [ $(type -t ${function_name}) = "function" ]; then
		echo "[1m[34m${function_name}[0m --> ${function_desc}"
	else
		echo -e "\t[1m[31m${function_name} is not a function :[[0m"
	fi
}

declare -A FUNCTIONS
