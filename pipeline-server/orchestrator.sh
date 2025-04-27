#!/bin/bash

command -v docker-compose >/dev/null 2>&1 && docker-compose down
rm -rf data/
cd scripts
./000_setup_ec2.sh
./001_file_structure.sh
./002_prometheus_config.sh
./003_grafana_config.sh
# ./004_terraform_config.sh
docker-compose build 
docker-compose up zap prometheus sonarqube grafana -d