# Network Commands Reference

## Network Interface Info

```bash
ip addr                                           # all interfaces and IPs
ip addr show eth0                                 # specific interface
ip link                                           # link-layer info (MAC, state)
ifconfig                                          # older alternative
hostname -I                                       # all local IP addresses
ip route                                          # routing table
ip neigh                                          # ARP table (neighbors/MAC mapping)
nmcli device status                               # NetworkManager devices
nmcli con show                                    # saved connections
```

---

## Public IP

```bash
curl ifconfig.me                                  # your public IP
curl -s https://api.ipify.org                     # alternative
dig +short myip.opendns.com @resolver1.opendns.com  # DNS-based lookup
```

---

## DNS Lookup

```bash
nslookup example.com                              # basic DNS lookup
nslookup -type=MX example.com                     # mail records
dig example.com                                   # detailed DNS info
dig example.com A                                 # A record only
dig example.com MX                                # mail records
dig example.com CNAME                             # CNAME chain
dig +short example.com                            # just the IP
dig +trace example.com                            # trace DNS resolution from root
host example.com                                  # simple lookup
```

---

## Connectivity Testing

```bash
ping google.com                                   # basic reachability test
ping -c 4 google.com                              # limit to 4 packets
ping -i 0.2 google.com                            # ping every 0.2 seconds
traceroute google.com                             # show hops to destination
tracepath google.com                              # alternative (no root needed)
mtr google.com                                    # live combined ping + traceroute

# HTTP check
curl -I https://example.com                       # show HTTP headers only
curl -o /dev/null -s -w "%{http_code}" https://example.com  # just the status code
curl -v https://example.com                       # verbose connection details
wget --spider https://example.com                 # check URL without downloading
```

---

## Open Ports and Sockets

```bash
ss -tulnp                                         # open ports and listening services
ss -tulnp | grep :80                              # who is listening on port 80
netstat -tulnp                                    # older alternative
sudo lsof -i :3000                                # what's using port 3000
sudo lsof -i -P -n | grep LISTEN                 # all listening ports

# Kill whatever is using a port
sudo kill -9 $(sudo lsof -t -i:3000)
# or with fuser:
sudo fuser -k 3000/tcp
```

---

## Firewall (UFW — Ubuntu)

```bash
sudo ufw status                                   # show firewall status and rules
sudo ufw enable                                   # enable firewall
sudo ufw disable                                  # disable firewall
sudo ufw allow 22                                 # allow SSH
sudo ufw allow 80/tcp                             # allow HTTP
sudo ufw allow 443/tcp                            # allow HTTPS
sudo ufw deny 3306                                # block MySQL from outside
sudo ufw allow from 192.168.1.0/24               # allow from a local subnet
sudo ufw allow from 192.168.1.10 to any port 22  # allow specific IP on SSH
sudo ufw delete allow 80/tcp                      # remove a rule
sudo ufw status numbered                          # show rules with numbers
sudo ufw delete 3                                 # delete rule number 3
sudo ufw reset                                    # reset all rules
```

---

## SSH

```bash
ssh user@host                                     # connect
ssh -p 2222 user@host                             # custom port
ssh -i ~/.ssh/key.pem user@host                   # use specific key
ssh -v user@host                                  # verbose (debug connection issues)

# Port forwarding
ssh -L 8080:localhost:80 user@host                # local → remote (access remote:80 as localhost:8080)
ssh -R 9000:localhost:3000 user@host              # remote → local
ssh -N -f -L 8080:localhost:80 user@host          # run in background

# Run remote command without interactive session
ssh user@host "ls -la /var/log"
ssh user@host "sudo systemctl restart nginx"
```

### SSH Config (`~/.ssh/config`)

```
Host myserver
    HostName example.com
    User david
    Port 22
    IdentityFile ~/.ssh/my_key

Host raspi
    HostName 192.168.1.50
    User pi
    Port 22
```

Then just connect with:
```bash
ssh myserver
ssh raspi
```

---

## File Transfer

### scp — Secure Copy
```bash
scp file.txt user@host:/remote/path/              # upload file
scp user@host:/remote/file.txt .                  # download file
scp -r folder/ user@host:/remote/path/            # upload directory
scp -P 2222 file.txt user@host:/path/             # custom SSH port
```

### rsync — Efficient Sync
```bash
rsync -avz folder/ user@host:/remote/folder/      # sync to remote
rsync -avz user@host:/remote/folder/ ./local/     # sync from remote
rsync -avz --delete source/ destination/          # mirror (delete removed files)
rsync -avz --exclude="node_modules" . user@host:/path/   # exclude folder
rsync -n -avz source/ destination/               # dry run (preview)
rsync --progress -avz large-file.iso user@host:/  # show progress
```

### wget / curl — Downloads
```bash
wget https://example.com/file.zip                 # download file
wget -O custom-name.zip https://example.com/file.zip  # rename download
wget -c https://example.com/file.zip              # resume interrupted download
wget -q https://example.com/file.zip              # silent download
curl -O https://example.com/file.zip              # download with curl
curl -L -O https://example.com/file.zip           # follow redirects
curl -C - -O https://example.com/file.zip         # resume download
```

---

## Network Speed Test

```bash
# Install speedtest-cli
pip install speedtest-cli
speedtest

# Or use fast.com via curl
curl https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -

# Local network throughput (iperf3)
sudo apt install iperf3
iperf3 -s                                         # run server on one machine
iperf3 -c server-ip                               # run client on another
```

---

## Network Monitoring

```bash
iftop                                             # live bandwidth per connection (sudo apt install iftop)
nload                                             # live bandwidth per interface (sudo apt install nload)
nethogs                                           # bandwidth per process (sudo apt install nethogs)
vnstat                                            # traffic stats over time (sudo apt install vnstat)
vnstat -l                                         # live bandwidth
```

---

## Useful One-Liners

```bash
# Check if a port is open on a remote host
nc -zv host 80
nc -zv host 3000-3010                             # scan a range

# Scan local network for active hosts
nmap -sn 192.168.1.0/24

# Find your router's IP
ip route | grep default

# Check if you can reach DNS
nslookup google.com 8.8.8.8

# Flush DNS cache
sudo systemctl restart systemd-resolved
sudo resolvectl flush-caches

# Show all active connections
ss -s
```
