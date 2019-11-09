#!/bin/bash

function alis_aws_tools {
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

	local _install_targets="aws-cli s3cmd"

	# shellcheck disable=SC2086
	if $_should_install; then
		sudo -H -u "$_user" yay -S --needed --noconfirm --no-edit $_install_targets
	else
		sudo -H -u "$_user" yay -Rs --needed --noconfirm $_install_targets
	fi

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_aws_tools "$1" "$2"
