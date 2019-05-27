#!/bin/bash
# set up encrypted lvm

# @arguments
# swap size         size of swap        defaults to current amount of ram
# fs                file system to use  defaults to "btrfs"
# system partlabel  label of partition  defaults to same as $partlabel_system in ./partition-system-disk.bash
# efi partlabel     label of partition  defaults to same as $partlabel_efi in ./partition-system-disk.bash

function alis_encrypted_lvm_create {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	# shellcheck disable=SC2155
	# defaults
	local _default_size_swap="$(free -h | gawk  '/Mem:/{print $2}')"
	local _default_fs="btrfs"
	local _default_partlabel_system="system"
	local _default_partlabel_efi="EFI"

	if [ $1 = "help" ]; then
		echo "=> You can specify the following:"
		echo "==> size of swap, defaults to your memory size ($_default_size_swap)"
		echo "==> file system (default: $_default_fs)"
		echo "==> partlabel for root (default: $_default_partlabel_system)"
		echo "==> partlabel for EFI (default: $_default_partlabel_efi)"
		echo "=> Usage:"
		echo "=> $_script_name 8.1G ext4 system EFI"
		exit 125
	fi

	# set argument vars with fallbacks
	local _size_swap=${1:-$_default_size_swap}
	local _fs=${2:-$_default_fs}
	local _partlabel_system=${3:-$_default_partlabel_system}
	local _partlabel_efi=${4:-$_default_partlabel_efi}

	echo "=> Formatting boot partition"
	mkfs.fat -F 32 -n $_partlabel_efi /dev/disk/by-partlabel/$_partlabel_efi

	echo "=> Encrypting $_partlabel_system partition"
	cryptsetup --batch-mode -c aes-xts-plain64 -y --use-random \
		luksFormat /dev/disk/by-partlabel/$_partlabel_system

	echo "=> Opening encrypted volume"
	cryptsetup --batch-mode luksOpen /dev/disk/by-partlabel/$_partlabel_system luks

	echo "=> Initialising LVM"
	pvcreate /dev/mapper/luks
	vgcreate vg0 /dev/mapper/luks

	echo "=> Creating LVM swap partition, size: $_size_swap"
	lvcreate --size $_size_swap --name swap -C y vg0

	echo "=> Creating LVM root partition, size: all remaining space"
	lvcreate -l +100%FREE --name root vg0

	echo "=> Formatting root partition"
	# shellcheck disable=SC2092
	mkfs.$_fs --force /dev/mapper/vg0-root

	echo "=> Creating swap"
	mkswap -L "cryptswap" /dev/mapper/vg0-swap

	echo -e "\n[${_script_name}] Done\n"
}

alis_encrypted_lvm_create $1 $2 $3 $4
