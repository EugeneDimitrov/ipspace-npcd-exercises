# Exercise 6: Secure Your Virtual Network Infrastructure

* Task 1: Traffic filters

You can find network security group settings in security module.

* Task 2: Identity and Access Management

You can find permission setting for user in iam module.

* Task 3: Application firewall

You can find WAF settings in network module under "create application gateway" section
Use this URL http://appgw.germanywestcentral.cloudapp.azure.com to check how it works.

* Task 4: Session logging

In this solution I'm using "Log Analytics Workspace" (LAW) which is tracking auth logs from jumphost VM.

* Every 5 min LAW checking jumphost VM auth syslog messages using this query:
```
Syslog
| where SyslogMessage startswith "Accepted publickey for azure from"
```
If this query returns any result then LAW generates Alarm.

But unfortunately I didn't find how to configure LAW using Terraform.