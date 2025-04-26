#!/bin/bash
# Fix ownership of /var/jenkins_home
chown -R jenkins:jenkins /var/jenkins_home
# Start Jenkins
exec su jenkins -c "/usr/local/bin/jenkins.sh"
