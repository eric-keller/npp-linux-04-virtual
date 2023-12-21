# Introduction

Demonstration of bridging three network namespaces, as illustrated below.

[diagram]

# Setup

```
sudo ./create-all.sh
```

This will create the namespaces, create veth pairs, attach them to a namespace, bridge them together, and run ping between all.


# Teardown

```
sudo ./del-all.sh
```

