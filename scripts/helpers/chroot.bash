#!/bin/bash

# helper for arch chroot

function alis_chroot {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [[ -z $1 ]] || [[ -z $2 ]] || [[ $1 == "help" ]]; then
		echo "=> You must specify a mount point and a command"
		echo "=> Usage:"
		echo "=> ${_script_name} /mnt passwd"
		exit 125
	fi

	echo "=> Running: '${2}' on mount point: '${1}'"

	arch-chroot "$1" /bin/bash -c "$2"

	echo -e "\n[${_script_name}] Done\n"
}

alis_chroot "$1" "$2"
