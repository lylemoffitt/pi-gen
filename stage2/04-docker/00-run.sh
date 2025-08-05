#!/bin/bash -e


# Change to add files for docker
mkdir --parents "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/counter/"
install -m 777 files/app.sh "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/counter/"
install -m 666 files/docker-compose.yml "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/counter/"
install -m 666 files/Dockerfile "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/counter/"
# End change to add files for docker

#REF: https://docs.docker.com/engine/install/debian/#install-using-the-repository
on_chroot << EOF
# Add Docker's official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${RELEASE} stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
EOF

# Change to install docker /docker-compose
on_chroot << EOF
apt-get update
apt-get install -y \
	docker-ce{,-cli} docker-{compose,buildx}-plugin containerd.io
systemctl enable docker
EOF
# End change to install docker /docker-compose

# Change to user to docker group
on_chroot <<EOF
adduser $FIRST_USER_NAME docker
EOF