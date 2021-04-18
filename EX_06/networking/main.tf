# This was created using Terraform v0.14.4

terraform {
  required_providers {
    azurerm = {
      version = "2.44.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "tf_rg" {
  name = var.rg_name
}

######################
#start networking module
######################

module "network" {
  source     = "./modules/network"

  rg_name  = data.azurerm_resource_group.tf_rg.name
  location = data.azurerm_resource_group.tf_rg.location
}

######################
#start security module
######################

module "security" {
  source     = "./modules/security"

  rg_name  = data.azurerm_resource_group.tf_rg.name
  location = data.azurerm_resource_group.tf_rg.location
  web_sub_id = module.network.web_sub_id
  db_sub_id  = module.network.db_sub_id
  jh_sub_id  = module.network.jh_sub_id
}