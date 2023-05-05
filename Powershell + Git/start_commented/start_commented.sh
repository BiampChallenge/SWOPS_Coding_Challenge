#!/bin/bash

# Get the user's UID and GID
passwdline=cat /opt/host/etc/passwd | grep "^$USER:"
uid=echo $passwdline | cut -f3 -d':'
gid=echo $passwdline | cut -f4 -d':'

# Create a group with the user's GID
groupadd -g ${gid} ${USER}

# Create a user with the user's UID and GID, and add it to the 'yocto' and 'sudo' groups
useradd -u ${uid} -g ${USER} -G yocto,sudo -s /bin/bash --home-dir ${HOME} ${USER}

# Create /dev/loop0 if it doesn't exist
if [ ! -b /dev/loop0 ]; then
  mknod /dev/loop0 b 7 0
fi

# Set the user's password
echo "${USER}:${USER}" | chpasswd 

# Create directories and set permissions
sudo mkdir -p "/var/cache/yocto/"
sudo chown ${USER}:${USER} -R "/var/cache/yocto/"
mkdir -p "${HOME}/.yocto-cache/downloads"
sudo chown ${USER}:${USER} -R "${HOME}/.yocto-cache/downloads"
sudo ln -s "${HOME}/.yocto-cache/downloads" "/var/cache/yocto/downloads" 
mkdir -p "${HOME}/.yocto-cache/sstate"
sudo chown ${USER}:${USER} -R "${HOME}/.yocto-cache/sstate"
sudo ln -s "${HOME}/.yocto-cache/sstate" "/var/cache/yocto/sstate" 

# Change to the working directory
cd $WORKING_DIR

# Set the BASH_RC_FILE variable to the user's .bashrc file
BASH_RC_FILE="/home/${USER}/.bashrc"

# If command line arguments are provided, execute them as the user in a new shell
if [ $# -gt 0 ]; then
  exec sudo  --user=${USER} env "PATH=${PATH}" "VIRTUAL_ENV=${VIRTUAL_ENV}" "CONTAINER=true" "BITBUCKET_URL=${BITBUCKET_URL}" /bin/bash --rcfile ${BASH_RC_FILE} -c "$*"
else
  # Otherwise, start a new shell as the user
  exec sudo  --user=${USER} env "PATH=${PATH}" "VIRTUAL_ENV=${VIRTUAL_ENV}" "CONTAINER=true" "BITBUCKET_URL=${BITBUCKET_URL}" /bin/bash --rcfile ${BASH_RC_FILE}
fi