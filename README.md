# rimworld-openworld-server

## Containerized [Rimworld OpenWorld Mod by D12-Dev](https://github.com/D12-Dev/OpenWorld/releases)

### [Download the Docker image directly](https://hub.docker.com/repository/docker/f00d4tehg0dz/rimworld-openworld-server)

## Install from Docker Build

Docker Pull

```bash
docker pull f00d4tehg0dz/rimworld-openworld-server-docker
```

Docker Run with defaults
Change the volume options to a directory on your node and maybe use a different name than the one in the example

```bash
docker run -it -p 25555:25555/udp -p 25555:25555/tcp -v /Rimworld:/rimworld \
--name rimworld-openworld-server \
f00d4tehg0dz/rimworld-openworld-server-docker:latest
```

## Build Manually

```bash
git clone https://github.com/f00d4tehg0dz/rimworld-openworld-server-docker.git
docker build -t f00d4tehg0dz/rimworld-openworld-server-docker:latest .
```

## FAQ

- The first run of the container may fail as the system must generate Server Settings.txt and World Settings.txt. Stop the container and edit the configurations as required.  
- The server IP will be automatically set based on the container IP - Server Local IP: 0.0.0.0
- For additional configuration details, please see the [Open World Server documentation](https://github.com/D12-Dev/OpenWorld)

## Kubernetes Support 

To support Kubernetes and terminal-less deployments, set the K8 environment variable to True.

```bash
docker run -it -p 25555:25555/udp -p 25555:25555/tcp -v /Rimworld:/rimworld \
-e K8="True" \
--name rimworld-openworld-server \
f00d4tehg0dz/rimworld-openworld-server-docker:latest
```

## Environmental Variables with Default Values

- GAME_PORT 25555
- K8 False
- TZ America/New_York

