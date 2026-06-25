#!/bin/bash

#Tested in Ubuntu
sudo apt update
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker

sudo apt install gh

# Installing using nvm 
# Refer this documentation for further customisation: https://www.linode.com/docs/guides/how-to-install-use-node-version-manager-nvm/

sudo apt install curl

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

source ~/.bashrc

#bun install
curl -fsSL https://bun.com/install | bash

# Dislpay the installed version of nvm package manager
nvm --version

# Install the latest version of node to customise this command refer the docs
nvm install node 

node --version

npm --version

bun --version
