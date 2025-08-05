#!/bin/bash -e

# install support packages
on_chroot <<EOF
cd /var/cache/apt/archives
wget https://github.com/ocristopfer/cockpit-sensors/releases/latest/download/cockpit-sensors.deb
apt install ./cockpit-sensors.deb
EOF

###
# BUG: dpkg-deb: error: archive '/var/cache/apt/archives/cockpit-dockermanager.deb' uses unknown compression for member 'control.tar.zst', giving up

# on_chroot <<EOF
# cd /var/cache/apt/archives
# curl -L -o cockpit-dockermanager.deb https://github.com/chrisjbawden/cockpit-dockermanager/releases/download/latest/dockermanager.deb
# apt install ./cockpit-dockermanager.deb
# EOF

###
# BUG: E: Internal error, could not locate member control.tar{.zst,.lz4,.gz,.xz,.bz2,.lzma,}

# on_chroot <<EOF
# cd /var/cache/apt/archives
# curl -LO https://github.com/45Drives/cockpit-file-sharing/releases/download/v4.2.10/cockpit-file-sharing_4.2.10-1focal_all.deb
# apt install ./cockpit-file-sharing_4.2.10-1focal_all.deb
# EOF