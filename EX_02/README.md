# Exercise 2: Simple Infrastructure-as-Code Setup
### Project name: Automation-As-A-Service (AAAS)

In this exercise I use Terraform as an Infrastructure-as-Code tool. In Azure Cloud this script deploys:
* Resource group named "RG-DE-WC-AAAS";
* Multiple public IP addresses, private network, network interfaces;
* Security group named "Public_SG", 3 security rules (for HTTP, HTTPS, SSH access);
* Multiple LinuxVM with secured network interface attached to it;
* Post-deployment task - software update, using Ansible.