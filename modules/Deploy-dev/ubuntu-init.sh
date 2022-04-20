#!/bin/bash
# Create a new user
sudo adduser ninja --disabled-password --gecos ""
sudo mkdir /home/ninja/.ssh
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDODSFkYBS+BuU40+lPWG2G7ZenWQoRfH0aqcpkuNT+Hdp+zNcCngnRgEXm9c2GI+U2T86sHcDDSYvroxUsk92nrgHDoOY3Ip1mZXwoW6a4T1xs3FJxJbSZzkIeI6ElVDEarogy3I1hZboN9IA2VgfHmpbPhgxCUUpDehFvgF0T3A7xf0oYXbsu2BB7nq0GPs7d1ZZI3i5NbmQlyYRTZ/AYiXhHr2LULS1DNVk8TWmFJsvMY5aO+uVn3RVke5WhXyItSt3dS4JPdHuYm2UFQ21R7ZjHB9C5wuwHdYZp+TKDtBIg/Om/GhQUqJQIaG1qWhHXMYd9mjVuoBb3ffw7ZROG2od432o94lEdErZmUGpKO1FSydhF+l1xHN9Mdow19FrCmBWh+h2/KK5TbNmX2SDiuxB6CEWfgjuYvee4Uoo4nVB0T+NnVBbO5N3152LWX37RtXJLp92UVZaH/gdy7iwqx6KkzINl4y5qebem/lTgmAS9Vz4VMuwd6Qa6VerL8aRt0NLKGCOBWK4cQog4+SJawTj9btwCcTz8UmfsYYSvgJevQGT6UQuQE2jkavYyBtDyGjZ/nkWzrcF4B8fZ6bQ31wTPBooRqdnWq2L9ND8Igwcl2LG82iLCnCR2IPPxCORdnLOJcrWzjpXwZg5TBQlU6oPmtMEqdKLRObKZ/mosyw== egor@Egor-Nats" > /home/ninja/.ssh/authorized_keys
sudo chown -R ninja:ninja /home/ninja
sudo bash -c 'echo "ninja ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
sudo apt update
sudo apt install unzip -y
cd /home/ninja
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install