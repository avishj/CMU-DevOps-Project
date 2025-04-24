#!/bin/bash

mkdir -p ../data/prometheus/config

cat > ../data/prometheus/config/prometheus.yml << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']
  - job_name: 'jenkins'
    metrics_path: '/jenkins/prometheus/'
    static_configs:
      - targets: ['jenkins:8080']
  - job_name: 'grafana'
    metrics_path: '/api/metrics'
    basic_auth:
      username: 'prometheus' 
      password: 'password'
    static_configs:
      - targets: ['grafana:3000']

  # Add other scrape configs as needed (GitLab, SonarQube, Jenkins...)
  # - job_name: 'gitlab'
  #   metrics_path: '/-/metrics'
  #   static_configs:
  #     - targets: ['gitlab:80']
  # - job_name: 'sonarqube'
  #   metrics_path: '/api/prometheus/metrics'
  #   static_configs:
  #     - targets: ['sonarqube:9000']

EOF
