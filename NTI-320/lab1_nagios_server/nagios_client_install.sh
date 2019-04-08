#!/bin/bash

yum -y install nagios-nrpe-server nagios-plugins

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe


sed -i 's/allowed_hosts=127.0.0.1/allowed_hosts=127.0.0.1, 10.138.0.3/g' /etc/nagios/nrpe.cfg

systemctl restart nrpe
