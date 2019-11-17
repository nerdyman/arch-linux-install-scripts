#!/bin/bash

function alis_fonts_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 1
	fi

	local _user=${1:-$_default_user}

	# shellcheck disable=2086
	sudo -H -u "$_user" yay -S --needed --noconfirm \
		cairo fontconfig freetype2 lib32-cairo lib32-freetype2 lib32-fontconfig \
		adobe-source-han-sans-otc-fonts adobe-source-han-sans-cn-fonts \
		adobe-source-han-sans-tw-fonts adobe-source-han-sans-jp-fonts \
		adobe-source-han-sans-kr-fonts bdf-unifont ttf-bitstream-vera \
		ttf-croscore ttf-dejavu ttf-fira-mono ttf-liberation ttf-hannom \
		ttf-joypixels ttf-roboto ttf-symbola wqy-zenhei

	echo "=> Enabling joypixels emoji color font"
	sudo -u "$_user" ln -s /etc/fonts/conf.avail/75-joypixels.conf /etc/fonts/conf.d/75-joypixels.conf

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_fonts_install "$1"
