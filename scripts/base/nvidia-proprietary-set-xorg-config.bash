#!/bin/bash

function alis_nvidia_proprietary_set_xorg_config {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"

	echo "[${_script_name}]"

	nvidia-xconfig --add-argb-glx-visuals --allow-glx-with-composite --composite \
		--render-accel -o /etc/X11/xorg.conf.d/20-nvidia.conf

	echo -e "[${_script_name}] Done\n"
}

alis_nvidia_proprietary_set_xorg_config
