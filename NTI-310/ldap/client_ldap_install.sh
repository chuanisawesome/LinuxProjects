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
