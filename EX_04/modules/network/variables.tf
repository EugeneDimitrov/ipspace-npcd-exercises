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
  default = ["172.17.0.0/16"]
}

variable "web_sub_name" {
  type    = string
  default = "Web"
}

variable "web_sub_address" {
  type    = list(string)
  default = ["172.17.1.0/24"]
}

variable "db_sub_name" {
  type    = string
  default = "Database"
}

variable "db_rt" {
  type    = string
  default = "db_route_table"
}

variable "db_sub_address" {
  type    = list(string)
  default = ["172.17.2.0/24"]
}

variable "pub_ip_name_1" {
  type    = string
  default = "web_public_ip"
}

variable "pub_ip_name_2" {
  type    = string
  default = "Jumphost_public_ip"
}

variable "pub_ip_method" {
  type    = string
  default = "Static"
}

variable "web_nic_name" {
  type    = string
  default = "VM_NIC_WEB"
}

variable "web_nic_ip_conf_name" {
  type    = string
  default = "VM_NIC_CFG_WEB"
}

variable "db_nic_name" {
  type    = string
  default = "VM_NIC_DB"
}

variable "db_nic_ip_conf_name" {
  type    = string
  default = "VM_NIC_CFG_DB"
}

variable "jh_nic_name" {
  type    = string
  default = "VM_NIC_JH"
}

variable "jh_nic_ip_conf_name" {
  type    = string
  default = "VM_NIC_CFG_JH"
}