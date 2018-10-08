#!/bin/bash


sudo yum install -y httpd mod_ssl                                #install apache with encryption
sudo systemctl enable httpd                                      #enable apache
sudo systemctl start httpd                                       #start apache

sudo sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                    #Commenting out the welcome.conf

echo -e "<html> \n<h1>Welcome, NTI-300</h1> \n<h2>Linux is awesome!</h2> \n</html>" > /var/www/html/index.html      #Creating index.html 
