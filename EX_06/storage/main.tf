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

######################
#start storage module
######################

#collect vars for compute module

data "azurerm_resource_group" "tf_rg" {
  name = var.rg_name
}

module "storage" {
  source     = "./modules/storage"

  rg_name          = data.azurerm_resource_group.tf_rg.name
  location         = data.azurerm_resource_group.tf_rg.location
}