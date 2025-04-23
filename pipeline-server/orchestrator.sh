#!/bin/bash

docker-compose down
rm -rf data/
cd scripts
./000_setup_ec2.sh
./001_file_structure.sh
./002_prometheus_config.sh
./003_grafana_config.sh
docker-compose up -d