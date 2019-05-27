#!/bin/bash

function alis_filesystems_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="autofs dosfstools exfat-utils f2fs-tools fuse fuse-exfat gvfs gvfs-google ntfs-3g mtpfs"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	echo -e "\n[${_script_name}] Done\n"
}

alis_filesystems_install
