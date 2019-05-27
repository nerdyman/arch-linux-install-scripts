#!bin/bash

function alis_get_partuuid_by_id {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"

	if [ -z "$1" ] || [ "$1" == "help" ]; then
		echo -e "[${_script_name}]\n"

		echo "You must specify a target drive, usage:"
		echo -e "$_script_name /dev/sda1\n"
		echo "Example output:"
		echo -e "76f56fc2-d840-4ce...\n"
		echo "[${_script_name}]"

		exit 125
	fi;

	local _partuuid

	_partuuid=$(blkid -s PARTUUID -o value $1)

	if [ -z $_partuuid ]; then
		echo -e "[${_script_name}] Error\n"
		echo -e "=> Unable to get partuuid. Is '$1' a valid id?\n"
		echo -e "[${_script_name}] Exiting\n"
		exit 125
	fi;

	# 'return' partuuid
	echo $_partuuid
}

alis_get_partuuid_by_id $1
