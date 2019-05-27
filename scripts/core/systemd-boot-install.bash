#!/bin/bash

function alis_systemd_boot_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]"

	if [ -z $1 ] || [ -z $2 ] || [ $1 == "help" ]; then
		echo "=> You must specify both root and boot directories"
		echo "=> Usage:"
		echo "=> $_script_name /mnt /boot"
		exit 125;
	fi

	local _root_dir=$1
	local _install_dir=$2

	echo "=> Installing bootloader to: $_install_dir"

	arch-chroot $_root_dir /bin/bash -c "mkdir -p $_install_dir && bootctl --path=$_install_dir install"

	echo -e "[$_script_name] Done\n"
}

alis_systemd_boot_install $1 $2
