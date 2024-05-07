#!/bin/bash

# Function to install kubectl
install_kubectl() {
    # Define the version of kubectl to download
    KUBECTL_VERSION="v1.30.0"

    # Download kubectl binary
    echo "Downloading kubectl binary..."
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

    # Install kubectl binary
    echo "Installing kubectl binary..."
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

    # Print confirmation message
    echo "kubectl binary installed successfully."

    # Test the installed kubectl version
    echo "Testing the installed kubectl version..."
    kubectl version --client
}

# Function to install eksctl
install_eksctl() {
    # Install eksctl
    echo "Installing eksctl..."
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo mv /tmp/eksctl /usr/local/bin

    # Print confirmation message
    echo "eksctl installed successfully."

    # Test the installed eksctl version
    echo "Testing the installed eksctl version..."
    eksctl version
}

# Function to install Helm
install_helm() {
    # Download Helm
    echo "Downloading Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

    # Install Helm
    echo "Installing Helm..."
    chmod 700 get_helm.sh
    ./get_helm.sh

    # Print confirmation message
    echo "Helm installed successfully."

    # Test the installed Helm version
    echo "Testing the installed Helm version..."
    helm version
}

# Install kubectl
install_kubectl

# Install eksctl
install_eksctl

# Install Helm
install_helm

# Set creator as "Tech Mahato"
echo "Creator: Tech Mahato"

# Print final message
echo "kubectl, eksctl, and Helm setup complete."

