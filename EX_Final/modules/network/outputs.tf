# outputs of network module

output "jh_nic_id_gwc" {
  value = azurerm_network_interface.jh_nic_gwc.id
}

output "app_nic_id_gwc" {
  value = azurerm_network_interface.app_nic_gwc.id
}

output "app_nic_id_ne" {
  value = azurerm_network_interface.app_nic_ne.id
}

output "db_nic_id_gwc" {
  value = azurerm_network_interface.db_nic_gwc.id
}

output "db_nic_id_ne" {
  value = azurerm_network_interface.db_nic_ne.id
}

output "subnet_jh_name_gwc" {
  value = azurerm_subnet.subnet_jh_gwc.name
}

output "subnet_app_name_gwc" {
  value = azurerm_subnet.subnet_app_gwc.name
}

output "subnet_app_name_ne" {
  value = azurerm_subnet.subnet_app_ne.name
}

output "subnet_db_name_gwc" {
  value = azurerm_subnet.subnet_db_gwc.name
}

output "subnet_db_name_ne" {
  value = azurerm_subnet.subnet_db_ne.name
}

output "vnet_maas_name_gwc" {
  value = azurerm_virtual_network.vnet_maas_gwc.name
}

output "vnet_maas_name_ne" {
  value = azurerm_virtual_network.vnet_maas_ne.name
} 