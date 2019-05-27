#!/bin/bash
# install mariadb

function _alis_mariadb {
	local _script_name="mariadb"
	echo "[$_script_name]"

	# install package
	echo "=> Installing packages"
	pacman -S --noconfirm --needed mariadb

	# init mariadb data directory
	echo "=> Setting data directory"
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	# enable service
	echo "=> Enabling and starting services"
	systemctl enable mariadb.serivce
	systemctl start mariadb.service

	# exec wizard
	echo "=> Starting installation wizard"
	mysql_secure_installation

	echo "[$_script_name] Done"
}

_alis_mariadb
