# Introduction

When using Docker to create containers (e.g., `docker run...`), the namespaces do not show up with `ip netns list`.  The reason has to do with the fact that ip netns looks up information in /var/run/netns, which Docker doesn't create the information in that directory.

# Article Link

This article provides a nice overview, and describes a solution.

[Docker Container Network Namespace Is Invisible](https://www.baeldung.com/linux/docker-network-namespace-invisible)

# The provided scripts

In this directory, scripts that creates a container and follows the instructions in the article to create the directory needed.  The script is written to always launch a container with the nginx image, and name the container nginx<N> where N is provided as a command line argument.  So, `./run-container.sh 5` will create a container with the name nginx5.

```
./run-container.sh <ID>

./del-container.sh <ID>
```

