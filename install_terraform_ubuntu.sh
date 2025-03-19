#!/bin/bash

# Terraform Installation Script for Ubuntu 22.04 LTS
# Author: Tech Mahato
# Date: March 2025

set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Starting Terraform installation on Ubuntu 22.04 LTS..."

# Update system packages
sudo apt update -y

# Install necessary dependencies
sudo apt install -y wget curl unzip gnupg software-properties-common

# Add HashiCorp GPG key
echo "🔑 Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp repository
echo "📦 Adding HashiCorp repository..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package list again
sudo apt update -y

# Install Terraform
echo "⚙️ Installing Terraform..."
sudo apt install -y terraform

# Verify installation
echo "✅ Verifying Terraform installation..."
terraform version

echo "🎉 Terraform installation completed successfully!"
