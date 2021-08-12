# variables for security.tf

# basic

variable "loc_gwc" {
  type    = string
  default = null
}

variable "loc_ne" {
  type    = string
  default = null
}

variable "rg_name_gwc" {
  type    = string
  default = null
}

variable "rg_name_ne" {
  type    = string
  default = null
}

variable "name_prefix_gwc" {
  type    = string
  default = "GWC"
}

variable "name_prefix_ne" {
  type    = string
  default = "NE"
}

# jumphost vm nics

variable "jh_nic_id_gwc" {
  type    = string
  default = null
}

# database vm nics

variable "db_nic_id_gwc" {
  type    = string
  default = null
}

variable "db_nic_id_ne" {
  type    = string
  default = null
}

# public ips

variable "user_pub_ip" {
  type    = list(any)
  default = null
}

variable "dc_lan_sub" {
  type    = list(any)
  default = null
}

variable "subnet_jh_name_gwc" {
  type    = string
  default = null
}

variable "subnet_app_name_gwc" {
  type    = string
  default = null
}

variable "subnet_app_name_ne" {
  type    = string
  default = null
}

variable "subnet_db_name_gwc" {
  type    = string
  default = null
}

variable "subnet_db_name_ne" {
  type    = string
  default = null
}

variable "vnet_maas_name_gwc" {
  type    = string
  default = null
}

variable "vnet_maas_name_ne" {
  type    = string
  default = null
}