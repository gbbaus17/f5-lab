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

# Disable SSH Host Key Checking for hosts in the lab
sudo cat << 'EOF' >> /etc/ssh/ssh_config
Host 10.*.*.*
    StrictHostKeyChecking no
    RSAAuthentication no
    PubkeyAuthentication no
    PasswordAuthentication yes
    LogLevel ERROR

EOF

# Modify SSH to listen only on specific address (optional)
#SERVER_ETH1=`ifconfig eth1 | egrep 'inet addr' | awk '{print tolower($2)}' | awk -F: '{print tolower($2)}'`
#sleep 2
# Change ListenAddress
# sudo sed -i "s/0\.0\.0\.0/$SERVER_ETH1/g" /etc/ssh/ssh_config

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
apt-get install -y docker-compose
sleep 2



              yum update -y
              yum install -y docker
              yum install -y telnet
              yum install -y curl
              yum install -y ab
              /sbin/chkconfig --add docker
              service docker start
             
              EOF
			  
			  
			  
			  
#Create new lab users
# quietly add user without passwords
adduser --quiet --disabled-password --shell /bin/bash --home /home/f5student --gecos "f5student" f5student
adduser --quiet --disabled-password --shell /bin/bash --home /home/external_user --gecos "external_user" f5student
sleep 5
# set passwords
echo "f5student:f5DEMOs4u!" | chpasswd
echo "external_user:f5DEMOs4u!" | chpasswd


#Download and install webgoat as per https://github.com/WebGoat/WebGoat
#curl https://raw.githubusercontent.com/WebGoat/WebGoat/develop/docker-compose.yml | docker-compose -f - up
#apt-get -y install default-jre
#sleep 5
#mkdir -p /home/ubuntu/webgoat
#cd /home/ubuntu/webgoat
#wget https://github.com/WebGoat/WebGoat/releases/download/v8.0.0.M21/webgoat-server-8.0.0.M21.jar -o ./webgoat.log
#nohup `java -jar /home/ubuntu/webgoat/webgoat-server-8.0.0.M21.jar --server.port=8081` &


sleep 60

# Start the f5-demo-httpd container
#cat << 'EOF' > /etc/rc.local
#!/bin/sh -e
docker run -d -p 8004:80 --restart always -e F5DEMO_APP=website -e F5DEMO_COLOR=FF0000 -e F5DEMO_NODENAME='Red' f5devcentral/f5-demo-httpd
docker run -d -p 8000:80 --restart always -e F5DEMO_APP=website -e F5DEMO_COLOR=FF8000 -e F5DEMO_NODENAME='Orange' f5devcentral/f5-demo-httpd
docker run -d -p 8001:80 --restart always -e F5DEMO_APP=website -e F5DEMO_COLOR=A0A0A0 -e F5DEMO_NODENAME='Gray' f5devcentral/f5-demo-httpd
docker run -d -p 8002:80 --restart always -e F5DEMO_APP=website -e F5DEMO_COLOR=33FF33 -e F5DEMO_NODENAME='Green' f5devcentral/f5-demo-httpd
docker run -d -p 8003:80 --restart always -e F5DEMO_APP=website -e F5DEMO_COLOR=3333FF -e F5DEMO_NODENAME='Blue' f5devcentral/f5-demo-httpd
#nohup `java -jar /home/ubuntu/webgoat/webgoat-server-8.0.0.M21.jar --server.port=8081 --server.address=10.1.20.252` &


sudo docker run -d -p 82:80 --restart always -e F5DEMO_APP=website -e F5DEMO_NODENAME="Public Cloud Lab: AZ #1" chen23/f5-demo-app:latest
sudo docker run -d -p 83:80 --restart always citizenstig/dvwa
sudo docker run  -d -p 84:80 --restart always mutzel/all-in-one-hackazon:postinstall supervisord -n
#Start DVWA with random mysql password:
#docker run  --restart=always -d -p 80:8000 -it appsecco/dsvw
sudo docker run -d -p 85:8000  --restart always -it gaganld/dsvw-gagan
#Port 8080 for DVWA
docker run -d -p 8080:80 -p 3306:3306 --restart always -e MYSQL_PASS="Chang3ME" gaganld/dvwa-gagan
			  
			  
			  
EOF

sleep 2


# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu

# Allow ubuntu user to access docker images
chmod 775 -R /var/lib/docker/image

# Ensure NICs are set and persit reboot
cat /home/ubuntu/interfaces > /etc/network/interfaces
touch /home/ubuntu/alert4-setup-finished-reboot-in-30s
echo "alert4-setup-finished-reboot-in-30s"
sleep 30
reboot


