#!/bin/bash

function alis_systemd_boot_entry_encrypted_lvm {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	# defaults
	local _default_mount_point="/mnt/boot"
	local _default_title="Arch Linux"
	local _default_file_name="arch"
	local _default_kernel="linux"
	local _default_is_intel=false

	if [ -z "$1" ] || [ "$1" == "help" ]; then
		echo "=> You must specify a disk target (preferably PARTUUID or UUID)"
		echo "=> Usage:"
		echo "=> $_script_name <partuuid>"
		echo -e "\\n=> You can also specify the following ordered arguments:"
		echo " -> Mount point (default: '${_default_mount_point}')"
		echo " -> Title (default: '${_default_title}')"
		echo " -> File name (default: '${_default_file_name}')"
		echo " -> Kernel image to use (linux|hardened|lts|zen) - default: '${_default_kernel}'"
		echo " -> If you have an Intel processor (default: ${_default_is_intel})"
		echo -e "\\n[${_script_name}] Done\\n"
		exit 125
	fi

	# parsed params
	local _disk_uid=$1
	local _mount_point=${2:-$_default_mount_point}
	local _title=${3:-$_default_title}
	local _file_name=${4:-$_default_file_name}
	local _kernel=${5:-$_default_kernel}
	local _is_intel=${6:-$_default_is_intel}

	# consts
	local _output_path="/loader/entries/"

	echo "=> Creating boot entry"

	# init boot entry
	local _boot_entry="title $_title\\n"

	# linux
	_boot_entry+="linux /vmlinuz-linux"

	if [[ $_kernel = "hardened" ]] || [[ $_kernel = "lts" ]] || [[ $_kernel = "zen" ]]; then
		_boot_entry+="-${_kernel}"
	elif [[ $_kernel != "linux" ]]; then
		echo "=> WARNING: '${_kernel}' is not a valid vmlinuz image, using vanilla Linux instead."
	fi

	_boot_entry+="\\n"

	# intel
	if [[ $_is_intel = true ]]; then
		_boot_entry+="initrd /intel-ucode.img\\n"
	fi

	# initramfs
	_boot_entry+="initrd /initramfs-linux"

	if [[ $_kernel = "hardened" ]] || [[ $_kernel = "lts" ]] || [[ $_kernel = "zen" ]]; then
		_boot_entry+="-${_kernel}"
	elif [[ $_kernel != "linux" ]]; then
		echo "=> WARNING: '${_kernel}' is not a valid initramfs image, using vanilla Linux instead."
	fi

	_boot_entry+=".img\\n"

	# options
	_boot_entry+="options cryptdevice=${_disk_uid}:lvm:allow-discards resume=/dev/mapper/vg0-swap root=/dev/mapper/vg0-root quiet rw"

	# set full output path
	_full_path="${_mount_point}${_output_path}${_file_name}.conf"

	echo "=> Writing boot entry to $_full_path"
	# touch $_full_path
	# shellcheck disable=SC2086
	echo -e $_boot_entry > "$_full_path"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_systemd_boot_entry_encrypted_lvm "$1" "$2" "$3" "$4" "$5" "$6"
