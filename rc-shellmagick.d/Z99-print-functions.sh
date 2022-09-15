#!/bin/sh

echo ""
echo "[1m[34mHelper functions registered and available:[0m"
echo "[1m[34m------------------------------------------[0m"

function functions {
	sorted=($(echo ${!FUNCTIONS[@]} | tr ' ' $'\n' | sort))
	for f in "${sorted[@]}"; do
		__describe_function "$f" "${FUNCTIONS[$f]}"
	done
	echo ""
}
FUNCTIONS[functions]="print all helper functions registered and available"

functions
