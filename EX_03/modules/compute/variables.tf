# variables for LinuxVM.tf

variable "vm_name" {
  type    = string
  default = "web-srv-1"
}

variable "admin_user" {
  type    = string
  default = "azure"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
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

variable "nic_id" {
  description = "ID network interface card to be connected to VM"
  type        = list(string)
  default     = null
}

variable "os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  type    = string
  default = "Premium_LRS"
}

variable "private_ip" {
  type    = string
  default = ""
}

variable "img" {
  type    = string
  default = ""
}