#!/bin/bash

function alis_qt_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	echo "=> Installing packages"
	sudo -H -u "$_user" yay -S --needed --noconfirm qt5-base qt5-styleplugins qt5-wayland

	echo -e "\n[${_script_name}] Done\n"
}

alis_qt_install
