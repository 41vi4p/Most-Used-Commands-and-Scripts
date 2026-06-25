# Docker Reference

## Install Docker on Ubuntu

```bash
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
sudo docker run hello-world
```

> After running `usermod`, log out and back in (or run `newgrp docker`) for the group change to take effect.

---

## Install Docker on Raspberry Pi (Debian-based)

```bash
sudo apt update
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
```

---

## Images

```bash
docker images                                     # list all local images
docker pull nginx                                 # pull an image
docker build -t my-app:latest .                   # build from Dockerfile in current dir
docker build -t my-app:latest -f Dockerfile.prod . # use specific Dockerfile
docker rmi image-name                             # remove image
docker image prune                                # remove dangling images
docker image prune -a                             # remove all unused images
docker tag my-app:latest my-app:v1.0              # tag an image
docker save my-app:latest | gzip > my-app.tar.gz  # export image to file
docker load < my-app.tar.gz                       # import image from file
```

---

## Containers

```bash
docker ps                                         # list running containers
docker ps -a                                      # list all containers (including stopped)
docker run -d -p 8080:80 --name my-app nginx       # run detached with port mapping
docker run -it ubuntu /bin/bash                   # run interactively
docker run --rm ubuntu echo "hello"               # auto-remove after exit
docker run -e ENV_VAR=value nginx                 # pass environment variable
docker run -v $(pwd):/app nginx                   # mount current dir
docker start container-name                       # start a stopped container
docker stop container-name                        # gracefully stop a container
docker restart container-name                     # restart a container
docker rm container-name                          # remove a stopped container
docker rm -f container-name                       # force remove a running container
docker logs container-name                        # view logs
docker logs -f container-name                     # follow logs (live)
docker logs --tail 100 container-name             # last 100 log lines
docker exec -it container-name /bin/bash          # open shell in running container
docker exec -it container-name sh                 # use sh if bash not available
docker cp file.txt container-name:/path/          # copy file into container
docker cp container-name:/path/file.txt .         # copy file out of container
docker inspect container-name                     # detailed container metadata
docker stats                                      # live resource usage for all containers
docker stats container-name                       # live resource usage for one container
```

---

## Docker Compose

```bash
docker compose up                                 # start all services (foreground)
docker compose up -d                              # start detached (background)
docker compose up --build                         # rebuild images then start
docker compose down                               # stop and remove containers
docker compose down -v                            # also remove volumes
docker compose restart                            # restart all services
docker compose logs -f                            # follow logs for all services
docker compose logs -f service-name               # follow logs for one service
docker compose ps                                 # list services and their status
docker compose exec service-name /bin/bash        # shell into a service
docker compose build                              # rebuild images
docker compose pull                               # pull latest images
docker compose run --rm service-name command      # run one-off command
```

---

## Volumes

```bash
docker volume ls                                  # list volumes
docker volume create my-volume                    # create a named volume
docker volume rm my-volume                        # remove a volume
docker volume prune                               # remove all unused volumes
docker volume inspect my-volume                   # inspect volume details
docker run -v my-volume:/data nginx               # mount named volume
docker run -v $(pwd):/app nginx                   # mount current directory (bind mount)
docker run -v $(pwd)/data:/data:ro nginx          # read-only bind mount
```

---

## Networks

```bash
docker network ls                                 # list networks
docker network create my-network                  # create a network
docker network rm my-network                      # remove a network
docker network inspect my-network                 # inspect network
docker run --network my-network nginx             # connect container to network
docker network connect my-network container-name  # connect running container
```

---

## Cleanup

```bash
docker system prune                               # remove all unused resources
docker system prune -a                            # including unused images
docker system df                                  # show disk usage by Docker
docker container prune                            # remove all stopped containers
docker image prune -a                             # remove all unused images
docker volume prune                               # remove all unused volumes
docker network prune                              # remove all unused networks
```

---

## Useful One-Liners

```bash
# Stop all running containers
docker stop $(docker ps -q)

# Remove all stopped containers
docker rm $(docker ps -aq -f status=exited)

# Remove all images
docker rmi $(docker images -q)

# Follow logs of the most recently started container
docker logs -f $(docker ps -lq)

# Check which port a container is exposing
docker port container-name
```
