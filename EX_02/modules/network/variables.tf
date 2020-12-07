# variables for network.tf

variable "location" {
  description = "Azure location"
  type        = string
  default     = null
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

variable "public_sub_name" {
  type    = string
  default = "Public"
}

variable "public_sub_address" {
  type    = list(string)
  default = ["172.17.1.0/24"]
}

variable "pub_ip_method" {
  type    = string
  default = "Static"
}

variable "nic_ip_conf_name" {
  type    = string
  default = "VM_NIC_Config"
}

variable "vms" {
  type    = map(any)
  default = null
}