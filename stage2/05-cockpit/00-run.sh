#!/bin/bash -e

# enable cockpit socket
on_chroot <<EOF
systemctl enable cockpit.socket
EOF
