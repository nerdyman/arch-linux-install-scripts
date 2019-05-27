#!/bin/bash

function alis_virtualbox_guest_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="virtualbox-guest-dkms virtualbox-guest-utils mesa-libgl"

	echo "=> Install targets: ${_install_targets}"
	pacman -S --needed --noconfirm $_install_targets

	# echo "=> Enabling kernel modules"
	# modprobe -a vboxguest vboxsf vboxvideo

	echo "=> Enabling systemd service"
	systemctl enable vboxservice

	if getent group customers | grep &>/dev/null "\b${_user}\b"; then
		echo "=> User is already in 'vboxusers' group, skipping"
	else
		echo "=> Adding ${_user} to 'vboxusers' group"
		usermod -a -G vboxusers $_user
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_virtualbox_guest_install $1
