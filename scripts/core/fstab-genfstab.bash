#!/bin/bash

function alis_genfstab {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_mount_point="/"

	if [ $1 = "help" ]; then
		echo "=> You can specify a mount point (default: ${_default_mount_point})"
		echo "==> Usage:"
		echo "===> $_script_name /mnt"
		exit 1
	fi

	local _mount_point=${1:-$_default_mount_point}

	if [[ $_mount_point != "$_default_mount_point" ]]; then
		_mount_point="${_mount_point}/"
	fi

	genfstab -U -p $_mount_point >> "${_mount_point}etc/fstab"

	echo -e "\n[${_script_name}] Done\n"
}

alis_genfstab $1
