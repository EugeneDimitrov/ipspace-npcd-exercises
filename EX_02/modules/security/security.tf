# security part of Azure infrastructure deploying security group, security rules ...

######################
#create security group
######################

resource "azurerm_network_security_group" "tf_sg" {
  name                = var.sg_name
  location            = var.location
  resource_group_name = var.rg_name
}

######################
#create security rules
######################

resource "azurerm_network_security_rule" "tf_sr_ssh" {
  name                        = "Inbound_SSH"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg.name
}

resource "azurerm_network_security_rule" "tf_sr_http" {
  name                        = "Inbound_HTTP"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg.name
}

resource "azurerm_network_security_rule" "tf_sr_https" {
  name                        = "Inbound_HTTPS"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.tf_sg.name
}

##############################
#apply security group to interface card
##############################

resource "azurerm_network_interface_security_group_association" "tf_sg_nic" {
  for_each = var.vms

  network_interface_id      = var.tf_nic[each.key].id
  network_security_group_id = azurerm_network_security_group.tf_sg.id
}