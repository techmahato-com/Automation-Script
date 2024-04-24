#!/bin/bash

# Define Prometheus version
PROMETHEUS_VERSION="2.51.2"

# Define Prometheus file details
PROMETHEUS_FILENAME="prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
PROMETHEUS_DOWNLOAD_URL="https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/${PROMETHEUS_FILENAME}"

# Download Prometheus
wget "$PROMETHEUS_DOWNLOAD_URL"

# Extract Prometheus archive
tar -xf "$PROMETHEUS_FILENAME"

# Move binaries to /usr/local/bin
sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus" "prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool" /usr/local/bin

# Create directories for configuration files and other data
sudo mkdir -p /etc/prometheus /var/lib/prometheus

# Move configuration files to the appropriate directory
sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/consoles" "prometheus-${PROMETHEUS_VERSION}.linux-amd64/console_libraries" /etc/prometheus

# Clean up leftover files
rm -r "prometheus-${PROMETHEUS_VERSION}.linux-amd64*"

# Create Prometheus configuration file
sudo tee /etc/prometheus/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 10s

scrape_configs:
- job_name: 'prometheus_metrics'
  scrape_interval: 5s
  static_configs:
  - targets: ['localhost:9090']
- job_name: 'node_exporter_metrics'
  scrape_interval: 5s
  static_configs:
  - targets: ['localhost:9100','prometheus-target-1:9100','prometheus-target-2:9100']
EOF

# Change ownership of Prometheus files
sudo useradd -rs /bin/false prometheus
sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus

# Create systemd unit file
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
   --config.file /etc/prometheus/prometheus.yml \
   --storage.tsdb.path /var/lib/prometheus/ \
   --web.console.templates=/etc/prometheus/consoles \
   --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Enable and start Prometheus service
sudo systemctl enable prometheus
sudo systemctl start prometheus

