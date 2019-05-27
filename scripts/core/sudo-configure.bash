#!/bin/bash

function alis_sudo_configure {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	if [[ $(getent group sudo) ]]; then
		echo "=> Group 'sudo' already exists, skipping..."
	else
		echo "=> Creating sudo group"
		groupadd sudo
	fi

	cp -fv /etc/sudoers /etc/sudoers.alis

	# allow wheel to execute all commands
	# sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

	# @SEE https://github.com/helmuthdu/aui/blob/5e8a3116fa1be73ab150613182044eaebd543720/lilo#L308
	echo "" >> /etc/sudoers
	echo 'Defaults !requiretty, !tty_tickets, !umask' >> /etc/sudoers
	echo 'Defaults visiblepw, path_info, insults, lecture=always' >> /etc/sudoers
	echo 'Defaults loglinelen=0, logfile =/var/log/sudo.log, log_year, log_host, syslog=auth' >> /etc/sudoers
	echo 'Defaults passwd_tries=3, passwd_timeout=1' >> /etc/sudoers
	echo 'Defaults env_reset, always_set_home, set_home, set_logname' >> /etc/sudoers
	echo 'Defaults !env_editor, editor="/usr/bin/vim:/usr/bin/vi:/usr/bin/nano"' >> /etc/sudoers
	echo 'Defaults timestamp_timeout=15' >> /etc/sudoers
	echo 'Defaults passprompt="[sudo] password for %u: "' >> /etc/sudoers
	echo 'Defaults lecture=never' >> /etc/sudoers

	echo -e "\n[${_script_name}] Done\n"
}

alis_sudo_configure
