#!/bin/bash

function alis_umask_default_set {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	echo "=> Setting default umask to 077"

	cp -f /etc/profile /etc/profile.orig
	sed -i -e "s/umask 022/umask 077/g" /etc/profile

	echo -e "\n[${_script_name}] Done\n"
}

alis_umask_default_set
