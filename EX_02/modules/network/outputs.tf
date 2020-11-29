# outputs of network module

output "resource_group" {
  description = "name of resource group for VM"
  value       = azurerm_resource_group.tf_rg.name
}

output "location" {
  value = azurerm_resource_group.tf_rg.location
}

output "nicID" {
  description = "id of network interface for VM"
  value       = [azurerm_network_interface.tf_nic.id]
}

output "public_ip" {
  value = azurerm_public_ip.tf_public_ip.ip_address
}

output "tf_nic_id" {
  value = azurerm_network_interface.tf_nic.id
}