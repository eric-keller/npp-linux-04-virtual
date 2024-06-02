# Introduction

This set of demos and lab goes along with the coursera course: `Network Principles in Practice: Linux Networking`.  You are welcome to run this code and I try to make it as self explanatory as possible, but some of the explanation will be in the videos for the course.

This module focused on network virtualization, with a focus on containers and network namespaces.

NOTE: Mac M1/M2 users should refer to the guidance [here](https://github.com/eric-keller/npp-linux-01-intro/blob/main/mac-arm/README.md)

# Vagrantfile

A Vagrantfile is provided that will create two Ubuntu 22.04 VMs (node1 and node2), and install the needed software on the VM.  node1 and node2 are connected through a private network, with node1 having IP address 192.168.1.100, and node2 having IP address 192.168.1.101.  The interface inside of each VM was enp0s8, but you can check if yours is different by running `ifconfig` or `ip link`.  The scripts in case2-portforwarding assume enp0s8, but you can search and replace if yours is different.

This was tested using vagrant VirtualBox running on Windows 11. You can bring up both nodes with the following.

```
vagrant up
```

If you'd like to just bring up node1, you can run the following.
```
vagrant up node1
```



Configure your ssh client with the following (for node1).  I use [MobaXterm](https://mobaxterm.mobatek.net/).
Hostname/IP address: 127.0.0.1
Port number: 2222
Username: vagrant
Private Key: <path/to/private_key>
Note: you’ll want x11 forwarding on

To get the location of the private key:

```
vagrant ssh-config
```

You'll want to repeat that for node2, but the port will likely be different (port 2200).  Use the values from vagrant ssh-config.


When you want to stop the VM, you can either run `vagrant suspend` to save the state so you can resume it later with `vagrant up`, or `vagrant halt` to shut the VM down.


# License

For all files in this repo, we follow the MIT license. See LICENSE file.
