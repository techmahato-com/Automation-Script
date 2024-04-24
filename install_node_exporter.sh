#!/bin/bash

# Define Node Exporter version
NODE_EXPORTER_VERSION="1.8.0"

# Download Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

# Extract the downloaded archive
tar -xf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz

# Move the node_exporter binary to /usr/local/bin
sudo mv node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter /usr/local/bin

# Remove the residual files
sudo rm -rf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64*

# Create node_exporter user
sudo useradd -rs /bin/false node_exporter

# Create systemd unit file for node_exporter
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOT
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start node_exporter service
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

echo "Node Exporter installation and setup completed."

