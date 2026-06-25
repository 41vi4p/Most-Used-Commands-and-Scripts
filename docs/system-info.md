# System Info & Monitoring Reference

## OS and Kernel Info

```bash
uname -a                                          # kernel version and architecture
uname -r                                          # kernel release only
hostnamectl                                       # hostname, OS, kernel info
cat /etc/os-release                               # OS version details
lsb_release -a                                    # distribution info
uptime                                            # how long system has been running
uptime -p                                         # pretty uptime format
who                                               # who is currently logged in
last                                              # login history
last reboot                                       # reboot history
```

---

## CPU Info

```bash
lscpu                                             # CPU architecture and core info
cat /proc/cpuinfo                                 # detailed per-core info
nproc                                             # number of available processors
lscpu | grep "Model name"                         # CPU model only
lscpu | grep "CPU MHz"                            # CPU speed
lshw -class processor                             # detailed processor info (needs sudo)
```

---

## Memory Info

```bash
free -h                                           # RAM usage (human readable)
free -h -s 2                                      # refresh every 2 seconds
cat /proc/meminfo                                 # detailed memory breakdown
vmstat -s                                         # memory and swap statistics
vmstat 2 5                                        # 5 reports, every 2 seconds
```

---

## Disk Info

```bash
lsblk                                             # list block devices (tree view)
lsblk -f                                          # include filesystem type and UUID
df -h                                             # disk space usage per mount
df -hT                                            # include filesystem type
du -sh /path/to/folder                            # size of a directory
du -sh * | sort -rh                               # size of each item, sorted
sudo fdisk -l                                     # partition table (all disks)
sudo parted -l                                    # partition table (alternative)
sudo smartctl -a /dev/sda                         # disk health via SMART
sudo smartctl -t short /dev/sda                   # run a short self-test
iostat -xz 1                                      # disk I/O statistics (sysstat package)
```

---

## GPU Info

```bash
lspci | grep -i vga                               # identify GPU
lspci | grep -i -E "vga|3d|display"              # all display devices
nvidia-smi                                        # NVIDIA GPU stats (if applicable)
nvidia-smi -l 2                                   # refresh every 2 seconds
glxinfo | grep "OpenGL renderer"                  # OpenGL renderer string
vulkaninfo | grep deviceName                      # Vulkan GPU name
```

---

## Full Hardware Summary

```bash
sudo lshw -short                                  # concise hardware list
sudo lshw                                         # full hardware details
sudo lshw -html > hardware.html                   # export to HTML
sudo dmidecode                                    # BIOS and hardware from DMI table
sudo dmidecode -t memory                          # RAM slot and speed info
sudo dmidecode -t baseboard                       # motherboard info
sudo dmidecode -t bios                            # BIOS version
inxi -Fxz                                         # all-in-one system summary (sudo apt install inxi)
```

---

## Temperature and Fan Monitoring

```bash
# Setup lm-sensors first (see linux-system.md)
sensors                                           # current temp and fan readings
watch -n 1 sensors                                # live refresh
watch -n 1 'sensors | grep -E "fan|temp|Core"'   # filtered live view

# GPU temperature (NVIDIA)
nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader

# CPU temp (alternative)
cat /sys/class/thermal/thermal_zone*/temp         # raw values in millidegrees
```

---

## Process Monitoring

```bash
ps aux                                            # all running processes
ps aux | grep process-name                        # find a process
ps aux --sort=-%cpu | head -10                    # top 10 by CPU usage
ps aux --sort=-%mem | head -10                    # top 10 by memory usage
top                                               # live process viewer
htop                                              # better live viewer (sudo apt install htop)
pgrep process-name                                # get PID
pgrep -a process-name                             # PID with full command
```

---

## Memory Usage by Process

```bash
# Show memory usage of a process
ps -o pid,user,%mem,rss,command -p PID

# Top 10 memory-hungry processes
ps aux --sort=-%mem | head -11

# Show shared memory usage
cat /proc/PID/status | grep -i vm
```

---

## Network Info

```bash
ip addr                                           # all network interfaces and IPs
ip addr show eth0                                 # specific interface
ip route                                          # routing table
ip neigh                                          # ARP table
ss -tulnp                                         # open ports and listening services
netstat -tulnp                                    # same (older tool)
hostname -I                                       # show all local IPs
curl ifconfig.me                                  # show public IP
nmcli device status                               # NetworkManager device status
nmcli con show                                    # list connections
```

---

## System Resource Overview

```bash
# Quick full snapshot
echo "=== CPU ===" && lscpu | grep "Model name" && \
echo "=== Memory ===" && free -h && \
echo "=== Disk ===" && df -h && \
echo "=== Load ===" && uptime
```

---

## Benchmarking

```bash
# CPU benchmark (stress test)
sudo apt install stress
stress --cpu 4 --timeout 60s                      # stress 4 CPU cores for 60s

# Disk write speed
dd if=/dev/zero of=/tmp/test_write bs=1G count=1 oflag=dsync

# Disk read speed
dd if=/tmp/test_write of=/dev/null bs=1G count=1

# Network speed (needs speedtest-cli)
pip install speedtest-cli
speedtest

# Memory bandwidth
sudo apt install mbw
mbw 256                                           # test with 256MB array
```

---

## Logs

```bash
journalctl -n 100                                 # last 100 system log lines
journalctl -f                                     # follow system log live
journalctl --since "1 hour ago"                   # logs from last hour
journalctl --since "2024-01-01" --until "2024-01-02"  # logs in a date range
journalctl -p err                                 # only error-level entries
journalctl -k                                     # kernel messages only
dmesg                                             # kernel ring buffer
dmesg | grep -i error                             # kernel errors
dmesg -T                                          # with human-readable timestamps
tail -f /var/log/syslog                           # traditional syslog
```
