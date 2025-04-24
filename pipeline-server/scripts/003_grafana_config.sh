#!/bin/bash

mkdir -p ../data/grafana/provisioning/datasources
mkdir -p ../data/grafana/provisioning/dashboards

cat > ../data/grafana/provisioning/datasources/datasource.yml << 'EOF'
apiVersion: 1

datasources:
  - name: Prometheus     # Name displayed in Grafana UI
    type: prometheus     # Data source type
    access: proxy        # Access mode: 'proxy' (Grafana backend fetches)
    url: http://prometheus:9090 # URL for Prometheus within the Docker network (service name 'prometheus', port 9090)
    jsonData:
      httpMethod: POST   
    isDefault: true      

EOF

cat > ../data/grafana/provisioning/dashboards/dashboard-provider.yml << 'EOF'
apiVersion: 1

providers:
  - name: 'default-dashboards'
    orgId: 1
    folder: ''
    type: file
    disableDeletion: true
    updateIntervalSeconds: 10
    allowUiUpdates: false
    options:
      path: /etc/grafana/provisioning/dashboards
      foldersFromFilesStructure: false

EOF

cat > ../data/grafana/provisioning/dashboards/prometheus-dashboard.json << 'EOF'


EOF

