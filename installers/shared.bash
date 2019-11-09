#!/bin/bash
# shared functions for install scripts

# shellcheck disable=SC1090
# shellcheck disable=SC2046

alis_shared_wd=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_alis_shared_script_name=$(basename "${BASH_SOURCE[0]}")

source "${alis_shared_wd}/config.bash"
source "${alis_shared_wd}/consts.bash"

_alis_mount_copy_dir="${MOUNT_POINT}${ALIS_COPY_DIRECTORY}"

# print line the width of the terminal
# @SEE https://github.com/helmuthdu/aui/blob/96c14c11bf2abb9ac54c7a1320f29d3f7a6c017f/sharedfuncs#L322
function print_line {
	printf "%$(tput cols)s\\n"|tr ' ' '-'
}

function alis_shared_debug {
	echo -e "\\n\\n######## DEBUG ########"
	echo -e "$1"
	echo -e "###### END DEBUG ######\\n"
	sleep 1
}

function alis_shared_banner {
	print_line

	cat <<-EOF
		:: Arch Linux Install Scripts

		:: Using installer: ${1}
	EOF

	echo -e ":: About: ${2}"

	print_line
}

# determine if a string ends with another string
function alis_shared_ends_with {
	if [[ "$1" == "*$2" ]]; then
		echo true
	else
		echo false
	fi
}

# copy list of files with specific permissions/ownership
function alis_shared_copy_files_with_permissions {
	local _script_name="[$_alis_shared_script_name]::${FUNCNAME[0]}"

	echo -e "${_script_name}\\n"

	local _files=$1
	local _destination=$2

	local _permissions=${3:-644}
	local _owner
	_owner=${4:-$(whoami)}
	local _files_root=${5:-"${alis_shared_wd}/../"}

	local _empty_string=""

	# determine if _destination has a trailing slash
	local _destination_has_trailing_slash
	_destination_has_trailing_slash=$(alis_shared_ends_with "${_destination}" "/")

	# add trailing slash if necessary
	if [[ ! $_destination_has_trailing_slash == true ]]; then
		_destination+="/"
	fi

	# copy each file
	while read -r _file; do
		# strip prefixed alis path from file path
		local _filename="${_file/${_files_root}/$_empty_string}"

		# set new file path e.g. `/mnt/etc/vimrc`
		local _new_file_path="${_destination}${_filename}"
		echo "=> Using file path: '${_new_file_path}'"

		echo "=> Copying '${_filename}' to '${_new_file_path}', permissions: ${_permissions}, owner: ${_owner}"
		install -m "$_permissions" -g "$_owner" -o "$_owner" -S ".alis" -D "$_file" "$_new_file_path"

		printf "\\n"

	done <<< "${_files}"

	echo -e "\\n${_script_name} Done\\n"
}

# copy static configs to mounted install
function alis_shared_copy_configs_etc {
	local _files
	_files=$(find "${alis_shared_wd}/../configs/etc" -type f)

	alis_shared_copy_files_with_permissions \
		"$_files" \
		"$alis_shared_wd/test/etc" \
		"644" \
		"root" \
		"${alis_shared_wd}/../configs/etc"
}

# copy static config to user's home directory
# @NOTE this is run from inside the container
function alis_shared_copy_configs_home {
	local _files
	_files=$(find "${ALIS_COPY_DIRECTORY}/configs/home" -type f)

	alis_shared_copy_files_with_permissions \
		"$_files" \
		"/home/${CONFIG_USER_USERNAME}" \
		"644" \
		"$CONFIG_USER_USERNAME" \
		"${ALIS_COPY_DIRECTORY}/configs/home"
}

# copy static configs to new install (with correct permissions)
function alis_shared_apply_static_configs {
	echo -e "[alis_shared_copy_static_configs]\\n"
	alis_shared_copy_configs_etc
	alis_shared_copy_configs_home
	echo -e "\\n[alis_shared_copy_static_configs]\\n"
}

# set ownership and permissions of copied files
function alis_shared_set_copied_script_permissions {
	echo "=> Changing ownership for files in '${_alis_mount_copy_dir}'"
	source "${alis_shared_wd}/../scripts/helpers/chroot.bash" \
		"$MOUNT_POINT" \
		"chown -R root:root ${ALIS_COPY_DIRECTORY}"

	echo "=> Setting permissions for files in '${_alis_mount_copy_dir}'"
	source "${alis_shared_wd}/../scripts/helpers/chroot.bash" \
		"$MOUNT_POINT" \
		"chmod -R 755 ${ALIS_COPY_DIRECTORY}"
}

