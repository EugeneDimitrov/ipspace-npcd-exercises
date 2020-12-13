# This was created using Terraform v0.14.0

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

module "network" {
  source = "./modules/network"

  location = azurerm_resource_group.tf_rg.location
  rg_name  = azurerm_resource_group.tf_rg.name
}

module "compute" {
  source = "./modules/compute"

  rg_name  = azurerm_resource_group.tf_rg.name
  location = azurerm_resource_group.tf_rg.location
  nic_id   = module.network.nicID
  private_ip = module.network.private_ip
  img = module.storage.tf_blob_img
}

module "storage" {
  source = "./modules/storage"

  rg_name  = azurerm_resource_group.tf_rg.name
  location = azurerm_resource_group.tf_rg.location
}

module "security" {
  source = "./modules/security"

  location  = azurerm_resource_group.tf_rg.location
  rg_name   = azurerm_resource_group.tf_rg.name
  tf_nic_id = module.network.tf_nic_id
  sg_name   = var.sg_name
}