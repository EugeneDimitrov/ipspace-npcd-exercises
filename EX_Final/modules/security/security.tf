# security part of Azure infrastructure deploying security group, security rules ...

data "azurerm_subnet" "subnet_jh_gwc" {
  name                 = var.subnet_jh_name_gwc
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = var.vnet_maas_name_gwc
}

data "azurerm_subnet" "subnet_app_gwc" {
  name                 = var.subnet_app_name_gwc
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = var.vnet_maas_name_gwc
}

data "azurerm_subnet" "subnet_app_ne" {
  name                 = var.subnet_app_name_ne
  resource_group_name  = var.rg_name_ne
  virtual_network_name = var.vnet_maas_name_ne
}

data "azurerm_subnet" "subnet_db_gwc" {
  name                 = var.subnet_db_name_gwc
  resource_group_name  = var.rg_name_gwc
  virtual_network_name = var.vnet_maas_name_gwc
}

data "azurerm_subnet" "subnet_db_ne" {
  name                 = var.subnet_db_name_ne
  resource_group_name  = var.rg_name_ne
  virtual_network_name = var.vnet_maas_name_ne
}

locals {
  sub_rfc1918 = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

############################################################
#create security group
############################################################

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

resource "azurerm_network_security_group" "app_sg_gwc" {
  name                = "SG_App_${var.name_prefix_gwc}"
  location            = var.loc_gwc
  resource_group_name = var.rg_name_gwc
}

resource "azurerm_network_security_group" "app_sg_ne" {
  name                = "SG_App_${var.name_prefix_ne}"
  location            = var.loc_ne
  resource_group_name = var.rg_name_ne
}

############################################################
#create security rules for jumphosts
############################################################

resource "azurerm_network_security_rule" "sr_jh_ssh_gwc" {
  name                        = "JH_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = concat(var.user_pub_ip, var.dc_lan_sub)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.jh_sg_gwc.name
}

############################################################
#create security rules for database vm
############################################################

resource "azurerm_network_security_rule" "sr_jh_to_db_ssh_in_gwc" {
  name                        = "DB_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_jh_gwc.address_prefixes, var.dc_lan_sub)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.db_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_jh_to_db_ssh_in_ne" {
  name                        = "DB_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_jh_gwc.address_prefixes, var.dc_lan_sub)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.db_sg_ne.name
}

resource "azurerm_network_security_rule" "sr_psql_to_db_in_gwc" {
  name                        = "DB_Inbound_Psql"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_app_gwc.address_prefixes, data.azurerm_subnet.subnet_app_ne.address_prefixes)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.db_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_psql_to_db_in_ne" {
  name                        = "DB_Inbound_Psql"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_app_ne.address_prefixes, data.azurerm_subnet.subnet_app_gwc.address_prefixes)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.db_sg_ne.name
}

resource "azurerm_network_security_rule" "sr_psql-repl_to_db_in_gwc" {
  name                        = "DB_Inbound_Repl_Psql"
  priority                    = 4010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefixes     = data.azurerm_subnet.subnet_db_ne.address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.db_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_psql-repl_to_db_in_ne" {
  name                        = "DB_Inbound_Repl_Psql"
  priority                    = 4010
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefixes     = data.azurerm_subnet.subnet_db_gwc.address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.db_sg_ne.name
}

resource "azurerm_network_security_rule" "sr_lan_to_db_in_gwc" {
  name                        = "LAN_DB_Inbound_Deny"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = local.sub_rfc1918
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.db_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_lan_to_db_in_ne" {
  name                        = "LAN_DB_Inbound_Deny"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = local.sub_rfc1918
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.db_sg_ne.name
}

############################################################
#create security rules for application vm
############################################################

resource "azurerm_network_security_rule" "sr_jh_to_app_ssh_in_gwc" {
  name                        = "App_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_jh_gwc.address_prefixes, var.dc_lan_sub)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.app_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_jh_to_app_ssh_in_ne" {
  name                        = "App_Inbound_SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = concat(data.azurerm_subnet.subnet_jh_gwc.address_prefixes, var.dc_lan_sub)
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.app_sg_ne.name
}

resource "azurerm_network_security_rule" "sr_https_to_app_in_gwc" {
  name                        = "App_Inbound_HTTPS"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_gwc
  network_security_group_name = azurerm_network_security_group.app_sg_gwc.name
}

resource "azurerm_network_security_rule" "sr_lan_to_app_in_ne" {
  name                        = "App_Inbound_HTTPS"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name_ne
  network_security_group_name = azurerm_network_security_group.app_sg_ne.name
}

############################################################
#apply security group to interface card
############################################################

resource "azurerm_network_interface_security_group_association" "sg_jh_nic_association_gwc" {
  network_interface_id      = var.jh_nic_id_gwc
  network_security_group_id = azurerm_network_security_group.jh_sg_gwc.id
}

############################################################
#apply security group to subnet
############################################################

resource "azurerm_subnet_network_security_group_association" "sg_app_sub_association_gwc" {
  subnet_id                 = data.azurerm_subnet.subnet_app_gwc.id
  network_security_group_id = azurerm_network_security_group.app_sg_gwc.id
}

resource "azurerm_subnet_network_security_group_association" "sg_app_sub_association_ne" {
  subnet_id                 = data.azurerm_subnet.subnet_app_ne.id
  network_security_group_id = azurerm_network_security_group.app_sg_ne.id
}

resource "azurerm_subnet_network_security_group_association" "sg_db_sub_association_gwc" {
  subnet_id                 = data.azurerm_subnet.subnet_db_gwc.id
  network_security_group_id = azurerm_network_security_group.db_sg_gwc.id
}

resource "azurerm_subnet_network_security_group_association" "sg_db_sub_association_ne" {
  subnet_id                 = data.azurerm_subnet.subnet_db_ne.id
  network_security_group_id = azurerm_network_security_group.db_sg_ne.id
}