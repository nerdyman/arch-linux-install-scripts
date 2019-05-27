#!/bin/bash
# partition disk for arch install

function alis_partition_system_disk {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	# default boot partition size
	local _default_disk_size_boot="250MiB"
	local _default_partlabel_system="system"
	local _default_partlabel_efi="EFI"

	if [ -z $1 ] || [ $1 = "help" ]; then
		echo "=> You must specify a disk target, usage:"
		echo "=> $(basename $0) /dev/sda"
		echo -e "\n=>You may also set following:"
		echo "==> boot partition size (default: $_default_disk_size_boot)"
		echo "==> system partition partlabel (default: $_default_partlabel_system)"
		echo "==> efi partition partlabel (default: $_default_partlabel_efi)"
		echo "==> $(basename $0) /dev/sda 500MiB mysystem myefi"
		exit 1
	fi

	# set argument vars with fallbacks
	local _disk_target=$1
	local _disk_size_boot=${2:-$_default_disk_size_boot}
	local _partlabel_system=${3:-$_default_partlabel_system}
	local _partlabel_efi=${4:-$_default_partlabel_efi}

	echo "=> Erasing $_disk_target"
	# erase disk and mbr/gpt table
	sgdisk --zap-all $_disk_target > /dev/null

	echo "=> Creating partitions on $_disk_target"
	echo "==> boot: $_disk_size_boot"
	echo "==> $_partlabel_system: all remaining space"
	sgdisk --clear \
		--new=1:0:+$_disk_size_boot  --typecode=1:ef00 --change-name=1:$_partlabel_efi \
		--new=2:0:0 --typecode=2:8300 --change-name=2:$_partlabel_system \
		$_disk_target

	echo -e "\n[${_script_name}] Done\n"
}

alis_partition_system_disk $1 $2 $3 $4
