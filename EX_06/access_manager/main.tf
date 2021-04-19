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
#create resource group
######################

resource "azurerm_resource_group" "tf_rg" {
  name     = var.rg_name
  location = var.location
}

######################
#start iam module
######################

module "iam" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/iam"

  rg_id = azurerm_resource_group.tf_rg.id
}

######################
#start loganalytic module
######################

module "loganalytic" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/loganalytic"

  rg_name    = var.rg_name
  location   = var.location
  jh_vm_name = var.jh_vm_name
}