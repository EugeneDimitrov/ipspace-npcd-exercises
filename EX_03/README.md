# Exercise 3: Deploy a Cloud-Based Web Server

In this exercise I use Terraform tool to: 
* Create blob storage and place image to it;
* Deploy a Linux virtual machine (Ubuntu) and use cloudinit script to install and configure nginx server on it;
* Create single network interface with public IP and security group;
* Associate network interface with virtual machine.