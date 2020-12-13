# outputs of network module

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

output "private_ip" {
  value = azurerm_network_interface.tf_nic.ip_configuration[0].private_ip_address
}
