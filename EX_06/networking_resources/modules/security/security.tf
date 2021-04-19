# security part of Azure infrastructure deploying security group, security rules ...

######################
#create security group
######################

resource "azurerm_network_security_group" "tf_sg_jh" {
  name                = "SG_JH"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "tf_sg_web" {
  name                = "SG_WEB"
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_group" "tf_sg_db" {
  name                = "SG_DB"
  location            = var.location
  resource_group_name = var.rg_name
}

######################
#create security rules
######################

#create inbound security rules for jumphost

resource "azurerm_network_security_rule" "tf_sg_jh_sr_ssh" {
  name                        = "Inbound_SSH"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "213.191.19.186"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_jh.name
}

#create inbound security rules for web

resource "azurerm_network_security_rule" "tf_sg_web_sr_http" {
  name                        = "Inbound_HTTP"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_web.name
}

resource "azurerm_network_security_rule" "tf_sg_web_sr_https" {
  name                        = "Inbound_HTTPS"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_web.name
}

resource "azurerm_network_security_rule" "tf_sg_web_sr_ssh" {
  name                        = "Inbound_SSH_from_JH"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "172.17.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_web.name
}

resource "azurerm_network_security_rule" "tf_sg_web_sr_icmp" {
  name                        = "Inbound_ICMP"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "172.17.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_web.name
}

resource "azurerm_network_security_rule" "tf_sg_web_sr_deny_all" {
  name                        = "Inbound_Deny_All"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "172.17.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_web.name
}

#create inbound security rules for databases

resource "azurerm_network_security_rule" "tf_sg_db_sr_mysql" {
  name                        = "Inbound_MySQL"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "172.17.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_http" {
  name                        = "Inbound_HTTP"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "172.17.1.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_ssh" {
  name                        = "Inbound_SSH_from_JH"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "172.17.0.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_icmp" {
  name                        = "Inbound_ICMP"
  priority                    = 104
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "172.17.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_deny_all" {
  name                        = "Inbound_Deny_All"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "172.17.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

#create outbound security rules for databases

resource "azurerm_network_security_rule" "tf_sg_db_sr_mysql_out" {
  name                        = "Outbound_MySQL"
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_http_out" {
  name                        = "Outbound_HTTP"
  priority                    = 102
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

resource "azurerm_network_security_rule" "tf_sg_db_sr_deny_all_out" {
  name                        = "Outbound_Deny_All"
  priority                    = 4096
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "172.17.0.0/16"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg_db.name
}

##############################
#apply security group to subnets
##############################

resource "azurerm_subnet_network_security_group_association" "tf_jh_sg_subnet" {
  subnet_id                 = var.jh_sub_id
  network_security_group_id = azurerm_network_security_group.tf_sg_jh.id
}

resource "azurerm_subnet_network_security_group_association" "tf_web_sg_subnet" {
  subnet_id                 = var.web_sub_id
  network_security_group_id = azurerm_network_security_group.tf_sg_web.id
}

resource "azurerm_subnet_network_security_group_association" "tf_db_sg_subnet" {
  subnet_id                 = var.db_sub_id
  network_security_group_id = azurerm_network_security_group.tf_sg_db.id
}