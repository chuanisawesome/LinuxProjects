#!/usr/bin/env python
import os, time


# aws setup for intallation of django enable, updates, python3, pip, and virtualenv
def setup_install():
    os.system('yum install wget -y')
    os.chdir('/tmp/')
    os.system('wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm')
    os.system('yum install ./epel-release-latest-7.noarch.rpm -y' + \
            '&& yum install epel-release -y')
    os.system('yum install python34 python-pip -y')
    os.system('pip install virtualenv' + \
            '&& pip install --upgrade pip ')


# make directory install django that uses virtualenv
def install_django():
    os.mkdir('/opt/django')
    os.chdir('/opt/django')
    os.system('virtualenv -p python3 django')
    os.chdir('/opt/django/django')
    os.system('source /opt/django/django/bin/activate ' + \
            '&& pip install django ')
    os.system('source /opt/django/django/bin/activate' + \
            '&& django-admin startproject project1')
    os.system('chown -R ec2-user /opt/django/*')


# gets IP and puts it into settings.py
def allow_host():
    os.system('myip=$( curl https://api.ipify.org )' + \
            '&& sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'"$myip"\']/g" /opt/django/django/project1/project1/settings.py')


# starts django as the user (ec2-user)
def start_django():
    os.system('sudo -u ec2-user -E sh -c "' + \
            'source /opt/django/django/bin/activate && ' + \
            '/opt/django/django/project1/manage.py runserver 0.0.0.0:8000&"')


# calls the functions
setup_install()
install_django()
allow_host()
start_django()
