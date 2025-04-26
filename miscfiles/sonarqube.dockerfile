FROM sonarqube:9.9-community

USER root

# Install necessary tools
RUN apt-get update && \
    apt-get install -y curl jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directory for the token
RUN mkdir -p /shared/tokens && \
    chmod 777 /shared/tokens

# Copy the token generation script
COPY generate-sonar-token.sh /opt/sonarqube/bin/
RUN chmod +x /opt/sonarqube/bin/generate-sonar-token.sh

# Create an entrypoint script that starts SonarQube and runs the token generator
# RUN echo '#!/bin/bash \n\
# # Start SonarQube in the background \n\
# /opt/sonarqube/bin/run.sh & \n\
# \n\
# # Wait for SonarQube to be fully up \n\
# echo "Waiting for SonarQube to start..." \n\
# until curl -s -u admin:admin http://localhost:9000/api/system/health | grep -q "\\"health\\":\\"GREEN\\""; do \n\
#   sleep 10 \n\
#   echo "Still waiting for SonarQube..." \n\
# done \n\
# \n\
# # Run the token generation script \n\
# /opt/sonarqube/bin/generate-sonar-token.sh \n\
# \n\
# # Keep container running \n\
# wait \n\
# ' > /opt/sonarqube/bin/entrypoint.sh


# RUN chmod +x /opt/sonarqube/bin/entrypoint.sh

# USER sonarqube

# ENTRYPOINT ["/opt/sonarqube/bin/entrypoint.sh"]

USER sonarqube