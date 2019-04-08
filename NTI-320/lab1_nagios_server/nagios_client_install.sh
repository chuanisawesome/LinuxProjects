#!/bin/bash
# make sure that instance is on Allow full access to all Cloud APIs

yum -y install nagios-nrpe-server nagios-plugins

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

nagios_server="nagios-a"

nagios_ip=$(gcloud compute instances list | grep $nagios_server | awk '{ print $4 }' | tail -1)

sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, $nagios_ip/g' /etc/nagios/nrpe.cfg

systemctl restart nrpe
