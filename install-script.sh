#!/bin/sh

# Update packages
echo "-- Installing dependences..."

apt update && apt upgrade -y
apt install git build-essential automake nginx apache2-utils -y

# Create srs user
echo "-- Configuring srs user..."

id -u srs &>/dev/null || useradd -r -s /bin/false srs
mkdir -p /home/srs
chown -R srs:srs /home/srs

echo "-- Cloning and compiling project..."
sudo -u srs bash <<EOF
cd /home/srs
git clone https://github.com/ossrs/srs.git
git clone https://github.com/ossrs/srs-console.git
cd srs/trunk
./configure
make
cp -r /home/srs/srs-console/* /home/srs/srs/trunk/objs/nginx/html/
EOF

echo "-- Configuring srs service..."

# configuration files
wget https://raw.githubusercontent.com/NioZero/srs-install-script/refs/heads/main/srs.conf -O /etc/srs.conf
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
