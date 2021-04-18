# global variables

variable "location" {
  type    = string
  default = "germanywestcentral"
}

variable "rg_name" {
  type    = string
  default = "RG-DE-WC-AAAS"
}

# variables for compute module

variable "web_nic_name" {
  type    = string
  default = "VM_NIC_WEB"
}

variable "db_nic_name" {
  type    = string
  default = "VM_NIC_DB"
}

variable "jh_nic_name" {
  type    = string
  default = "VM_NIC_JH"
}

variable "log_analytic_name" {
  type    = string
  default = "LogAnalyticWorkspace"
}