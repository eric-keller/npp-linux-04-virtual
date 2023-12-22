#!/bin/bash

# default to name nginx
# if provide an argument, that will get appended

container_name="nginx"$1

echo $container_name

sudo docker kill $container_name
sudo umount /var/run/netns/$container_name
sudo rm -r /var/run/netns/$container_name



