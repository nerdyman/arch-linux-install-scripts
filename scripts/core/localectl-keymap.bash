#!/bin/bash
# set system keymap

# @arguments
# keymap

function alis_localectl_keymap {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _default_model="pc104"
	local _default_variant="qwerty"
	local _default_options="grp:alt_shift_toggle,terminate:ctrl_alt_bksp"

	if [ -z "$1" ] || [ "$1" = "help" ]; then
		echo "=> You must specify the following:"
		echo "==> A keymap (e.g. uk)"
		echo "==> Usage:"
		echo "===> ${_script_name} uk"
		echo -e "=> You can also specify the folowing:"
		echo "==> An X11 keymap (defaults to first parameter)"
		echo "==> Model (default: ${_default_model})"
		echo "==> Variant (default: ${_default_variant})"
		echo "==> Options (default: ${_default_options})"
		echo "===> Usage: ${_script_name} uk gb pc104 qwerty shift:both_capslock,caps:none"
		echo "[${_script_name}]"
		exit 125
	fi

	local _layout=$1
	local _x11_layout=${2:-$1}
	local _model=${3:-$_default_model}
	local _variant=${4:-$_default_variant}
	local _options=${5:-$_default_options}

	localectl set-keymap "$_layout"
	localectl --no-convert set-x11-keymap "$_x11_layout" "$_model" "$_variant" "$_options"

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_localectl_keymap "$1" "$2" "$3" "$4"
