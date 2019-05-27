#!/bin/bash

function alis_dev_tools_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _install_targets="colordiff dos2unix"

	# shellcheck disable=SC2086
	pacman -S --noconfirm --needed $_install_targets

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_dev_tools_install
