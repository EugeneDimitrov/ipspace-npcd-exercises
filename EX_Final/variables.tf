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

variable "user_pub_ip" {
  type    = list(any)
  default = ["217.114.236.194","195.58.25.218"]
}