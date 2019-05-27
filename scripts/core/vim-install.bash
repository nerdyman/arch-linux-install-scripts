#!/bin/bash

function alis_vim_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_add_config=true

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "=> Whether to enable helpful config options (default: ${_default_add_config})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _add_config=${1:-$_defaul_default_add_configt_user}

	local _install_targets="vim"

	echo "=> Install targets: ${_install_targets}"

	pacman -S --needed --noconfirm $_install_targets

	if [[ $_add_config == true ]]; then
		echo "filetype indent off" >> /etc/vimrc
		set "mouse=a" >> /etc/vimrc
		echo "set cursorline" >> /etc/vimrc
		echo "set incsearch" >> /etc/vimrc
		echo "set hlsearch" >> /etc/vimrc
		echo "set number" >> /etc/vimrc
		echo "set showcmd" >> /etc/vimrc
		echo "set showmatch" >> /etc/vimrc
		echo "set spell" >> /etc/vimrc
		echo "set wildmenu" >> /etc/vimrc
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_vim_install $1 $2
