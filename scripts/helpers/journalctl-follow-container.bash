#!/bin/bash

function alis_journalctl_follow_container {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"

	if [ -z "$1" ] || [ "$1" == "help" ]; then
		echo -e "[${_script_name}]\n"

		echo "You must specify a container name, usage:"
		echo -e "$_script_name alis"
		echo "[${_script_name}]"

		exit 125
	fi;

	journalctl --follow --no-tail --machine $1

	echo -e "\n[${_script_name}] Done\n"
}

alis_journalctl_follow_container $1
