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

#ifconfig eth0 10.1.10.51 netmask 255.255.255.0
#ifconfig eth1 10.1.1.51 netmask 255.255.255.0

# Disable SSH Host Key Checking for hosts in the lab
cat << 'EOF' >> /etc/ssh/ssh_config

Host 10.*.*.*
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
   LogLevel ERROR

EOF

# Install desktop environment
# Option 1:apt-get -y install ubuntu-desktop mate-core mate-desktop-environment mate-notification-daemon tightvncserver xrdp
# Option 2
apt-get -y update
sleep 10
touch /home/ubuntu/alert3-xrdp-install-started-wait-about-7min
apt-get install -y ubuntu-desktop xrdp
sleep 10
service xrdp restart
sleep 10
apt-get install -y xfce4 xfce4-goodies
echo xfce4-session > /home/ubuntu/.xsession
# Install specific fonts support
# Japanese
apt-get -y install fonts-takao-mincho
systemctl enable xrdp.service

# Configure xrdp
cp /etc/xrdp/startwm.sh /etc/xrdp/startwm.sh.original

cat << 'EOF' > /etc/xrdp/startwm.sh
#!/bin/sh
if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi
. /etc/X11/Xsession
EOF

cp /etc/xrdp/xrdp.ini /etc/xrdp/xrdp.ini.original

cat << 'EOF' > /etc/xrdp/xrdp.ini
[globals]
bitmap_cache=yes
bitmap_compression=yes
port=3389
crypt_level=low
channel_code=1
max_bpp=24
#black=000000
#grey=d6d3ce
#dark_grey=808080
#blue=08246b
#dark_blue=08246b
#white=ffffff
#red=ff0000
#green=00ff00
#background=626c72

[f5labs]
name=F5Labs
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=-1

EOF

#sed -i.bak "s/FuseMountName=thinclient_drives/FuseMountName=remote_drives/g" /etc/xrdp/sesman.ini
systemctl restart xrdp.service

touch /home/ubuntu/alert4-xrdp-install-finished

# Install specific fonts support
# Japanese
#apt-get -y install fonts-takao-mincho

# Install Chrome setup and add the desktop icon
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get -y update
sleep 5
apt-get -y install google-chrome-stable

# Install ubuntu docker
#apt-get update
#apt-get install -y docker.io
#sleep 2


# Install official docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update
apt-get install -y docker-ce
sleep 2


# pull the f5-super-netops images : base, jenkins, ansible
docker pull f5devcentral/f5-super-netops-container:base
docker pull f5devcentral/f5-super-netops-container:jenkins
docker pull f5devcentral/f5-super-netops-container:ansible

# Install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz
ln -s /opt/Postman/Postman /usr/bin/postman
sleep 5

# Install Wapiti
apt-get -y install wapiti
sleep 5
   
# Install /Update Firefox
apt-get -y install firefox
sleep 5

#Install Apache Bench
apt-get -y install apache2-utils
sleep 5

#Install Download Burp 1.7.36
apt-get -y install openjdk-8-jre
sleep 5
mkdir -p /home/ubuntu/burpsuite/
wget -O /home/ubuntu/burpsuite/burpsuite_community_linux.jar 'https://portswigger.net/burp/releases/download?product=community&version=1.7.36&type=jar'
# Only need MOVE if Burpsuite JAR is bundled and part of Git clone
##mv /home/ubuntu/F5-Lab/jumphost/client-files/burpsuite/burpsuite_community_v1.7.36.jar /home/ubuntu/burpsuite/burpsuite_community_linux.jar
chmod 755 /home/ubuntu/burpsuite/burpsuite_community_linux.jar
cp /home/ubuntu/F5-Lab/jumphost/client-files/burp.png /home/ubuntu/burpsuite/burp.png
chmod 555 /home/ubuntu/burpsuite/burp.png
cd ~
sleep 1
   
# Setup Desktop icons
# Desktop folder probabely already exists
mkdir -p /home/ubuntu/Desktop

#Desktp shortcuts

