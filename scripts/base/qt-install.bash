#!/bin/bash

function alis_qt_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_user
	_default_user="$(whoami)"

	if [ "$1" = "help" ]; then
		echo "You can specify a user to write the config for (default: ${_default_user})"
		echo "=> Usage:"
		echo "${_script_name} myuser"
		echo -e "\n[${_script_name}]"
		exit 125
	fi;

	local _user=${1:-$_default_user}

	echo "=> Installing packages"
	sudo -H -u "$_user" yay -S --needed --noconfirm qt5-base qt5-styleplugins qt5-wayland

	echo -e "\n[${_script_name}] Done\n"
}

alis_qt_install "$1"
