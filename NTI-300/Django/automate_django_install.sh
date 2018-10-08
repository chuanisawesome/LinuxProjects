#!/bin/bash

# aws install, enable
yum install wget -y
cd /tmp/
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install ./epel-release-latest-7.noarch.rpm -y
yum install python-pip -y

# install virtualenv using pip
pip install virtualenv

# upgrade pip 
pip install --upgrade pip

# creating a directory to run django server
mkdir /opt/django

# change directory into that dir
cd /opt/django

# make sure that you are running python 3
python --version
yum install epel-release -y
yum install python34 -y

# run virtualenv and run python3
virtualenv -p python3 django
cd django
ls
source bin/activate

# check to see if you are running python 3
python --version

# the install of django
pip install django
django-admin --version

# create django project
django-admin startproject project1

# this server should be run as a user not root
# chown to username or ec2-user
chown -R ec2-user /opt/django/django/
ls -l

# exit to normal user (username or ec2-user) 
# start django test server
sudo -u ec2-user
source /opt/django/django/bin/activate
/opt/django/django/project1/manage.py runserver 0.0.0.0:8000&

# open the firewall to port 8000


# add ip address into your settings.py 
myip=$( curl https://api.ipify.org )
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \['"$myip"'\]/g" /opt/django/django/project1/project1/settings.py

