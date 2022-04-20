#!/bin/bash
sudo yum -y update
sudo yum install git -y
sudo yum install ruby -y
sudo yum install wget -y
sudo yum install git -y
sudo yum install python3-pip python3-devel python3-setuptools -y
sudo yum install openssl-devel libffi-devel bzip2-devel -y
# sudo yum groupinstall "Development Tools" -y
# wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
# tar xvf Python-3.10.0.tgz
# cd Python-3.10.0
# ./configure --enable-optimizations
# sudo make altinstall
# sudo ln -fs /usr/local/bin/python3.10 /usr/bin/python3
# curl -sSL https://install.python-poetry.org | python3 -
cd /home/ec2-user
# Use official documentation they said...
# wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
# sudo chmod +x ./install
# sudo ./install auto
# sudo service codedeploy-agent start
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/codedeploy-agent.noarch.rpm
sudo rpm -i codedeploy-agent.noarch.rpm

# Install authbind and modify port 80
wget https://s3.amazonaws.com/aaronsilber/public/authbind-2.1.1-0.1.x86_64.rpm
sudo rpm -Uvh https://s3.amazonaws.com/aaronsilber/public/authbind-2.1.1-0.1.x86_64.rpm
sudo touch /etc/authbind/byport/80
sudo chmod 500 /etc/authbind/byport/80
sudo chown ec2-user /etc/authbind/byport/80