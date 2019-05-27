#!/bin/bash

# Taken from helmuthdu's arch ultimate install
# @SEE https://github.com/helmuthdu/aui/blob/62f940ce266051a0594d96eb64c31cd90e1b2e8e/lilo#L1738

function alis_clamav_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_enable_service=true

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "=> Whether to enable and start the service (default: ${_default_enable_service})"
		echo "=> Usage:"
		echo "==> $_script_name false"
		echo -e "\\n[${_script_name}] Done\\n"
		exit 1
	fi

	local _enable_service=${1:$_default_enable_service}

	local _install_targets="clamav"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	# cp /etc/clamav/clamd.conf.sample /etc/clamav/clamd.conf
	# cp /etc/clamav/freshclam.conf.sample /etc/clamav/freshclam.conf

	sed -i '/Example/d' /etc/clamav/freshclam.conf
	sed -i '/Example/d' /etc/clamav/clamd.conf

	if [[ $_enable_service == true ]]; then
		echo "=> Enabling \"clamav-daemon\" service"
		systemctl enable clamav-daemon

		echo "=> Enabling \"clamav-freshclam\" service"
		systemctl enable clamav-freshclam

		echo "=> Starting \"clamav-daemon\" service"
		systemctl start clamav-daemon

		echo "=> Starting \"clamav-freshclam\" service"
		systemctl start clamav-freshclam
	fi

	# echo "=> Digging for clams"
	# freshclam

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_clamav_install "$1"
