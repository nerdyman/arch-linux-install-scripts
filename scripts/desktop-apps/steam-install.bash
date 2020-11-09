#!/bin/bash

function alis_steam_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	# ..might need these?: lib32-libcurl-gnutls lib32-gdk-pixbuf2 lib32-gtk2 lib32-gtk3 lib32-libpulse lib32-libxtst lib32-libvdpau libxtst
	local _install_targets="steam steam-native-runtime ttf-liberation"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=2086
	sudo -H -u "$_user" yay -S --needed --noconfirm $_install_targets

	# @NOTE steam requires 'en_US' locale
	echo "=> Enabling \"en_US.UTF-8 UTF-8\" locale"
	sudo sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

	echo "=> Generating locales"
	sudo locale-gen

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_steam_install "$1"
