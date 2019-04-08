#!/bin/bash

#####INSTALL NAGIOS#####
yum -y install nagios
systemctl enable nagios
systemctl start nagios

#####TURN OFF SE LINUX#####
setenforce 0

#####INSTALL APACHE#####
yum -y install httpd
systemctl enable httpd
systemctl start httpd

#####INSTALL NRPE#####
yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe

#####INSTALL NAGIOS SERVER PLUGINS#####
yum -y install nagios-plugins-all

#####INSTALL NRPE SERVER PLUGINS#####
yum -y install nagios-plugins-nrpe

#####CREATE PASSWORD#####
htpasswd -c /etc/nagios/passwd nagiosadmin

#####ENABLE ACCESS FOR LOGS#####
chmod 666 /var/log/nagios/nagios.log 

#####RESTARTING NAGIOS#####
/usr/sbin/nagios -v /etc/nagios/nagios.cfg

#####CHANGE DIRECTORY#####
cd /etc/nagios/

#vim generate_config.sh
#chmod +x generate_config.sh

#./generate_config.sh web-a 10.138.0.4

#####MAKE DIRECTORY#####
mkdir servers

######Need to put the NRPE changes into config file#####
echo '########### NRPE CONFIG LINE #######################
define command{
command_name check_nrpe
command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
}' >> /etc/nagios/servers/commands.cfg

#####RESTART NAGIOS#####
systemctl restart nagios
