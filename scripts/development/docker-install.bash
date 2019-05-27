#!/bin/bash

function alis_docker_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _install_targets="docker"

	echo "=> Install targets: ${_install_targets}"
	pacman -S --needed --noconfirm $_install_targets

	echo "=> Adding $(whoami) to vboxusers group"
	usermod -a -G docker "$(whoami)"

	echo -e "\n[${_script_name}] Done\n"
}

alis_docker_install
