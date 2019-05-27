#!/bin/bash

# bootstrap - run before initial install
function bootstrap {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	echo "=> Installing installer dependencies"
	pacman -Syy --noconfirm dmidecode || \
		echo -e "=> [WARN] Unable to install dmidecode - will not be able to determine if install is running in a virtual machine\\n==> You can specify this manually in 'config.bash' with 'IS_VM=true'"

	echo -e "\\n[${_script_name}] Done\\n"
}

bootstrap
