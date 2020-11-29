provider "azurerm" {
  version = "2.36.0"
  features {}
}

module "network" {
  source = "./modules/network"

  location = var.location
  rg_name  = var.rg_name
}

module "compute" {
  source = "./modules/compute"

  rg_name  = var.rg_name
  location = var.location
  nic_id   = module.network.nicID
}

module "security" {
  source = "./modules/security"

  location  = module.network.location
  rg_name   = module.network.resource_group
  tf_nic_id = module.network.tf_nic_id
  sg_name   = var.sg_name
}