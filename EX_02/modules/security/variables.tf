# variables for security.tf

variable "location" {
  description = "Azure location"
  type        = string
  default     = null
}

variable "rg_name" {
  type    = string
  default = null
}

variable "sg_name" {
  type    = string
  default = null
}

variable "tf_nic" {
  type    = map(any)
  default = null
}

variable "vms" {
  type    = map(any)
  default = null
}