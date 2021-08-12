# This was created using Terraform v1.0.2

terraform {
  required_providers {
    azurerm = {
      version = "2.71.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "d23ffeda-4d68-496a-a0b0-1abb8b4aa902"
  features {}
}

######################
#create resource groups
######################

resource "azurerm_resource_group" "tf_rg_ne" {
  name     = var.rg_name_ne
  location = var.loc_ne
}

resource "azurerm_resource_group" "tf_rg_gwc" {
  name     = var.rg_name_gwc
  location = var.loc_gwc
}

######################
#start networking module
######################

module "network" {
  depends_on = [azurerm_resource_group.tf_rg_gwc, azurerm_resource_group.tf_rg_ne]
  source     = "./modules/network"

  rg_name_gwc   = var.rg_name_gwc
  rg_name_ne    = var.rg_name_ne
  loc_gwc       = var.loc_gwc
  loc_ne        = var.loc_ne
  dc_lan_sub    = var.dc_lan_sub
  bgp_dc1_r1    = var.bgp_dc1_r1
  bgp_dc1_r2    = var.bgp_dc1_r2
  ipsec_sec_key = var.ipsec_sec_key
}

######################
#start compute module
######################

module "compute" {
  depends_on = [azurerm_resource_group.tf_rg_gwc, azurerm_resource_group.tf_rg_ne]
  source     = "./modules/compute"

  rg_name_gwc   = var.rg_name_gwc
  rg_name_ne    = var.rg_name_ne
  loc_gwc       = var.loc_gwc
  loc_ne        = var.loc_ne
  jh_nic_id_gwc = module.network.jh_nic_id_gwc
  app_nic_id_gwc = module.network.app_nic_id_gwc
  app_nic_id_ne  = module.network.app_nic_id_ne
  db_nic_id_gwc  = module.network.db_nic_id_gwc
  db_nic_id_ne   = module.network.db_nic_id_ne
}

######################
#start security module
######################

module "security" {
  depends_on = [azurerm_resource_group.tf_rg_gwc, azurerm_resource_group.tf_rg_ne]
  source     = "./modules/security"

  rg_name_gwc         = var.rg_name_gwc
  rg_name_ne          = var.rg_name_ne
  loc_gwc             = var.loc_gwc
  loc_ne              = var.loc_ne
  jh_nic_id_gwc       = module.network.jh_nic_id_gwc
  db_nic_id_gwc       = module.network.db_nic_id_gwc
  db_nic_id_ne        = module.network.db_nic_id_ne
  user_pub_ip         = var.user_pub_ip
  dc_lan_sub          = var.dc_lan_sub
  subnet_jh_name_gwc  = module.network.subnet_jh_name_gwc
  subnet_app_name_gwc = module.network.subnet_app_name_gwc
  subnet_app_name_ne  = module.network.subnet_app_name_ne
  subnet_db_name_gwc  = module.network.subnet_db_name_gwc
  subnet_db_name_ne   = module.network.subnet_db_name_ne
  vnet_maas_name_gwc  = module.network.vnet_maas_name_gwc
  vnet_maas_name_ne   = module.network.vnet_maas_name_ne
}