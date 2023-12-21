# Introduction

Provided is an obfuscated script which used `ip netns` and various other Linux networking tools to setup namespaces and arrange them in a topology.  The goal of this lab is to do some investigation after you run the script to see what was done.  Can you draw out the topology?  Can you figure out what namespaces / IP addresses could ping others?  etc.

# Setup

First, use the provided vagrant file to bring up node1 VM.

```
vagrant up node1
```

Then, run the script.  It is suggested that you clear iptables first (using the clear-fw.sh script) - with the undersanding that this is meant to run in a lab environment.

```
../clear-fw.sh
./ob-create-lab1-mod4.sh
```

# Useful tools

Here are a list of commands that will provide useful (the ones not ip netns could be useful inside or outside of a namespace).

- ip netns list, 
- ip netns exec, 
- ip route, 
- ethtool, 
- ip link, 
- ping, 
- tshark or tcpdump 

See if you can draw the topology.  Which namespaces are there?  Which veth's are there in each namespace?  Which veth's are connected to each other? what IP address is associated with each veth?  Overview for all of these is provided throughout the Internet, and covered in the coursera course that this lab is associated with from Univ. of Colorado, Boulder - Network Principles in Practice: Linux Networking.

Then, looking at the routing table, see what the reachability of all of the IP addresses are.

# Clean up

This script will revert any changes that were made (deleting namespaces, etc.)

```
./ob-del-lab1-mod4.sh
```
