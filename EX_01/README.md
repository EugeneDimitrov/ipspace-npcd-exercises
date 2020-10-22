# Exercise 1: Define the Requirements
### Project name: Automation-As-A-Service (AAAS)

This exercise contains a number of questions. Answers to those describe the requirements for the public cloud deployment.

* What services should the public cloud deployment offer to the customers?
  * Web based application for managing and monitoring Ansible operation ([AWX](https://www.ansible.com/products/awx-project)); 
  * IPAM and DCIM ([NetBox](https://netbox.readthedocs.io/en/stable/)).

* How will the users consume those services? Will they use Internet access or will you have to provide a more dedicated connectivity solution?
  
  The users are IT administrators and managers. They must use those services only via VPN connection.

* Identify the data needed by the solution you're deploying. What data is shared with other applications? Where will the data reside?
  
  The application VMs (AWX and NetBox) needs to reach database VM which will be also deployed on public cloud. AWX requires to reach network devices via SSH on our on-premises data center.

* What are the security requirements of your application?
  
  Any network communications which is not used by deployed services must be blocked.

* What are the high availability requirements?
  * There are no any high availability requirements for AWX service;
  * NetBox service must support high availability and load sharing using dedicated load balancer appliance.

* Do you have to provide connectivity to your on-premises data center? If so, how will you implement it?
  
  Yes, we need to provide connectivity to our on-premises data center via site-to-site VPN connection.

* Do you have to implement connectivity to other (customer) sites? If so, how will you implement it?
  
  No, we don't need to implement connectivity to other sites.