# Linux System Tools Reference

## Fan Speed Control (lm-sensors)

### Install and configure
```bash
sudo apt update
sudo apt install lm-sensors
sudo sensors-detect          # answer YES to all prompts
sudo reboot
```

### Monitor fans and temperatures
```bash
sensors                                  # current readings
watch -n 1 sensors                       # refresh every second
watch -n 1 'sensors | grep fan'          # fan speeds only
watch -n 1 'sensors | grep temp'         # temperatures only
```

### Install fancontrol for automated fan management
```bash
sudo apt install fancontrol
sudo pwmconfig                           # configure fan control curves
sudo systemctl enable fancontrol
sudo systemctl start fancontrol
```

---

## QEMU / KVM Virtualization

### Install QEMU and KVM
```bash
sudo apt update
sudo apt install qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```

### Add user to libvirt group (required to manage VMs without sudo)
```bash
sudo usermod -aG libvirt $(whoami)
```

### Verify KVM is working
```bash
qemu-system-x86_64 --version
lsmod | grep kvm
kvm-ok                                   # install with: sudo apt install cpu-checker
```

### Start virt-manager GUI
```bash
virt-manager
```

---

## VMware on Ubuntu 24.04

### Install dependencies
```bash
sudo apt install curl gcc-12 git libgcc-12-dev build-essential linux-headers-$(uname -r) -y
```

### Run the installer (assumes VMware bundle is in ~/Downloads)
```bash
cd ~/Downloads
chmod +x VMware*.bundle
sudo ./VMware*.bundle
```

---

## Disk Management

### Check disk health (SMART)
```bash
sudo apt install smartmontools
sudo smartctl -a /dev/sda               # check disk health
sudo smartctl -t short /dev/sda         # run short self-test
```

### Partition and format
```bash
lsblk                                    # list block devices
sudo fdisk /dev/sdX                      # partition a disk interactively
sudo mkfs.ext4 /dev/sdX1                # format as ext4
sudo mkfs.exfat /dev/sdX1               # format as exFAT (cross-platform)
sudo mount /dev/sdX1 /mnt               # mount a partition
sudo umount /mnt                         # unmount
```

### fstab (auto-mount at boot)
```bash
sudo blkid                               # get UUID of partitions
# Add to /etc/fstab:
# UUID=xxxx /mount/point ext4 defaults 0 2
sudo mount -a                            # test fstab without rebooting
```

---

## System Service Management (systemd)

```bash
sudo systemctl status service-name       # check service status
sudo systemctl start service-name        # start service
sudo systemctl stop service-name         # stop service
sudo systemctl restart service-name      # restart service
sudo systemctl enable service-name       # auto-start at boot
sudo systemctl disable service-name      # disable auto-start
sudo systemctl list-units --type=service --state=running  # running services
journalctl -u service-name               # view service logs
journalctl -u service-name -f            # follow service logs
journalctl -n 100                        # last 100 system log lines
journalctl --since "1 hour ago"          # logs from last hour
```

---

## Process Management

```bash
ps aux                                   # list all processes
ps aux | grep process-name               # find a specific process
top                                      # live process viewer
htop                                     # better viewer (sudo apt install htop)
pgrep process-name                       # get PID of a process
kill PID                                 # send SIGTERM (graceful stop)
kill -9 PID                              # send SIGKILL (force stop)
pkill process-name                       # kill by name
killall process-name                     # kill all matching processes
nice -n 10 command                       # run with lower CPU priority
renice 10 -p PID                         # change priority of running process
```

---

## Cron Jobs

```bash
crontab -e                               # edit current user's crontab
crontab -l                               # list current cron jobs
sudo crontab -e                          # edit root's crontab

# Cron syntax:
# ┌───── minute (0-59)
# │ ┌───── hour (0-23)
# │ │ ┌───── day of month (1-31)
# │ │ │ ┌───── month (1-12)
# │ │ │ │ ┌───── day of week (0-7, 0 and 7 = Sunday)
# │ │ │ │ │
# * * * * * /path/to/command

# Examples:
# 0 2 * * *  /path/to/backup.sh         # every day at 2am
# */5 * * * * /path/to/check.sh         # every 5 minutes
# 0 9 * * 1  /path/to/report.sh         # every Monday at 9am
```

---

## Boot and Startup

```bash
systemd-analyze                          # show boot time
systemd-analyze blame                    # show what slowed boot
systemd-analyze critical-chain           # show critical path
sudo update-grub                         # update GRUB bootloader config
```
