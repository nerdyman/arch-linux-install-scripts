#!/bin/bash

function alis_sudo_sudoers_password {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_require_password=true

	if [ $1 == "help" ]; then
		echo "=> You can specify the following:"
		echo "==> Whether to prompt sudo members for their password (default: ${_default_require_password})"
	fi

	local _require_password=${1:-_default_require_password}

	local _toggler_state="Enabling"

	if [ false == $_require_password ]; then
		_toggler_state="Disabling"
	fi

	echo "=> ${_toggler_state} password requirement for sudo users"

	sed -i '/%sudo/d' /etc/sudoers

	local _password_flag=""

	if [ false == $_require_password ]; then
		_password_flag="NOPASSWD:"
	fi

	echo "%sudo	ALL=(ALL) ${_password_flag}ALL
" >> /etc/sudoers

	echo -e "\n[${_script_name}] Done\n"
}

alis_sudo_sudoers_password $1
