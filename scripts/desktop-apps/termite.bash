#!/bin/bash

function alis_termite_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_user
	_default_user=$(whoami)

	local _default_add_vte_source=true

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "==> Whether to add VTE source to user's .xinitrc (default: ${_default_add_vte_source})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}
	local _add_vte_source=${2:-$_default_add_vte_source}

	local _home_dir

	if [[ $_user == "root" ]]; then
		_home_dir="/root"
	else
		_home_dir="/home/${_user}"
	fi

	local _xinitrc_path="${_home_dir}/.xinitrc"
	local _termite_path="${_home_dir}/.config/termite"
	local _termite_config_path="${_termite_path}/config"

	local _install_targets="termite"

	echo "=> Install targets: ${_install_targets}"

	sudo -H -u $_user trizen -S --needed --noconfirm --noedit $_install_targets

	# source VTE to user's xinitrc
	if [[ $_add_vte_source == true ]] && [[ -f $_xinitrc_path ]]; then
		echo "=> Adding VTE source to '${_xinitrc_path}'"
		sed '1 a source /etc/profile.d/vte.sh' $_xinitrc_path
	else
		echo "=> '${_xinitrc_path}' does not exist, skipping VTE source"
	fi

	if [[ ! -d $_termite_path ]]; then
		echo "=> Creating directory '${_termite_config_path}'"
		mkdir -p $_termite_path
		chown -R $_user:$_user $_termite_path
	fi

	if [[ ! -f ${_termite_config_path} ]]; then
		echo "=> Copying default termite config to '${_termite_config_path}'"
		cp /etc/xdg/termite/config ${_termite_config_path}
		chown $_user:$_user $_termite_config_path
	fi

	echo -e "\n[${_script_name}] Done\n"
}

alis_termite_install $1 $2
