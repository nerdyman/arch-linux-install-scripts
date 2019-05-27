#!/bin/bash
# securely wipe disk

function alis_wipe_disk {
	echo "[${BASH_SOURCE[0]}]"

	if [ -z $1 ] || [ $1 == "help" ]; then
		echo "=> You must specify a disk target, usage:"
		echo "=> $(basename $0) /dev/sda"
		exit 1
	fi

	echo "=> Shredding contents on: $1"
	shred -vfuz -n 10 $1

	echo "[${BASH_SOURCE[0]}] Done"
}

alis_wipe_disk $1
