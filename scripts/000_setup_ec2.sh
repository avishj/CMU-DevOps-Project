#!/bin/bash

# This script sets up the necessary environment for the Final Project.
# It installs Docker, Docker Compose.
sudo su
yum update -y
yum install -y docker
yum install -y git
service docker start
chkconfig docker on

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version