#Setup to COntrol Fan Speeds in Ubuntu

# Referenced: https://www.greasyguide.com/linux/display-change-fan-speed-ubuntu/

sudo apt update
sudo apt install lm-sensors

echo "Anwers yes to all the prompts"
sudo sensors-detect

sudo reboot

#reboots the system
#further instructions refer webpage


