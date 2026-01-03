#!/bin/bash

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
