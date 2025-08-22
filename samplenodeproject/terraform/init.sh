#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker azureuser

# Install NGINX
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Java (required for Jenkins)
sudo apt install -y openjdk-17-jdk

# Install kubectl
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'
sudo apt update
sudo apt install -y kubectl

# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/
