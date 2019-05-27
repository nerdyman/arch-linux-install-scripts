#!/bin/bash

function alis_network_manager_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="networkmanager dnsmasq network-manager-applet nm-connection-editor"

	pacman -S --noconfirm --needed $_install_targets

	systemctl enable NetworkManager.service
	systemctl start NetworkManager.service

	echo -e "\n[${_script_name}] Done\n"
}

alis_network_manager_install
