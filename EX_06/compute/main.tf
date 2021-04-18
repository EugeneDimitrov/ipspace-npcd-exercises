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
#start compute module
######################

#collect vars for compute module

data "azurerm_resource_group" "tf_rg" {
  name = var.rg_name
}

data "azurerm_network_interface" "web_nic" {
  name                = var.web_nic_name
  resource_group_name = var.rg_name
}

data "azurerm_network_interface" "db_nic" {
  name                = var.db_nic_name
  resource_group_name = var.rg_name
}

data "azurerm_network_interface" "jh_nic" {
  name                = var.jh_nic_name
  resource_group_name = var.rg_name
}

data "azurerm_log_analytics_workspace" "log_analytic" {
  name                = var.log_analytic_name
  resource_group_name =  var.rg_name
}

module "compute" {
  source     = "./modules/compute"

  rg_name          = data.azurerm_resource_group.tf_rg.name
  location         = data.azurerm_resource_group.tf_rg.location
  web_nic_id       = [data.azurerm_network_interface.web_nic.id]
  db_nic_id        = [data.azurerm_network_interface.db_nic.id]
  jh_nic_id        = [data.azurerm_network_interface.jh_nic.id]
  web_private_ip   = data.azurerm_network_interface.web_nic.ip_configuration[0].private_ip_address
  db_private_ip    = data.azurerm_network_interface.db_nic.ip_configuration[0].private_ip_address
  jh_public_ip     = data.azurerm_network_interface.jh_nic.ip_configuration[0].private_ip_address
  log_analytic_id  = data.azurerm_log_analytics_workspace.log_analytic.workspace_id
  log_analytic_key = data.azurerm_log_analytics_workspace.log_analytic.primary_shared_key
}