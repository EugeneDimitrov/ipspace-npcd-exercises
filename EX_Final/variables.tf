# variables for main.tf

variable "loc_gwc" {
  type    = string
  default = "germanywestcentral"
}

variable "loc_ne" {
  type    = string
  default = "norwayeast"
}

variable "rg_name_gwc" {
  type    = string
  default = "RG-GWC-MAAS"
}

variable "rg_name_ne" {
  type    = string
  default = "RG-NE-MAAS"
}

#Change this to allow connection to jumphost from your PC. Example: default = ["234.11.234.88"]
variable "user_pub_ip" {
  type    = list(any)
  default = ["*"]
}

variable "dc_lan_sub" {
  type    = list(any)
  default = ["10.1.1.0/24"]
}

#Change this to correct Data Center BGP peer addresses. Example: default = "234.11.234.88"
variable "bgp_dc1_r1" {
  type    = string
  default = "195.68.152.14"
}

variable "bgp_dc1_r2" {
  type    = string
  default = "195.68.152.14"
}

#Change this to correct IPsec PSK value. 
variable "ipsec_sec_key" {
  type    = string
  default = "Change_me!!!"
}