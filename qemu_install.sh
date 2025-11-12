sudo apt update

sudo apt install qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

#Check QEMU version
qemu-system-x86_64 --version

#Check KVM modules
lsmod | grep kvm

#Add your user to the libvirt group
sudo usermod -aG libvirt $(whoami)
