#!/bin/bash

function alis_systemd_nspawn {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_is_background=false
	local _default_container_name="arch-container"

	if [ -z $1 ] || [ "$1" == "help" ]; then
		echo "=> You must specify a mount point, usage:"
		echo "=> $_script_name /mnt"
		echo -e "\n=> You can also specifiy the following:"
		echo "==> A container name (default: ${_default_container_name})"
		echo "==> Whether to the force systemd-nspawn to the background (default: ${_default_is_background})"
		echo "==> Usage:"
		echo "==> $_script_name /mnt my-container true"
		echo "[${_script_name}]"

		exit 125
	fi;

	local _mount_point=$1
	local _container_name=${2:-$_default_container_name}
	local _is_background=${3:-$_default_is_background}

	echo "=> Spawning container on ${1}"

	if [ $_is_background == true ]; then
		# shellcheck disable=SC2210
		# spawn in background
		nohup systemd-nspawn -u root -M $_container_name -bD $_mount_point 2&>1 &
	else
		systemd-nspawn -u root -M $_container_name -bD $_mount_point
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_systemd_nspawn $1 $2 $3
