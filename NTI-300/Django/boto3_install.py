#!/usr/bin/env python
import os, time


def setup_install():
    os.system('yum install wget -y')
    os.chdir('/tmp/')
    os.system('wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm')
    os.system('yum install ./epel-release-latest-7.noarch.rpm -y' + \
            '&& yum install epel-release -y')
    os.system('yum install python34 python-pip -y')
    os.system('pip install --upgrade pip ')
    os.system('pip install boto3' + \
            '&& pip install awscli')
    os.system('aws configure')
    time.sleep(60)
    os.system('aws ec2 describe-instances')


setup_install()
