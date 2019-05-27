#!/bin/bash

function alis_machinectl_kill_container {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [ -z $1 ] || [ $1 == "help" ]; then
		echo "=> You must specify the following:"
		echo "==> A target container name"
		echo "==> Usage:"
		echo "==> $_script_name my-container"
		echo "[${_script_name}]"

		exit 125
	fi;

	local _container_name=$1

	echo "=> Terminating container: $_container_name"
	machinectl terminate $_container_name

	echo -e "\n[${_script_name}] Done\n"
}

alis_machinectl_kill_container $1
