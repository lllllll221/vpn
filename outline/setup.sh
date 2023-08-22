#!/bin/bash

# Step 2: System Update
echo "System update..."
sudo apt update && sudo apt upgrade -y

# Step 4: Install Docker
echo "Installing Docker..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce

# Additional Docker status check
echo "Checking Docker status..."
sudo systemctl status docker

echo "Installation complete!"
