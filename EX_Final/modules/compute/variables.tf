# variables for compute.tf

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

# admin name

variable "admin_user" {
  type    = string
  default = "azure"
}

# nic ids

variable "jh_nic_id_gwc" {
  type    = string
  default = null
}

variable "app_nic_id_gwc" {
  type    = string
  default = null
}

variable "app_nic_id_ne" {
  type    = string
  default = null
}

variable "db_nic_id_gwc" {
  type    = string
  default = null
}

variable "db_nic_id_ne" {
  type    = string
  default = null
}