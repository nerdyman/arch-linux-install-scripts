#!/bin/bash

function alis_i3_xfce_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ "$1" == "help" ]]; then
		echo -e "=> Install i3 with an assortment of xfce4 packages along with additional desktop tools.\\n"
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="compton eog ffmpegthumbnailer file-roller flameshot i3-gaps libnotify lxappearance nitrogen redshift raw-thumbnailer rofi thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler xfce4-panel xfce4-pulseaudio-plugin xfce4-mount-plugin xfce4-notifyd xfce4-statusnotifier-plugin"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=SC2086
	sudo -H -u $_user trizen -S --needed --noconfirm --noedit $_install_targets

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_i3_xfce_install "$1"
