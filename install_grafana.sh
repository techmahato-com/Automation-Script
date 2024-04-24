#!/bin/bash

# Download the Grafana GPG key and add it to keyrings
wget -q -O - https://packages.grafana.com/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/grafana.gpg > /dev/null

# Add Grafana repository to APT sources
echo "deb [signed-by=/usr/share/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Refresh APT cache
sudo apt update

# Install Grafana
sudo apt install grafana -y

# Start Grafana server
sudo systemctl start grafana-server

# Verify Grafana service status
sudo systemctl status grafana-server

# Enable automatic start of Grafana on boot
sudo systemctl enable grafana-server

# Provide user with information on accessing Grafana
echo "Grafana is installed and running. You can access it by pointing your web browser to https://your_domain"

