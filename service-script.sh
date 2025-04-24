#!/bin/sh

echo "-- Configuring srs service..."

# configuration files
wget https://raw.githubusercontent.com/NioZero/srs-install-script/refs/heads/main/srs.service -O /etc/systemd/system/srs.service

# configure service
systemctl daemon-reload
systemctl enable srs
systemctl start srs

# configure firewall rules
ufw allow 1935/tcp
ufw allow 1985/tcp
ufw allow 8080/tcp
ufw reload

echo "-- srs service installed and running..."