#!/bin/bash

function alis_install_x11 {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="xclip xdotool xorg-server xorg-server-devel xorg-server-xwayland xorg-xinit xorg-xkill xorg-xinput xf86-input-libinput xf86-video-fbdev xf86-video-vesa xorg-xprop xorg-xsetroot xorg-apps xkeyboard-config xterm mesa"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	echo "=> Creating font directories"
	mkfontdir /usr/share/fonts/75dpi
	mkfontdir /usr/share/fonts/100dpi

	echo -e "\n[${_script_name}] Done\n"
}

alis_install_x11
