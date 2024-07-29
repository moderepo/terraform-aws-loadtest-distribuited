#!/bin/bash

sudo dnf update -y
sudo dnf install -y --allowerasing pcre2-devel.x86_64 python3.11 gcc python3.11-devel tzdata unzip bash htop python3.11-pip
sudo dnf remove -y python3-requests

# Set up alternatives to use Python 3.11 by default
sudo alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
sudo alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2
echo "2" | sudo alternatives --config python3

# Set up alternatives to use pip3 for Python 3.11 by default
sudo alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.9 1
sudo alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.11 2
echo "2" | sudo alternatives --config pip3

sudo pip3 install requests

# LOCUST
export LOCUST_VERSION="2.29.0"
sudo pip3 install locust==$LOCUST_VERSION --log pip_install.log
sudo pip3 uninstall urllib3 --log pip_install.log
sudo pip3 install urllib3==1.26.6 --log pip_install.log
sudo pip3 install locust_plugins --log pip_install.log

export PRIVATE_IP=$(hostname -I | awk '{print $1}')
echo "PRIVATE_IP=$PRIVATE_IP" >> /etc/environment

source ~/.bashrc

mkdir -p ~/.ssh
echo 'Host *' > ~/.ssh/config
echo 'StrictHostKeyChecking no' >> ~/.ssh/config

touch /tmp/finished-setup
