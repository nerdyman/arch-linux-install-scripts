#!/bin/bash

function alis_ssh_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_enable_service=true

	if [ $1 == "help" ]; then
		echo "=> You can specify the following:"
		echo "=> Whether to enable and start the service (default: ${_default_enable_service})"
		echo "=> Usage:"
		echo "==> $_script_name false"
		echo -e "\n[${_script_name}] Done\n"
		exit 1
	fi;

	local _enable_service=${1:$_default_enable_service}

	local _install_targets="openssh"

	pacman -S --noconfirm --needed $_install_targets

	if [ $_enable_service == true ]; then
		systemctl enable sshd
		systemctl start sshd
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_ssh_install $1
