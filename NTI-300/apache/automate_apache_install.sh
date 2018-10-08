#!/bin/bash



#install,enable,start apache
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

#restart apache instance and loads new module
sudo yum install -y mod_ssl
sudo systemctl restart httpd
