# Log analytic Azure infrastructure

##############################
#start log analytic
##############################

resource "azurerm_log_analytics_workspace" "tf_log_analytic" {
  name                = var.log_analytic_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}