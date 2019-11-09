#!/bin/bash
# bells and whistles install script

# shellcheck disable=SC1090

set -e

# shellcheck disable=SC2046
alis_installer_wd=$(dirname $(realpath "$0"))

# load config
source "${alis_installer_wd}/../../installers/config.bash"

# load shared functions
source "${alis_installer_wd}/../../installers/shared.bash"

# set time
source "${alis_installer_wd}/../../scripts/core/timezone-sync.bash" \
	"$CONFIG_TIMEZONE"
print_line

# disable password prompts for sudo users
source "${alis_installer_wd}/../../scripts/core/sudo-sudoers-password.bash" false
print_line

# set mirrorlist (https: true, http: false)
source "${alis_installer_wd}/../../scripts/core/pacman-set-mirrorlist.bash" \
	"$CONFIG_PACMAN_MIRROR" \
	true \
	false
print_line

# enable multilib repo
source "${alis_installer_wd}/../../scripts/core/pacman-add-multilib.bash"
print_line

# install aur package manager
source "${alis_installer_wd}/../../scripts/base/yay.bash" "true" "$CONFIG_USER_USERNAME"
print_line

alis_shared_debug "ISVM: ${IS_VM}"

# install gfx drivers
install_graphics_drivers "$CONFIG_GFX_DRIVERS" "$IS_VM"
print_line

# install base fonts
source "${alis_installer_wd}/../../scripts/base/fonts-install.bash" "$CONFIG_USER_USERNAME"
print_line

# add emoji font config
# source "${alis_installer_wd}/../../scripts/base/fonts-emoji-config.bash"
# print_line

# configure pretty font rendering
source "${alis_installer_wd}/../../scripts/base/font-rendering-set.bash"
print_line

# install base filesystems
source "${alis_installer_wd}/../../scripts/base/filesystems-install.bash"
print_line

# install network manager
source "${alis_installer_wd}/../../scripts/base/network-manager-install.bash"
print_line

# install shell goodies
if [[ $CONFIG_USER_SHELL == "/bin/zsh" ]]; then
	source "${alis_installer_wd}/../../scripts/base/zsh-goodies-install.bash" \
	"/home/${CONFIG_USER_USERNAME}/.zshrc" \
	"$CONFIG_USER_USERNAME"
fi
print_line

# install admin tools
source "${alis_installer_wd}/../../scripts/base/admin-tools-install.bash"
print_line

# install archive tools
source "${alis_installer_wd}/../../scripts/base/archive-tools-install.bash"
print_line

# install mime tools
source "${alis_installer_wd}/../../scripts/base/mime-tools-install.bash"
print_line

# install audio servers
source "${alis_installer_wd}/../../scripts/base/audio-servers-install.bash"
print_line

# install display server
source "${alis_installer_wd}/../../scripts/base/x11-install.bash"
print_line

# install codecs
source "${alis_installer_wd}/../../scripts/base/codecs-install.bash"
print_line

# install and configure security settings
source "${alis_installer_wd}/../../scripts/base/security-services-install.bash"
print_line
source "${alis_installer_wd}/../../scripts/base/security-strict-permissions-set.bash"
print_line
source "${alis_installer_wd}/../../scripts/base/security-tools-install.bash"
print_line
source "${alis_installer_wd}/../../scripts/base/security-umask-default-set.bash"
print_line

# install clamav
source "${alis_installer_wd}/../../scripts/base/clamav-install.bash" true
print_line

# install ssh (don't enable service)
source "${alis_installer_wd}/../../scripts/base/ssh-install.bash" false
print_line

# install dev tools
source "${alis_installer_wd}/../../scripts/base/dev-tools-install.bash"
print_line

# install gtk
source "${alis_installer_wd}/../../scripts/meta/gtk.bash" "${CONFIG_USER_USERNAME}"
print_line

# install qt
source "${alis_installer_wd}/../../scripts/base/qt-install.bash"
print_line

# source "${alis_installer_wd}/../../scripts/base/qt-gtk-style.bash" "$CONFIG_USER_USERNAME"
# print_line

# install desktop environment
# source "${alis_installer_wd}/../../scripts/desktop-environments/i3-xfce-frankenstein-install.bash" "$CONFIG_USER_USERNAME"
# print_line

# install terminal emulator
# source "${alis_installer_wd}/../../scripts/desktop-apps/termite.bash" "$CONFIG_USER_USERNAME" true
# print_line

# set up git
source "${alis_installer_wd}/../../scripts/development/git-global-user.bash" \
	"$CONFIG_GIT_NAME" \
	"$CONFIG_GIT_EMAIL" \
	"$CONFIG_GIT_EDITOR"
#	"$CONFIG_GIT_EDITOR" \
#	""$CONFIG_USER_USERNAME"" # getting sudo errors, need to investigate
print_line

# install dev tools
source "${alis_installer_wd}/../../scripts/development/docker-install.bash"
print_line

# install display manager
# @TODO

# install virtualbox
source "${alis_installer_wd}/../../scripts/development/virtualbox-install.bash" "$CONFIG_USER_USERNAME"
print_line

# install node.js
source "${alis_installer_wd}/../../scripts/development/node-js-install.bash" "$CONFIG_USER_USERNAME"
print_line

# install shell tools
source "${alis_installer_wd}/../../scripts/development/shell-tools-install.bash" "$CONFIG_USER_USERNAME"
print_line

# install virtualbox guest packages if in vm
if $IS_VM; then
	source "${alis_installer_wd}/../../scripts/base/virtualbox-guest-install.bash" "$CONFIG_USER_USERNAME"
	print_line
fi

# # install web browsers
# source "${alis_installer_wd}/../../scripts/desktop-apps/browsers-install.bash" "$CONFIG_USER_USERNAME"
# print_line

# install productivity tools
source "${alis_installer_wd}/../../scripts/desktop-apps/productivity-tools-install.bash" "$CONFIG_USER_USERNAME"
print_line

# # install atom
# source "${alis_installer_wd}/../../scripts/desktop-apps/atom-install.bash" \
# 	"$CONFIG_USER_USERNAME"
# 	"$CONFIG_LOCALE"
# print_line

# # install atom web developer packages
# source "${alis_installer_wd}/../../scripts/desktop-apps/atom-packages-web-developer-install.bash" "$CONFIG_USER_USERNAME"
# print_line

# install gaming packages
source "${alis_installer_wd}/../../meta/gaming.bash" true "$CONFIG_USER_USERNAME"
print_line

# clean up packages
source "${alis_installer_wd}/../../scripts/base/pacman-clean.bash"
print_line

# enable password prompt for sudo users
source "${alis_installer_wd}/../../scripts/core/sudo-sudoers-password.bash" true
print_line

# copy home files
# alis_shared_copy_configs_home

echo -e "\\n:: install-last.bash Complete\\n"

print_line
