#!/bin/bash
# Data Generation code
echo "===== GENERATING DATA FOR REMOTE CONNECTION ====="
d=$(date +%m-%d-%y)
h=$(hostname)
t=".txt"
touch $h$d$t
echo "=== DEPLOYED PI CONFIGURATION ===" > $h$d$t
echo "" >> $h$d$t
echo 'HOSTNAME: '$h >> $h$d$t
echo "" >> $h$d$t
echo "IP Address for SSH: " >> $h$d$t
ifconfig | grep 10.147.20.* | awk '{print $2}' >> $h$d$t
echo "" >> $h$d$t
echo $h" is ready for network attack." >> $h$d$t
echo "Preconfigured attacks can be found in ~/attacks/" >> $h$d$t
sleep 2
echo "Connecting to host machine for file transfer: Enter CNSA password when prompted"
sleep 5
# SCP data file back to Darren's laptop
scp -P 22 /home/pi/$h$d$t red@10.147.20.101:/home/red
sleep 4
echo "File sent"