#!/bin/bash

yum -y install nagios
systemctl enable nagios
systemctl start nagios

setenforce 0

yum -y install httpd
systemctl enable httpd
systemctl start httpd

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

yum -y install nagios-plugins-all
yum -y install nagios-plugins-nrpe

htpasswd -c /etc/nagios/passwd nagiosadmin

chmod 666 /var/log/nagios/nagios.log 

/usr/sbin/nagios -v /etc/nagios/nagios.cfg


echo '########### NRPE CONFIG LINE #######################
define command{
command_name check_nrpe
command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /etc/nagios/objects/commands.cfg
