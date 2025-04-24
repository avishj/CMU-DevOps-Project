#!/bin/bash
# This script creates the necessary directory structure for the Final Project.

mkdir -p ../data # Create a base directory for volumes for the project

mkdir -p ../data/prometheus/config # For Prometheus configuration files
mkdir -p ../data/prometheus/data   # For Prometheus time series data

mkdir -p ../data/sonarqube/data   # For SonarQube database, search indexes
mkdir -p ../data/sonarqube/logs   # For SonarQube application logs
mkdir -p ../data/sonarqube/extensions # For SonarQube plugins

mkdir -p ../data/grafana                          # For Grafana dashboards, plugins, database
mkdir -p ../data/grafana/provisioning/datasources # For Grafana data sources
mkdir -p ../data/grafana/provisioning/dashboards  # For Grafana dashboards
mkdir -p ../data/jenkins     # Jenkins home directory
mkdir -p ../data/zap         # ZAP session data, reports, configs

# Create the configuration files
touch ../data/prometheus/config/prometheus.yml
touch ../data/grafana/datasources/datasource.yml
touch ../data/grafana/dashboards/dashboard.yml

# Fix permissions (insecure but simple for local development)
chmod -R 777 ../data/

# Final directory structure:

# cmu-devops-project/
# ├── data/
# │   ├── grafana/
# │   │   ├── provisioning/
# │   │   │   └── datasources/
# │   │   │       └── datasource.yml
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