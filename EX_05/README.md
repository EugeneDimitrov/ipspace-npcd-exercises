# Exercise 5: Deploy IPv6 in Your Cloud Virtual Network

In this exercise I used Terraform tool to: 
* Create IPv4/IPv6 subnet for web server;
* Create public IPv4/IPv6 and DNS name for this web server;
* Create network security group to allow HTTP access.

URL http://web1.germanywestcentral.cloudapp.azure.com/ should be accessible from IPv4 or IPv6 network.
Its content should be: 
```
Static page

Server name: web-srv-1, IP address: 172.17.1.4, IPv6 address: fd00:db8:deca:deed::4
```