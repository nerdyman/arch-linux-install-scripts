#!/bin/bash

function alis_browsers_install {
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

	local _install_targets="chromium firefox google-chrome pepper-flash"

	echo "=> Install targets: ${_install_targets}"

	sudo -H -u $_user trizen -S --needed --noconfirm --noedit $_install_targets

	echo -e "\n[${_script_name}] Done\n"
}

alis_browsers_install $1
