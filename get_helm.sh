#!/bin/bash

# Define the Helm version
HELM_VERSION="3.6.0"

# Define the download URL for the Helm binary
HELM_URL="https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz"

# Define the directory to download and extract Helm binary
HELM_DIR="/tmp/helm"

# Create a temporary directory for Helm installation
mkdir -p "${HELM_DIR}"

# Download Helm binary
echo "Downloading Helm ${HELM_VERSION}..."
wget -qO "${HELM_DIR}/helm.tar.gz" "${HELM_URL}"

# Extract Helm binary
echo "Extracting Helm binary..."
tar -zxvf "${HELM_DIR}/helm.tar.gz" -C "${HELM_DIR}"

# Move Helm binary to /usr/local/bin directory
echo "Installing Helm..."
sudo mv "${HELM_DIR}/linux-amd64/helm" /usr/local/bin/helm

# Verify Helm installation
helm version --short

# Clean up
echo "Cleaning up..."
rm -rf "${HELM_DIR}"

echo "Helm ${HELM_VERSION} has been installed successfully."
