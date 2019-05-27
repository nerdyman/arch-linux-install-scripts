#!/bin/bash
# set system hostname

function alis_locale {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [ -z $1 ] || [ $1 = "help" ]; then
		echo "=> You must specify a hostname"
		echo "==> Usage:"
		echo "===> ${_script_name} myhostname"
		echo "[${_script_name}]"
		exit 125
	fi

	hostnamectl set-hostname $1

	echo -e "\n[${_script_name}] Done\n"
}

alis_locale $1 $2
