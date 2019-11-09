#!/bin/bash

function alis_yay_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_tagets="yay"
	local _wd
	_wd=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

	local _default_install="true"
	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> Install (true) or uninstall (false) (default: true)"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _install=${1:-$_default_install}
	local _user=${2:-$_default_user}

	if [[ $_install == "true" ]]; then
		echo "=> Installing $_install_tagets"
		# shellcheck disable=1090
		# shellcheck disable=SC2154
		source "${_wd}/aur-package-install.bash" "yay" "$_user"
	else
		sudo -u "$_user" sudo pacman -R --noconfirm "$_install_tagets"
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_yay_install $1
