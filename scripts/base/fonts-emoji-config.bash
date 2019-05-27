#!/bin/bash

function alis_fonts_emoji_config {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _config_path="/etc/fonts/local.conf"
	local _font_name="Noto Color Emoji" # @TODO support font as arg

	if [[ -f "${_config_path}" ]]; then
		echo "=> File '${_config_path}' exists, creating backup..."
		mv "$_config_path" "${_config_path}.alis"
	fi

	cat << EOF > ${_config_path}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<match>
 <test name="family"><string>sans-serif</string></test>
 <edit name="family" mode="prepend" binding="strong">
 <string>${_font_name}</string>
 </edit>
</match>

<match>
 <test name="family"><string>serif</string></test>
 <edit name="family" mode="prepend" binding="strong">
 <string>${_font_name}</string>
 </edit>
</match>

<match>
 <test name="family"><string>Apple Color Emoji</string></test>
 <edit name="family" mode="prepend" binding="strong">
 <string>${_font_name}</string>
 </edit>
</match>
</fontconfig>
EOF

	echo "=> Rebuilding font cache"
	fc-cache -f -v

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_fonts_emoji_config
