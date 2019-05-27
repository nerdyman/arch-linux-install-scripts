#!/bin/bash

function alis_nvidia_proprietary_install_drivers_legacy {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"

	echo -e "[${_script_name}]\\n"

	local _install_targets="nvidia-340xx-dkms lib32-nvidia-340xx-utils"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=SC2086
	pacman -S --needed --noconfirm $_install_targets

	echo -e "[${_script_name}] Done\\n"
}

alis_nvidia_proprietary_install_drivers_legacy
