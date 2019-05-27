#!/bin/bash
# sync time to timezone

function alis_timezone_sync {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	if [ -z "$1" ] || [ "$1" = "help" ]; then
		echo "=> You must specify a timezone, usage:"
		echo "=> ${_script_name} \"Europe/London\""
		exit 1
	fi

	echo "=> Enabling SNTP synchronization"
	timedatectl set-ntp true

	echo "=> Setting timezone: $1"
	timedatectl set-timezone "$1"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_timezone_sync "$1"
