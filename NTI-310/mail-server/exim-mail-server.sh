#!/bin/bash

yum install wget -y
yum install exim mailx -y

mkdir /root/SSL/mail.mydomain.com -p
cd /root/SSL/mail.mydomain.com

COUNTRY="US"                # 2 letter country-code
STATE="Washington"            # state or province name
LOCALITY="Seattle"        # Locality Name (e.g. city)
ORGNAME="SCC"               # Organization Name (eg, company)
ORGUNIT="1"                  # Organizational Unit Name (eg. section)
HOSTNAME="Mail"
EMAIL="chuan@mydomain.com"  # certificate's email address
cat <<__EOF__ | openssl req -nodes -x509 -newkey rsa:2048 -keyout mail.mydomain.com.key -out mail.mydomain.com.crt -days 365
$COUNTRY
$STATE
$LOCALITY
$ORGNAME
$ORGUNIT
$HOSTNAME
$EMAIL
__EOF__

cp mail.mydomain.com.key mail.mydomain.com.crt /etc/ssl/
cp /etc/exim/exim.conf{,.orig}

# TODO: in vim /etc/exim/exim.conf

# backs up org with .1 
wget --backups=1 /etc/exim/ https://raw.githubusercontent.com/chuanisawesome/NTI-310/master/mail-server/exim.conf
  
systemctl start exim
systemctl status exim
systemctl enable exim
  
yum install dovecot -y

wget --backups=1 /etc/dovecot/conf.d/ https://raw.githubusercontent.com/chuanisawesome/NTI-310/master/mail-server/10-ssl.conf

systemctl start dovecot
systemctl status dovecot
systemctl enable dovecot
