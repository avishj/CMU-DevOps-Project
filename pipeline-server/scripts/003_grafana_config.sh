#!/bin/bash

mkdir -p ../data/grafana/datasources

cat > ../data/grafana/datasources/datasource.yml << 'EOF'
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