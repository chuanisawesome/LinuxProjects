#!/usr/bin/python

###########
##
# Author Chuan-Li Chang and Nicole Bade
# NTI-300 Final
##
############

import boto3                                                        # AWS SDK for Python
import pprint                                                       # "pretty-print" data that can be input to the interpreter


ec2 = boto3.resource('ec2')                                         # creates a connection
client = boto3.client('ec2')                                        # low-level client representing Amazon EC2

amazon_image = 'ami-223f945a'                                       # This will launch a red hat instance
amazon_instance = 't2.micro'                                        # We've been working with micro's, if you use Amazon Linux, you could launch a nono
amazon_pem_key = 'brandnewkeypair'                    # The name of the key/pem file you would like to use to access this machine
firewall_profiles = ['launch-wizard-30']                             # The security group name(s) you would like to use, remember, this is your firewall, make sure the ports you want open are open

print(amazon_image)                                                 # Prints the red hat instance
print(amazon_instance)                                              # Prints the t2.micro that we have been using
print(amazon_pem_key)                                               # Prints the name of the pemkey that we use to access the machine


def launch_test_instance():

    instances = ec2.create_instances(                               # The start of creating the instance
      ImageId=amazon_image,                                         # The amazon_image that we are using which is the red hat instance
      InstanceType=amazon_instance,                                 # The type of instance that we are going to use which is the t2.micro
      MinCount=1,                                                   # Minimum amount of instance
      MaxCount=1,                                                   # Maximum amount of instances
      KeyName=amazon_pem_key,                                       # Gets the amazon_pem_key which would be able to access your account
      SecurityGroupIds=firewall_profiles,                           # Uses the firewall_profiles that would allow access to the host IP
      UserData="""#!/usr/bin/env python
import sys, os, subprocess

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

     ip = subprocess.check_output("curl http://checkip.amazonaws.com", shell=True)
     f = open('/opt/django/django/project1/project1/settings.py', 'r')
     filedata = f.read()
     f.close()
     ipaddr = "ALLOWED_HOSTS = ['" + ip.rstrip() + "',]"
     newdata = filedata.replace('ALLOWED_HOSTS = []', ipaddr)
     f = open('/opt/django/django/project1/project1/settings.py', 'w')
     f.write(newdata)
     f.close()

    # os.system('myip=$( curl https://api.ipify.org )' + \
    #         '&& sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'"$myip"\'\]/g" /opt/django/django/project1/project1/settings.py')


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

"""

    )

    pprint.pprint(instances)


launch_test_instance()                                              # Calls the function launch_test_instance
