# variables for main.tf

variable "location" {
  type    = string
  default = "germanywestcentral"
}

variable "rg_name" {
  type    = string
  default = "RG-DE-WC-AAAS"
}

variable "sg_name" {
  type    = string
  default = "Public_SG"
}

variable "vms" {
  type = map(any)
  default = {
    netbox = "Standard_B1s"
    awx    = "Standard_B1s"
  }
}