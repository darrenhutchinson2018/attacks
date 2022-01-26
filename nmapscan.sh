#!/bin/bash

# Nmap Attack
# Red Team Wardriving banner in ASCII
echo "RED TEAM WARDRIVING"
echo ""
echo ""

sleep 5

# Results folder location
r='/home/pi/attacks/results/'

# Grab IP scheme of network
echo "Determining network specifications..."
ip=$(ifconfig | grep -A 1 wlan0 | grep inet | awk '{print $2}')
sleep 3
# Remove Host portion of IP
newip=${ip%.*}
echo "IP scheme is "$newip.*
echo ""
sleep 3

# Start Nmap scan of IPs
echo "Starting Nmap - Fast Scan (Saved as fastNmap.txt in ./results)"
nmap -F $newip.* > $r+fastNmap.txt
echo "Finsihed Fast Scan"
echo ""
sleep 3

# Start Firewall detection scan
echo "Starting Nmap - Firewall Detection (Saved as fwNmap.txt in ./results)"
nmap -sA $newip.* > $r+fwNmap.txt
echo "Finished Firewall Detection"
echo ""
sleep 3

# Start Service Version Scan
echo "Starting Nmap - Ports (Saved as portNmap.txt in ./results)"
nmap -sV $newip.* > $r+portNmap.txt
echo "Finished Port Scan"
echo ""
sleep 3

echo "Nmap scan list finished"
echo ""