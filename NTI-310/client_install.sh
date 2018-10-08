#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Installs debconf
apt-get -y install debconf-utils

# Gets ldap debconf from github
wget https://raw.githubusercontent.com/chuanisawesome/NTI-310/master/ldap_debconf
while read line; do echo "$line" | debconf-set-selections; done < ldap_debconf

# Installs ldap utils
apt-get -y install libpam-ldap nscd

# Set login to include ldap
sed -i 's/compat/compat ldap/g' /etc/nsswitch.conf
/etc/init.d/nscd restart

# test to see if ldap users outputs
getent passwd
export DEBIAN_FRONTEND=interactive

# -------------------- Start of NFS Client --------------------------

#install nfs client
apt-get install nfs-client

#input for the ipaddress that from nfs server
ipaddress=X.X.X.X
echo "This is the ip address you input: $ipaddress"

#show available mounts on nfs server
showmount -e $ipaddress

#makes a directory for testing
mkdir /mnt/test

#this will mount the shared fles on reboot
echo "$ipaddress:/var/nfsshare/testing        /mnt/test       nfs     defaults 0 0" >> /etc/fstab

#mount all shares in the fstab file
mount -a

#change to testing directory
cd /mnt/test
