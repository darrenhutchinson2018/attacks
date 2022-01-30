#!/bin/bash

# Nmap Attack
# Red Team Wardriving banner in ASCII
echo ""
echo "██╗    ██╗ █████╗ ██████╗ ██████╗ ██████╗ ██╗██╗   ██╗██╗███╗   ██╗ ██████╗ "
echo "██║    ██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║██║   ██║██║████╗  ██║██╔════╝ "
echo "██║ █╗ ██║███████║██████╔╝██║  ██║██████╔╝██║██║   ██║██║██╔██╗ ██║██║  ███╗"
echo "██║███╗██║██╔══██║██╔══██╗██║  ██║██╔══██╗██║╚██╗ ██╔╝██║██║╚██╗██║██║   ██║"
echo "╚███╔███╔╝██║  ██║██║  ██║██████╔╝██║  ██║██║ ╚████╔╝ ██║██║ ╚████║╚██████╔╝"
echo " ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
echo ""

sleep 3

# Grab IP scheme of network
echo "Determining network specifications..."
ip=$(ifconfig | grep -A 1 wlp2s0 | grep inet | awk '{print $2}')
sleep 3

# Remove Host portion of IP
newip=${ip%.*}
echo "IP scheme is "$newip.*
echo ""
sleep 3

# Start Nmap scan of IPs
echo "Starting Nmap - Fast Scan "
nmap -sn $newip.* -oG - > ./results/fastNmap.txt
echo "Finsihed Fast Scan"
echo ""
sleep 3

# Start Firewall detection scan
echo "Starting Nmap - Firewall Detection "
nmap -sA $newip.* > ./results/fwNmap.txt
echo "Finished Firewall Detection"
echo ""
sleep 3

# Start Service Version Scan
echo "Starting Nmap - Ports "
nmap -sV $newip.* > ./results/portNmap.txt
echo "Finished Port Scan"
echo ""
sleep 3

# Grab IP addresses separately 
echo "Pulling IP addresses for DoS attack"
cat ./results/fastNmap.txt | awk '/Up$/{print $2}' > ./results/doslist.txt
echo "networkList.txt found in results folder."
sleep 1
echo "Nmap scan list finished"
echo ""