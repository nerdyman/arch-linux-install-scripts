#!/bin/bash

function alis_admin_tools_install {
	# shellcheck disable=SC2155
	local _script_name="$(basename "${BASH_SOURCE[0]}")"
	echo -e "[${_script_name}]\\n"

	local _install_targets="bash-completion bc ccze curl dnsutils ethtool expac gnutls htop jq lzop mlocate ncurses netdata nload pkgstats strace wget whois yajl"

	# shellcheck disable=SC2086
	pacman -S --noconfirm --needed $_install_targets

	systemctl enable netdata
	systemctl start netdata

	echo -e "\\n[${_script_name}] Done\\n"
}

alis_admin_tools_install
