#!/bin/bash

function alis_install_mime_tools {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="perl-file-mimeinfo"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	echo -e "\n[${_script_name}] Done\n"
}

alis_install_mime_tools
