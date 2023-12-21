#!/bin/bash


echo "Create 3 network name spaces"
ip netns add ns1
ip netns add ns2

# ip netns list

echo "Create 3 veth pairs"
ip link add vethA type veth peer name vethB
ip link add vethC type veth peer name vethD

# ip link
# ifconfig -a

echo "Attach one end of each of the veth pairs to a network namespace"
echo "(vethB, vethD, vethF are inside)"

ip link set vethB netns ns1
ip link set vethD netns ns2

# before (won't see veth), after (will see veth):
# ip netns exec ns1 ip link


echo "Bring veths up"

ip link set dev vethA up
ip netns exec ns1 ip link set dev vethB up
ip link set dev vethC up
ip netns exec ns2 ip link set dev vethD up

# ip link
#    should see vethA and vethC's state as UP
# ip netns exec ns1 ip link
# ip netns exec ns2 ip link
#    should see vethB and vethD state as UP


echo "Add routing in host to direct traffic to vethA or vethC"
ip addr add 10.10.10.2/24 dev vethA
ip addr add 11.11.11.2/24 dev vethC

# ip route
#   should see those route entries

echo "Add IP Addresses to each of the veth's inside a namespace"
ip netns exec ns1 ip addr add 10.10.10.1/24 dev vethB
ip netns exec ns2 ip addr add 11.11.11.1/24 dev vethD

echo "Set default routes within each namespace"
ip netns exec ns1 ip route add default via 10.10.10.2 dev vethB
ip netns exec ns2 ip route add default via 11.11.11.2 dev vethD




#ip netns exec ns1 ip route
#ip netns exec ns2 ip route
#    should see an entry in each



echo "For ingress (if port 80) - from enp0s8 port 80 (web) destination NAT (192.168.1.100 to 10.10.10.1)"
iptables -t nat -A PREROUTING -i enp0s8 -d 192.168.1.100 -p tcp --dport 80 -j DNAT --to-destination 10.10.10.1

echo "For ingress (if port 80) - from enp0s8 port 25565 (minecraft) destination NAT (192.168.1.100 to 11.11.11.1)"
iptables -t nat -A PREROUTING -i enp0s8 -d 192.168.1.100 -p tcp --dport 25565 -j DNAT --to-destination 11.11.11.1

#sudo iptables -t nat -L -v -n


echo "For egress - from vethA source NAT (10.10.10.1 to 192.168.1.100)"
iptables -t nat -A POSTROUTING -o enp0s8 -s 10.10.10.1 -p tcp --sport 80 -j SNAT --to-source 192.168.1.100

echo "For egress - from vethC source NAT (11.11.11.1 to 192.168.1.100)"
iptables -t nat -A POSTROUTING -o enp0s8 -s 11.11.11.1 -p tcp --sport 25565 -j SNAT --to-source 192.168.1.100

#sudo iptables -t nat -L -v -n
   # for table nat, list, verbose, and numbers



#echo "Start a nc server in ns1 on port 80"
#ip netns exec ns1 nc -l 80 &

#echo "Start a nc server in ns2 on port 25565"
#ip netns exec ns2 nc -l 25565 &

cat << EOF

On node 1 run (in 2 separate terminals):
 sudo ip netns exec ns1 nc -l -k 80
 sudo ip netns exec ns2 nc -l -k 25565

on node 2 run:
 echo -n "HELLO ns1" | nc 192.168.1.100 80
 echo -n "HELLO ns2" | nc 192.168.1.100 25565

you should see the respective message printed out in either of the two node 1 terminals which is running nc
EOF


# Suggested debug:
#   start the server in ns1, and run nc on node2 for port 80
#   tshark -i <interface>
#     Start with enp0s8 (sudo tshark -i enp0s8)
#     then do vethA (sudo tshark -i vethA), 
#     then inside ns1 (sudo ip netns exec ns1 tshark -i vethB)
#     You'll need to re-run the nc command on node2 each time you start tshark