# copy all files
function alis_shared_copy_files {
	echo -e "[alis_shared_copy_files]\\n"

	mkdir -p "$_alis_mount_copy_dir"

	echo "=> Copying scripts to ${_alis_mount_copy_dir}"
	# cp -rf $alis_shared_wd/../scripts $_alis_mount_copy_dir
	cp -rf "$alis_shared_wd/.." "$_alis_mount_copy_dir"

	# set permissions
	alis_shared_set_copied_script_permissions

	echo -e "\\n[alis_shared_copy_files]\\n"
}

# @SEE https://github.com/helmuthdu/aui/blob/3472013b9c3f59fe90ecd7db73887d20d4acab5c/sharedfuncs#L567
function alis_shared_pause {
	read -r -e -sn 1 -p "Press enter to continue..."
}

# Install a shell if it isn't installed
# Usage: `alis_shared_shell_install "/bin/zsh"`
# function alis_shared_shell_install {
# 	local _shell=$1
# 	local _file_path="${MOUNT_POINT}/etc/shells"
#
# 	echo "=> Checking if '${_shell}' exists in ${_file_path}"
#
# 	if grep -Fxq "$_shell" "$_file_path"; then
# 		echo "==> Shell already exists, skipping install"
# 	else
# 		# get shell name e.g. '/bin/zsh' > 'zsh'
# 		local _shell_name
# 		_shell_name=$(basename "$_shell")
#
# 		# if zsh
# 		if [[ $_shell_name == "zsh" ]]; then
# 			echo "==> Shell doesn't exist, installing"
# 			source "${alis_shared_wd}/../scripts/core/zsh-install.bash" \
# 				"${MOUNT_POINT}/home/${CONFIG_USER_USERNAME}/.zshrc"
# 				$CONFIG_USER
# 				true
# 		# shell not supported
# 		else
# 			echo "=> WARN: shell '${_shell_name}' is not supported, skipping"
# 		fi
# 	fi
# }

# standard init commands for any installer script
function alis_shared_installer_init {
	# prevent screen from sleeping if $TERM is defined
	if [[ -z "${TERM}" ]]; then
		setterm -blank 0 -powerdown 0
	fi

	# sync time
	timedatectl set-ntp true
}

# complete notification
function alis_shared_installer_done {
	print_line

	echo -e "\\n:: Installation complete\\n"

	print_line
}

# enable/disable remote root login (@NOTE ONLY DISABLE DURING INSTALL!)
function alis_shared_remote_root_login {
	local _enable_remote_root_login=$1

	local _file_path="${MOUNT_POINT}/etc/securetty"
	local _file_path_backup="${_file_path}.alis"

	if [[ $_enable_remote_root_login == true ]] && [[ -f $_file_path ]]; then
		echo "=> ENABLING remote root login"
		mv "$_file_path" "$_file_path_backup"

	elif [[ ! $_enable_remote_root_login ]] && [[ -f $_file_path_backup ]]; then
		echo "=> Disabling remote root login"
		mv "$_file_path_backup" "$_file_path"

	else
		echo "=> No files found at '${_file_path}' or '${_file_path_backup}', skipping"
	fi
}

function install_graphics_drivers {
	local _driver_family=$1
	local _is_vm=${2:false}

	alis_shared_debug "[install_graphics_drivers] ISVM: ${IS_VM}, 2: $2, _is_vm: ${_is_vm}"

	if [[ $_is_vm == false ]] || [[ $_is_vm == 'false' ]]; then # never want 3rd party gfx drivers in vm

		# nvidia proprietary
		if [[ $_driver_family == "$ALIS_GPU_DRIVER_NVIDIA" ]]; then
			source "${alis_shared_wd}/../scripts/base/nvidia-proprietary-install-drivers.bash"
			source "${alis_shared_wd}/../scripts/base/nvidia-proprietary-set-xorg-config.bash"

		# nvidia proprietary legacy
	elif [[ $_driver_family == "$ALIS_GPU_DRIVER_NVIDIA_LEGACY" ]]; then
			source "${alis_shared_wd}/../scripts/base/nvidia-proprietary-install-drivers-legacy.bash"
			source "${alis_shared_wd}/../scripts/base/nvidia-proprietary-set-xorg-config.bash"
		fi
	else
		echo "=> Install is running in a virtual machine '${_driver_family}' packages will not be installed"
	fi
}

function alis_shared_unmount {
	echo "=> Unmounting boot at '${MOUNT_POINT_BOOT}'"
	umount "$MOUNT_POINT_BOOT"

	echo "=> Unmounting root at '${MOUNT_POINT}'"
	umount "$MOUNT_POINT"
}
