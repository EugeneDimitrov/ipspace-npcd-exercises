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

  rg_name          = var.rg_name
  location         = var.location
  web_nic_id       = module.network.web_nic_id_lst
  db_nic_id        = module.network.db_nic_id_lst
  jh_nic_id        = module.network.jh_nic_id_lst
  web_private_ip   = module.network.web_private_ip
  db_private_ip    = module.network.db_private_ip
  jh_public_ip     = module.network.jh_public_ip
  log_analytic_id  = module.loganalytic.log_analytic_id
  log_analytic_key = module.loganalytic.log_analytic_key
}

######################
#start security module
######################

module "security" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/security"

  location   = azurerm_resource_group.tf_rg.location
  rg_name    = azurerm_resource_group.tf_rg.name
  web_sub_id = module.network.web_sub_id
  db_sub_id  = module.network.db_sub_id
  jh_sub_id  = module.network.jh_sub_id
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
#start iam module
######################

module "loganalytic" {
  depends_on = [azurerm_resource_group.tf_rg]
  source     = "./modules/loganalytic"

  location = azurerm_resource_group.tf_rg.location
  rg_name  = azurerm_resource_group.tf_rg.name
}