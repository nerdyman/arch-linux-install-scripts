#!/bin/bash

# @SEE https://github.com/helmuthdu/aui/blob/master/sharedfuncs#L455
function alis_install_from_aur {
	# shellcheck disable=SC2155
	local _script_name="$(basename ${BASH_SOURCE[0]})"
	echo -e "[${_script_name}]\n"

	local _default_user
	local _default_tmp_dir=/tmp/aur_packages

	_default_user=$(whoami)

	if [ -z $1 ] || [ $1 = "help" ]; then
		echo "=> You must specify a package"
		echo "==> Usage:"
		echo "===> ${_script_name} aur-package-name"
		echo "=> You can also specify the following:"
		echo "==> User to run install as (default: ${_default_user})"
		echo "==> Temporary to download packages (default: ${_default_tmp_dir})"
		echo "[${_script_name}]"
		exit 125
	fi

	local _user=${2:-$_default_user}
	local _tmp_dir=${3:-$_default_tmp_dir}

	# set dir for packages
	[[ ! -d $_tmp_dir ]] && sudo -H -u $_user mkdir -p $_tmp_dir

	chown -R $_user:$_user $_tmp_dir

	pushd $_tmp_dir

	for _pkg in $1; do
		echo "=> Installing AUR package: ${_pkg}"

		sudo -H -u $_user curl -o "${_pkg}.tar.gz" "https://aur.archlinux.org/cgit/aur.git/snapshot/${_pkg}.tar.gz"

		[[ -d "${_tmp_dir}/${_pkg}" ]] && rm -rf "${_tmp_dir:?}/${_pkg}"

		sudo -H -u $_user tar -zxf "${_pkg}.tar.gz"

		rm "${_pkg}.tar.gz"

		cd $_pkg

		su $_user -c "makepkg -csi --noconfirm"
	done

	popd

	echo -e "\n[${_script_name}] Done\n"
}

alis_install_from_aur $1 $2 $3
