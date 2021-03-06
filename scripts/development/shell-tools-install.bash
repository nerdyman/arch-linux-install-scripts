#!/bin/bash
# install node.js with additional packages

function alis_shell_tools_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	echo "=> Installing packages"
	# shellcheck disable=SC2086
	sudo -H -u $_user yay -S --noconfirm --needed shellcheck

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_shell_tools_install "$1"
