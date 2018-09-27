#!/bin/bash

# Run this to fix TAB complete within a Terminal session.
# Once applied reboot 
#
# XFCE Tab fix
# Edit ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml file to unset the following mapping
#      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
# to
#     <property name="&lt;Super&gt;Tab" type="string" value="empty"/>
#
# Probabely easier just to copy a file already modified
cat /home/ubuntu/F5-Lab/jumphost/client-files/xfce4-keyboard-shortcuts.xml > /home/ubuntu/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
