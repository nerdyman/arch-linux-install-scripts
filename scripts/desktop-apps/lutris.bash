#!/bin/bash

function alis_lutris {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_should_install=true
	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> Whether to install or remove the package(s) (default: ${_default_should_install})"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _should_install=${1:-$_default_should_install}
	local _user=${2:-$_default_user}

	local _install_targets="lutris"

	if $_should_install; then
		echo "=> Install targets: ${_install_targets}"
		# shellcheck disable=SC2086
		sudo -H -u "$_user" trizen -S --needed --noconfirm --noedit $_install_targets
	else
		echo "=> Removal targets: ${_install_targets}"
		# shellcheck disable=SC2086
		sudo -H -u "$_user" trizen -Rs --noconfirm $_install_targets
	fi

	echo -e "\\n[${_script_name}] Done\\n"
}

# shellcheck disable=SC2086
alis_lutris $1 "$2"
