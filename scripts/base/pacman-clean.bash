#!/bin/bash

# shellcheck disable=SC2046
# shellcheck disable=SC2155

function alis_pacman_clean {
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	echo "=> Removing orphan packages (sorry orphans)"

	pacman -Rsc --noconfirm $(pacman -Qqdt)

	echo "=> Running pacman-optimize"
	pacman-optimize

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_pacman_clean
