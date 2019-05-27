#!/bin/bash

function alis_trizen_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _wd
	_wd=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	echo "=> Installing trizen"
	# shellcheck disable=1090
	# shellcheck disable=SC2154
	source ${_wd}/aur-package-install.bash trizen $_user

	echo -e "\n[${_script_name}] Done\n"
}

alis_trizen_install $1
