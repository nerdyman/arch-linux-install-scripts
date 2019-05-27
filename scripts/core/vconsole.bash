#!/bin/bash

function alis_vconsole {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]"

	local _default_output_path="/etc/vconsole.conf"

	if [ -z $1 ] || [ $1 == "help" ]; then
		echo "=> You must specify a keymap, usage:"
		echo "==> $_script_name uk"
		echo -e "\n=> You can also specify the following:"
		echo "==> An output path (default ${_default_output_path})"
		echo "==> Usage:"
		echo "==> $_script_name uk /mnt/etc/vconsole.conf"
		echo "[${_script_name}]"

		exit 125
	fi;

	local _keymap=$1
	local _output_path=${2:-$_default_output_path}

	echo "=> Using keymap: ${_keymap}"
	echo "=> Writing to: ${_output_path}"

	echo -e "KEYMAP=${_keymap}\n" > $_output_path

	echo -e "[${_script_name}] Done\n"
}

alis_vconsole $1 $2
