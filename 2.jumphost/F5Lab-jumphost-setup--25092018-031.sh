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
#ifconfig eth0 10.1.10.51 netmask 255.255.255.0
#ifconfig eth1 10.1.1.51 netmask 255.255.255.0

# Disable SSH Host Key Checking for hosts in the lab
cat << 'EOF' >> /etc/ssh/ssh_config

Host 10.1.*.*
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
   LogLevel ERROR

EOF


# Install desktop environment
# Option 1:apt-get -y install ubuntu-desktop mate-core mate-desktop-environment mate-notification-daemon tightvncserver xrdp
# Option 2
apt-get -y update
touch /home/ubuntu/alert3-xrdp-install-started-wait-about-7min
apt-get install -y ubuntu-desktop xrdp
service xrdp restart
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
#docker pull f5devcentral/f5-super-netops-container:base
#docker pull f5devcentral/f5-super-netops-container:jenkins
#docker pull f5devcentral/f5-super-netops-container:ansible

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
##mv /home/ubuntu/F5-Lab/2.jumphost/client-files/burpsuite/burpsuite_community_v1.7.36.jar /home/ubuntu/burpsuite/burpsuite_community_linux.jar
chmod 755 /home/ubuntu/burpsuite/burpsuite_community_linux.jar
cp /home/ubuntu/F5-Lab/2.jumphost/client-files/burp.png /home/ubuntu/burpsuite/burp.png
chmod 555 /home/ubuntu/burpsuite/burp.png
cd ~
sleep 1
   
# Setup Desktop icons
# Desktop folder probabely already exists
mkdir -p /home/ubuntu/Desktop

#Either get these pre-created Desktop shortcuts or create them at each build below

#curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/Firefox.desktop > /home/ubuntu/Desktop/Firefox.desktop
#curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/Chrome.desktop > /home/ubuntu/Desktop/Chrome.desktop
#curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/Postman.desktop > /home/ubuntu/Desktop/Postman.desktop
#curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/BurpSuite.desktop > /home/ubuntu/Desktop/BurpSuite.desktop						  

#chmod 755 /home/ubuntu/Desktop/Firefox.desktop
#chmod 755 /home/ubuntu/Desktop/Chrome.desktop
#chmod 755 /home/ubuntu/Desktop/Postman.desktop
#chmod 755 /home/ubuntu/Desktop/BurpSuite.desktop


#Either copy the Desktp shortcuts above or create them at each build

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

sleep 1



# XFCE Tab fix
# Edit ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml file to unset the following mapping
#      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
# to
#     <property name="&lt;Super&gt;Tab" type="string" value="empty"/>
#
# Probabely easier just to copy a file already done
curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/xfce4-keyboard-shortcuts.xml > /home/ubuntu/xfce4-keyboard-shortcuts.xml
sleep 2
rm /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
touch /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
cat /home/ubuntu/xfce4-keyboard-shortcuts.xml > /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
chmod 775 /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml
chown -R ubuntu:ubuntu /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce-perchannel-xml
sleep 2
#If above does not work put a script on Desktop to run manually
curl https://raw.githubusercontent.com/gbbaus17/F5-Lab/master/2.jumphost/client-files/make-tab-complete-work.sh > /home/ubuntu/Desktop/make-tab-complete-work.sh
chmod 775 /home/ubuntu/Desktop/make-tab-complete-work.sh


#Create new lab users
# quietly add users without passwords
adduser --quiet --disabled-password --shell /bin/bash --home /home/f5student --gecos "f5student" f5student
adduser --quiet --disabled-password --shell /bin/bash --home /home/admin --gecos "admin" admin
# set passwords
echo "f5student:f5DEMOs4u!" | chpasswd
echo "admin:f5DEMOs4u!" | chpasswd
#echo "root:f5DEMOs4u!" | chpasswd


# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu/Desktop
chown -R ubuntu:ubuntu /home/ubuntu/F5-Lab

touch /home/ubuntu/alert5-finished-jumphost-setup-script

#To avoid lab running shutdown daily 
#Add the below line (with tweaks) to the end of /etc/crontab:
cat << 'EOF' >> /etc/crontab
30 23 * * * root shutdown -h now

EOF

sleep 1
touch /home/ubuntu/alert6-cron-daily-autoshutdown-configured
sleep 2
touch /home/ubuntu/alert7-setup-finished-reboot-in-10s
sleep 10
reboot
