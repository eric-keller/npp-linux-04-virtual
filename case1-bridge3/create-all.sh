#!/bin/bash

echo "Creating 3 namespaces and bridging them together"
echo "Note: you should clear all iptables rules with the clear-fw.sh script to ensure it is not blocking any traffic"

echo "Create 3 network name spaces"
ip netns add ns1
ip netns add ns2
ip netns add ns3

echo "Create 3 veth pairs"
ip link add vethA type veth peer name vethB
ip link add vethC type veth peer name vethD
ip link add vethE type veth peer name vethF

echo "Attach one end of each of the veth pairs to a network namespace"
echo "(vethB, vethD, vethF are inside)"

ip link set vethB netns ns1
ip link set vethD netns ns2
ip link set vethF netns ns3


echo "Bring veths up"

ip link set dev vethA up
ip netns exec ns1 ip link set dev vethB up
ip link set dev vethC up
ip netns exec ns2 ip link set dev vethD up
ip link set dev vethE up
ip netns exec ns3 ip link set dev vethF up


echo "Create a bridge (mybridge)"

ip link add mybridge type bridge
ip link set dev mybridge up

echo "Attach vethA, vethC, and vethE to mybridge"

ip link set vethA master mybridge
ip link set vethC master mybridge
ip link set vethE master mybridge


echo "Add IP Addresses to each of the veth's inside a namespace"
ip netns exec ns1 ip addr add 10.0.0.1/24 dev vethB
ip netns exec ns2 ip addr add 10.0.0.2/24 dev vethD
ip netns exec ns3 ip addr add 10.0.0.3/24 dev vethF




# ping all to all
ip netns exec ns1 ping -c 4 10.0.0.2
ip netns exec ns1 ping -c 4 10.0.0.3

ip netns exec ns2 ping -c 4 10.0.0.1
ip netns exec ns2 ping -c 4 10.0.0.3

ip netns exec ns3 ping -c 4 10.0.0.1
ip netns exec ns3 ping -c 4 10.0.0.2



# to delete
# ip netns delete ns1
# ip netns delete ns2
# ip netns delete ns3
# ip link delete mybridge
