#!/bin/bash
# install node.js with additional packages

function alis_node_js_install {
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

	echo "=> Installing packages"
	sudo -H -u "$_user" trizen -S --noconfirm --needed nodejs npm yarn nvm

	echo "=> Setting 'fs.inotify.max_user_watches' to prevent ENOSPC issues"
	echo "fs.inotify.max_user_watches=524288" | tee /etc/sysctl.d/40-max-user-watches.conf
	sysctl --system || echo "=> [WARN] Unable to manually load system config files, they will be loaded automatically on next boot"

	echo "=> Installing npx globally"
	sudo -H -u "$_user" npm install -g npx || npm install -g npx || echo "=> [WARN] Unable to install npx globally"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_node_js_install "$1"
