#!/bin/bash

function alis_user_root_password {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	passwd root

	echo -e "\n[${_script_name}] Done\n"
}

alis_user_root_password
