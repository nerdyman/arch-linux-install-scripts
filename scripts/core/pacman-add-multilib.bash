#!/bin/bash

function alis_pacman_add_multilib {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	echo "=> Adding multilib entry to pacman.conf"

	local _file_path="/etc/pacman.d/mirrorlist"

	if grep -Fxq "[multilib]" $_file_path; then
		echo "==> Multilib already enabled, skipping"
	else
		echo "==> Enabling multilib"
		cat >> /etc/pacman.conf <<_EOF_
[multilib]
Include = /etc/pacman.d/mirrorlist

_EOF_
	fi

	echo "=> Syncing package repositories"
	pacman -Syy

	echo -e "\n[${_script_name}] Done\n"
}

alis_pacman_add_multilib
