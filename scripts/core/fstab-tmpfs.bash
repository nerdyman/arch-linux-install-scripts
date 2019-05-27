#!/bin/bash

function alis_fstab_tmpfs {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [[ $1 = "help" ]]; then
		"You can specify a mount point, usage:"
		echo "=> $_script_name /mnt"
		echo "=> Otherwise it will overwrite your main fstab (/etc/fstab)"
		exit 125
	fi

	local _fstab_path_prefix=${1:-""}

	echo "Adding tmpfs to $_fstab_path_prefix/etc/fstab"

	echo "tmpfs	/tmp	tmpfs	defaults,noatime,mode=1777	0	0
	" >> $_fstab_path_prefix/etc/fstab

	echo -e "\n[${_script_name}] Done\n"
}

alis_fstab_tmpfs $1
