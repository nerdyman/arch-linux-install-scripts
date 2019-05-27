#!/bin/bash
# complete installer (pre and post)
# shellcheck disable=SC1090

set -e

# shellcheck disable=SC2046
alis_installer_wd=$(dirname $(realpath "$0"))

# get shared installer tools
source "${alis_installer_wd}/../../installers/bootstrap.bash"
source "${alis_installer_wd}/../../installers/shared.bash"

# all systems go
alis_shared_installer_init
alis_shared_banner "nerdyman" "Hardened install for Web/JavaScript Developers, i3wm"

# run install-first.bash, don't kill container
source "${alis_installer_wd}/install-first.bash" false

# enable remote root login
alis_shared_remote_root_login true

# run install-last.bash on container
source "${alis_installer_wd}/../../scripts/helpers/systemd-run.bash" \
	"$CONFIG_HOSTNAME" \
	"${ALIS_COPY_DIRECTORY}/installers/nerdyman/install-last.bash" \
	true

# watch output
# source $alis_installer_wd/../../scripts/helpers/journalctl-follow-container.bash $CONFIG_HOSTNAME

# disable remote root login
alis_shared_remote_root_login false

# kill container
source "${alis_installer_wd}/../../scripts/helpers/machinectl-kill-container.bash" \
	"$CONFIG_HOSTNAME"

alis_shared_unmount

alis_shared_installer_done
