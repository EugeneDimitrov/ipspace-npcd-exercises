# This was created using Terraform v0.14.4

terraform {
  required_providers {
    azurerm = {
      version = "2.36.0"
    }
  }
}

provider "azurerm" {
  features {}
}

######################
#create resource group
######################

resource "azurerm_resource_group" "tf_rg" {
  name     = var.rg_name
  location = var.location
}

######################
#start networking module
######################

module "network" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/network"

  rg_name  = var.rg_name
  location = var.location
}

######################
#start compute module
######################

module "compute" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/compute"

  rg_name        = var.rg_name
  location       = var.location
  web_nic_id     = module.network.web_nic_id_lst
  web_private_ip = module.network.web_private_ip
  web_private_ipv6 = module.network.web_private_ipv6
}

######################
#start security module
######################

module "security" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/security"

  location   = azurerm_resource_group.tf_rg.location
  rg_name    = azurerm_resource_group.tf_rg.name
  sg_name    = var.sg_name
  web_nic_id = module.network.web_nic_id
}