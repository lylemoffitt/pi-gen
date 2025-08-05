#!/bin/bash -e

## Configure DHCP automatically on boot

install -v -m 600 files/crontab "${ROOTFS_DIR}/etc/"

install -v -m 644 files/NetworkManager.conf	"${ROOTFS_DIR}/etc/NetworkManager/"

install -v -d					"${ROOTFS_DIR}/etc/netplan"
install -v -m 600 files/50-eth0-dhcp.yaml	"${ROOTFS_DIR}/etc/netplan/"

