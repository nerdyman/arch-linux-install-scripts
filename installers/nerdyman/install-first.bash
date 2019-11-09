#!/bin/bash
# base install script

# shellcheck disable=SC1090

set -e

# shellcheck disable=SC2046
alis_installer_wd=$(dirname $(realpath "$0"))

_default_kill_container=true
_kill_container=${1:-$_default_kill_container}

# load config
source "${alis_installer_wd}/../../installers/config.bash"
source "${alis_installer_wd}/../../installers/shared.bash"

# wipe install target disk
# source ${alis_installer_wd}/../../scripts/core/wipe-disk.bash $DISK_TARGET

# partition install target disk
source "${alis_installer_wd}/../../scripts/core/partition-system-disk.bash" \
	"${DISK_TARGET}" \
	"${DISK_SIZE_BOOT}" \
	"${DISK_PARTLABEL_SYSTEM}" \
	"${DISK_PARTLABEL_EFI}"

print_line

# need to wait between partitioning and mounting new volumes for some reason
sleep 3

# set up encrypted lvm
source "${alis_installer_wd}/../../scripts/core/encrypted-lvm-create.bash" \
	"${DISK_SIZE_SWAP}" \
	"${DISK_FS_ROOT}" \
	"${DISK_PARTLABEL_SYSTEM}" \
	"${DISK_PARTLABEL_EFI}"

print_line

# mount encrypted lvm
source "${alis_installer_wd}/../../scripts/core/encrypted-lvm-mount.bash" \
	"${MOUNT_POINT}" \
	"${MOUNT_POINT_BOOT}" \
	"${DISK_PARTLABEL_EFI}" \
	"${MOUNT_OPTIONS_SYSTEM}"

print_line

# set mirrorlist (https: true, http: false)
source "${alis_installer_wd}/../../scripts/core/pacman-set-mirrorlist.bash" \
	"${CONFIG_PACMAN_MIRROR}" \
	true \
	false

print_line

# run pacstrap on mounted volume
source "${alis_installer_wd}/../../scripts/core/pacstrap.bash" \
	"$MOUNT_POINT" \
	true \
	"$IS_INTEL" \
	"zen"

print_line

# generate and write fstab for mounted volume
source "${alis_installer_wd}/../../scripts/core/fstab-genfstab.bash" "${MOUNT_POINT}"

print_line

# add tmpfs to fstab on mounted volume
source "${alis_installer_wd}/../../scripts/core/fstab-tmpfs.bash" "${MOUNT_POINT}"

print_line

# install systemd-boot
source "${alis_installer_wd}/../../scripts/core/systemd-boot-install.bash" \
	"${MOUNT_POINT}" \
	"${MOUNT_PATH_BOOT}"

print_line

# get the partuuid of the installation target disk
_alis_installer_disk_target_uid="PARTUUID="$(source "${alis_installer_wd}/../../scripts/helpers/get-partuuid-by-id.bash" "${DISK_TARGET}2")

print_line

# create zen boot entry
source "${alis_installer_wd}/../../scripts/core/systemd-boot-entry-encrypted-lvm.bash" \
	"$_alis_installer_disk_target_uid" \
	"$MOUNT_POINT_BOOT" \
	"Arch Linux Zen Kernel" \
	"arch" \
	"zen" \
	"$IS_INTEL"

print_line

# create vanilla entry
source "${alis_installer_wd}/../../scripts/core/systemd-boot-entry-encrypted-lvm.bash" \
	"$_alis_installer_disk_target_uid" \
	"$MOUNT_POINT_BOOT" \
	"Arch Linux" \
	"arch_vanilla" \
	"linux" \
	"$IS_INTEL"

print_line

# create loader entry
source "${alis_installer_wd}/../../scripts/core/systemd-boot-loader.bash" \
	"${MOUNT_POINT_BOOT}" \
	"arch" \
	5

print_line

# write new mkinitcpio.conf with encrypt and lvm2 to new install
source "${alis_installer_wd}/../../scripts/core/mkinitcpio-config.bash" \
	"${MOUNT_POINT}/etc/mkinitcpio.conf" \
	true

print_line

# copy scripts to new install
alis_shared_copy_files
print_line

# write new vconsole.conf to new install
source "${alis_installer_wd}/../../scripts/core/vconsole.bash" \
	"${CONFIG_VCONSOLE}" \
	"${MOUNT_POINT}/etc/vconsole.conf"

print_line

# set locale
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"/bin/bash  ${ALIS_COPY_DIRECTORY}/scripts/core/locale.bash $CONFIG_LOCALE $CONFIG_LOCALE_SECONDARY"

print_line

# set root password
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"/bin/bash ${ALIS_COPY_DIRECTORY}/scripts/core/user-root-password.bash"

print_line

# configure sudo
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"/bin/bash ${ALIS_COPY_DIRECTORY}/scripts/core/sudo-configure.bash"

print_line

# add superuser
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"/bin/bash ${ALIS_COPY_DIRECTORY}/scripts/core/user-create.bash $CONFIG_USER_USERNAME $CONFIG_USER_SHELL"

print_line

# install shell if it doesn't exist
alis_shared_shell_install "${CONFIG_USER_SHELL}"
print_line

# copy etc configs to new install
alis_shared_copy_configs_etc

print_line

# install editor
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"/bin/bash ${ALIS_COPY_DIRECTORY}/scripts/core/vim-install.bash true $CONFIG_USER_USERNAME"

print_line

# spawn container in background
source "${alis_installer_wd}/../../scripts/helpers/systemd-nspawn.bash" \
	"${MOUNT_POINT}" \
	"${CONFIG_HOSTNAME}" \
	true

print_line

# wait until container is up
source "${alis_installer_wd}/../../scripts/helpers/wait-for-container-ready.bash" "${CONFIG_HOSTNAME}"

print_line

# run mkinitcpio
source "${alis_installer_wd}/../../scripts/helpers/chroot.bash" \
	"${MOUNT_POINT}" \
	"mkinitcpio -P"

print_line

# set hostname
source "${alis_installer_wd}/../../scripts/helpers/systemd-run.bash" \
	"${CONFIG_HOSTNAME}" \
	"${ALIS_COPY_DIRECTORY}/scripts/core/hostname.bash $CONFIG_HOSTNAME"
	true

# set locale keymap
source "${alis_installer_wd}/../../scripts/helpers/systemd-run.bash" \
	"${CONFIG_HOSTNAME}" \
	"${ALIS_COPY_DIRECTORY}/scripts/core/localectl-keymap.bash $CONFIG_VCONSOLE $CONFIG_XKB_LAYOUT $CONFIG_XKB_MODEL $CONFIG_XKB_VARIANT $CONFIG_XKB_OPTIONS"
	true

print_line

# kill container
if [ true == "$_kill_container" ]; then
	echo -e "\\n:: Killing container: '${CONFIG_HOSTNAME}'"
	source "${alis_installer_wd}/../../scripts/helpers/machinectl-kill-container.bash" "$CONFIG_HOSTNAME"
fi

print_line

echo -e "\\n:: install-first.bash Complete\\n"

print_line
