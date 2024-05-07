#!/bin/bash

# Update packages
sudo apt-get update

# Install unzip (if not already installed)
sudo apt-get install -y unzip

# Download the AWS CLI version 2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installation script
sudo ./aws/install

# Verify the installation
aws --version

# Clean up
rm -rf aws awscliv2.zip

