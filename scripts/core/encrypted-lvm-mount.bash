#!/bin/bash
# set up encrypted lvm

# @arguments
# swap size         size of swap        defaults to current amount of ram
# fs                file system to use  defaults to "btrfs"
# system partlabel  label of partition  defaults to same as $partlabel_system in ./partition-system-disk.bash
# efi partlabel     label of partition  defaults to same as $partlabel_efi in ./partition-system-disk.bash

function alis_encrypted_lvm_mount {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	# set defaults
	local _default_mount_point_boot="boot"
	local _default_disk_partlabel_efi="EFI"
	local _default_mount_options="defaults,x-mount.mkdir,compress=lzo,ssd,noatime"

	if [ -z $1 ] || [ $1 = "help" ]; then
		echo "=> You must specifiy a mount point, usage:"
		echo "=> $_script_name /mnt"
		echo -e "\n=> You can also specify:"
		echo "==> The mount point for the boot partition (default $_default_mount_point_boot)"
		echo "==> The EFI partlabel (default $_default_disk_partlabel_efi)"
		echo "==> Mount options for root (default $_default_mount_options)"
		echo "==> $_script_name /mnt /mnt/boot EFI"
		echo -e "[${_script_name}]\n"
		exit 125
	fi

	local _mount_point=$1
	local _mount_point_boot=${2:-$_default_mount_point_boot}
	local _disk_partlabel_efi=${3:-$_default_disk_partlabel_efi}
	local _mount_options=${4:-$_default_mount_options}

	echo "=> Mounting root"
	mount /dev/mapper/vg0-root $_mount_point -o $_mount_options

	echo "=> Enabling swap"
	swapon /dev/mapper/vg0-swap

	echo "=> Creating directory for boot partition at '${_mount_point_boot}'"
	mkdir $_mount_point_boot

	echo "=> Mounting boot partition"
	mount  /dev/disk/by-partlabel/$_disk_partlabel_efi $_mount_point_boot

	echo -e "\n[${_script_name}] Done\n"
}

alis_encrypted_lvm_mount $1 $2 $3 $4
