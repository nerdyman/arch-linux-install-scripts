#!/bin/bash

function alis_nvidia_proprietary_install_drivers {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"

	echo -e "[${_script_name}]\\n"

	local _install_targets="nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=SC2086
	pacman -S --needed --noconfirm $_install_targets

	echo -e "[${_script_name}] Done\\n"
}

alis_nvidia_proprietary_install_drivers
