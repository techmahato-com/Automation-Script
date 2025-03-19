#!/bin/bash

# This script is created by Tech Mahato | Arbind Sir
# Don't forget to subscribe to the YouTube channel: 
# https://www.youtube.com/c/TechMahato?sub_confirmation=1

# Step 1: Update system packages
echo "Updating system packages..."
sudo apt update -y

# Step 2: Install Java Development Kit (JDK) 17
echo "Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk

# Step 3: Add Jenkins repository key and repository
echo "Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-archive.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Step 4: Update system packages again
echo "Updating package lists after adding Jenkins repository..."
sudo apt update -y

# Step 5: Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Step 6: Enable and start Jenkins service
echo "Enabling and starting Jenkins service..."
sudo systemctl enable --now jenkins

# Step 7: Display Jenkins service status
echo "Checking Jenkins status..."
sudo systemctl status jenkins --no-pager

# Step 8: Retrieve and display Jenkins initial admin password
echo "Fetching Jenkins initial admin password..."
jenkins_password=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Jenkins admin password: $jenkins_password"

# Step 9: Print access instructions
echo "Jenkins installation is complete!"
echo "Access the Jenkins web interface at: http://your_server_ip_or_domain:8080"
echo "Follow the setup wizard to complete the installation."
echo "Ensure port 8080 is open in your firewall/security group settings to access Jenkins externally."

# End of script