touch >> /home/ubuntu/Desktop/Firefox.desktop
cat << 'EOF' > /home/ubuntu/Desktop/Firefox.desktop
[Desktop Entry]
Version=1.0
Name=FireFox
Comment=Open Firefox
Exec=/usr/bin/firefox
Icon=/usr/share/app-install/icons/firefox.png
Terminal=false
Type=Application
StartupNotify=false

EOF

sleep 1
chmod 755 /home/ubuntu/Desktop/Firefox.desktop

touch /home/ubuntu/Desktop/Chrome.desktop
cat << 'EOF' >> /home/ubuntu/Desktop/Chrome.desktop
[Desktop Entry]
Version=1.0
Name=Chrome
Comment=Open Chrome
Exec=/opt/google/chrome/google-chrome
Icon=google-chrome
Terminal=false
Type=Application
Path=
StartupNotify=false

EOF

sleep 1
chmod 755 /home/ubuntu/Desktop/Chrome.desktop


touch /home/ubuntu/Desktop/F5-BigIP.desktop
cat << 'EOF' >> /home/ubuntu/Desktop/F5-BigIP.desktop
[Desktop Entry]
Version=1.0
Type=Link
Name=F5-BigIP
Comment=
Icon=google-chrome
URL=https://10.1.1.245

EOF

sleep 1
chmod 755 /home/ubuntu/Desktop/F5-BigIP.desktop


touch /home/ubuntu/Desktop/Postman.desktop
cat << 'EOF' >> /home/ubuntu/Desktop/Postman.desktop
[Desktop Entry]
Version=1.0
Name=Postman
Comment=Open Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Path=
StartupNotify=false

EOF

sleep 1
chmod 755 /home/ubuntu/Desktop/Postman.desktop


touch /home/ubuntu/Desktop/BurpSuite.desktop
cat << 'EOF' >> /home/ubuntu/Desktop/BurpSuite.desktop
[Desktop Entry]
Version=1.0
Name=BurpSuite
Comment=Run Burp
Exec=java -jar /home/ubuntu/burpsuite/burpsuite_community_linux.jar
Icon=/home/ubuntu/burpsuite/burp.png
Terminal=false
Type=Application
Path=/home/ubuntu/burpsuite/
StartupNotify=false

EOF

sleep 1
chmod 755 /home/ubuntu/Desktop/BurpSuite.desktop

#File to make 'tab complete' work
# XFCE Tab fix
# Edit ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml file to unset the following mapping
#      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
# to
#     <property name="&lt;Super&gt;Tab" type="string" value="empty"/>
#
# Probabely easier just to copy a file already done
chmod 664 /home/ubuntu/F5-Lab/jumphost/client-files/xfce4-keyboard-shortcuts.xml
#Put a script link on the Desktop to fix 'tab complete' - user must run manually and reboot and after XRDP first launch
chmod 775 /home/ubuntu/F5-Lab/jumphost/client-files/make-tab-complete-work.sh
ln -s /home/ubuntu/F5-Lab/jumphost/client-files/make-tab-complete-work.sh /home/ubuntu/Desktop/make-tab-complete-work.sh
# Create lab files shortcut
ln -s /home/ubuntu/F5-Lab/lab-files/ /home/ubuntu/Desktop/lab-files

#Create new lab users
# quietly add user without passwords
adduser --quiet --disabled-password --shell /bin/bash --home /home/f5student --gecos "f5student" f5student
adduser --quiet --disabled-password --shell /bin/bash --home /home/external_user --gecos "external_user" f5student
sleep 5
# set passwords
echo "f5student:f5DEMOs4u!" | chpasswd
echo "external_user:f5DEMOs4u!" | chpasswd

# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu/Desktop
chown -R ubuntu:ubuntu /home/ubuntu/F5-Lab

# Ensure NICs are set and persit reboot
cat /home/ubuntu/interfaces > /etc/network/interfaces
touch /home/ubuntu/alert5-setup-finished-reboot-in-30s
sleep 30
reboot

