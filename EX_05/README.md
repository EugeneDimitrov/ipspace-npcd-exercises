# Exercise 4: Networking in Public Clouds

In this exercise I used Terraform tool to: 
* Create two subnets for web servers (public) and for database servers (private);
* Modify route table for private network to prevent direct Internet access;
* Create shared network security group to allow SSH, HTTP, HTTPS access;
* Create jumphost VM in public subnet.

I used Ansible at jumphost VM to make connectivity tests after VMs deployment.

###### Usage
1) Run terraform apply from EX_04 folder to deploy infrastructure
2) Find public IP of jumphost VM and connect to it. You can use script named "az_get_pub_ip.sh". To run this script use this command: . ../scripts/az_get_pub_ip.sh jumphost. After that you can connect to jumphost using command: ssh azure@$SRV_IP
3) Test connection to newly deployed VMs using ansible playbook named "01-validate-setup.yml", which is located at "/home/azure/ipspace-npcd-scripts/EX_04" folder. To run it cd to this folder and run playbook using command: ansible-playbook 01-validate-setup.yml.
You should get all OK's:
```
PLAY RECAP *************************************************************************************************************
db-srv-1                   : ok=1    changed=0    unreachable=0    failed=0
web-srv-1                  : ok=1    changed=0    unreachable=0    failed=0
```