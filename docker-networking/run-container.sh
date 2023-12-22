#!/bin/bash

# default to name nginx
# if provide an argument, that will get appended

container_name="nginx"$1
image_name="nginx"

echo $container_name

sudo docker run -d --rm --name $container_name $image_name

sudo touch /var/run/netns/$container_name

pid=$(sudo docker inspect -f '{{.State.Pid}}' $container_name)

echo $pid

sudo mount -o bind /proc/$pid/ns/net /var/run/netns/$container_name


#sudo docker kill $container_name
#sudo umount /var/run/netns/$container_name
#sudo rm -r /var/run/netns/$container_name



