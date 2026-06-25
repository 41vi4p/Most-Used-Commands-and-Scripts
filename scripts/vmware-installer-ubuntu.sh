##Installing vmware on ubuntu 24.04

#Installs all required dependencies
sudo apt install curl gcc-12 git libgcc-12-dev build-essential linux-headers-$(uname -r) -y

#Assuming vmware was downloaded into the Downloads folder
cd
cd Downloads

#make the file executable
chmod +x VMware*.bundle

#Run the installer
sudo ./VMware*.bundle


