#!/bin/bash

set -C -e

if [[ ! -e ".config" ]]; then
	echo "No .config file found. :("
	exit 0
fi
echo "Let's Build! :D"

ThreadCount=$(grep -c ^processor /proc/cpuinfo)
Time=$(date '+%Y-%m-%d_%H%M')

make V=1 -j${ThreadCount} 2>&1 | tee ~/kernels/build-output/${Time}-make.log 

echo "Sudo Time, Enter password"

function kernel_install () {

echo "Installing kernel..."
sudo make install

echo "Installling Modules"
sudo make modules_install

echo "Building initramfs"

sudo mkinitcpio -p linux-custom
}

kernel_install 2>&1 | tee -a ~/kernels/build-output/${Time}-make.log 2>&1
