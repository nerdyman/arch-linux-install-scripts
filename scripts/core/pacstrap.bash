#!/bin/bash

# run pacstrap

function alis_pacstrap {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_sync_packages=true
	local _default_is_intel=false

	if [[ -z $1 ]] || [[ $1 = "help" ]]; then
		echo "=> You must specify a mount point, usage:"
		echo "$_script_name /mnt"
		echo -e "\\n=> You can also specify the following:"
		echo "=> To sync package databases (default ${_default_sync_packages})"
		echo "=> Whether you have an Intel processor (default: ${_default_is_intel})"
		echo "=> The kernel(s) you want to install ('linux' is always installed)"
		echo "   -> Comma separated, possible values 'hardened,lts,zen'"
		echo -e "\\n=> Usage:"
		echo "=> $_script_name /mnt true true hardened,zen,lts"
		echo -e "\\n[${_script_name}] Done\\n"
		exit 125
	fi

	local _mount_point=$1
	local _sync_packages=${2:-$_default_sync_packages}
	local _is_intel=${3:-$_default_is_intel}
	local _kernels=${4:-"linux"}

	if [[ $_sync_packages = true ]]; then
		echo "=> Syncing package databases"
		pacman -Syy --noconfirm archlinux-keyring
	fi

	local _packages="base base-devel parted dosfstools btrfs-progs f2fs-tools gptfdisk ntp net-tools linux-headers"

	# add requested kernels to package list
	IFS=', ' read -r -a _kernels_array <<< "$_kernels"

	for _kernel in "${_kernels_array[@]}"
	do
		if [[ $_kernel == "hardened" ]] || [[ $_kernel == "lts" ]] || [[ $_kernel == "zen" ]]; then
			echo "=> Adding 'linux-${_kernel}' to package list"
			_packages+=" linux-${_kernel} linux-${_kernel}-headers"
		elif [[ $_kernel != "linux" ]]; then
			echo "=> WARNING: '${_kernel}' is not a valid kernel, skipping"
		fi
	done

	# add intel-ucode if requested
	if [[ $_is_intel = true ]]; then
		echo "=> Adding 'intel-ucode' to package list"
		_packages+=" intel-ucode"
	fi

	echo "=> Running pacstrap"
	# shellcheck disable=SC2086
	pacstrap "$_mount_point" $_packages

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_pacstrap "$1" "$2" "$3" "$4"
