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
    metrics_path: '/metrics'
    basic_auth:
      username: 'prometheus' 
      password: 'password'
    static_configs:
      - targets: ['grafana:3000']
  - job_name: 'sonarqube'
    metrics_path: '/api/monitoring/metrics'
    authorization:
      type: Bearer
      credentials: 'password'
    static_configs:
      - targets: ['sonarqube:9000']
  - job_name: 'springapplication'
    metrics_path: '/actuator/prometheus'
    static_configs:
      - targets: ['ip-172-31-36-9.ec2.internal:8079']

EOF
