output "log_analytic_id" {
  value = azurerm_log_analytics_workspace.tf_log_analytic.workspace_id
}

output "log_analytic_key" {
  value = azurerm_log_analytics_workspace.tf_log_analytic.primary_shared_key
}