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

#create alarm

resource "azurerm_monitor_scheduled_query_rules_alert" "tf_alert_rule" {
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