# outputs of network module

output "resource_group" {
  description = "name of resource group for VM"
  value       = azurerm_resource_group.tf_rg.name
}

output "location" {
  value = azurerm_resource_group.tf_rg.location
}

output "public_ip" {
  value = azurerm_public_ip.tf_public_ip
}

output "tf_nic" {
  value = azurerm_network_interface.tf_nic
}