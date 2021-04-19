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

# add vm extension for log analytic

data "azurerm_virtual_machine" "tf_jh_vm" {
  name                = var.jh_vm_name
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_machine_extension" "tf_jh_vm_oms" {
  virtual_machine_id         = data.azurerm_virtual_machine.tf_jh_vm.id
  name                       = "OmsAgentForLinux"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
        "workspaceId": "${azurerm_log_analytics_workspace.tf_log_analytic.workspace_id}"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "workspaceKey": "${azurerm_log_analytics_workspace.tf_log_analytic.primary_shared_key}"
    }
  PROTECTED_SETTINGS

}

resource "azurerm_virtual_machine_extension" "tf_jh_vm_cust_script" {
  name                 = "CustomScript"
  virtual_machine_id   = data.azurerm_virtual_machine.tf_jh_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = <<SETTINGS
    {
        "fileUris": ["https://raw.githubusercontent.com/EugeneDimitrov/ipspace-npcd-scripts/main/oms-cfg.sh"],
        "commandToExecute": "sudo sh oms-cfg.sh"
    }
  SETTINGS
}

#create alarm

resource "azurerm_monitor_scheduled_query_rules_alert" "tf_alert_rule" {
  depends_on          = [azurerm_log_analytics_workspace.tf_log_analytic]
  name                = "Tracking SSH connections to jumphost"
  location            = var.location
  resource_group_name = var.rg_name
  data_source_id      = azurerm_log_analytics_workspace.tf_log_analytic.id
  description         = "Tracking SSH connections to jumphost"
  enabled             = true
  query               = <<-QUERY
  Syslog |
    where SyslogMessage startswith 'Accepted publickey for azure from'
  QUERY
  severity            = 2
  frequency           = 5
  time_window         = 30

  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }

  action {
    action_group = []
  }
}