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
ifconfig eth1 10.1.1.51 netmask 255.255.255.0
ifconfig eth2 10.1.10.20 netmask 255.255.255.0

# Install desktop environment
# Option 1:apt-get -y install ubuntu-desktop mate-core mate-desktop-environment mate-notification-daemon tightvncserver xrdp
# Option 2
apt-get -y update
apt-get install -y ubuntu-desktop xrdp
service xrdp restart
apt-get install -y xfce4 xfce4-goodies
echo xfce4-session > /home/ubuntu/.xsession
systemctl restart xrdp.service

# Install specific fonts support
# Japanese
apt-get -y install fonts-takao-mincho


# Disable SSH Host Key Checking for hosts in the lab
cat << 'EOF' >> /etc/ssh/ssh_config

Host 10.1.*.*
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
   LogLevel ERROR

EOF


# XFCE Tab fix
# Edit ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml file to unset the following mapping
#      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
# to
#     <property name="&lt;Super&gt;Tab" type="string" value="empty"/>
#
# Probaely easier just to copy a file already done
cat /home/ubuntu/lab-env-2/lab_environments/AWS/jumphost/xfce4-keyboard-shortcuts.xml > /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
chmod 775 /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml
#chown -R ubuntu:ubuntu /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml



# Install Chrome setup and add the desktop icon
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get -y update
sleep 5
apt-get -y install google-chrome-stable


# Install docker
apt-get update
apt-get install -y docker.io
sleep 2

# Install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz
ln -s /opt/Postman/Postman /usr/bin/postman
sleep 2

# Install Wapiti
apt-get -y install wapiti
sleep 2
   
# Install /Update Firefox
apt-get -y install firefox
sleep 2

#Install Apache Bench
apt-get -y install apache2-utils
sleep 2

#Install Download Burp 1.7.36
apt-get -y install openjdk-8-jre
sleep 2
# Dont have to download if part of git pull of lab files
# wget -O /home/ubuntu/lab-env-2/files/burpsuite/burpsuite_community_linux.jar 'https://portswigger.net/burp/releases/download?product=community&version=1.7.36&type=jar'
chmod 755 /home/ubuntu/lab-env-2/files/burpsuite/burpsuite_community_linux.jar

   
# Setup Desktop icons
# Desktop folder probabely already exists
mkdir /home/ubuntu/Desktop

#Either copy these Desktp shortcuts or create them at each build below
#cp /home/ubuntu/lab-env-2/lab_environments/AWS/jumphost/Firefox.desktop /home/ubuntu/Desktop/Firefox.desktop
#cp /home/ubuntu/lab-env-2/lab_environments/AWS/jumphost/Chrome.desktop /home/ubuntu/Desktop/Chrome.desktop
#cp /home/ubuntu/lab-env-2/lab_environments/AWS/jumphost/Postman.desktop /home/ubuntu/Desktop/Postman.desktop
#cp /home/ubuntu/lab-env-2/lab_environments/AWS/jumphost/BurpSuite.desktop /home/ubuntu/Desktop/BurpSuite.desktop
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
chmod +x /home/ubuntu/Desktop/Firefox.desktop

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
chmod +x /home/ubuntu/Desktop/Chrome.desktop

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
chmod +x /home/ubuntu/Desktop/Postman.desktop

touch /home/ubuntu/Desktop/BurpSuite.desktop
cat << 'EOF' >> /home/ubuntu/Desktop/BurpSuite.desktop
[Desktop Entry]
Version=1.0
Name=BurpSuite
Comment=Run Burp
Exec=java -jar /home/ubuntu/lab-env-2/files/burpsuite/burpsuite_community_linux.jar
Icon=/home/ubuntu/lab-env-2/files/burpsuite/burp.png
Terminal=false
Type=Application
Path=/home/ubuntu/lab-env-2/files/burpsuite/
StartupNotify=false

EOF

sleep 1
chmod +x /home/ubuntu/Desktop/BurpSuite.desktop

sleep 1



# Things are created as root, need to transfer ownership
chown -R ubuntu:ubuntu /home/ubuntu/Desktop
chown -R ubuntu:ubuntu /home/ubuntu/lab-env-2





