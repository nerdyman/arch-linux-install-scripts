#!/bin/bash

# shellcheck disable=SC2155
# shellcheck disable=SC1090
# shellcheck disable=SC2046

##
# config.sh - shared variables
##

set -e

alis_config_wd=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

source "${alis_config_wd}/consts.bash"

# shellcheck disable=SC2143
export IS_INTEL=$([[ $(grep -i "GenuineIntel" /proc/cpuinfo) ]] && echo true || echo false) # are you using an intel processor?
# shellcheck disable=SC2143
export IS_VM=$([[ $(dmidecode --type 1 | grep VirtualBox) ]] && echo true || echo false) # are you running the install in a virtual machine? (for virtualbox only!)

# config - basic machine config
export CONFIG_EDITOR="vim"
export CONFIG_GFX_DRIVERS=$ALIS_GPU_DRIVER_NVIDIA # gfx drivers to install - see consts.bash for options
export CONFIG_HOSTNAME="abox" # hostname for install
export CONFIG_LOCALE="en_GB" # primary locale
export CONFIG_LOCALE_SECONDARY="en_US" # secondary locale
export CONFIG_PACMAN_MIRROR="GB" # uppercase mirrorlist country code for arch mirror list
export CONFIG_TIMEZONE="Europe/Dublin" # timezone
export CONFIG_VCONSOLE="uk" # virtual console keymap
export CONFIG_UMASK=077 # default umask

# superuser config (sudo etc.)
export CONFIG_USER_SHELL="/bin/zsh" # default shell
export CONFIG_USER_USERNAME="me" # primary username

# xorg keyboard settings
export CONFIG_XKB_LAYOUT="gb" # X11 keyboard layout
export CONFIG_XKB_MODEL="pc104"
export CONFIG_XKB_OPTIONS="grp:alt_shift_toggle,terminate:ctrl_alt_bksp"
export CONFIG_XKB_VARIANT="qwerty" # dvorak|qwertz etc.

# disk - disks to target and their options
export DISK_FS_ROOT="btrfs" # file system for root partition
export DISK_PARTLABEL_EFI="EFI" # partlabel for BOOT (efi)
export DISK_PARTLABEL_SYSTEM="system" # partlabel for root
export DISK_SIZE_SWAP=$(free -h | gawk  '/Mem:/{print $2}') # calculated using total ram
export DISK_SIZE_BOOT="250MiB" # size of boot partition
export DISK_TARGET="/dev/sda" # disk to install on

# mount - mount settings for installed OS
export MOUNT_OPTIONS="defaults,x-mount.mkdir"
export MOUNT_OPTIONS_SYSTEM="${MOUNT_OPTIONS},compress=lzo,ssd,noatime" # mount options for main partition
export MOUNT_PATH_BOOT="/boot" # path for boot (used with chroot)
export MOUNT_POINT="/mnt" # where the install is mounted
export MOUNT_POINT_BOOT="${MOUNT_POINT}${MOUNT_PATH_BOOT}" # full mount point for boot (used without chroot)

# git
export CONFIG_GIT_EDITOR=$CONFIG_EDITOR
export CONFIG_GIT_EMAIL="email@example.com"
export CONFIG_GIT_NAME=$CONFIG_USER_USERNAME

export ALIS_COPY_DIRECTORY="/root/.alis" # where alis scripts get copied to on the new install
