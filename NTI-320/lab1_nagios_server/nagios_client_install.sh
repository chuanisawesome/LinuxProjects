#!/bin/bash
# make sure that instance is on Allow full access to all Cloud APIs

yum -y install nagios-nrpe-server nagios-plugins

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

nagios_server="nagios-a"

sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, $nagios_server/g' /etc/nagios/nrpe.cfg

systemctl restart nrpe
