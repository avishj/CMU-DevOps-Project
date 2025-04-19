# This script creates the necessary directory structure for the Final Project.

mkdir -p data # Create a base directory for volumes for the project
mkdir -p data/gitlab/config # For GitLab configuration files
mkdir -p data/gitlab/logs  # For GitLab logs
mkdir -p data/gitlab/data  # For GitLab database, repositories, etc.

mkdir -p data/prometheus/config # For Prometheus configuration files
mkdir -p data/prometheus/data   # For Prometheus time series data

mkdir -p data/sonarqube/data   # For SonarQube database, search indexes
mkdir -p data/sonarqube/logs   # For SonarQube application logs
mkdir -p data/sonarqube/extensions # For SonarQube plugins

mkdir -p data/grafana/data     # For Grafana dashboards, plugins, database

mkdir -p data/jenkins/data     # Jenkins home directory

mkdir -p data/zap/data         # ZAP session data, reports, configs

# Create the Prometheus configuration file
touch data/prometheus/config/prometheus.yml

# Final directory structure:

# cmu-devops-project/
# ├── data/
# │   ├── gitlab/
# │   │   ├── config/
# │   │   ├── data/
# │   │   └── logs/
# │   ├── grafana/
# │   ├── jenkins/
# │   ├── prometheus/
# │   │   ├── config/
# │   │   │   └── prometheus.yml
# │   │   └── data/
# │   ├── sonarqube/
# │   │   ├── data/
# │   │   ├── extensions/
# │   │   └── logs/
# │   └── zap/
# └── docker-compose.yml