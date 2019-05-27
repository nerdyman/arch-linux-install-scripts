#!/bin/bash

function alis_debug_env {
	# shellcheck disable=SC2143
	IS_INTEL=$([[ $(grep -i "GenuineIntel" /proc/cpuinfo) ]] && echo true || echo false) # are you using an intel processor?
	# shellcheck disable=SC2143
	IS_VM=$([[ $(dmidecode --type 1 | grep VirtualBox) ]] && echo true || echo false) # are you running the install in a virtual machine? (for virtualbox only!)

	HAS_DMIDECODE=$([[ -f /bin/dmidecode ]] && echo true || echo false) # do you have dmidecode installed?

	echo "dmidecode: ${HAS_DMIDECODE}"
	echo "IS_INTEL:  ${IS_INTEL}"
	echo "IS_VM:     ${IS_VM}"
}

alis_debug_env
