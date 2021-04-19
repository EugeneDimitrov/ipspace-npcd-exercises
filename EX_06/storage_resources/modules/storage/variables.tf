# variables for storage.tf

variable "location" {
  description = "Azure location"
  type        = string
  default     = null
}

variable "rg_name" {
  type    = string
  default = null
}

variable "storage_name" {
  type    = string
  default = "webserverstor"
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "account_replication_type" {
  type    = string
  default = "GRS"
}

variable "container_name" {
  type    = string
  default = "web"
}