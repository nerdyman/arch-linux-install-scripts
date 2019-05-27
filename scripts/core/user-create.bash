#!/bin/bash

function alis_user_create {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_shell="/bin/zsh"

	if [ -z "$1" ] || [ "$1" = "help" ]; then
		echo "=> You must specify a username, usage:"
		echo "=> ${_script_name} myuser"
		echo -e "\\n=> You can also specify the following:"
		echo "==> A shell (default: ${_default_shell}), usage:"
		echo "==> ${_script_name} myuser /bin/bash"
		exit 1
	fi

	local _username=$1
	local _shell=${2:-$_default_shell}

	echo "=> Creating user: ${_username}"
	useradd \
		--create-home \
		--user-group \
		-G sudo,users,wheel \
		-s "$_shell" \
		-K LOGIN_RETRIES=3 "$_username"

	echo "=> Fingering user"
	chfn -f "$_username" "$_username"

	echo "=> Enter password for ${_username}"
	passwd "$_username"

	if [[ ! -f "/usr/bin/xdg-user-dirs-update" ]]; then
		echo "=> Package 'xdg-user-dirs' isn't installed, installing..."
		pacman -S --noconfirm xdg-user-dirs
	fi

	echo "=> Creating XDG dirs"
	sudo -H -u "$_username" xdg-user-dirs-update

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_user_create "$1" "$2"
