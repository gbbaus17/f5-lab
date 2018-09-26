#!/bin/bash

# The purpose of this script is to setup the required components for the F5
# waf lab Linux jumphost
#
# This script is processed by cfn-init and will be run as root.
#
# You can monitor the progress of the packages install through
# /var/log/cfn-init-cmd.log. Here you will see all the different commands run
# from the Cloud Formation Template and through this script
#
# It takes approx. 10-15 min to have the RDP instance fully setup

set -x

# This should not be needed - TO BE INVESTIGATED
#ifconfig eth0 10.1.20.100 netmask 255.255.255.0
#ifconfig eth1 10.1.1.250 netmask 255.255.255.0

sleep 10
# Allow ssh with passwords
sudo sed -i 's/RSAAuthentication yes/RSAAuthentication no/g; s/PubkeyAuthentication yes/PubkeyAuthentication no/g; s/PasswordAuthentication no/PasswordAuthentication yes /g' /etc/ssh/sshd_config


touch /home/ubuntu/alert4-ssh-with-psswd-enabled


# Install official docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
apt-get install -y docker-ce
sleep 2


#Create new lab users
# quietly add users without passwords
adduser --quiet --disabled-password --shell /bin/bash --home /home/f5student --gecos "f5student" f5student
adduser --quiet --disabled-password --shell /bin/bash --home /home/admin --gecos "admin" admin
# set passwords
echo "f5student:f5DEMOs4u!" | chpasswd
echo "admin:f5DEMOs4u!" | chpasswd


## Start the f5-demo-httpd container
## check wehre these are pulled from ????
#cat << 'EOF' > /etc/rc.local
##!/bin/sh -e
#docker run -d -p 80:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=FF0000 -e F5DEMO_NODENAME='Red' f5devcentral/f5-demo-httpd
#docker run -d -p 8000:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=FF8000 -e F5DEMO_NODENAME='Orange' f5devcentral/f5-demo-httpd
#docker run -d -p 8001:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=A0A0A0 -e F5DEMO_NODENAME='Gray' f5devcentral/f5-demo-httpd
#docker run -d -p 8002:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=33FF33 -e F5DEMO_NODENAME='Green' f5devcentral/f5-demo-httpd
#docker run -d -p 8003:80 --restart unless-stopped -e F5DEMO_APP=website -e F5DEMO_COLOR=3333FF -e F5DEMO_NODENAME='Blue' f5devcentral/f5-demo-httpd
#EOF


# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu/F5-Lab
chown -R ubuntu:ubuntu /home/ubuntu/set-nics-and-hosts.sh

touch /home/ubuntu/alert5-finished-server1-setup-script

# Initilise NIC on every reboot -- need to figure out cloud-init with /etc/network/interfaces.d
# Also to avoid lab running and costing money, shutdown daily :
# Use 'shutdown -c ' to cancel
cat << 'EOF' >> /etc/rc.local
#!/bin/sh -e
sudo /home/ubuntu/set-nics-and-hosts.sh
shutdown -h 23:59
EOF

touch /home/ubuntu/alert6-daily-autoshutdown-configured
sleep 2
touch /home/ubuntu/alert7-setup-finished-reboot-in-10s
sleep 10
reboot
