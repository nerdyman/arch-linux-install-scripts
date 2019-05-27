#!/bin/bash

function alis_virtualbox_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to add to 'vboxusers' group (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="virtualbox virtualbox-host-dkms virtualbox-guest-iso"

	groupadd vboxusers || echo "User group: vboxusers already exists... skipping"

	echo "=> Install targets: ${_install_targets}"
	pacman -S --needed --noconfirm $_install_targets

	echo "=> Adding $(whoami) to vboxusers group"
	usermod -a -G vboxusers $_user

	echo -e "\n[${_script_name}] Done\n"
}

alis_virtualbox_install $1
