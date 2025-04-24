
# Update packages
apt update && apt upgrade -y
apt install git build-essential automake nginx apache2-utils -y

# Create srs user
useradd -r -s /bin/false srs
mkdir /home/srs
chown -R srs:srs /home/srs
sudo -u srs -s
cd /home/srs

# Clone official repo
git clone https://github.com/ossrs/srs.git
git clone https://github.com/ossrs/srs-console.git
cd srs/trunk

# configure and build
./configure
make

# copy dashboard
cp -r /home/srs/srs-console/* /home/srs/srs/trunk/objs/nginx/html/

# return to root user
exit

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
ufu reload

./objs/srs -c conf/srs.conf