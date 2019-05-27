#!/bin/bash

# set mirrorlist

function alis_pacman_set_mirrorlist {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"

	echo -e "[${_script_name}]\n"

	local _default_https=true
	local _default_http=false
	local _default_ipv6=true
	local _default_ipv4=true
	local _default_path="/etc/pacman.d/mirrorlist"

	if [ -z $1 ] || [ $1 == "help" ]; then
		echo "=> You must specify a mirror country ID (case sensitive, uppercase)"
		echo "=> Usage:"
		echo "==> ${_script_name} IE"
		echo -e "\n=> You can also specify the following:"
		echo "==> https (default: $_default_https)"
		echo "==> http (default: $_default_http)"
		echo "==> ipv6 (default: $_default_ipv6)"
		echo "==> ipv4 (default: $_default_ipv4)"
		echo "==> path (default: $_default_path)"
		echo -e "\n==> Usage:"
		echo "===> ${_script_name} IE true false true true ./mirrorlist.conf"

		if [ -z $1 ]; then
			exit 125;
		else
			exit 1
		fi
	fi;

	local _https=${2:-$_default_https}
	local _http=${3:-$_default_http}
	local _ipv6=${4:-$_default_ipv6}
	local _ipv4=${5:-$_default_ipv4}
	local _path=${6:-$_default_path}

	local _query_string="?country=$1"

	if [ $_http == true ]; then
		_query_string+="&protocol=http"
	fi

	if [ $_https == true ]; then
		_query_string+="&protocol=https"
	fi

	if [ $_ipv4 == true ]; then
		_query_string+="&ip_version=4"
	fi

	if [ $_ipv6 == true ]; then
		_query_string+="&ip_version=6"
	fi

	# backup current mirrorlist
	cp -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig

	local _mirror_uri="https://www.archlinux.org/mirrorlist/$_query_string"

	# get new mirrorlist
	echo "=> Using mirrorlist: ${_mirror_uri}"
	curl -so $_path $_mirror_uri

	# enable all mirrors, will probably need limited
	sed -i -e 's/#Server/Server/g' $_path

	echo -e "\n[${_script_name}] Done\n"
}

alis_pacman_set_mirrorlist $1 $2 $3 $4 $5 $6
