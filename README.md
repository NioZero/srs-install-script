# SRS install script

Automatic script to install srs server on linux

## Execution

In your Linux simply run this command

```
wget -qO- https://raw.githubusercontent.com/NioZero/srs-install-script/refs/heads/main/install-script.sh | bash
```

## Development

You can test this script inside a docker container.

```
docker run -it --rm ubuntu:latest /bin/bash
```

Because this script was made for full linux system, not docker containers
you'll need to install some stuff if you want to test the script.

```
apt update && apt upgrade -y
apt install wget systemd ufw -y
```

After that you can execute the `install-script.sh` as normal.
