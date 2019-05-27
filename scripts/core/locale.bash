#!/bin/bash

function alis_locale {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [ -z $1 ] || [ $1 = "help" ]; then
		echo "=> You must specify a complete locale, usage:"
		echo "=> ${_script_name} \"en_GB\""
		echo -e "\n=>You may also include an optional secondary locale:"
		echo "=> ${_script_name} \"en_GB\" \"en_US\""
		exit 1
	fi

	local _lang="${1}.UTF-8"

	# set secondary locale if requested
	if [[ ! -z $2 ]]; then
		echo "=> Enabling secondary locale: '${2}'"
		sed -i 's/#'${2}.UTF-8'/'${2}.UTF-8'/' /etc/locale.gen
	fi

	echo "=> Enabling primary locale: '${_lang}'"
	echo 'LANG="'${_lang}'"' > /etc/locale.conf
	sed -i 's/#'${_lang}'/'${_lang}'/' /etc/locale.gen

	echo "=> Generating locale(s)"
	locale-gen

	echo -e "\n[${_script_name}] Done\n"
}

alis_locale "$1" "$2"
