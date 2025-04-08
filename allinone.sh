#!/bin/bash

# Update system
sudo yum update -y

# Install Git
sudo yum install -y git

# Install Terraform
sudo yum install -y yum-utils
touch /etc/yum.repos.d/hashicorp.repo
echo "[hashicorp]" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
echo "name=HashiCorp Stable - $basearch" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
echo "baseurl=https://rpm.releases.hashicorp.com/RHEL/\$releasever/\$basearch/stable" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
echo "enabled=1" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
echo "gpgcheck=1" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
echo "gpgkey=https://rpm.releases.hashicorp.com/gpg" | sudo tee -a /etc/yum.repos.d/hashicorp.repo
sudo yum install -y terraform

# Install Jenkins
sudo yum install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
# Add required dependencies for the jenkins package
sudo yum install -y fontconfig java-17-openjdk
sudo yum install -y jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Install Docker
sudo yum install -y yum-utils
touch /etc/yum.repos.d/docker-ce.repo
echo "[docker-ce]" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "name=Docker CE Stable - $basearch" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "baseurl=https://download.docker.com/linux/centos/\$releasever/\$basearch/stable" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "enabled=1" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "gpgcheck=1" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "gpgkey=https://download.docker.com/linux/centos/gpg" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker
#sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
#sudo firewall-cmd --reload



# Install Ansible
sudo yum install -y epel-release
sudo yum install -y ansible

# Install Python
sudo yum install -y python3

# Verify installation
echo "Verifying installations..."
echo "Git version: $(git --version)"
echo "Terraform version: $(terraform -version)"
echo "Jenkins status: $(systemctl is-active jenkins)"
echo "Docker version: $(docker --version)"
echo "Docker status: $(systemctl is-active docker)"
echo "Ansible version: $(ansible --version | head -n 1)"
echo "Python version: $(python3 --version)"

echo "Installation completed successfully."

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Gcloud Login 

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

sudo dnf install google-cloud-cli


