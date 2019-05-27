#!/bin/bash

function alis_font_rendering_set {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [[ ! -f "/etc/fonts/conf.d/11-lcdfilter-default.conf" ]]; then
		echo "=> Symlinking 11-lcdfilter-default config"
		ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
	else
		echo "=> '11-lcdfilter-default' already exists, skipping"
	fi

	if [[ ! -f "/etc/fonts/conf.d/10-sub-pixel-rgb.conf" ]]; then
		echo "=> Symlinking 10-sub-pixel-rgb config"
		ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
	else
		echo "=> '10-sub-pixel-rgb.conf' already exists, skipping"
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_font_rendering_set
