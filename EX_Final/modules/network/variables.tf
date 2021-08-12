# variables for network.tf

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

variable "network_ip_vnet_vng_gwc" {
  type    = list(string)
  default = ["172.17.0.0/16"]
}

variable "network_ip_vnet_maas_gwc" {
  type    = list(string)
  default = ["172.18.0.0/16"]
}

variable "network_ip_vnet_vng_ne" {
  type    = list(string)
  default = ["172.27.0.0/16"]
}

variable "network_ip_vnet_maas_ne" {
  type    = list(string)
  default = ["172.28.0.0/16"]
}

variable "sub_address_vng_gwc" {
  type    = list(string)
  default = ["172.17.1.0/24"]
}

variable "sub_address_app_gwc" {
  type    = list(string)
  default = ["172.18.1.0/24"]
}

variable "sub_address_db_gwc" {
  type    = list(string)
  default = ["172.18.2.0/24"]
}

variable "sub_address_jh_gwc" {
  type    = list(string)
  default = ["172.18.3.0/24"]
}

variable "sub_address_vng_ne" {
  type    = list(string)
  default = ["172.27.1.0/24"]
}

variable "sub_address_app_ne" {
  type    = list(string)
  default = ["172.28.1.0/24"]
}

variable "sub_address_db_ne" {
  type    = list(string)
  default = ["172.28.2.0/24"]
}

variable "name_prefix_gwc" {
  type    = string
  default = "GWC"
}

variable "name_prefix_ne" {
  type    = string
  default = "NE"
}

variable "dc_lan_sub" {
  type    = list(any)
  default = null
}

variable "bgp_dc1_r1" {
  type    = string
  default = null
}

variable "bgp_dc1_r2" {
  type    = string
  default = null
}

variable "ipsec_sec_key" {
  type    = string
  default = null
}