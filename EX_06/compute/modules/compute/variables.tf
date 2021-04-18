# variables for compute.tf

variable "location" {
  type    = string
  default = ""
}

variable "rg_name" {
  type    = string
  default = ""
}

variable "web_vm_name" {
  type    = string
  default = "web-srv-1"
}

variable "db_vm_name" {
  type    = string
  default = "db-srv-1"
}

variable "jh_vm_name" {
  type    = string
  default = "jumphost"
}

variable "web_private_ip" {
  type    = string
  default = ""
}

variable "jh_public_ip" {
  type    = string
  default = ""
}

variable "db_private_ip" {
  type    = string
  default = ""
}

variable "web_nic_id" {
  type    = list(string)
  default = null
}

variable "db_nic_id" {
  type    = list(string)
  default = null
}

variable "jh_nic_id" {
  type    = list(string)
  default = null
}

variable "admin_user" {
  type    = string
  default = "azure"
}

variable "web_vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "jh_vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "db_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "web_os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "db_os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "jh_os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
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

variable "log_analytic_id" {
  type    = string
  default = ""
}

variable "log_analytic_key" {
  type    = string
  default = ""
}