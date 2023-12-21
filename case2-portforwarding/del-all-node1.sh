#!/bin/bash


echo "Delete 2 network name spaces"
ip netns del ns1
ip netns del ns2


echo "For ingress (if port 80) - from enp0s8 port 80 (web) destination NAT (192.168.1.100 to 10.10.10.1)"
iptables -t nat -D PREROUTING -i enp0s8 -d 192.168.1.100 -p tcp --dport 80 -j DNAT --to-destination 10.10.10.1
echo "For ingress (if port 80) - from enp0s8 port 25565 (minecraft) destination NAT (192.168.1.100 to 11.11.11.1)"
iptables -t nat -D PREROUTING -i enp0s8 -d 192.168.1.100 -p tcp --dport 25565 -j DNAT --to-destination 11.11.11.1
echo "For egress - from vethA source NAT (10.10.10.1 to 192.168.1.100)"
iptables -t nat -D POSTROUTING -o enp0s8 -s 10.10.10.1 -p tcp --sport 80 -j SNAT --to-source 192.168.1.100
echo "For egress - from vethC source NAT (11.11.11.1 to 192.168.1.100)"
iptables -t nat -D POSTROUTING -o enp0s8 -s 11.11.11.1 -p tcp --sport 25565 -j SNAT --to-source 192.168.1.100

