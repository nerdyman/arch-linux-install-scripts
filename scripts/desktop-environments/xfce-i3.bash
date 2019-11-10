#!/bin/bash

function alis_i3_xfce_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_user
	_default_user=$(whoami)
	local _should_install=true

	if [[ $1 == "help" ]]; then
		echo "=> You can specify the following:"
		echo "==> Whether to install or remove packages and confnigs (default: ${_should_install})"
		echo "==> User to run install as (default: ${_default_user})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${1:-$_default_user}

	local _install_targets="compton nitrogen redshift rofi thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler xfce4 xfce4-goodies"

	echo "=> Packages: ${_install_targets}"

	local _user_i3_config="/home/${_user}/.config/i3/config"

	if [[ $_should_install == true ]]; then
		echo "=> Installing packages"
		# shellcheck disable=SC2086
		sudo -H -u $_user yay -S --needed --noconfirm $_install_targets

		if [[ ! -f "${_user_i3_config}" ]]; then
			echo "=> Writing new i3 config to '${_user_i3_config}'"

			sudo -H -u "$_user" mkdir -p "$(dirname "${_user_i3_config}")"
			sudo -H -u "$_user" cp -f "/etc/i3/config" "${_user_i3_config}"
		else
			echo "=> i3 config already exists, writing new one to '${_user_i3_config}.alis'"
			sudo -H -u "$_user" cp -f "/etc/i3/config" "${_user_i3_config}.alis"
		fi

		echo "=> Replacing xfwm4 with i3"

	else
		echo "=> Removing packages"
		# shellcheck disable=SC2086
		sudo -H -u "$_user" pacman -Rs $_install_targets

		echo "=> Removing configs"
		sudo -H -u "$_user" rm -rf "${_user_i3_config}" "${_user_i3_config}.alis"
	fi

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_i3_xfce_install "$1" "$2"
