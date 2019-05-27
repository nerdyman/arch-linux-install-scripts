#!/bin/bash

function alis_zsh_goodies_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_zshrc_path="$HOME/.zshrc"
	local _default_user

	_default_user=$(whoami)

	if [ $1 == "help" ]; then
		echo "=> You can specify a path to your .zshrc file for plugins (default: $_default_zshrc_path)"
		echo "=> Usage:"
		echo "==> ${_script_name} /home/myuser/.zshrc"
		echo -e "=> You can also specify the following:"
		echo "==> A username to run the install as (default: ${_default_user})"
		echo "==> Usage:"
		echo "===> ${_script_name} /home/myuser/.zshrc myuser"
		echo -e "\n[${_script_name}]\n"
		exit 125
	fi

	local _zshrc_path=${1:-$_default_zshrc_path}
	local _user=${2:-$_default_user}

	echo "=> Running for user: ${_user}"
	echo "=> Using file: ${_zshrc_path}"

	local _install_targets="zsh-syntax-highlighting oh-my-zsh-git"

	echo "=> Install targets: ${_install_targets}"
	sudo -H -u $_user trizen -S --needed --noconfirm --noedit $_install_targets

	# copy oh-my-zsh config
	echo "=> Copying default oh-my-zsh config to '${_zshrc_path}'"
	cp -f /usr/share/oh-my-zsh/zshrc $_zshrc_path
	chown ${_user}:${_user} $_zshrc_path

	echo "=> Enabling ZSH syntax highlighting plugin"
	echo "source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
		>> $_zshrc_path

	echo -e "\n[${_script_name}] Done\n"
}

alis_zsh_goodies_install "$1" $2
