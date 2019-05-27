#!/bin/bash

# shellcheck disable=SC2089
# shellcheck disable=SC2090

function alis_mkinitcpio_config {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_output_path="/etc/mkinitcpio.conf"
	local _default_backup_enabled=true

	if [ $1 = "help" ]; then
		echo "=> You can specify the following:"
		echo "=> A path to write the config to (default: ${_default_output_path})"
		echo "=> Whether to the existing config (default: ${_default_backup_enabled})"
		echo "=> Usage:"
		echo "$_script_name /mnt/etc/mkinitcpio.conf false"
		echo -e "\n[${_script_name}] Done\n"
		exit 125
	fi

	local _output_path=${1:-$_default_output_path}
	local _backup_enabled=${2:-$_default_backup_enabled}

	local _backup_path="${_output_path}.alis"

	local _mkinitcpio_config="MODULES=\"btrfs\"\n"
	_mkinitcpio_config+="BINARIES=\"\"\n"
	_mkinitcpio_config+="FILES=\"\"\n"
	_mkinitcpio_config+="HOOKS=\"base udev autodetect keyboard keymap modconf block encrypt lvm2 resume filesystems fsck\"\n"

	if [[ -f $_output_path ]] && [[ $_backup_enabled == true ]]; then
		echo "=> Copying original ${_output_path} to ${_backup_path}"
		cp -f $_output_path $_backup_path
	fi

	echo -e $_mkinitcpio_config > $_output_path

	echo -e "\n[${_script_name}] Done\n"
}

alis_mkinitcpio_config "$1" $2
