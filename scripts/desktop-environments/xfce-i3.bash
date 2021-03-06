#!/bin/bash

function alis_desktop_environment_xfce {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ "$1" == "help" ]]; then
		echo -e "=> XFCE + i3 + Goodies\\n"
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="compton-tryone-git eog file-roller flameshot gtk3-nocsd-git i3-gaps-rounded-git kitty nautilus-typeahead nitrogen redshift rofi thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman xfce4 xfce4-goodies"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=SC2086
	sudo -H -u $_user yay -S --needed --noconfirm $_install_targets

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_desktop_environment_xfce "$1"
