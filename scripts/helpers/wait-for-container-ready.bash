#!bin/bash

function _alis_wait_for_container_ready {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"

	echo "[${_script_name}]"

	if [ -z "$1" ] || [ "$1" == "help" ]; then
		echo "=> You must specify the following:"
		echo "==> A target container name"
		echo "==> The command you want to execute"
		echo "==> Usage:"
		echo "==> $_script_name my-container-name"

		exit 125
	fi

	local _name="$1"
	local _get_state="machinectl show ${_name} --value --property=State"
	local _state=""

	# check every second to see if container is up
	while true; do
		_state=$(eval "$_get_state" || echo "")

		if [[ "$_state" == "running" ]]; then
			echo "=> ${_name} is running"
			break
		else
			echo "=> ${_name} not running, polling..."
			sleep 1
		fi
	done

	echo -e "[${_script_name}] Done\\n"
}

_alis_wait_for_container_ready "$1"
