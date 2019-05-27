#!/bin/bash

function alis_systemd_run {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo "[${_script_name}]"

	local _default_is_wait=false

	if [[ -z $1 ]] || [[ -z $2 ]] || [[ $1 == "help" ]]; then
		echo "=> You must specify the following:"
		echo "==> A target container name"
		echo "==> The command you want to execute"
		echo "==> Usage:"
		echo "==> $_script_name my-container \"/usr/bin/echo hi\""
		echo -e "\n=> You can also specifiy the following:"
		echo "==> Whether to wait for the command to exit (default: ${_default_is_wait})"
		echo "==> Usage:"
		echo "==> $_script_name my-container \"/usr/bin/echo hi\" true"
		echo "[${_script_name}]"

		exit 125
	fi

	local _args="--no-ask-password --pty"
	local _container_name=$1
	local _command=$2
	local _is_wait=${3:-$_default_is_wait}

	if [ $_is_wait == true ]; then
		_args+=" --wait"
	fi

	echo "=> Using container: ${_container_name}"
	echo "==> Executing: ${_command}"
	# shellcheck disable=SC2046
	systemd-run $_args -M $_container_name /bin/bash -c "$_command"

	echo -e "[${_script_name}] Done\n"
}

alis_systemd_run "$1" "$2" $3
