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

resource "azurerm_subnet" "tf_db_subnet" {
  name                 = var.db_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.tf_vnet.name
  address_prefixes     = var.db_sub_address
}

###############
#create route tables
###############

resource "azurerm_route_table" "tf_db_rt" {
  name                = var.db_rt
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name           = "block_internet_access"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "None"
  }
}

###############
#associate route table with subnet
###############

resource "azurerm_subnet_route_table_association" "tf_db_rt_tf_db_subnet" {
  subnet_id      = azurerm_subnet.tf_db_subnet.id
  route_table_id = azurerm_route_table.tf_db_rt.id
  depends_on     = [azurerm_subnet.tf_db_subnet]
}

#################
#create public ip
#################

resource "azurerm_public_ip" "tf_pub_ip_1" {
  name                = var.pub_ip_name_1
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = var.pub_ip_method
}

resource "azurerm_public_ip" "tf_pub_ip_2" {
  name                = var.pub_ip_name_2
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = var.pub_ip_method
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
    public_ip_address_id          = azurerm_public_ip.tf_pub_ip_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "tf_db_nic_1" {
  name                = var.db_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.db_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "tf_jh_nic_1" {
  name                = var.jh_nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.jh_nic_ip_conf_name
    subnet_id                     = azurerm_subnet.tf_web_subnet.id
    public_ip_address_id          = azurerm_public_ip.tf_pub_ip_2.id
    private_ip_address_allocation = "Dynamic"
  }
}