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

	# @TODO find smaller repo for 'nerd-fonts-complete', it's currently 2GB :(
	local _install_targets="cairo fontconfig freetype2 lib32-cairo lib32-freetype2 lib32-fontconfig adobe-source-han-sans-otc-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-fira-mono ttf-liberation ttf-hannom ttf-joypixels ttf-roboto ttf-roboto-mono-powerline-git ttf-symbola wqy-zenhei"

	echo "=> Install targets: ${_install_targets}"

	# shellcheck disable=2086
	sudo -H -u "$_user" trizen -S --needed --noconfirm --noedit $_install_targets

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_fonts_install "$1"
