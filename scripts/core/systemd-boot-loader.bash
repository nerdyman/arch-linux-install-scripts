#!/bin/bash

# create loader config for systemd-boot

function alis_systemd_boot_loader {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_timeout=5

	if [ -z $1 ] || [ -z $2 ] || [ $1 == "help" ]; then
		echo "=> You must specify an install directory and a default entry"
		echo "=> Usage:"
		echo "=> $_script_name /mnt/boot arch"
		echo -e "\n=> You can also specify a timeout (default: ${_default_timeout})"
		echo "==> Usage:"
		echo "==> $_script_name /mnt/boot arch 10"
		exit 125;
	fi;

	local _install_dir=$1
	local _entry=$2
	local _timeout=${3:-$_default_timeout}

	echo "timeout ${_timeout}
default ${_entry}
editor 0
" > "${_install_dir}/loader/loader.conf"

	echo "[${_script_name}] Done"
}

alis_systemd_boot_loader $1 $2 $3
