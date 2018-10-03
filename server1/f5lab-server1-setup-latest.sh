#!/bin/bash

# The purpose of this script is to setup the required components for the F5
# automation lab Linux server
#
# This script is processed by cfn-init and will be run as root.
#
# You can monitor the progress of the packages install through
# /var/log/cfn-init-cmd.log. Here you will see all the different commands run
# from the Cloud Formation Template and through this script
#
# It takes approx. 5 min to have the instance fully setup

#ifconfig eth0 10.1.20.100 netmask 255.255.255.0
#ifconfig eth0:1 10.1.20.101 netmask 255.255.255.0
#ifconfig eth0:2 10.1.20.102 netmask 255.255.255.0 
#ifconfig eth0:3 10.1.20.103 netmask 255.255.255.0
#ifconfig eth0:4 10.1.20.252 netmask 255.255.255.0
#ifconfig eth1 10.1.1.250 netmask 255.255.255.0
#ifconfig eth1:1 10.1.1.15 netmask 255.255.255.0

touch /home/ubuntu/alert3-server-install-started-wait-about-10-15min

# Allow ssh with passwords
sudo sed -i 's/RSAAuthentication yes/RSAAuthentication no/g; s/PubkeyAuthentication yes/PubkeyAuthentication no/g; s/PasswordAuthentication no/PasswordAuthentication yes /g' /etc/ssh/sshd_config

# Disable SSH Host Key Checking for hosts in the lab
cat << 'EOF' >> /etc/ssh/ssh_config
Match address 10.0.0.0/8
    PasswordAuthentication yes

EOF

# Install dnsmasq
apt-get install -y dnsmasq
# these entries are added in template file
#cat << 'EOF' > /etc/dnsmasq.d/f5lab
#listen-address=127.0.0.1,10.1.20.100,10.1.20.101,20.1.10.102,10.1.20.103,10.1.20.252,10.1.1.250,10.1.1.15
#no-dhcp-interface=lo0,eth0,eth0:1,eth0:2,eth0:3,eth0:4,eth1,eth1:1
#EOF
systemctl enable dnsmasq.service
service dnsmasq start

# Install ubuntu docker
#apt-get update
#apt-get install -y docker.io
#sleep 2

# Install official docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce
sleep 2


#Create new lab users
# quietly add user without passwords
adduser --quiet --disabled-password --shell /bin/bash --home /home/f5student --gecos "f5student" f5student
adduser --quiet --disabled-password --shell /bin/bash --home /home/external_user --gecos "external_user" f5student
sleep 5
# set passwords
echo "f5student:f5DEMOs4u!" | chpasswd
echo "external_user:f5DEMOs4u!" | chpasswd

# Start the f5-demo-httpd container
cat << 'EOF' > /etc/rc.local
#!/bin/sh -e
docker run -d -p 80:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=FF0000 -e F5DEMO_NODENAME='Red' f5devcentral/f5-demo-httpd
docker run -d -p 8000:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=FF8000 -e F5DEMO_NODENAME='Orange' f5devcentral/f5-demo-httpd
docker run -d -p 8001:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=A0A0A0 -e F5DEMO_NODENAME='Gray' f5devcentral/f5-demo-httpd
docker run -d -p 8002:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=33FF33 -e F5DEMO_NODENAME='Green' f5devcentral/f5-demo-httpd
docker run -d -p 8003:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=3333FF -e F5DEMO_NODENAME='Blue' f5devcentral/f5-demo-httpd

EOF

sleep 2
# Ensure NICs are set and persit reboot
cat /home/ubuntu/interfaces > /etc/network/interfaces

touch /home/ubuntu/alert4-setup-finished-reboot-in-30s
sleep 30
reboot

# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu/F5-Lab

# Ensure NICs are set and persit reboot
cat /home/ubuntu/interfaces > /etc/network/interfaces
touch /home/ubuntu/alert5-setup-finished-reboot-in-30s
sleep 30
reboot


