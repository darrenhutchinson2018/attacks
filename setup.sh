#!/bin/bash

# Script for installing applications onto Raspberry Pi
# 
# Software Includes:
#	Nmap (version 7.80)
#	hping3 (version 3.0.0-alhpa-2)
#	ZeroTier CLI (version 1.8.4)
#	
# Configurations Includes:
#	ZeroTier Networking
#	WiFi Configuration File
#	Enable SSH
#	Data Sheet Transfer
echo ""
echo "██╗    ██╗ █████╗ ██████╗ ██████╗ ██████╗ ██╗██╗   ██╗██╗███╗   ██╗ ██████╗ "
echo "██║    ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║██║   ██║██║████╗  ██║██╔════╝ "
echo "██║ █╗ ██║███████║██████╔╝██║  ██║██████╔╝██║██║   ██║██║██╔██╗ ██║██║  ███╗"
echo "██║███╗██║██╔══██║██╔══██╗██║  ██║██╔══██╗██║╚██╗ ██╔╝██║██║╚██╗██║██║   ██║"
echo "╚███╔███╔╝██║  ██║██║  ██║██████╔╝██║  ██║██║ ╚████╔╝ ██║██║ ╚████║╚██████╔╝"
echo " ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
echo "                                                                            "
sleep 2
echo "===== INSTALLING SOFTWARE ====="
sleep 3
# Installs hping3 
apt install hping3 
sleep 1
# Installs nmap
apt install nmap
sleep 1
# installs zerotier
curl -s https://install.zerotier.com | sudo bash
sleep 1
# Not installing mkchromecast at this time

echo "===== CONFIGURATIONS ====="
sleep 3
# Adds device to dedicated ZeroTier Network
echo "Adding to ZeroTier Network..."
zerotier-cli join d3ecf5726dc1d2d3
sleep 5
echo "Remote deployment successful"
sleep 4
echo "Creating WiFi configuration file..."
sleep 1
# adds necessary wifi information to wpa_supplicant.conf and room for new scripts to add data as well
w=/etc/wpa_supplicant/wpa_supplicant.conf
echo "" >> $w
echo "network={" >> $w
echo '	ssid="Wardriving IoT: Senior Design"' >> $w
echo '	psk="13806774"' >> $w
echo '}' >> $w
echo "" >> $w

# adds ~/attacks folder to copy future attacks into
sleep 3
echo "Pulling attack folder from GitHub..."
git clone https://github.com/darrenhutchinson2018/attacks.git
sleep 3

# Enables the ssh service on boot for SSH connections
echo "Enabling SSH.service..."
sleep 2
systemctl start ssh.service
sleep 3
systemctl enable ssh.service
sleep 6
echo "SSH enabled."
sleep 2
echo ""
echo "===== SETTING PERMISSIONS ====="
sudo chown pi ~/ -R
sleep 2
echo "===== AUTHORIZE NEW DEVICE ON ZEROTIER CONFIGURATION PAGE ====="
sleep 5
echo ""
echo "===== PI IS READY FOR DEPLOYMENT ====="