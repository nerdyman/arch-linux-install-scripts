#!/bin/bash

function alis_zsh_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\n"

	local _default_change_user_shell=true
	local _default_user
	_default_user=$(whoami)
	local _default_zshrc_path
	_default_zshrc_path="$(eval echo "~${_default_user}")/.zshrc"

	if [ "$1" == "help" ]; then
		echo "=> You can specify the following"
		echo "==> A username to run the install as (default: ${_default_user})"
		echo "==> Whether to change the shell to ZSH for that user (default: ${_default_change_user_shell})"
		echo "==> A path to your .zshrc file for plugins (default: $_default_zshrc_path)"
		echo "==> Usage:"
		echo "===> ${_script_name} myuser true /home/myuser/.zshrc"
		exit 125
	fi

	local _user=${1:-$_default_user}
	local _change_user_shell=${2:-$_default_change_user_shell}
	local _zshrc_path=${3:-$_default_zshrc_path}

	local _install_targets="zsh zsh-completions"

	echo "=> Install targets: ${_install_targets}"
	# shellcheck disable=SC2086
	pacman -S --needed --noconfirm $_install_targets

	if [ ! -f "$_zshrc_path" ]; then
		echo "=> ${_zshrc_path} does not exist, creating new one"
		sudo -H -u "$_user" touch "$_zshrc_path"

		# set default config options
		echo "=> Setting defaults in ${_zshrc_path}"
		local _zshrc_config="autoload -Uz promptinit\npromptinit\n"
		_zshrc_config+="autoload -Uz compinit\ncompinit\n"
		_zshrc_config+="setopt COMPLETE_ALIASES"

		echo -e $"_zshrc_config" >> "$_zshrc_path"
	fi

	if [[ $_change_user_shell == true ]]; then
		echo "=> Running chsh for: ${_user}"
		chsh -s /bin/zsh "$_user"
	fi

	echo -e "\n[${_script_name}] Done\n"
}

# shellcheck disable=SC2086
alis_zsh_install "$1" "$2" $3
