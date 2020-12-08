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

module "network" {
  source = "./modules/network"

  vms      = var.vms
  location = var.location
  rg_name  = var.rg_name
}

module "compute" {
  source = "./modules/compute"

  vms       = var.vms
  rg_name   = var.rg_name
  location  = var.location
  tf_nic    = module.network.tf_nic
  public_ip = module.network.public_ip
}

module "security" {
  source = "./modules/security"

  vms      = var.vms
  location = module.network.location
  rg_name  = module.network.resource_group
  tf_nic   = module.network.tf_nic
  sg_name  = var.sg_name
}