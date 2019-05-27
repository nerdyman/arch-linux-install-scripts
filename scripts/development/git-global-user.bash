#!/bin/bash

function alis_git_global_user {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ -z "$1" ]] || [ -z "$2" ] || [[ -z "$3" ]] || [[ $1 == "help" ]]; then
		echo "=> You must specify a username, email and editor, usage:"
		echo "==> git-global-user.bash username email editor"
		echo -e "\\n=> You can also specify a user to run the command as (default: ${_default_user})"
		echo "==> git-global-user.bash username email editor"
		echo "[${_script_name}]"
		exit 125
	fi

	local _username=$1
	local _email=$2
	local _editor=$3

	local _user=${4:-$_default_user}

	echo "=> Setting git config for user: '$_user'"

	echo "=> Setting username: '$_username'"
	sudo -H -u "$_user" git config --global user.name "$_username"

	echo "=> Setting email: '$_email'"
	sudo -H -u "$_user" git config --global user.email "$_email"

	echo "=> Setting editor: '$_editor'"
	sudo -H -u "$_user" git config --global core.editor "$_editor"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_git_global_user "$1" "$2" "$3" "$4"
