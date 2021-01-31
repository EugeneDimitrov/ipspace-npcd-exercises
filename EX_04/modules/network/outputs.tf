# outputs of network module

output "web_nic_id" {
  value = azurerm_network_interface.tf_web_nic_1.id
}

output "db_nic_id" {
  value = azurerm_network_interface.tf_db_nic_1.id
}

output "jh_nic_id" {
  value = azurerm_network_interface.tf_jh_nic_1.id
}

output "web_nic_id_lst" {
  value = [azurerm_network_interface.tf_web_nic_1.id]
}

output "db_nic_id_lst" {
  value = [azurerm_network_interface.tf_db_nic_1.id]
}

output "jh_nic_id_lst" {
  value = [azurerm_network_interface.tf_jh_nic_1.id]
}

output "web_private_ip" {
  value = azurerm_network_interface.tf_web_nic_1.ip_configuration[0].private_ip_address
}

output "db_private_ip" {
  value = azurerm_network_interface.tf_db_nic_1.ip_configuration[0].private_ip_address
}

output "jh_public_ip" {
  value = azurerm_public_ip.tf_pub_ip_2.ip_address
}
