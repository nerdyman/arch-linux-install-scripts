#!/bin/bash

# standard security tools

function alis_security_services_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="firewalld stubby"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	echo "=> Enabling firewalld"
	systemctl enable firewalld
	systemctl start firewalld

	echo -e "\n[${_script_name}] Done\n"
}

alis_security_services_install
