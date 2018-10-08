#!/usr/bin/env bash

#install nfs client
apt-get install nfs-client

#raw input for the ipaddress that from nfs server
read ipaddress
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
