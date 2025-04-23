#!/bin/bash

# This script sets up the necessary environment for the Final Project.
# It installs Docker, Docker Compose.
sudo yum update -y
sudo yum install -y docker
sudo yum install -y git
sudo service docker start
sudo chkconfig docker on

# Install Docker Compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose version