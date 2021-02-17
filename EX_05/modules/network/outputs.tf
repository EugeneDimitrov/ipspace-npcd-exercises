# outputs of network module

output "web_nic_id" {
  value = azurerm_network_interface.tf_web_nic_1.id
}

output "web_nic_id_lst" {
  value = [azurerm_network_interface.tf_web_nic_1.id]
}

output "web_private_ip" {
  value = azurerm_network_interface.tf_web_nic_1.ip_configuration[0].private_ip_address
}

output "web_private_ipv6" {
  value = azurerm_network_interface.tf_web_nic_1.ip_configuration[1].private_ip_address
}