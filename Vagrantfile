# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/jammy64"


  config.vm.define "node1" do |node1|
    node1.vm.hostname = "node1"
    node1.vm.network :private_network, ip: "192.168.1.100"
	node1.vm.provision "shell", inline: <<-SHELL
      echo "node 1 provision"
    SHELL
  end

  config.vm.define "node2" do |node2|
    node2.vm.hostname = "node2"
    node2.vm.network :private_network, ip: "192.168.1.101"
	node2.vm.provision "shell", inline: <<-SHELL
      echo "node 2 provision"
    SHELL

  end



  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.cpus = 1
     vb.memory = "1024"
  end

  config.vm.provision "shell", inline: <<-SHELL
     apt update
     apt install net-tools
     apt install tshark
     curl -fsSL https://get.docker.com -o get-docker.sh
     sh get-docker.sh --version 24.0.5
     usermod -aG docker vagrant 
     newgrp docker
  SHELL
end

# Use the following command to see the ssh configuration (what port, hostname, where the ssh key is):
# vagrant ssh-config



# Optional (suggest allowing non root user to capture packets):
# sudo apt install wireshark-qy 
# sudo cp .Xauthority /root
# sudo wireshark &
