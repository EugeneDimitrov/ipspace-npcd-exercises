# network part of Azure infrastructure deploying resource group, vnet, subnets, nic ...

########################
# create virtual network
########################

resource "azurerm_virtual_network" "tf_vnet" {
  name                = var.network_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.network_ip
}

###############
#create subnets
###############

resource "azurerm_subnet" "tf_web_subnet" {
  name                 = var.web_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.web_sub_address
}

#################
#create public ip
#################

resource "azurerm_public_ip" "tf_pub_ip_1" {
  name                = var.pub_ip_name_1
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv4"
  domain_name_label   = "web1"
}

resource "azurerm_public_ip" "tf_pub_ipv6_1" {
  name                = var.pub_ipv6_name_1
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  ip_version          = "IPv6"
  domain_name_label   = "web1"
}

##############################
#create network interface card
##############################

resource "azurerm_network_interface" "tf_web_nic_1" {
  name                = var.web_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.web_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_web_subnet.id
    private_ip_address_version    = "IPv4"
    public_ip_address_id          = azurerm_public_ip.tf_pub_ip_1.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }

  ip_configuration {
    name                          = var.web_nic_ipv6_conf_name
    subnet_id                     = azurerm_subnet.tf_web_subnet.id
    private_ip_address_version    = "IPv6"
    public_ip_address_id          = azurerm_public_ip.tf_pub_ipv6_1.id
    private_ip_address_allocation = "Dynamic"
  }
}