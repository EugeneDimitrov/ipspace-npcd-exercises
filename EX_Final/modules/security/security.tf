# security part of Azure infrastructure deploying security group, security rules ...

data "azurerm_subnet" "subnet_jh_gwc" {
  name                 = var.subnet_jh_name_gwc
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = var.vnet_maas_name_gwc
}

######################
#create security group
######################

resource "azurerm_network_security_group" "jh_sg_gwc" {
  name                = "SG_JH_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
}

resource "azurerm_network_security_group" "db_sg_gwc" {
  name                = "SG_DB_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
}

resource "azurerm_network_security_group" "db_sg_ne" {
  name                = "SG_DB_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne
}

######################
#create security rules for jumphosts
######################

resource "azurerm_network_security_rule" "sr_jh_ssh_gwc" {
  name                        = "JH_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.user_pub_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.jh_sg_gwc.name
}

######################
#create security rules for database vm
######################

resource "azurerm_network_security_rule" "sr_jh_to_db_ssh_in_ne" {
  name                        = "DB_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = data.azurerm_subnet.subnet_jh_gwc.address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.db_sg_ne.name
}

##############################
#apply security group to interface card
##############################

resource "azurerm_network_interface_security_group_association" "sg_jh_nic_association_gwc" {
  network_interface_id      = var.jh_nic_id_gwc
  network_security_group_id = azurerm_network_security_group.jh_sg_gwc.id
}

resource "azurerm_network_interface_security_group_association" "sg_db_nic_association_ne" {
  network_interface_id      = var.db_nic_id_ne
  network_security_group_id = azurerm_network_security_group.db_sg_ne.id
}
