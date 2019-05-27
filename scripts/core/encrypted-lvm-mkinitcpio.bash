#!/bin/bash

# shellcheck disable=SC2089
# shellcheck disable=SC2090

function _alis_encrypted_lvm_mkinitcpio {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_is_hardened=true
	local _default_chroot=false

	local _backup_path="/etc/mkinitcpio.conf.orig"

	if [ $1 = "help" ]; then
		echo "=> You can specify the following:"
		echo "=> Whether to run for 'linux-hardened' (default: ${_default_is_hardened})"
		echo "=> Directory to run commands via chroot (default: ${_default_chroot})"
		echo "=> Usage:"
		echo "$_script_name true /mnt"
		echo -e "\n[${_script_name}] Done\n"
		exit 125
	fi;

	local _is_hardened=${1:-$_default_is_hardened}
	local _chroot=${2:-_default_chroot}

	local _mkinitcpio_config="MODULES=\"btrfs\"\n"
	_mkinitcpio_config+="BINARIES=\"\"\n"
	_mkinitcpio_config+="FILES=\"\"\n"
	_mkinitcpio_config+="HOOKS=\"base udev autodetect modconf block keymap encrypt lvm2 resume filesystems keyboard fsck\"\n"

	if [ $_chroot == false ]; then
		echo "Moving original config to ${_backup_path}"
		mv /etc/mkinitcpio.conf $_backup_path

		echo "=> Writing new mkinitcpio file"
		echo -e $_mkinitcpio_config > /etc/mkinitcpio.conf

		echo "=> Running mkinitcpio"
		mkinitcpio -p linux

		if [ $_is_hardened = true ]; then
			echo "=> Running mkinitcpio for linux-hardened"
			mkinitcpio -p linux-hardened
		fi;
	else
		echo "Moving original config to ${_backup_path}"
		arch-chroot $_chroot /bin/bash -c "mv /etc/mkinitcpio.conf $_backup_path"

		echo "=> Writing new mkinitcpio file"
		arch-chroot $_chroot /bin/bash -c "echo -e ${_mkinitcpio_config} > /etc/mkinitcpio.conf"

		echo "=> Running mkinitcpio"
		arch-chroot $_chroot /bin/bash -c "mkinitcpio -p linux"

		if [ $_is_hardened = true ]; then
			echo "=> Running mkinitcpio for linux-hardened"
			arch-chroot $_chroot /bin/bash -c "mkinitcpio -p linux-hardened"
		fi;
	fi;

	echo -e "\n[${_script_name}] Done\n"
}

_alis_encrypted_lvm_mkinitcpio $1
