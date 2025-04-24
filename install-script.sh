#!/bin/sh

# Update packages
echo "-- Installing dependences..."

apt update && apt upgrade -y
apt install git build-essential ufw automake nginx apache2-utils -y

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

echo "-- srs server installed..."