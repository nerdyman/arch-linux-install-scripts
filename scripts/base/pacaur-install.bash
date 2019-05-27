#!/bin/bash

# shellcheck disable=SC1090
# shellcheck disable=SC2155

function alis_pacaur_install {
	local _wd=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
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

	echo "=> Adding PGP key '1EB2638FF56C0C53'"
	sudo -H -u $_user gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53

	echo "=> Installing pacaur"

	source ${_wd}/aur-package-install.bash cower $_user
	source ${_wd}/aur-package-install.bash pacaur $_user

	echo -e "\n[${_script_name}] Done\n"
}

alis_pacaur_install $1
