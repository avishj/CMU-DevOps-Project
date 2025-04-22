# Use the same base image as in your docker-compose.yml
FROM jenkins/jenkins:lts-jdk17

# Switch to root user to change permissions if needed and install plugins
USER root

RUN apt-get update && apt-get install -y --no-install-recommends docker.io && rm -rf /var/lib/apt/lists/*

# Copy the custom plugins list i have created into the jenkins specific directory
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Create the directory for CasC configuration
RUN mkdir -p /usr/share/jenkins/ref/casc_configs && \
    chown jenkins:jenkins /usr/share/jenkins/ref/casc_configs

COPY ./jenkins-casc.yaml /var/jenkins_home/casc_configs/jenkins.yaml
# RUN ls -la /var/jenkins_home/casc_configs/

# disables the initial auth
# ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dcasc.jenkins.config=/var/jenkins_home/casc_configs/jenkins.yaml -Dio.jenkins.plugins.casc.ConfigurationAsCode.logging=FINE"
# ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false  -Dio.jenkins.plugins.casc.ConfigurationAsCode.logging=FINE"

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Dcasc.jenkins.config=/var/jenkins_home/casc_configs/ -Dio.jenkins.plugins.casc.ConfigurationAsCode.logging=FINE" 

USER jenkins
