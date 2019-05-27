#!/bin/bash

# shellcheck disable=SC1090

function alis_meta_gaming {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	local _script_wd
	# shellcheck disable=SC2046
	_script_wd=$(dirname $(realpath "$0"))

	if [[ $1 == "help" ]]; then
		echo "=> This script will install steam, wine and lutris"
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	echo "=> Including scripts relative to \"${_script_wd}\""
	source "${_script_wd}/../../scripts/desktop-apps/wine-install.bash" "$_user"
	source "${_script_wd}/../../scripts/desktop-apps/steam-install.bash" "$_user"
	source "${_script_wd}/../../scripts/desktop-apps/lutris.bash" true "$_user"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_meta_gaming "$1"
