#!/bin/bash -e

# NOTE: firmware-brcm80211 is newer and provides [../brcmfmac43430-sdio.txt]
# NOTE: raspi-firmware is older and also has it
OLD_PKG=raspi-firmware
CONFLICT_PKG=firmware-brcm80211
CONFLICT_FILE=/lib/firmware/brcm/brcmfmac43430-sdio.txt

log "Checking diversion of ${CONFLICT_FILE}"
on_chroot <<EOF
dpkg-divert --listpackage ${CONFLICT_FILE} | xargs echo Diverted ${CONFLICT_FILE} by  
dpkg-divert --list "*${CONFLICT_FILE}*"
dpkg-divert --package ${CONFLICT_PKG} --list "${CONFLICT_FILE}"
EOF

log "Cleaning diversion of ${CONFLICT_FILE}"
on_chroot <<EOF
dpkg-divert --local --rename --remove ${CONFLICT_FILE} || true
dpkg-divert --local --no-rename --remove ${CONFLICT_FILE} || true
dpkg-divert --package ${CONFLICT_PKG} --rename --remove ${CONFLICT_FILE} || true
EOF


log "Ensuring diversion of ${CONFLICT_FILE}"
on_chroot <<EOF
dpkg-divert --package ${CONFLICT_PKG} --rename --add ${CONFLICT_FILE}
# dpkg-divert --local --rename --add ${CONFLICT_FILE} 
EOF

log "Double Checking diversion of ${CONFLICT_FILE}"
on_chroot <<EOF
dpkg-divert --list "*${CONFLICT_PKG}*"
dpkg-divert --list "*${CONFLICT_FILE}*"

dpkg-divert --listpackage ${CONFLICT_FILE} | xargs echo Diverted ${CONFLICT_FILE} by  
EOF

# NOTE: The above did not work, so now we force
log "Try/Force Install of ${CONFLICT_PKG}"
on_chroot <<EOF
apt install -y ${CONFLICT_PKG} \
    || ( apt install -o Dpkg::Options::="--force-overwrite" ${CONFLICT_PKG} \
        && apt --fix-broken install )
EOF
