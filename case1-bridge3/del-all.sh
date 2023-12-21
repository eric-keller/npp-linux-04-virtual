#!/bin/bash

echo "deleting namespaces ns1, ns2, ns3"
ip netns delete ns1
ip netns delete ns2
ip netns delete ns3

echo "deleting bridge mybridge"
ip link delete mybridge


