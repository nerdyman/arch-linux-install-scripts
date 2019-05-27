#!/bin/bash
# Make Qt apps use GTK+ appearance

function alis_qt_gtk_style {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_username
	_default_username="$(whoami)"

	if [ -z "$1" ] || [ $1 = "help" ]; then
		echo "You can specify a user to write the config for (default: ${_default_username})"
		echo "=> Usage:"
		echo "${_script_name} myuser"
		echo -e "\n[${_script_name}]"
		exit 125
	fi;

	local _username=${1:-$_default_username}
	local _output_path=""

	if [ $_username == "root" ]; then
		_output_path+="/root"
	else
		_output_path+="/home/${_username}"
	fi

	_output_path+="/.config/Trolltech.conf"

	echo "=> Writing config to: ${_output_path}"

	echo "[Qt]
	style=GTK+
	" >> $_output_path

	echo -e "\n[${_script_name}] Done\n"
}

alis_qt_gtk_style $1
