# network part of Azure infrastructure deploying resource group, vnet, subnets, nic ...

######################
#create resource group
######################

resource "azurerm_resource_group" "tf_rg" {
  name     = var.rg_name
  location = var.location
}

########################
# create virtual network
########################

resource "azurerm_virtual_network" "tf_vnet" {
  name                = var.network_name
  location            = var.location
  resource_group_name = azurerm_resource_group.tf_rg.name
  address_space       = var.network_ip
}

###############
#create subnets
###############

resource "azurerm_subnet" "tf_public_subnet" {
  name                 = var.public_sub_name
  resource_group_name  = azurerm_resource_group.tf_rg.name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.public_sub_address
}

#################
#create public ip
#################

resource "azurerm_public_ip" "tf_public_ip" {
  for_each = var.vms

  name                = "${each.key}-Public_IP"
  location            = var.location
  resource_group_name = azurerm_resource_group.tf_rg.name
  allocation_method   = var.pub_ip_method
}

##############################
#create network interface card
##############################

resource "azurerm_network_interface" "tf_nic" {
  for_each = var.vms

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.tf_rg.name

  ip_configuration {
    name                          = var.nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_public_subnet.id
    public_ip_address_id          = azurerm_public_ip.tf_public_ip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
