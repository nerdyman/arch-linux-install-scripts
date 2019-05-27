#!/bin/bash
# install php with additional packages

function _alis_php {
	local _script_name="mariadb"
	echo "[$_script_name]"

	echo "=> Installing packages"
	pacman -S --noconfirm --needed composer php php-fpm php-gd php-geoip php-intl php-mcrypt php-memcached php-sqlite xdebug

	echo "=> Enabling and starting services"
	systemctl enable php-fpm.service
	systemctl start php-fpm.service

	echo "[$_script_name] Done"
}

_alis_php
