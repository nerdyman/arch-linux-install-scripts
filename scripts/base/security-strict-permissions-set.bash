#!/bin/bash

function alis_strict_permissions_set {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	declare -a _files=("/boot" "/etc/iptables" "/etc/nftables.conf")

	for _file in "${_files[@]}"; do
		echo "=> Setting 700 permissions on ${_files[$_file]}"

		if [[ -f ${_files[$_file]} ]]; then
			chmod 700 ${_files[$_file]}
		else
			echo "=> File '${_files[$_file]}' doesn't exist, skipping..."
		fi
	done

	echo -e "\n[${_script_name}] Done\n"
}

alis_strict_permissions_set
