#!/bin/bash
# Create a new user
sudo adduser ninja
sudo mkdir /home/ninja/.ssh
sudo bash -c 'echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDODSFkYBS+BuU40+lPWG2G7ZenWQoRfH0aqcpkuNT+Hdp+zNcCngnRgEXm9c2GI+U2T86sHcDDSYvroxUsk92nrgHDoOY3Ip1mZXwoW6a4T1xs3FJxJbSZzkIeI6ElVDEarogy3I1hZboN9IA2VgfHmpbPhgxCUUpDehFvgF0T3A7xf0oYXbsu2BB7nq0GPs7d1ZZI3i5NbmQlyYRTZ/AYiXhHr2LULS1DNVk8TWmFJsvMY5aO+uVn3RVke5WhXyItSt3dS4JPdHuYm2UFQ21R7ZjHB9C5wuwHdYZp+TKDtBIg/Om/GhQUqJQIaG1qWhHXMYd9mjVuoBb3ffw7ZROG2od432o94lEdErZmUGpKO1FSydhF+l1xHN9Mdow19FrCmBWh+h2/KK5TbNmX2SDiuxB6CEWfgjuYvee4Uoo4nVB0T+NnVBbO5N3152LWX37RtXJLp92UVZaH/gdy7iwqx6KkzINl4y5qebem/lTgmAS9Vz4VMuwd6Qa6VerL8aRt0NLKGCOBWK4cQog4+SJawTj9btwCcTz8UmfsYYSvgJevQGT6UQuQE2jkavYyBtDyGjZ/nkWzrcF4B8fZ6bQ31wTPBooRqdnWq2L9ND8Igwcl2LG82iLCnCR2IPPxCORdnLOJcrWzjpXwZg5TBQlU6oPmtMEqdKLRObKZ/mosyw== egor@Egor-Nats" > /home/ninja/.ssh/authorized_keys'
sudo chown -R ninja:ninja /home/ninja
sudo bash -c 'echo "ninja ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
#
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
cd /home/ninja
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
sudo chown ninja /etc/authbind/byport/80