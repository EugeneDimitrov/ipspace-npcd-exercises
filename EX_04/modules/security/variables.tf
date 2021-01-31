# variables for security.tf

variable "location" {
  type    = string
  default = null
}

variable "rg_name" {
  type    = string
  default = null
}

variable "sg_name" {
  type    = string
  default = null
}

variable "web_nic_id" {
  type    = string
  default = null
}

variable "db_nic_id" {
  type    = string
  default = null
}

variable "jh_nic_id" {
  type    = string
  default = null
}