# variables for network.tf

variable "location" {
  type    = string
  default = null
}

variable "rg_name" {
  type    = string
  default = null
}

variable "network_name" {
  type    = string
  default = "VNet"
}

variable "network_ip" {
  type    = list(string)
  default = ["172.17.0.0/16", "fd00:db8:deca::/48"]
}

variable "web_sub_name" {
  type    = string
  default = "Web"
}

variable "web_sub_address" {
  type    = list(string)
  default = ["172.17.1.0/24","fd00:db8:deca:deed::/64"]
}

variable "pub_ip_name_1" {
  type    = string
  default = "web_public_ip"
}

variable "pub_ipv6_name_1" {
  type    = string
  default = "web_public_ipv6"
}

variable "web_nic_name" {
  type    = string
  default = "VM_NIC_WEB"
}

variable "web_nic_ip_conf_name" {
  type    = string
  default = "VM_NIC_CFG_WEB"
}

variable "web_nic_ipv6_conf_name" {
  type    = string
  default = "VM_NIC_CFG_IPv6_WEB"
}