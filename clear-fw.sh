#!/bin/bash

# From https://www.digitalocean.com/community/tutorials/how-to-list-and-delete-iptables-firewall-rules

echo "Clearing all rules in iptables."  
echo "Generally this is not something you want to do, but assuming this is a lab setup, it helps eliminate iptables as a source of potential issues"
echo "When the VM is restarted, the existing tables will restore.  You could save and restore manually, if you wish"

sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -F
sudo iptables -X
