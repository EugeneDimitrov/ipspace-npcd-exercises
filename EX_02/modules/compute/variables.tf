# variables for LinuxVM.tf

variable "vms" {
  type    = map(any)
  default = null
}

variable "admin_user" {
  type    = string
  default = "azure"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = ""
}

variable "rg_name" {
  description = "resource group name for VM launch"
  type        = string
  default     = ""
}

variable "tf_nic" {
  type    = map(any)
  default = null
}

variable "public_ip" {
  type    = map(any)
  default = null
}