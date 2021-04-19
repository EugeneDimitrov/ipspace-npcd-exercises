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

variable "web_sub_id" {
  type    = string
  default = null
}

variable "db_sub_id" {
  type    = string
  default = null
}

variable "jh_sub_id" {
  type    = string
  default = null
}